" Basic
" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
" 开启256色支持
set t_Co=256
" Disable Q in normal mode
noremap Q <Nop>
augroup Local_Autocmd_Group
  autocmd FileType * call SetIndent()
  " Uncomment the following to have Vim jump to the last position when reopening a file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
set autoindent
set smartindent
set expandtab                 " 把Tab字符用空格代替，和tabstop相关
set list                      " Enable special character display
set listchars=tab:>>¦,trail:• " Show a tab as >>¦, show a trailing space as •
function! SetIndent()
  let l:indent_val=4
  if &filetype=='c' || &filetype=='cpp'
    set cindent     " 设置使用C/C++语言的自动缩进方式
  elseif &filetype=='vim'
    let l:indent_val = 2
  endif
  let &tabstop = l:indent_val      " Tab键的显示宽度 and its practical width
  let &softtabstop = l:indent_val  " 按下Tab键时输入的宽度
  let &shiftwidth = l:indent_val   " 设置自动缩进时的缩进长度
endfunction
set foldmethod=manual
set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [%{toupper(&fileencoding)}=0x%B]%m%r
set statusline+=%=\ [%{strftime(\"%m/%d/%y-%a-%H:%M\")}]%<
" 当窗口多于一个时显示状态行(1),总是显示状态行(2)
set laststatus=2
" 允许光标出现在最后一个字符的后面
set virtualedit=block,onemore
" 总是显示光标位置
set ruler
" 突出显示当前行
set cursorline
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 显示行号
set number
 " Merge signcolumn and number column into one
set signcolumn=number
 " Column guide
set colorcolumn=80,120,160

" 会使vim看起来不友好的命令
if has('gui_running')
  set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 21
  " 设置光标格式竖纹：ver33  下划线：hor20   方块：block,其中数字为百分比
  set guicursor=c-i:ver33-Cursor
  set guicursor+=a:blinkon0
  " 设定窗口大小
  set lines=60 columns=120
  " 隐藏滚动栏
  set guioptions-=r
  " tab只显示文件名不显示标签
  set guitablabel=%t
endif

call plug#begin('~/.vim/plugged')
" Vim theme, No_Lazy
Plug 'dracula/vim', {'as': 'dracula'}
" 彩虹括号
Plug 'luochen1990/rainbow'
" 缩进显示
Plug 'nathanaelkane/vim-indent-guides'
" Python 语法高亮插件
Plug 'vim-python/python-syntax', {'for': ['python']}
" Nerdcommenter快速注释插件
Plug 'preservim/nerdcommenter'
call plug#end()
let maplocalleader = ","

colorscheme dracula
noremap <Leader>ppt :<C-u>colorscheme zellner<CR>

" Rainbow setting
" Set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

" Vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_tab_guides = 0
let g:indent_guides_default_mapping = 0

" Python-syntax setting
let g:python_highlight_builtins = 1
let g:python_highlight_string_formatting = 1
let g:python_highlight_func_calls = 1
let g:python_highlight_class_vars = 1
let g:python_highlight_operators = 1
let g:python_highlight_file_headers_as_comments = 1

" nerdcommenter插件快速注释
let g:NERDSpaceDelims            = 1      " 在注释符号后加一个空格
let g:NERDCompactSexyComs        = 1      " 紧凑排布多行注释
let g:NERDToggleCheckAllLines    = 1      " 检查选中项是否有没被注释的项，有则全部注释
let g:NERDDefaultAlign           = 'left' " 逐行注释左对齐
let g:NERDCommentEmptyLines      = 0      " 允许空行注释
let g:NERDTrimTrailingWhitespace = 1      " 取消注释时删除行尾空格
let g:NERDToggleCheckAllLines    = 1      " 检查选中的行操作是否成功
let g:NERDCustomDelimiters = {
        \ 'c': {'left': '//'},
        \ } " Use custom delimiers  to comment source codes.
let g:NERDCreateDefaultMappings = 0
map <F3> <plug>NERDCommenterComment
map <S-F3> <plug>NERDCommenterUncomment

" After 333ms
function! TimerStart(timer)
  call InitializeTabPos()
endfunction
call timer_start(333,'TimerStart',{'repeat':1})

" Alt+n跳到第n个tab，0<n<10
function! TabPosActivateBuffer(index)
  if a:index <= tabpagenr('$')
    exec 'tabnext' a:index
  else
    echo 'The index number(now, '.a:index.') must be less than the total number of tabs(now, '.tabpagenr('$').').'
  endif
endfunction
function! InitializeTabPos()
  for l:i in range(1, 9)
      exec 'noremap <M-' . l:i . '> :<C-u>call TabPosActivateBuffer(' . l:i . ')<CR>'
      exec 'inoremap <M-' . l:i . '> <C-o>:call TabPosActivateBuffer(' . l:i . ')<CR>'
  endfor
  exec 'noremap <M-0> :<C-u>call TabPosActivateBuffer(10)<CR>'
  exec 'inoremap <M-0> <C-o>:call TabPosActivateBuffer(10)<CR>'
endfunction

noremap <Leader><F2> :<C-u>call CompileCommand()<CR>
if !(exists('*CompileCommand') && &filetype=='vim')
  function! CompileCommand()
    if &filetype=='python'
    elseif &filetype=='perl'
    elseif &filetype=='vim'
      exec ':source ~/.vimrc'
    endif
  endfunction
endif

noremap <LocalLeader><F4> :<C-u>vert diffsplit

noremap <LocalLeader><F7> :<C-u>call RetabAndDeleteTraillingUselessChars()<CR>
function! RetabAndDeleteTraillingUselessChars()
  exec 'normal! ms'
  exec ':%retab!'
  exec ':%s/\s\+$//e'
  exec ':%s/\r//e'
  exec 'normal! `s'
endfunction
" 不少插件的信息更新都会需要这个时间
set updatetime=33
" 设置<ESC>键响应时间
set ttimeoutlen=0
" Setting keymapping timeout
set timeoutlen=666
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 打开文件时进行解码的猜测列表
set fileencodings=utf-8,utf-16,utf-32,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5,latin1
" 把当前文件转换为当前系统编码进行处理，这里为utf-8
set encoding=utf-8
scriptencoding utf-8
" 禁止生成临时文件
set nobackup
set nowritebackup
set noswapfile
set shortmess+=c
set showcmd
" 设置当文件被改动时自动载入
set autoread
" 共享剪贴板
set clipboard=unnamedplus
" 设置魔术正则语法
set magic
" No bell
set novisualbell
set belloff=all
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 历史记录数
set history=3333
" 行内替换
set gdefault
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 增强模式中的命令行自动完成/补全操作
set wildmode=list:longest
" Prevent exe files from appearing in auto-completion
set wildignore=*.exe
" 使回格键（backspace）正常处理indent, eol, nostop等
set backspace=indent,eol,nostop
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l,[,]
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selectmode=key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 设置搜索可以循环搜索, 搜索和补全时忽略大小写,智能大小写,逐字符高亮
set wrapscan
set ignorecase
set smartcase
set hlsearch
set incsearch
