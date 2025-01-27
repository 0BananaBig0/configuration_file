" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
" 开启256色支持
set t_Co=256
" 不少插件的信息更新都会需要这个时间
set updatetime=33
" 打开文件时进行解码的猜测列表
set fileencodings=utf-8,utf-16,utf-32,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5,latin1
" 把当前文件转换为当前系统编码进行处理，这里为utf-8
set encoding=utf-8
scriptencoding utf-8
" 禁止生成临时文件
set nobackup
set nowritebackup
set noswapfile
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
      exec 'noremap <M-' . l:i . '> :call TabPosActivateBuffer(' . l:i . ')<CR>'
      exec 'inoremap <M-' . l:i . '> <C-o>:call TabPosActivateBuffer(' . l:i . ')<CR>'
  endfor
  exec 'noremap <M-0> :call TabPosActivateBuffer(10)<CR>'
  exec 'inoremap <M-0> <C-o>:call TabPosActivateBuffer(10)<CR>'
endfunction
set shortmess+=c
set showcmd
set foldmethod=manual
set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [%{toupper(&fileencoding)}=0x%B]%m%r
set statusline+=%=\ [%{strftime(\"%m/%d/%y-%a-%H:%M\")}]%<
" 当窗口多于一个时显示状态行(1),总是显示状态行(2)
set laststatus=2
" 设置<ESC>键响应时间
set ttimeoutlen=0
" setting keymapping timeout
set timeoutlen=666
" 允许光标出现在最后一个字符的后面
set virtualedit=block,onemore
" 总是显示光标位置
set ruler
" 突出显示当前行
set cursorline
" no bell
set novisualbell
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 显示行号
set number
" merge signcolumn and number column into one
set signcolumn=number
set colorcolumn=80,120,160 " Column guide
" Uncomment the following to have Vim jump to the last position when reopening a file
augroup Local_Autocmd_Group | autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | augroup END
" 设置当文件被改动时自动载入
set autoread
" 共享剪贴板
set clipboard=unnamedplus
" 设置魔术正则语法
set magic
" 去掉输入错误的提示声音
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
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
" 设置搜索可以循环搜索
set wrapscan
" 搜索和补全时忽略大小写,智能大小写,逐字符高亮
set ignorecase
set smartcase
set hlsearch
set incsearch
augroup Local_Autocmd_Group
  autocmd FileType * call SetIndent()
  autocmd BufNewFile * call SetTitle()
  autocmd FileType c,cpp,verilog nnoremap <Leader>` :call CallShowNearestFunction()<CR>
  autocmd QuitPre *.[ch]* call EnsureEmptyLastLine() " Recommended by the POSIX standard
  " Disable automatic word wrap which is enabled by filetype plugin indent on
  autocmd FileType vim set textwidth=0
augroup END
set autoindent
set smartindent
set expandtab                 " 把Tab字符用空格代替，和tabstop相关
set list                      " Enable special character display
set listchars=tab:>>¦,trail:• " Show a tab as >>¦, show a trailing space as •
function! SetIndent()
  if &filetype=='c' || &filetype=='cpp' || &filetype=='opencl' || &filetype=='json'
        \ || &filetype=='python' || &filetype=='sh' || &filetype=='verilog'
        \ || &filetype=='perl' || &filetype=='tcl'
    set tabstop=3     " Tab键的显示宽度
    set softtabstop=3 " 按下Tab键时输入的宽度
    set shiftwidth=3  " 设置自动缩进时的缩进长度
    if &filetype=='c' || &filetype=='cpp'
      set cindent     " 设置使用C/C++语言的自动缩进方式
    endif
  else
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
  endif
endfunction
function! AppendInfo(info, column_limit)
  let l:padding_str_len = 3
  let l:padding_strs = repeat(&commentstring[0], l:padding_str_len)
  let l:start_space_len = (a:column_limit - strlen(a:info) - l:padding_str_len * 2) / 2
  let l:end_space_len = a:column_limit - l:start_space_len - strlen(a:info) - l:padding_str_len * 2
  call append(line('$'), l:padding_strs.repeat(' ', l:start_space_len).a:info.repeat(' ', l:end_space_len).l:padding_strs)
endfunction
function! SetTitle()
  if empty(&commentstring) || empty(&filetype) || (strlen(&commentstring) > 3
      \ && &commentstring[0] != &commentstring[1] && &commentstring[1] != ' ')
    return
  endif
  let l:column_limit = split(&colorcolumn, ",")[0]
  let l:top_and_bottom = repeat(&commentstring[0], l:column_limit)
  call setline(1, l:top_and_bottom)
  call AppendInfo('File Name: '.expand('%:t'), l:column_limit)
  call AppendInfo('Author: Huaxiao Liang', l:column_limit)
  call AppendInfo('Mail: 1184903633@qq.com', l:column_limit)
  call AppendInfo(strftime('%m/%d/%Y-%a-%H:%M:%S'), l:column_limit)
  call append(line('$'), l:top_and_bottom)
  call append(line('$'), '')
  if &filetype=='c'
    call append(line('$'), '#include <stdio.h>')
  elseif &filetype=='cpp'
    if expand('%:e')=~?'^h.*'
      call append(line('$'), '#pragma once')
    endif
    call append(line('$'), '#include <iostream>')
  elseif &filetype=='make'
    call append(line('$'), '.PHONY:')
  elseif &filetype=='sh'
    call append(line('$'), '#!/bin/bash')
  elseif &filetype=='perl'
    call append(line('$'), '#!/bin/perl')
    call append(line('$'), 'use strict;')
    call append(line('$'), 'use warnings;')
  elseif &filetype=='tcl'
    call append(line('$'), '#!/usr/bin/tclsh')
  endif
  call append(line('$'), '')
  exec 'normal! G'
endfunction
function! ShowCurrentModule()
  let l:module_line = search('module', 'bnWz')
  let l:module_name = getline(l:module_line)
  let l:module_end_poisition = strridx(l:module_name, '(')
  if(l:module_end_poisition > 0)
    let l:module_name = strpart(l:module_name, 0, l:module_end_poisition)
  endif
  let l:module_name = strpart(l:module_name, stridx(l:module_name, 'module')+7)
  while(strpart(l:module_name, 0 , 1)==' ')
    let l:module_name = strpart(l:module_name, 1)
  endwhile
  echo 'module -->' l:module_name
endfunction
function! ShowNearestClassOrStruct()
  let l:class_line = search('\n'.'class', 'bnWz')
  let l:struct_line = search('\n'.'struct', 'bnWz')
  if(l:class_line > l:struct_line)
    let l:nearest_name = getline(l:class_line+1)
  elseif(l:class_line < l:struct_line)
    let l:nearest_name = getline(l:struct_line+1)
  else
    let l:nearest_name = 'No class/struct can be found.'
  endif
  let l:nearest_end_poisition = strridx(l:nearest_name, '{')
  if(l:nearest_end_poisition > 0)
    let l:nearest_name = strpart(l:nearest_name, 0, l:nearest_end_poisition)
  endif
  echo l:nearest_name
endfunction
function! CallShowNearestFunction()
  if &filetype=='cpp' || &filetype=='c'
     call ShowNearestClassOrStruct()
  elseif &filetype=='verilog'
     call ShowCurrentModule()
  endif
endfunction
function! EnsureEmptyLastLine()
  if getline(line('$')) !=# '' && filereadable(expand('%'))
    call append(line('$'), '')
    write
  endif
endfunction
nnoremap <Space><F5> :call DeleteBlankLine()<CR>
function! DeleteBlankLine()
  exec 'normal! m"'
  " Find the nearest line which contains at least one non-space character.
  if getline('.') =~? '^\s*$' " The current line is empty.
    let l:line_num = line('.')
    let l:down_line_num = search('^\s*\S', 'nW')
    let l:up_line_num = search('^\s*\S', 'bnW')
    if l:up_line_num == 0 && l:down_line_num == 0 " All lines are empty.
      let l:line_num = 1
    elseif l:down_line_num == 0 || (l:up_line_num != 0
          \ && l:line_num - l:up_line_num < l:down_line_num - l:line_num)
      let l:line_num = l:up_line_num " Closest to the up line.
    elseif l:line_num != l:down_line_num
      let l:line_num = l:down_line_num
    endif
    let l:col_num = col('.')
    if strlen(getline(l:line_num)) < l:col_num
      let l:col_num = strlen(getline(l:line_num))
    endif
    call setpos('.', [0, l:line_num, l:col_num, 0])
    exec 'normal! m"'
  endif
  exec ':g/^\s*$/d'
  exec 'normal! `"'
endfunction
nnoremap <Space><F7> :call RetabAndDeleteTraillingUselessChars()<CR>
function! RetabAndDeleteTraillingUselessChars()
  exec 'normal! ms'
  exec ':%retab!'
  exec ':%s/\s\+$//e'
  exec ':%s/\r//e'
  exec 'normal! `s'
endfunction
" Ctrl-Enter/Space在普通模式下像插入模式一样使用回车/Space
nnoremap <C-CR> :call InsertEnterInNormalMode()<CR>
nnoremap <M-CR> :call EnterWithoutTraillingComment()<CR>
inoremap <M-CR> <C-o>:call EnterWithoutTraillingComment()<CR>
function! InsertEnterInNormalMode()
  " 1. 获取当前光标所在位置的行数
  let l:cur_line = line('.')
  let l:new_line = l:cur_line + 1
  " 2. 获取 `l:cur_line` 中的缩进空格数，并存储在 `l:cur_indent_count` 中
  let l:cur_indent_count = indent(l:cur_line)
  " 3. 生成 n 个空格
  let l:cur_indent = repeat(' ', l:cur_indent_count)
  " 4. 进入插入模式，输入回车，然后返回正常模式
  " feedkeys() is an asynchronous function that causes some issues.
  " call feedkeys("i\<CR>\<ESC>", 'n')
  exec "normal! i\<CR>\<ESC>"
  let l:new_column = col('.')
  if l:new_column != 1
    let l:new_column = l:new_column + 1
  endif
  " 5. 如果 `l:new_line` 行为空或只有空格, 给 `l:new_line` 行插入 `l:cur_indent`
  if getline(l:new_line) =~? '^\s*$'
    call setline(l:new_line, l:cur_indent)
    let l:new_column = l:cur_indent_count + 1
  endif
  " 6. 如果 `l:cur_line` 行为空或只有空格，则清除 `l:cur_line` 行的空格
  if getline(l:cur_line) =~? '^\s*$'
    call setline(l:cur_line, '')
  endif
  " 7. 去到 `l:new_line` 行的l:new_column列
  call setpos('.', [0, l:new_line, l:new_column, 0])
endfunction
function! EnterWithoutTraillingComment()
  let l:cur_line = line('.')
  let l:new_line = l:cur_line + 1
  let l:cur_indent_count = indent(l:cur_line)
  let l:cur_indent = repeat(" ", l:cur_indent_count)
  set paste
  exec "normal! i\<CR>\<ESC>"
  set nopaste
  call setline(l:new_line, l:cur_indent.getline(l:new_line))
  call setpos('.', [0, l:new_line, l:cur_indent_count + 1, 0])
endfunction
" Alt-h/j/k/l/p/P/u/D/Y/I/A use h/j/k/l/p/P/u/D/Y/I/A in the insert mode like in the normal mode
inoremap <M-h> <Left>
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-l> <Right>
inoremap <M-p> <C-o>P
inoremap <M-S-p> <C-o>p
inoremap <M-u> <C-o>u
inoremap <M-r> <C-o><C-r>
inoremap <M-S-d> <C-o>D
inoremap <M-S-y> <C-o>Y
inoremap <M-S-a> <C-o>A
inoremap <M-S-i> <C-o>I
