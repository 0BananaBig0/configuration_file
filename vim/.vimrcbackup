"If you want to use my .vimrc, make sure your vim version is bigger than 8.1.1564
"If you use neovim, make sure its versio is bigger than 0.5.0
"There some depedencies you should have:
"(1)*llvm* and *clang* , make sure their versions are bigger than 10.0 coc will need them
"(2)nodejs and yarn, make sure nodejs version is bigger than 12.12. coc will need them
"Also,markdown-preview.nvim needs yarn.
"(3)bear. It can support compile_commands.json for clangd if you use make to manage your project.
"If you use cmake, add set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
"to your CMakeLists.txt, that can support compile_commands.json. After the
"compile_commands.json created, you should copy it or link it so that we can
"find it in your root of your projece.
"(4)vimplug,https://github.com/junegunn/vim-plug,this can help you manage your plugin of vim
"(5)if you use python, you also need to execute the following commands:
"python3 -m pip install pysnooper ipdb pylint yapf futures isort pyright
"(6)python3 -m pip install pygments vim-vint cmakelang
"(7)if you want to use my coc-settings.json, you can copy it from
"/home/hxliang/.vim to /home/you/.vim. And there are some dependencies you
"should have: install verilator,verible and sudo npm install -g @imc-trading/svlangserver
"if your write the verilog. https://github.com/chipsalliance/verible
"(8)install ripgrep,if you want to use 'leaderf rg' command in .vimrc . https://github.com/BurntSushi/ripgrep
"(9)if your vim tell you that it can't find some models, you can do that
"first, coc.nvim use iverilog or verilator check the verilog syntax
"last,at the top of your verilog file add the following statement:
"`include "/path/to/xxx.v"
"ps:xxx.v must include those models which had been told that vim misses by
"coc.nvim
"If you want to know what functions my vimrc have you should scan the .vimrc.
"If you want to know the shortcut key, search 'map ' in the .vimrc . Or use
":map in normal mode
"If you confuse with some configuration, you can use the help command. For
"example I confuse with 'set ws', so I use vim command as the following :
"help ws. If I confuse with 'let g:coc_start_at_startup = 0', I can use the
"following command:help coc_start_at_startup
"There are some commands you may need to know:you can use tab key to complete
"if you want to use the shell command,you can add ! before your shell command,
"for example,if you want to use ls command,you can type the  :!ls  in the vim normal mode
"or correct your vim commands you type
"vimplug:  PlugInstall PlugUpdate PlugUpgrade
"leaderf: LeaderfFunction



" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
" 开启256色支持
set t_Co=256
" 不少插件的信息更新都会需要这个时间
set updatetime=33
" 打开文件时进行解码的猜测列表
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5,latin1
" 把当前文件转换为当前系统编码进行处理，这里为utf-8
set encoding=utf-8
scriptencoding utf-8
" 禁止生成临时文件
set nobackup
set nowritebackup
set noswapfile
" 使用localleader映射的快捷键必须出现在let g:maplocalleader = ' '之后
let g:maplocalleader = ' '



" let g:plug_url_format = 'https://git::@github.91chi.fun//https://github.com/%s.git'
call plug#begin('~/.vim/plugged')
" vim theme
Plug 'dracula/vim', { 'as': 'dracula' }
" 彩虹括号
Plug 'luochen1990/rainbow'
" 缩进显示
Plug 'nathanaelkane/vim-indent-guides'
" 补全插件 动态检测语法插件,可鼠标停留显示信息
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 文件目录插件
Plug 'preservim/nerdtree',{'on': 'NERDTreeToggle'}
" 标签窗口列表插件
Plug 'liuchengxu/vista.vim',{'on':'Vista!!'}
" 书签插件，用于写代码注解等等
Plug 'MattesGroeger/vim-bookmarks',{'on':['BookmarkToggle','BookmarkShowAll','BookmarkAnnotate']}
" Esc退出变回英文输入法，进入insert模式切换为原来的输入法
Plug '0BananaBig0/fcitx.vim',{'branch':'fcitx4','on':[]}
" Multiple highlights
Plug 'lfv89/vim-interestingwords',{'on':[]}
" Git command
Plug 'tpope/vim-fugitive',{'on':[]}
" Git status show
Plug 'airblade/vim-gitgutter',{'on':[]}
" c/cpp debug
Plug 'puremourning/vimspector',{'on':[]}
" 快速查找插件，包括查找文件，当前文件函数，模糊查找字段
Plug 'Yggdroot/LeaderF', {'on': ['Leaderf','LeaderfFunction','LeaderfBuffer','LeaderfFile']}
" LeaderF extension for navigate the marks
Plug 'Yggdroot/LeaderF-marks', {'on': ['Leaderf','LeaderfFunction','LeaderfBuffer','LeaderfFile']}
" highlight opencl 2.0 syntax
Plug 'brgmnn/vim-opencl', {'on':[]}
" 高亮c++类模板等插件
Plug 'bfrg/vim-cpp-modern', {'on':[]}
" python 语法高亮插件
Plug 'vim-python/python-syntax', {'on':[]}
" roslaunch语法高亮
Plug 'taketwo/vim-ros',{'on':[]}
" verilog indent file
Plug '0BananaBig0/verilog_indent',{'on':[]}
" vim快捷键管理和提示插件
Plug 'liuchengxu/vim-which-key', { 'on': [] }
" markdown实时预览插件
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'on': []}
" markdown表格插件
Plug 'godlygeek/tabular', {'on': []}
" markdown目录构建插件
Plug 'mzlogin/vim-markdown-toc',{'on':[]}
" nerdcommenter快速注释插件
Plug 'preservim/nerdcommenter', {'on':[]}
" 异步执行shell命令插件，如果需要打开新终端，请去github看skywind3000/asyncrun.extra插件
Plug 'skywind3000/asyncrun.vim',{'on':[]}
" 菜单栏插件
Plug 'skywind3000/vim-quickui'
call plug#end()



colorscheme dracula
" 设置光标格式竖纹：ver33  下划线：hor20   方块：block,其中数字为百分比
set guicursor=c-i:ver33-Cursor
set guicursor+=a:blinkon0
nnoremap <silent><Leader>ppt :colorscheme zellner<CR>
                           \ :set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 23<CR>
                           \ :IndentGuidesDisable<CR>
" 插件疑似不支持按文件类型加载，手动添加autocmd判断，也不支持利用vim的特性延迟加载
augroup Call_Highlight_Plugin
  autocmd BufNewFile,BufRead *.cl silent call plug#load('vim-opencl')
  autocmd FileType cpp,c,opencl silent call plug#load('vim-cpp-modern')
  autocmd FileType python silent call plug#load('python-syntax')
  autocmd BufNewFile,BufRead *.launch setfiletype roslaunch
  autocmd BufRead *.launch silent call plug#load('vim-ros')
  autocmd FileType verilog silent call plug#load('verilog_indent')
augroup END



" rainbow setting
let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle



" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_tab_guides = 0
let g:indent_guides_default_mapping = 0



" coc setting
" After 333ms, call the coc.nvim,delay the coc startup,vim-plug lazy load
let g:coc_start_at_startup = 0
function! CocTimerStart(timer)
    exec 'CocStart'
    augroup Lazy_Call_Plugin
      autocmd FileType markdown silent call plug#load('markdown-preview.nvim')
      autocmd FileType markdown silent call plug#load('vim-markdown-toc')
      autocmd FileType markdown silent call plug#load('tabular')
    augroup END
    silent call Lazy_On_Plugin_Configuration()
    silent call Lazy_Plugin_Configuration()
    silent call plug#load('vim-which-key')
    silent call plug#load('nerdcommenter')
    silent call plug#load('asyncrun.vim')
endfunction
silent call timer_start(333,'CocTimerStart',{'repeat':1})
function! Lazy_On_Plugin_Configuration()
  " vim-which-key setting
  let g:which_key_fallback_to_native_key=1
  nnoremap <silent><Leader> :WhichKey '<Leader>'<CR>
  nnoremap <silent><Localleader> :WhichKey '<Localleader>'<CR>
  nnoremap <silent>[ :WhichKey '['<CR>
  nnoremap <silent>] :WhichKey ']'<CR>



  " Use tab for trigger completion with characters ahead and navigate.
  " After we select the word we needn't press enter key
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped
  " by other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
                                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  nmap <silent><Localleader>d <Plug>(coc-definition)
  nmap <silent><Localleader>c <Plug>(coc-declaration)
  nmap <silent><Localleader>i <Plug>(coc-implementation)
  nmap <silent><Localleader>r <Plug>(coc-references)
  nmap <silent><Localleader>n <Plug>(coc-rename)
  nmap <silent><Localleader>f <Plug>(coc-refactor)
  nnoremap <silent>[d :silent call CocAction('jumpDefinition', 'tabe')<CR>
  nnoremap <silent>[c :silent call CocAction('jumpDeclaration', 'tabe')<CR>
  nnoremap <silent>[i :silent call CocAction('jumpImplementation', 'tabe')<CR>
  nmap <silent>[j <Plug>(coc-diagnostic-next)
  nmap <silent>[k <Plug>(coc-diagnostic-prev)
  nmap <silent><Localleader>j <Plug>(coc-diagnostic-next-error)
  nmap <silent><Localleader>k <Plug>(coc-diagnostic-prev-error)
  nnoremap <silent>[t :silent call CocAction('diagnosticToggleBuffer')<CR>
  nmap <silent>[l <Plug>(coc-diagnostic-info)
  let g:coc_filetype_map = {'opencl': 'cpp'}
  let g:coc_global_extensions = ['coc-word', 'coc-tag', 'coc-snippets',
           \ 'coc-dictionary', 'coc-yaml', 'coc-cmake', 'coc-clangd',
           \ 'coc-vimlsp', 'coc-sh', 'coc-pyright', 'coc-perl',
           \ 'coc-markdownlint', 'coc-json', 'coc-css', 'coc-tsserver']
  function! Cpp_Workspace_Root()
    let cpp_workspace_root = finddir('.git', '.;')
    if (strlen(cpp_workspace_root) == 0)
      let cpp_workspace_root = expand('%:p:h')
    elseif (cpp_workspace_root ==? '.git')
      let cpp_workspace_root = '.'
    else
      let cpp_workspace_root = strpart(cpp_workspace_root,0,strridx(cpp_workspace_root,'/.git'))
    endif
    return cpp_workspace_root
  endfunction
  function! Cpp_Format_Configuration()
    let cpp_workspace_root = Cpp_Workspace_Root()
    let clang_format = cpp_workspace_root.'/.clang-format'
    if !filereadable(clang_format)
      let clang_format_content = readfile($HOME.'/.vim/.c_cpp/.clang-format')
      call writefile(clang_format_content,clang_format,'s')
    endif
  endfunction
  noremap <silent><Leader><F7> :silent call Cpp_Format_Configuration()<CR>
  nmap <F7>  <Plug>(coc-format)
  xmap <F7>  <Plug>(coc-format-selected)



  " NERDTree Setting, \nt打开目录,\nf从编辑区回到目录
  nnoremap <silent><Leader>nt :NERDTreeToggle<CR>
  let g:NERDTreeFileExtensionHighlightFullName = 1
  let g:NERDTreeExactMatchHighlightFullName = 1
  let g:NERDTreePatternMatchHighlightFullName = 1
  let g:NERDTreeHighlightFolders = 1
  let g:NERDTreeHighlightFoldersFullName = 1
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible = '-'
  let g:NERDTreeHidden = 0



  " Vista setting, Vista toggle
  nnoremap <silent><Leader>vt :Vista!!<CR>
  let g:vista_default_executive = 'coc'
  let g:vista#renderer#enable_icon = 1
  let g:vista_close_on_jump = 1
  let g:vista_cursor_delay = 0
  let g:vista_blink = [0,0]
  let g:vista_top_level_blink = [0,0]
  let g:vista_echo_cursor_strategy = 'echo'



  " vim-bookmarks setting
  let g:bookmark_no_default_key_mappings = 1
  let g:bookmark_auto_close = 1
  " Save bookmarks to the nearest .git which is in parent or current directory,
  " if .git can be found, otherwise save bookmarks to $HOME/.vim
  let g:bookmark_save_per_working_dir = 1
  function! g:BMWorkDirFileLocation()
    let bookmarkextension = 'bookmarks'
    let cur_file_path = expand('%:p:h')
    " Look upwards (at parents) for a directory named '.git' begin form cur_file_path
    let location = finddir('.git', '.;')
    if location ==? '.git'
      " current directory is workspace or current file path has .git directory
      let path_to_pro = getcwd()
    elseif strlen(strpart(location,0,1)) == 1
      " can find .git, but current directory not has .git
      let path_to_pro = strpart(location,0,strridx(location,'/.git'))
    endif
    if len(location) > 0
      if strpart(path_to_pro,0,1)!=?'/'
        let path_to_pro='/'.path_to_pro
      endif
      let pro_dir = strpart(path_to_pro,strridx(path_to_pro,'/'))
      let pro_to_file = strpart(cur_file_path,stridx(cur_file_path,pro_dir)+strlen(pro_dir))
      let location = simplify(location.'/.vim-bookmarks'.pro_to_file)
    else
      " the bookmarks of the root and common user both are saved in the same directory
      if strpart(cur_file_path,0,5) ==? '/root'
        let pro_to_file = cur_file_path
      elseif strpart($SUDO_USER,0,1) ==? ''
        let pro_to_file = strpart(cur_file_path,strlen($HOME))
      else
        let pro_to_file = strpart(cur_file_path,strlen('/home/'.$SUDO_USER))
      endif
      if strpart($SUDO_USER,0,1) ==? ''
        let location = $HOME.'/.vim/.vim-bookmarks'.pro_to_file
      else
        let location = '/home/'.$SUDO_USER.'/.vim/.vim-bookmarks'.pro_to_file
      endif
    endif
    if !isdirectory(location)
      call mkdir(location,'p')
    endif
      return simplify(location.'/'.expand('%:t').'.'.bookmarkextension)
  endfunction
  nnoremap <silent><Leader>bo :silent call plug#load('vim-bookmarks')<CR>
  nnoremap <silent><Leader>bt :BookmarkToggle<CR>
  nnoremap <silent><Leader>ba :BookmarkAnnotate<CR>
  nnoremap <silent><Leader>bs :BookmarkShowAll<CR>
  nnoremap <silent><Leader>bn :BookmarkNext<CR>
  nnoremap <silent><Leader>bp :BookmarkPrev<CR>
  nnoremap <silent><Leader>bc :BookmarkClear<CR>
  nnoremap <silent><Leader>br :BookmarkClearAll<CR>
  nmap <silent><Leader>bu <Plug>BookmarkMoveUp
  nmap <silent><Leader>bd <Plug>BookmarkMoveDown
  nmap <silent><Leader>bl <Plug>BookmarkMoveToLine



  " fcitx.nvim setting
  nnoremap <silent><Leader><Localleader> :silent call plug#load('fcitx.vim')<CR>



  " vim-interestingwords setting, highlight:\k ,  clear all:\K
  nnoremap <silent><Localleader>h :silent call plug#load('vim-interestingwords')<CR>
  let g:interestingWordsRandomiseColors = 1



  " vim-fugitive and vim-gitgutter setting
  nnoremap <silent><Leader>git :silent normal! m`<CR>
                             \ :silent call plug#load('vim-fugitive')<CR>
                             \ :silent call plug#load('vim-gitgutter')<CR>
                             \ :set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [ASCII=0x%B]%m%r<CR>
                             \ :set statusline+=%=\ %{GitStatus()}%{FugitiveStatusline()}<CR>
                             \ :set statusline+=\ [%{strftime(\"%d/%m/%y-%H:%M\")}]%<<CR>
                             \ :silent normal! ``<CR>
  let g:fugitive_no_maps = 1
  let g:gitgutter_map_keys = 0
  function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endfunction
  let g:gitgutter_map_keys = 0
  nmap <silent><Leader>gp <Plug>(GitGutterPrevHunk)
  nmap <silent><Leader>gn <Plug>(GitGutterNextHunk)
  nmap <silent><Leader>gf <Plug>(GitGutterFold)



  " vimspector setting
  function! Cpp_Debug_Configuration()
    let cpp_workspace_root = Cpp_Workspace_Root()
    let launch_json = cpp_workspace_root.'/.vscode/launch.json'
    if !filereadable(launch_json)
      call mkdir(cpp_workspace_root.'/.vscode', 'p', 0755)
      let launch_json_content = readfile($HOME.'/.vim/.c_cpp/.vscode/launch.json')
      call writefile(launch_json_content,launch_json,'s')
    endif
    let vimspector_json = cpp_workspace_root.'/.vimspector.json'
    if !filereadable(vimspector_json)
      let cpp_json_content = readfile($HOME.'/.vim/.c_cpp/.vimspectorjson/cpp.json')
      call writefile(cpp_json_content,vimspector_json,'s')
    endif
      exec 'tabe ' . vimspector_json
  endfunction
  nmap <silent><F2> <Plug>VimspectorContinue
  nnoremap <silent><S-F2> :VimspectorReset<CR>
  nnoremap <silent>]<F2> :call vimspector#Restart()<CR>
  nmap <silent>]<C-F2> <Plug>VimspectorPause
  nmap <silent>]<S-F2> <Plug>VimspectorStop
  nmap <silent>]<F3> <Plug>VimspectorBalloonEval
  xmap <silent>]<F3> <Plug>VimspectorBalloonEval
  nmap <silent>]<S-F3> <Plug>VimspectorRunToCursor
  nmap <silent><F4> <Plug>VimspectorToggleBreakpoint
  nnoremap <silent><S-F4> :call vimspector#ClearBreakpoints()<CR>
  nmap <silent>]<F4> <Plug>VimspectorToggleConditionalBreakpoint
  nnoremap <silent>]<S-F4> :call vimspector#SetAdvancedLineBreakpoint()<CR>
  nnoremap <silent>]<C-F4> :call vimspector#AddAdvancedFunctionBreakpoint()<CR>
  nnoremap <silent><F5> :silent call plug#load('vimspector')<CR>
  nnoremap <silent>]<F5> :set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 19<CR>
                       \ :silent call plug#load('vimspector')<CR>
                       \ :call vimspector#Launch()<CR>
  nnoremap <silent><Leader><F5> :silent call Cpp_Debug_Configuration()<CR>
  nmap <silent><F6> <Plug>VimspectorStepOver
  nmap <silent><C-F6> <Plug>VimspectorStepInto
  nmap <silent><S-F6> <Plug>VimspectorStepOut
  nmap <silent>]<F7> <Plug>VimspectorUpFrame
  nmap <silent>]<S-F7> <Plug>VimspectorDownFrame
  nnoremap <silent>]<F8> :let g:vimspector_variables_display_mode = 'full'<CR>
  nnoremap <silent><C-1> :call win_gotoid( g:vimspector_session_windows.variables )<CR>
  nnoremap <silent><C-3> :call win_gotoid( g:vimspector_session_windows.code )<CR>
  nnoremap <silent><C-4> :call win_gotoid( g:vimspector_session_windows.terminal )<CR>
  nnoremap <silent><C-7> :call win_gotoid( g:vimspector_session_windows.watches )<CR>
  nnoremap <silent><C-9> :VimspectorShowOutput Console<CR>
  sign define vimspectorBP            text=B texthl=WarningMsg
  sign define vimspectorBPCond        text=BC texthl=WarningMsg
  sign define vimspectorBPLog         text=BL texthl=SpellRare
  sign define vimspectorBPDisabled    text=BD texthl=LineNr
  sign define vimspectorPC            text=$ texthl=MatchParen linehl=CursorLine
  sign define vimspectorPCBP          text=●>  texthl=MatchParen linehl=CursorLine
  sign define vimspectorCurrentThread text=>   texthl=MatchParen linehl=CursorLine
  sign define vimspectorCurrentFrame  text=>   texthl=Special    linehl=CursorLine
  function! s:SetUpUI() abort
    call win_execute( g:vimspector_session_windows.stack_trace, 'q' )
    call win_gotoid( g:vimspector_session_windows.watches )
    nunmenu WinBar
    call win_gotoid( g:vimspector_session_windows.variables )
    23wincmd _
    nunmenu WinBar
    let g:vimspector_bottombar_height = 15
    call win_gotoid( g:vimspector_session_windows.code )
    103wincmd |
    23wincmd _
    nunmenu WinBar
  endfunction
  function! s:SetUpTerminal()
    call win_gotoid( g:vimspector_session_windows.terminal )
    3wincmd |
  endfunction
  augroup VimspectorCustom
    autocmd!
    autocmd User VimspectorUICreated call s:SetUpUI()
    autocmd User VimspectorTerminalOpened call s:SetUpTerminal()
  augroup END



  " leaderf setting,列出当前文件函数(:LeaderfFunction),使用rg模糊查找(:Leaderf rg)
  " ctrl+j/k上下选择显示查找结果，ctrl+上/下键上下移动被显示的查找结果的内容
  let g:Lf_GtagsAutoGenerate = 0
  let g:Lf_Gtagslabel = 'native-pygments'
  let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }
  let g:Lf_RootMarkers = ['.root', '.svn', '.git', '.hg', '.project']
  let g:Lf_WorkingDirectoryMode = 'Ac'
  let g:Lf_CacheDirectory = expand('~/.vim/cache')
  let g:Lf_CursorBlink = 0
  let g:Lf_RgConfig = [
          \ '--max-columns=150',
          \ '--type-add web:*.{html,css,js}*',
          \ '--glob=!git/*',
          \ '--hidden'
      \ ]
  let g:Lf_PreviewInPopup = 1
  " open the preview window automatically
  let g:Lf_PreviewResult = {'Rg': 1 }
  let g:Lf_ShortcutB = '<Leader>fb'
  let g:Lf_ShortcutF = '<Leader>ff'
endfunction



" vim-cpp-modern
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_simple_highlight = 1



" python-syntax setting
let g:python_highlight_builtins = 1
let g:python_highlight_string_formatting = 1
let g:python_highlight_func_calls = 1
let g:python_highlight_class_vars = 1
let g:python_highlight_operators = 1
let g:python_highlight_file_headers_as_comments = 1



function! Lazy_Plugin_Configuration()
   " markdown-preview.nvim setting
   let g:mkdp_browser = '/usr/bin/firefox'



  " vim-markdown-toc setting :GenTocGFM :UpdateToc :RemoveToc generate the menu
  " at the top, mark the last line of the menu and delete the space line.
  " If you want to go to the last line of the menu, you can press `` in normal mode
  nnoremap <silent><Leader>gm ggO<ESC>:GenTocGFM<CR>m`ggdd
  nnoremap <silent><Leader>um :UpdateToc<CR>
  let g:vmt_auto_update_on_save = 0



  " nerdcommenter插件快速注释
  let g:NERDSpaceDelims            = 1      " 在注释符号后加一个空格
  let g:NERDCompactSexyComs        = 1      " 紧凑排布多行注释
  let g:NERDToggleCheckAllLines    = 1      " 检查选中项是否有没被注释的项，有则全部注释
  let g:NERDDefaultAlign           = 'left' " 逐行注释左对齐
  let g:NERDCommentEmptyLines      = 1      " 允许空行注释
  let g:NERDTrimTrailingWhitespace = 1      " 取消注释时删除行尾空格
  let g:NERDToggleCheckAllLines    = 1      " 检查选中的行操作是否成功
  let g:NERDAltDelims_c            = 1      " use // to comment c source codes.
  let g:NERDCustomDelimiters = { 'opencl': { 'left': '//' } } " use // to comment cl source codes.
  map <silent><F3> <plug>NERDCommenterComment
  map <silent><S-F3> <plug>NERDCommenterUncomment



  " asyncrun setting,自动打开 quickfix window ，高度为 6
  let g:asyncrun_open = 6
  let g:asyncrun_bell = 1
  nnoremap <silent><F8> :silent call asyncrun#quickfix_toggle(6)<CR>
  nnoremap <Localleader><F8> :AsyncRun! 



  " vim-quickui setting
  " clear all the menus
  call quickui#menu#reset()
  " install a 'File' menu, use [text, command] to represent an item.
  call quickui#menu#install('&File', [
              \ [ "&New File\tCtrl+n", 'echo 0' ],
              \ [ "&Open File\t(F3)", 'echo 1' ],
              \ [ '&Close', 'echo 2' ],
              \ [ '--', '' ],
              \ [ '&Save\tCtrl+s', 'echo 3'],
              \ [ 'Save &As', 'echo 4' ],
              \ [ 'Save All', 'echo 5' ],
              \ [ '--', '' ],
              \ [ "E&xit\tAlt+x", 'echo 6' ],
              \ ])
  " items containing tips, tips will display in the cmdline
  call quickui#menu#install('&Edit', [
              \ [ '&Copy', 'echo 1', 'help 1' ],
              \ [ '&Paste', 'echo 2', 'help 2' ],
              \ [ '&Find', 'echo 3', 'help 3' ],
              \ ])
  " script inside %{...} will be evaluated and expanded in the string
  call quickui#menu#install('&Option', [
        \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
        \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
        \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
        \ ])
  " register HELP menu with weight 10000
  call quickui#menu#install('H&elp', [
        \ ['&Cheatsheet', 'help index', ''],
        \ ['T&ips', 'help tips', ''],
        \ ['--',''],
        \ ['&Tutorial', 'help tutor', ''],
        \ ['&Quick Reference', 'help quickref', ''],
        \ ['&Summary', 'help summary', ''],
        \ ], 10000)
  " enable to display tips in the cmdline
  let g:quickui_show_tip = 1
  " color scheme for the menu plugin,five color schemes we can choose default is
  " borland,another four are gruvbox, solarized,papercol dark and papercol light
  if has('gui_running')
    let g:quickui_color_scheme = 'papercol light'
  else
    let g:quickui_color_scheme = 'papercol dark'
  endif
  " hit \qm to open menu
  noremap <silent><Leader>qm :call quickui#menu#open()<CR>
  " hit \qb to switch buffer
  noremap <silent><Leader>qb :call quickui#tools#list_buffer('e')<CR>
  " hit \qt to preview tags
  noremap <silent><Leader>qt :call quickui#tools#preview_tag('')<CR>
endfunction



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关和实用设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 会使vim看起来不友好的命令
if has('gui_running')
  if !has('nvim')
    " set guifont=Monospace\ 18   " 设置字体
    " set guifont=DejaVuSansM\ Nerd\ Font\ Mono\ 19   " 设置字体
    set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 21   " 设置字体
  endif
  " 设定窗口大小
  set lines=60 columns=80
  " 隐藏滚动栏
  set guioptions-=r
  " tab只显示文件名不显示标签
  set guitablabel=%t
endif
set shortmess+=c
set showcmd
set foldmethod=manual
set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [ASCII=0x%B]%m%r
set statusline+=%=\ [%{strftime(\"%d/%m/%y-%H:%M\")}]%<
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
" 不要闪烁
set novisualbell
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 显示行号
set number
" merge signcolumn and number column into one
set signcolumn=number
" Uncomment the following to have Vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Tab键的显示宽度
set tabstop=3
" 按下Tab键时输入的宽度
set softtabstop=3
" 把Tab字符用空格代替，和tabstop相关
set expandtab
" 设置自动缩进时的缩进长度
set shiftwidth=3
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
" 缩进
set autoindent
autocmd FileType c,cpp set cindent " 设置使用C/C++语言的自动缩进方式
set smartindent "
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
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=3
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
  autocmd BufNewFile *.[ch]pp,*.[ch],*.sh,*.v,*.cl,*.pl,*.tcl exec ':call SetTitle()'
  autocmd FileType c,cpp,python,sh,verilog,perl,tcl,markdown
           \ nnoremap <silent><Localleader><F2>
           \ :call Compile_And_Excute()<CR>
  autocmd FileType c,cpp,verilog nnoremap <silent><Leader><F2>
           \ :call Compile_Command()<CR>
  autocmd FileType vim nnoremap <silent><Localleader><F2>
           \ :source ~/.vimrc<CR>
  autocmd FileType c,cpp,verilog nnoremap <silent><Leader>` :call Call_Show_Nearest_Function()<CR>
  if has('nvim')
    autocmd UIEnter * silent call TabPos_Initialize()
  else
    autocmd GUIEnter * silent call TabPos_Initialize()
  endif
augroup END
function! SetTitle()
  if &filetype==?'sh' || &filetype==?'perl' || &filetype==?'tcl'
    call setline(1,'#########################################################################')
    call append(line('$'), '# File Name: '.expand('%'))
    call append(line('$'), '# Author: Huaxiao Liang')
    call append(line('$'), '# mail: 1184903633@qq.com')
    call append(line('$'), '# Created Time: '.strftime('%c'))
    call append(line('$'), '#########################################################################')
    if &filetype==?'sh'
      call append(line('$'), '#!/bin/bash')
    elseif &filetype==?'perl'
      call append(line('$'), '#!/bin/perl')
      call append(line('$'), 'use strict;')
      call append(line('$'), 'use warnings;')
    elseif &filetype==?'tcl'
      call append(line('$'), '#!/usr/bin/tclsh')
    endif
    call append(line('$'), '')
  else
    call setline(1, '/*************************************************************************')
    call append(line('$'), '  > File Name: '.expand('%'))
    call append(line('$'), '  > Author: Huaxiao Liang')
    call append(line('$'), '  > Mail: 1184903633@qq.com')
    call append(line('$'), '  > Created Time: '.strftime('%c'))
    call append(line('$'), ' ************************************************************************/')
    call append(line('$'), '')
  endif
  if &filetype==?'cpp' && expand('%:e')==?'cpp'
    call append(line('$'), '#include <iostream>')
    call append(line('$'), '')
  elseif &filetype==?'c'
    call append(line('$'), '#include <stdio.h>')
    call append(line('$'), '')
  elseif &filetype==?'verilog'
    call append(line('$'),'module ')
  endif
  exec 'silent normal! G'
endfunc
function! Compile_And_Excute()
  if &filetype==?'cpp'
    exec ':AsyncRun! -save=1 g++ % -o E%<.exe -g -lboost_program_options -lOpenCL && ./E%<.exe'
  elseif &filetype==?'c'
    exec ':AsyncRun! -save=1 gcc % -o E%<.exe -g -lOpenCL && ./E%<.exe'
  elseif &filetype==?'python'
    exec ':AsyncRun! -save=1 python3 %'
  elseif &filetype==?'sh'
    exec ':AsyncRun! -save=1 ./%'
  elseif &filetype==?'verilog'
    exec ':AsyncRun! -save=1 iverilog *.v -o %<.vcd && vvp %<.vcd'
  elseif &filetype==?'perl'
    exec ':AsyncRun! -save=1 perl %'
  elseif &filetype==?'tcl'
    exec ':AsyncRun! -save=1 tclsh %'
  elseif &filetype==?'markdown'
    exec ':MarkdownPreview'
  endif
endfunction
function! Compile_Command()
  if &filetype==?'cpp'
    exec ':AsyncRun! -save=1 g++ % -o E%<.exe -g -lboost_program_options -lOpenCL'
  elseif &filetype==?'c'
    exec ':AsyncRun! -save=1 gcc % -o E%<.exe -g -lOpenCL'
  elseif &filetype==?'verilog'
    exec ':AsyncRun! -save=1 iverilog *.v -o %<.vcd'
  endif
endfunction
function! Show_Current_Module()
  let module_line = search('module','bnWz')
  let module_name = getline(module_line)
  let module_end_poisition = strridx(module_name,'(')
  if(module_end_poisition > 0)
    let module_name = strpart(module_name,0,module_end_poisition)
  endif
  let module_name = strpart(module_name,stridx(module_name,'module')+7)
  while(strpart(module_name, 0 , 1) ==? ' ')
    let module_name = strpart(module_name,1)
  endwhile
  echo 'module -->' module_name
endfunction
function! Show_Nearest_Class_Or_Struct()
  let class_line = search('\n'.'class','bnWz')
  let struct_line = search('\n'.'struct','bnWz')
  if(class_line > struct_line)
    let nearest_name = getline(class_line+1)
  elseif(class_line < struct_line)
    let nearest_name = getline(struct_line+1)
  else
    let nearest_name = 'No class/struct can be find.'
  endif
  let nearest_end_poisition = strridx(nearest_name,'{')
  if(nearest_end_poisition > 0)
    let nearest_name = strpart(nearest_name,0,nearest_end_poisition)
  endif
  echo nearest_name
endfunction
function! Call_Show_Nearest_Function()
  if &filetype==?'cpp' || &filetype==?'c'
     call Show_Nearest_Class_Or_Struct()
  elseif &filetype==?'verilog'
     call Show_Current_Module()
  endif
endfunction
" alt+n跳到第n个tab，0<n<10
function! TabPos_ActivateBuffer(num)
    let s:count = a:num
    exec 'tabfirst'
    exec 'tabnext' s:count
endfunction
function! TabPos_Initialize()
for i in range(1, 9)
        exec 'noremap <silent><M-' . i . '> :silent call TabPos_ActivateBuffer(' . i . ')<CR>'
    endfor
    exec 'noremap <silent><M-0> :silent call TabPos_ActivateBuffer(10)<CR>'
endfunction
" Toggle Menu and Toolbar菜单栏和工具栏
if has('gui_running')
  set guioptions-=m
  set guioptions-=T
  nnoremap <silent><Localleader>m :silent call MENU_TOOGLE()<CR>
  function! MENU_TOOGLE()
    if &guioptions=~#'T'
      set guioptions-=T
      set guioptions-=m
    else
      set guioptions+=T
      set guioptions+=m
    endif
  endfunction
endif
nnoremap <silent><Localleader>t :tabnew<CR>
nnoremap <silent><Localleader>b :silent call Close_and_Back_Tab()<CR>
function! Close_and_Back_Tab()
  exec 'tabp'
  exec '+tabclose'
endfunction
nnoremap <silent><Localleader>q :q<CR>
nnoremap <silent><Localleader>w :w<CR>
nnoremap <silent><Localleader><F4> :%retab!<CR>
" 比较文件
nnoremap <Localleader><F5> :vert diffsplit
nnoremap <silent><Localleader><F6> :silent call Delete_Blank_Line()<CR>
function! Delete_Blank_Line()
  exec 'silent normal! m`'
  exec 'silent :g/^\s*$/d'
  exec 'silent normal! ``'
endfunction
nnoremap <silent><Localleader><F7> :silent call Delete_Trailling_Space()<CR>
function! Delete_Trailling_Space()
  exec 'silent normal! m`'
  exec 'silent :%s/\s\+$//e'
  exec 'silent normal! ``'
endfunction
" Ctrl-Enter在普通模式下像插入模式一样使用回车
nnoremap <silent><C-CR> i<CR><ESC>
" Alt-Enter新建空行
nnoremap <silent><M-CR> o<ESC>g$d0
inoremap <silent><M-CR> <ESC>o<ESC>g$d0i
