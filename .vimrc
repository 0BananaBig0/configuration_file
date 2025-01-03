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
"There are some commands you may need to know: you can use tab key to complete
"if you want to use the shell command,you can add ! before your shell command,
"for example,if you want to use ls command,you can type the  :!ls  in the vim normal mode
"or correct your vim commands you type
"vimplug:  PlugInstall PlugUpdate PlugUpgrade



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



let g:plug_url_format = 'https://githubfast.com/%s.git'
call plug#begin('~/.vim/plugged')
" vim theme, No_Lazy
Plug 'dracula/vim', {'as': 'dracula'}
" 彩虹括号
Plug 'luochen1990/rainbow'
" 缩进显示
Plug 'nathanaelkane/vim-indent-guides'
" highlight opencl 2.0 syntax
Plug 'brgmnn/vim-opencl', {'for': []}
" highlight qml syntax
Plug 'peterhoeg/vim-qml', {'for': ['qml']}
" 高亮c++类模板等插件
Plug 'bfrg/vim-c-cpp-modern', {'for': ['cpp', 'c', 'opencl']}
" python 语法高亮插件
Plug 'vim-python/python-syntax', {'for': ['python']}
" verilog indent file
Plug '0BananaBig0/verilog_indent', {'for': ['verilog']}
" highlight qmake syntax
Plug 'artoj/qmake-syntax-vim', {'for': ['qmake']}
" markdown目录构建插件
Plug 'mzlogin/vim-markdown-toc', {'for': []}
" 补全插件, 动态检测语法插件, 可鼠标停留显示信息, Delay-load
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" vim快捷键管理和提示插件
Plug 'liuchengxu/vim-which-key', {'on': []}
" nerdcommenter快速注释插件
Plug 'preservim/nerdcommenter', {'on': []}
" 异步执行shell命令插件
Plug 'skywind3000/asyncrun.vim', {'on': []}
" 菜单栏插件, Manual-load
Plug 'skywind3000/vim-quickui', {'on': []}
" 文件目录插件
Plug 'preservim/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeCWD']}
" 标签窗口列表插件
Plug 'liuchengxu/vista.vim', {'on': ['Vista!!', 'Vista focus']}
" 书签插件，用于写代码注解等等
Plug 'MattesGroeger/vim-bookmarks', {'on': ['BookmarkToggle', 'BookmarkShowAll', 'BookmarkAnnotate']}
" Multiple highlights
Plug 'lfv89/vim-interestingwords', {'on': []}
" Git command
Plug 'tpope/vim-fugitive', {'on': []}
" Git status show
Plug 'airblade/vim-gitgutter', {'on': []}
" c/cpp debug
Plug 'puremourning/vimspector', {'on': []}
" 快速查找插件，包括查找文件，当前文件函数，模糊查找字段
Plug 'Yggdroot/LeaderF', {'on': ['Leaderf', 'LeaderfFunction', 'LeaderfBuffer', 'LeaderfFile']}
" LeaderF extension for navigate the marks
Plug 'Yggdroot/LeaderF-marks', {'on': ['Leaderf', 'LeaderfFunction', 'LeaderfBuffer', 'LeaderfFile']}
call plug#end()
" 插件疑似不支持按文件类型加载，手动添加autocmd判断，也不支持利用vim的特性延迟加载
augroup Call_Highlight_Plugin
  autocmd BufNewFile,BufRead *.cl call plug#load('vim-opencl')
  autocmd BufNewFile,BufRead */include/* set filetype=cpp
  autocmd BufNewFile,BufRead *.launch set filetype=xml
  autocmd BufNewFile,BufRead *.qrc set filetype=xml
augroup END



colorscheme dracula
nnoremap <Leader>ppt :colorscheme zellner<CR>
                   \ :set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 23<CR>
                   \ :IndentGuidesDisable<CR>



" rainbow setting
let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle



" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_tab_guides = 0
let g:indent_guides_default_mapping = 0



" vim-c-cpp-modern
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_operator_highlight = 1



" python-syntax setting
let g:python_highlight_builtins = 1
let g:python_highlight_string_formatting = 1
let g:python_highlight_func_calls = 1
let g:python_highlight_class_vars = 1
let g:python_highlight_operators = 1
let g:python_highlight_file_headers_as_comments = 1



" After 333ms, call the coc.nvim, markdown-preview and so on
let g:coc_start_at_startup = 0
function! CocTimerStart(timer)
  exec 'CocStart'
  call plug#load('vim-which-key')
  call MarkdownPluginConfiguration()
  call DelayedPluginConfiguration()
  call ManualLoadPluginConfiguration()
  call plug#load('nerdcommenter')
  call plug#load('asyncrun.vim')
endfunction
call timer_start(333,'CocTimerStart',{'repeat':1})



function! MarkdownPluginConfiguration()
  " coc-markmap, coc-markdownlint setting
  " Watch workflow from the whole file
  nnoremap <Leader>mm :CocCommand markmap.watch<CR>
  " Create markmap html file
  nnoremap <Leader>mc :CocCommand markmap.create --offline<CR>
  nnoremap <Leader>mh <Plug>(coc-markmap-create)
  vnoremap <Leader>mh <Plug>(coc-markmap-create-v)
  nnoremap <Leader>mf :CocCommand markdownlint.fixAll<CR>



  " vim-markdown-toc setting :GenTocGFM :UpdateToc :RemoveToc generate the menu
  " If you want to go to the last line of the menu, you can press `` in normal mode
  nnoremap <Leader>mg :call CreateMarkdownMenu()<CR>
  nnoremap <Leader>mu :call UpdateMarkdownMenu()<CR>
  let g:vmt_auto_update_on_save = 0
  let g:vmt_list_item_char = '-'
  function! CreateMarkdownMenu()
    exec 'normal! ms'
    if !exists(':GenTocGFM')
      call plug#load('vim-markdown-toc')
    endif
    exec "normal! ggO\<ESC>"
    exec ':GenTocGFM'
    exec 'normal! ggdd`s'
  endfunction
  function! UpdateMarkdownMenu()
    let l:previous_column = col('.')
    let l:previous_line = line('.')
    let l:previous_total_line_count = line('$')
    if !exists(':UpdateToc')
      call plug#load('vim-markdown-toc')
    endif
    exec ':UpdateToc'
    let l:new_line = l:previous_line + (line('$') - l:previous_total_line_count)
    call setpos('.', [0, l:new_line, l:previous_column, 0])
  endfunction
endfunction



function! DelayedPluginConfiguration()
  " vim-which-key setting
  let g:which_key_fallback_to_native_key=0
  nnoremap <Leader> :WhichKey '<Leader>'<CR>
  nnoremap <Space> :WhichKey '<Space>'<CR>
  nnoremap [ :WhichKey '['<CR>
  nnoremap ] :WhichKey ']'<CR>



  " coc setting
  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped
  " by other plugin before putting this into your config.
  inoremap <expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ CheckBackspace() ? "\<Tab>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice.
  inoremap <expr> <CR> coc#pum#visible() ? coc#_select_confirm()
                      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  nmap <Space>c <Plug>(coc-declaration)
  nmap <Space>d <Plug>(coc-definition)
  nmap <Space>f <Plug>(coc-refactor)
  nmap <Space>i <Plug>(coc-implementation)
  nmap <Space>j <Plug>(coc-diagnostic-next-error)
  nmap <Space>k <Plug>(coc-diagnostic-prev-error)
  nmap <Space>n <Plug>(coc-rename)
  nmap <Space>r <Plug>(coc-references)
  nmap [a <Plug>(coc-codeaction)
  nmap [e <Plug>(coc-codeaction-line)
  nnoremap [c :call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpDeclaration', 'tabe')<CR>
  nnoremap [d :call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpDefinition', 'tabe')<CR>
  nnoremap [i :call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpImplementation', 'tabe')<CR>
  nmap [j <Plug>(coc-diagnostic-next)
  nmap [k <Plug>(coc-diagnostic-prev)
  nmap [l <Plug>(coc-diagnostic-info)
  nmap [s <Plug>(coc-codeaction-selected)
  vmap [s <Plug>(coc-codeaction-selected)
  nnoremap [b :call CocActionAsync('diagnosticToggleBuffer')<CR>
  nnoremap [t :call CocActionAsync('diagnosticToggle', 1)<CR>
  let g:coc_filetype_map = {'opencl': 'cpp'}
  let g:coc_global_extensions = ['coc-word', 'coc-tag', 'coc-dictionary', 'coc-snippets',
           \ 'coc-prettier', 'coc-yaml', 'coc-cmake', 'coc-clangd', 'coc-perl', 'coc-vimlsp',
           \ 'coc-sh', 'coc-pyright', 'coc-webview', 'coc-markmap', 'coc-markdown-preview-enhanced',
           \ 'coc-markdownlint', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-xml']
  let g:root_patterns = ['.git', '.hg', '.projections.json', '.project', '.svn', '.root', 'SConstruct']
  function! FindRoot(target_path)
    let l:workspace_root_dir =''
    let l:workspace_root_file =''
    for l:pattern in g:root_patterns
      if empty(l:workspace_root_dir)
        let l:workspace_root_dir = finddir(l:pattern, a:target_path.';')
      endif
      if empty(l:workspace_root_file)
        let l:workspace_root_file = findfile(l:pattern, a:target_path.';')
      endif
      if !empty(l:workspace_root_dir) && !empty(l:workspace_root_file)
        break
      endif
    endfor
    if !empty(l:workspace_root_dir)
      let l:workspace_root_dir = substitute(fnamemodify(l:workspace_root_dir, ':p'), '/$', '', '')
      let l:workspace_root_dir = strpart(l:workspace_root_dir, 0, strridx(l:workspace_root_dir,'/'))
    endif
    if !empty(l:workspace_root_file)
      let l:workspace_root_file = substitute(fnamemodify(l:workspace_root_file, ':p'), '/$', '', '')
      let l:workspace_root_file = strpart(l:workspace_root_file, 0, strridx(l:workspace_root_file,'/'))
    endif
    if len(l:workspace_root_dir) < len(l:workspace_root_file)
      return l:workspace_root_file
    endif
    return l:workspace_root_dir
  endfunction
  function! JumpToTheMainWin()
    let l:target_win = win_getid()
    let l:cur_tab = tabpagenr()
    for l:win in getwininfo()
      if l:win['tabnr'] == l:cur_tab && l:win['winid'] < l:target_win
        let l:target_win = l:win['winid']
      endif
    endfor
    call win_gotoid(l:target_win )
  endfunction
  function! WorkspaceRoot()
    if &filetype==?'help' || &buftype ==?'terminal' || &filetype==?'VimspectorPrompt'
        \ || &filetype==?'vista' || &buftype ==?'nofile' || &filetype==?'nerdtree'
      call JumpToTheMainWin() " Avoid potential bugs
    endif
    let l:workspace_root = FindRoot(expand('%:p:h')) " Where we store the opened file
    if empty(l:workspace_root)
      echo 'You had better create a root-pattern file like .git in your project.'
      return expand('%:p:h')
    endif
    return l:workspace_root
  endfunction
  function! CopyFileRelToCPP(cpp_workspace_root, file_name)
    let l:related_file = a:cpp_workspace_root.'/'.a:file_name
    let l:related_file_source = $HOME.'/.vim/.c_cpp/'.a:file_name
    if !filereadable(l:related_file) && filereadable(l:related_file_source)
      let l:clang_file_content = readfile(l:related_file_source)
      call writefile(l:clang_file_content, l:related_file, 's')
    elseif filereadable(l:related_file)
      echo 'The '.l:related_file.' file has existed.'
    else
      echo 'The '.l:related_file_source.' file does not exist.'
    endif
  endfunction
  function! ClangToolConfiguration()
    let l:cpp_workspace_root = WorkspaceRoot()
    call CopyFileRelToCPP(l:cpp_workspace_root, '.clang-format')
    call CopyFileRelToCPP(l:cpp_workspace_root, '.clang-tidy')
  endfunction
  noremap <Leader><F7> :call ClangToolConfiguration()<CR>
  nmap <F7>  <Plug>(coc-format)
  vmap <F7>  <Plug>(coc-format-selected)
  " Use K to show documentation in preview window
  nnoremap K :call ShowDocumentation()<CR>
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
  " Highlight the symbol and its references when holding the cursor
  augroup Plugin_Configuration | autocmd CursorHold * call CocActionAsync('highlight') | augroup END
  hi sym_hilight guifg='White' guibg='Black'



  " nerdcommenter插件快速注释
  let g:NERDSpaceDelims            = 1      " 在注释符号后加一个空格
  let g:NERDCompactSexyComs        = 1      " 紧凑排布多行注释
  let g:NERDToggleCheckAllLines    = 1      " 检查选中项是否有没被注释的项，有则全部注释
  let g:NERDDefaultAlign           = 'left' " 逐行注释左对齐
  let g:NERDCommentEmptyLines      = 1      " 允许空行注释
  let g:NERDTrimTrailingWhitespace = 1      " 取消注释时删除行尾空格
  let g:NERDToggleCheckAllLines    = 1      " 检查选中的行操作是否成功
  let g:NERDAltDelims_c            = 1      " use // to comment c source codes.
  let g:NERDCustomDelimiters = {'opencl': {'left': '//'}} " use // to comment cl source codes.
  let g:NERDCustomDelimiters = {'qmake': {'left': '#'}} " use // to comment cl source codes.
  let g:NERDCreateDefaultMappings = 0
  map <F3> <plug>NERDCommenterComment
  map <S-F3> <plug>NERDCommenterUncomment



  " asyncrun setting
  let g:tab_term_buf_size = 33
  function! JumpToTerm()
    if !exists('g:tab_term_buf')
      let g:tab_term_buf = repeat([-1], g:tab_term_buf_size)
    endif
    let l:target_buf = -1
    let l:target_win = -1
    for l:win in getwininfo()
      if l:win['terminal'] == 1 && l:win['bufnr'] > l:target_buf
        let l:target_buf = l:win['bufnr']
        let l:target_win = l:win['winid']
      endif
    endfor
    if l:target_buf != -1 && l:target_win != -1
      call win_gotoid(l:target_win)
      call feedkeys("\<C-\>\<C-n>", 'n')
      let g:tab_term_buf[tabpagenr()] = l:target_buf
    endif
  endfunction
  function! ToggleTerminal(height)
    " Step 1: Check if there is a terminal window visible in the current tab
    let l:terminal_shown = 0
    let l:cur_tab = tabpagenr()
    " Create an array to store the most recent terminal buffer for each tab
    if !exists('g:tab_term_buf')
      let g:tab_term_buf = repeat([-1], g:tab_term_buf_size)
    endif
    " Loop through all windows in the current tab to check for a terminal
    for l:win in getwininfo()
      if l:win['terminal'] == 1 && l:win['tabnr'] == l:cur_tab
        " A terminal window is found, set the flag and get the buffer number
        let l:terminal_shown = 1
        if l:win['bufnr'] > g:tab_term_buf[l:cur_tab]
          let g:tab_term_buf[l:cur_tab] = l:win['bufnr']
        endif
        " Switch to the terminal window to hide it
        call win_gotoid(l:win['winid'])
        hide
      endif
    endfor
    " Step 2: If no terminal window is visible, check for a hidden terminal buffer
    if l:terminal_shown == 0
      " Get the list of all buffers and find the latest terminal buffer
      let l:latest_terminal = g:tab_term_buf[l:cur_tab]
      " Step 3: Open the latest terminal buffer if found, or open a new terminal
      if l:latest_terminal != -1 && bufexists(l:latest_terminal)
        " Open the terminal buffer in a new split at the bottom with the specified height
        exec 'belowright ' . a:height . ' split | b ' . l:latest_terminal
      else
        " If no terminal buffer exists, open a new terminal at the bottom with the specified height
        exec 'belowright ' . ' terminal'
        exec 'resize ' . a:height
        let g:tab_term_buf[l:cur_tab] = bufnr('%')
      endif
      call feedkeys("\<C-\>\<C-n>", 'n')
    endif
  endfunction
  function! UpdateTabTermBuf(id_first, id_last, plus_or_minus_one)
    for l:term_index in range(a:id_first, a:id_last, a:plus_or_minus_one[1])
      if(g:tab_term_buf[l:term_index] != -1)
        let g:tab_term_buf[l:term_index + a:plus_or_minus_one[0]] = g:tab_term_buf[l:term_index]
        let g:tab_term_buf[l:term_index] = - 1
      endif
    endfor
  endfunction
  function! CUpdateTabTermBuf(buf_id = -1)
    if exists('g:tab_term_buf')
      if bufexists(g:tab_term_buf[tabpagenr()])
        if a:buf_id != g:tab_term_buf[tabpagenr()] && a:buf_id != -1
          return
        elseif a:buf_id == -1
          exec 'silent bwipeout! ' . g:tab_term_buf[tabpagenr()]
        endif
      endif
      let g:tab_term_buf[tabpagenr()] = - 1
      call UpdateTabTermBuf(tabpagenr() + 1, tabpagenr('$'), [-1, +1])
    endif
  endfunction
  function! NUpdateTabTermBuf()
    if exists('g:tab_term_buf')
      call UpdateTabTermBuf(tabpagenr('$'), tabpagenr() + 1, [+1, -1])
      let g:tab_term_buf[tabpagenr() + 1] = - 1
    endif
  endfunction
  function! CAllTermsOfCurTab()
    " Loop through all windows in the current tab to check for a terminal
    let l:cur_tab = tabpagenr()
    for l:win in getwininfo()
      if l:win['terminal'] == 1 && l:win['tabnr'] == l:cur_tab && bufexists(l:win['bufnr'])
        exec 'silent bwipeout! ' . l:win['bufnr']
      endif
    endfor
    call CUpdateTabTermBuf()
  endfunction
  let g:asyncrun_bell = 1
  let g:asyncrun_save = 1
  let g:asyncrun_mode = 'term'
  noremap <F8> :call ToggleTerminal(6)<CR>
  nnoremap <Space><F8> :AsyncRun! -strip -rows=6 -hidden=1 -focus=0 -post=call\ JumpToTerm()<Space>
endfunction




function! ManualLoadPluginConfiguration()
  " vim-quickui setting
  function! QuickuiConfiguration()
    call plug#load('vim-quickui')
    " clear all the menus
    call quickui#menu#reset()
    " install a 'File' menu, use [text, command] to represent an item.
    call quickui#menu#install('&File', [
          \ [ "&Save\tCtrl+s", 'w'],
          \ [ 'Save &As', 'call feedkey(":saveas ")' ],
          \ [ 'Save All', 'wa' ],
          \ [ '--', '' ],
          \ [ 'LeaderF &File', 'Leaderf file', 'Open file with leaderf'],
          \ [ 'LeaderF &Mru', 'Leaderf mru --regexMode', 'Open recently accessed files'],
          \ [ 'LeaderF &Buffer', 'Leaderf buffer', 'List current buffers in leaderf'],
          \ [ '--', '' ],
          \ [ "E&xit\tAlt+x", 'q' ],
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
          \ ['--',''],
          \ ['&Vim Script', 'help eval', ''],
          \ ['&Function List', 'help function-list', ''],
          \ ], 10000)
  endfunction
  function! QuickuiOpenMenu()
    if !exists('quickui#menu#open')
      call QuickuiConfiguration()
    endif
    call quickui#menu#open()
  endfunction
  function! QuickuiListBuffer()
    if !exists('quickui#tools#list_buffer')
      call QuickuiConfiguration()
    endif
    call quickui#tools#list_buffer('e')
  endfunction
  function! QuickuiPreviewTag()
    if !exists('quickui#tools#preview_tag')
      call QuickuiConfiguration()
    endif
    call quickui#tools#preview_tag('')
  endfunction
  " enable to display tips in the cmdline
  let g:quickui_show_tip = 1
  let g:quickui_color_scheme = 'papercol light'
  " hit \qm to open menu
  noremap <Leader>qm :call QuickuiOpenMenu()<CR>
  " hit \qb to switch buffer
  noremap <Leader>qb :call QuickuiListBuffer()<CR>
  " hit \qt to preview tags
  noremap <Leader>qt :call QuickuiPreviewTag()<CR>



  " NERDTree Setting
  nnoremap <Leader>nt :NERDTreeToggle<CR>
  nnoremap <Leader>nc :NERDTreeCWD<CR>
  let g:NERDTreeFileExtensionHighlightFullName = 1
  let g:NERDTreeExactMatchHighlightFullName = 1
  let g:NERDTreePatternMatchHighlightFullName = 1
  let g:NERDTreeHighlightFolders = 1
  let g:NERDTreeHighlightFoldersFullName = 1
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible = '-'
  let g:NERDTreeHidden = 0



  " Vista setting
  let g:vista_no_mappings = 0
  let g:vista_default_executive = 'coc'
  let g:vista#renderer#enable_icon = 1
  let g:vista_close_on_jump = 1
  let g:vista_cursor_delay = 0
  let g:vista_blink = [0,0]
  let g:vista_top_level_blink = [0,0]
  let g:vista_echo_cursor_strategy = 'echo'
  nnoremap <Leader>vt :Vista!!<CR>
  nnoremap <Leader>vf :Vista focus<CR>



  " vim-bookmarks setting
  let g:bookmark_no_default_key_mappings = 1
  let g:bookmark_auto_close = 1
  let g:bookmark_auto_save = 1
  " Save bookmarks to $HOME/.vim/.vim-bookmarks
  let g:bookmark_save_per_working_dir = 1
  function! g:BMWorkDirFileLocation()
    let l:bookmark_extension = 'bookmarks'
    " Bookmark files of the root user are saved to /home/$SUDO_USER/.vim/.vim-bookmarks
    if empty($SUDO_USER)
      let l:bookmark_root_location = $HOME.'/.vim/.vim-bookmarks'
    else
      let l:bookmark_root_location = '/home/'.$SUDO_USER.'/.vim/.vim-bookmarks'
    endif
    let l:bookmark_path = l:bookmark_root_location.expand('%:p:h')
    let l:bookmark_file = simplify(l:bookmark_path.'/'.expand('%:t').'.'.l:bookmark_extension)
    if !isdirectory(l:bookmark_path)
      call mkdir(l:bookmark_path, 'p')
      if !empty($SUDO_USER)
        call system('chown -R $SUDO_USER:$SUDO_USER '.shellescape(l:bookmark_root_location))
      endif
    endif
    if !filereadable(l:bookmark_file)
      call system('touch '.shellescape(l:bookmark_file))
      if !empty($SUDO_USER)
        call system('chown $SUDO_USER:$SUDO_USER '.shellescape(l:bookmark_file))
      endif
    endif
    return l:bookmark_path
  endfunction
  nnoremap <Leader>bo :call plug#load('vim-bookmarks')<CR>
  nnoremap <Leader>bt :BookmarkToggle<CR>
  nnoremap <Leader>ba :BookmarkAnnotate<CR>
  nnoremap <Leader>bs :BookmarkShowAll<CR>
  nnoremap <Leader>bn :BookmarkNext<CR>
  nnoremap <Leader>bp :BookmarkPrev<CR>
  nnoremap <Leader>bc :BookmarkClear<CR>
  nnoremap <Leader>br :BookmarkClearAll<CR>
  nmap <Leader>bu <Plug>BookmarkMoveUp
  nmap <Leader>bd <Plug>BookmarkMoveDown
  nmap <Leader>bl <Plug>BookmarkMoveToLine



  " vim-interestingwords setting
  nnoremap <Leader>wt :call LoadAndSetVimInterestingwords()<CR>
  function! LoadAndSetVimInterestingwords()
    let g:interestingWordsRandomiseColors = 1
    let g:interestingWordsDefaultMappings = 0
    call plug#load('vim-interestingwords')
    nnoremap <Leader>wh :call InterestingWords('n')<CR>
    vnoremap <Leader>wh :call InterestingWords('v')<CR>
    nnoremap <Leader>w<S-h> :call UncolorAllWords()<CR>
    nnoremap n :call WordNavigation(1)<CR>
    nnoremap <S-n> :call WordNavigation(0)<CR>
  endfunction



  " vim-fugitive and vim-gitgutter setting
  nnoremap <Leader>git :call LoadAndSetGitPlugin()<CR>
  function! LoadAndSetGitPlugin()
    let g:fugitive_no_maps = 1
    let g:gitgutter_map_keys = 0
    nmap <Leader>gp <Plug>(GitGutterPrevHunk)
    nmap <Leader>gn <Plug>(GitGutterNextHunk)
    nmap <Leader>gf <Plug>(GitGutterFold)
    exec 'normal! ms'
    call plug#load('vim-fugitive')
    call plug#load('vim-gitgutter')
    set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [%{toupper(&fileencoding)}=0x%B]%m%r
    set statusline+=%=\ %{GitStatus()}%{FugitiveStatusline()}
    set statusline+=\ [%{strftime(\"%m/%d/%y-%a-%H:%M\")}]%<
    exec 'normal! `s'
  endfunction
  function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endfunction



  " vimspector setting
  function! CppDebugConfiguration()
    let l:cpp_workspace_root = WorkspaceRoot()
    if !isdirectory(l:cpp_workspace_root.'/.vscode')
      call mkdir(l:cpp_workspace_root.'/.vscode', 'p', 0755)
    endif
    call CopyFileRelToCPP(l:cpp_workspace_root, '.vscode/launch.json')
    call CopyFileRelToCPP(l:cpp_workspace_root, '.vimspector.json')
    exec 'tabe ' . l:cpp_workspace_root.'/.vimspector.json'
  endfunction
  nmap <F2> <Plug>VimspectorContinue
  nnoremap <S-F2> :call vimspector#Restart()<CR>
  nmap ]<F2> <Plug>VimspectorRunToCursor
  nmap ]<S-F2> <Plug>VimspectorStop
  nmap ]<C-F2> <Plug>VimspectorPause
  nmap ]<F3> <Plug>VimspectorBalloonEval
  vmap ]<F3> <Plug>VimspectorBalloonEval
  nmap <F4> <Plug>VimspectorToggleBreakpoint
  nnoremap <S-F4> :call vimspector#ClearBreakpoints()<CR>
  nmap ]<F4> <Plug>VimspectorToggleConditionalBreakpoint
  nnoremap ]<S-F4> :call vimspector#SetAdvancedLineBreakpoint()<CR>
  nnoremap ]<C-F4> :call vimspector#AddAdvancedFunctionBreakpoint()<CR>
  nnoremap <F5> :call plug#load('vimspector')<CR>
  silent nnoremap <S-F5> :VimspectorReset<CR>
  nnoremap ]<F5> :set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 19<CR>
               \ :call plug#load('vimspector')<CR>
               \ :call vimspector#Launch()<CR>
  nnoremap <Leader><F5> :call CppDebugConfiguration()<CR>
  nmap <F6> <Plug>VimspectorStepOver
  nmap <C-F6> <Plug>VimspectorStepInto
  nmap <S-F6> <Plug>VimspectorStepOut
  nmap ]<F7> <Plug>VimspectorUpFrame
  nmap ]<S-F7> <Plug>VimspectorDownFrame
  nnoremap ]<F8> :let g:vimspector_variables_display_mode = 'full'<CR>
  nnoremap <C-1> :call win_gotoid(g:vimspector_session_windows.variables)<CR>
  inoremap <C-1> <ESC>:call win_gotoid(g:vimspector_session_windows.variables)<CR>
  nnoremap <C-3> :call win_gotoid(g:vimspector_session_windows.code)<CR>
  inoremap <C-3> <ESC>:call win_gotoid(g:vimspector_session_windows.code)<CR>
  nnoremap <C-4> :call win_gotoid(g:vimspector_session_windows.terminal)<CR>
  inoremap <C-4> <ESC>:call win_gotoid(g:vimspector_session_windows.terminal)<CR>
  nnoremap <C-5> :call win_gotoid(g:vimspector_session_windows.watches)<CR>
  inoremap <C-5> <ESC>:call win_gotoid(g:vimspector_session_windows.watches)<CR>
  nnoremap <C-7> :call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>
  inoremap <C-7> <ESC>:call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>
  nnoremap <C-8> :VimspectorShowOutput Console<CR>
  inoremap <C-8> <ESC>:VimspectorShowOutput Console<CR>
  sign define vimspectorBP            text=B texthl=WarningMsg
  sign define vimspectorBPCond        text=BC texthl=WarningMsg
  sign define vimspectorBPLog         text=BL texthl=SpellRare
  sign define vimspectorBPDisabled    text=BD texthl=LineNr
  sign define vimspectorPC            text=$ texthl=MatchParen linehl=CursorLine
  sign define vimspectorPCBP          text=●>  texthl=MatchParen linehl=CursorLine
  sign define vimspectorCurrentThread text=>   texthl=MatchParen linehl=CursorLine
  sign define vimspectorCurrentFrame  text=>   texthl=Special    linehl=CursorLine
  function! s:SetUpTerminal()
    call win_gotoid(g:vimspector_session_windows.terminal)
    wincmd L
    12wincmd |
    call win_gotoid(g:vimspector_session_windows.variables)
    nunmenu WinBar
    30wincmd |
    wincmd _
    call win_gotoid(g:vimspector_session_windows.watches)
    nunmenu WinBar
    16wincmd _
    call win_gotoid(g:vimspector_session_windows.stack_trace)
    3wincmd _
    call win_gotoid(g:vimspector_session_windows.code)
    nunmenu WinBar
    wincmd _
    call win_gotoid(g:vimspector_session_windows.output)
    9wincmd _
  endfunction
  augroup Plugin_Configuration | autocmd User VimspectorTerminalOpened call s:SetUpTerminal() | augroup END



  " Leaderf setting,列出当前文件函数(:LeaderfFunction),使用rg模糊查找(:Leaderf rg)
  " ctrl+j/k上下选择显示查找结果，ctrl+上/下键上下移动被显示的查找结果的内容
  let g:Lf_WindowPosition = 'popup'
  if empty($SUDO_USER)
    let g:Lf_CacheDirectory = expand($HOME.'/.vim/cache')
  else
    let g:Lf_CacheDirectory = expand('/home/'.$SUDO_USER.'/.vim/cache')
  endif
  let g:Lf_GtagsAutoGenerate = 0
  let g:Lf_Gtagslabel = 'native-pygments'
  let g:Lf_StlSeparator = {'left': '', 'right': '', 'font': ''}
  let g:Lf_RootMarkers = g:root_patterns
  let g:Lf_WorkingDirectoryMode = 'Ac'
  let g:Lf_CursorBlink = 0
  let g:Lf_RgConfig = [
          \ '--max-columns=150',
          \ '--type-add web:*.{html,css,js}*',
          \ '--glob=!git/*',
          \ '--hidden'
      \ ]
  let g:Lf_PreviewInPopup = 1
  " open the preview window automatically
  let g:Lf_PreviewResult = {'Rg': 1}
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关和实用设置
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 会使vim看起来不友好的命令
if has('gui_running')
  set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 21   " 设置字体
  " 设置光标格式竖纹：ver33  下划线：hor20   方块：block,其中数字为百分比
  set guicursor=c-i:ver33-Cursor
  set guicursor+=a:blinkon0
  " 设定窗口大小
  set lines=60 columns=80
  " 隐藏滚动栏
  set guioptions-=r
  " tab只显示文件名不显示标签
  set guitablabel=%t
  " Toggle Menu and Toolbar菜单栏和工具栏
  set guioptions-=m
  set guioptions-=T
  nnoremap <Space>m :call MenuToggle()<CR>
  function! MenuToggle()
    if &guioptions=~#'T'
      set guioptions-=T
      set guioptions-=m
    else
      set guioptions+=T
      set guioptions+=m
    endif
  endfunction
endif
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
  autocmd BufNewFile *.[ch]pp,*.[ch],*.sh,*.v,*.cl,*.pl,*.tcl exec ':call SetTitle()'
  autocmd FileType c,cpp,python,sh,verilog,perl,tcl,markdown,vim,cmake,qmake,make,xml
           \ nnoremap <Space><F2>
           \ :call CompileAndExcute()<CR>
  autocmd FileType c,cpp,verilog nnoremap <Leader><F2>
           \ :call CompileCommand()<CR>
  autocmd FileType c,cpp,verilog nnoremap <Leader>` :call CallShowNearestFunction()<CR>
  if has('nvim')
    autocmd UIEnter * call TabPosInitialize()
  else
    autocmd GUIEnter * call TabPosInitialize()
  endif
augroup END
" 缩进
set autoindent
set smartindent
" 把Tab字符用空格代替，和tabstop相关
set expandtab
function! SetIndent()
  if &filetype==?'c' || &filetype==?'cpp' || &filetype==?'opencl'
           \  || &filetype==?'sh' || &filetype==?'verilog'
           \  || &filetype==?'perl' || &filetype==?'tcl'
           \  || &filetype==?'json' || &filetype==?'java'
           \  || &filetype==?'python'
    set tabstop=3     " Tab键的显示宽度
    set softtabstop=3 " 按下Tab键时输入的宽度
    set shiftwidth=3  " 设置自动缩进时的缩进长度
    if &filetype==?'c' || &filetype==?'cpp'
      set cindent     " 设置使用C/C++语言的自动缩进方式
    endif
  else
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
  endif
endfunction
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
    call setline(1, '//*************************************************************************')
    call append(line('$'), '//  > File Name: '.expand('%'))
    call append(line('$'), '//  > Author: Huaxiao Liang')
    call append(line('$'), '//  > Mail: 1184903633@qq.com')
    call append(line('$'), '//  > Created Time: '.strftime('%c'))
    call append(line('$'), '//************************************************************************')
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
  exec 'normal! G'
endfunction
function! CPPCompilation()
  let l:cpp_workspace_root = WorkspaceRoot()
  let l:cur_file_path = expand('%:p:h')
  let l:all_possible_paths = [l:cpp_workspace_root]
  for l:str_id in range(strlen(l:cpp_workspace_root) + 1, strlen(l:cur_file_path))
    if l:cur_file_path[l:str_id] ==? '/'
      call add(l:all_possible_paths, strpart(l:cur_file_path, 0, l:str_id))
    endif
  endfor
  call add(l:all_possible_paths, l:cur_file_path)
  let l:qmakepro_path = ''
  let l:makefile_path = ''
  let l:sconstruct_path = ''
  for l:possible_path in l:all_possible_paths
    let l:pattern = l:possible_path."/CMakeLists.txt"
    " Get the list of matching files (non-recursive)
    let l:cmakelist_path = glob(l:pattern, 0, 1)
    if !empty(l:cmakelist_path)
      let l:cmakelist_path = ' cd '.l:possible_path.' && cmake'
      call system('ccache --version')
      if v:shell_error " Not use ccache
        echo "ccache is not installed."
      else
        let l:cmakelist_path = l:cmakelist_path.' -DCMAKE_C_COMPILER_LAUNCHER=ccache'
                            \  .' -DCMAKE_CXX_COMPILER_LAUNCHER=ccache'
      endif
      return l:cmakelist_path.' -S . -B build'
          \ .' && bear --append -- make -C build -j12'
    endif
    let l:pattern = l:possible_path."/*.pro"
    let l:qmakepro_path = glob(l:pattern, 0, 1)
    if !empty(l:qmakepro_path)
      return ' cd '.l:possible_path.' && qmake -o build/Makefile'
          \ .' && bear --append -- make -C build -j12'
    endif
    let l:pattern = l:possible_path."/[m,M]akefile"
    let l:makefile_path = glob(l:pattern, 0, 1)
    if !empty(l:makefile_path)
      return ' cd '.l:possible_path.' && bear --append -- make -j12'
    endif
    let l:pattern = l:possible_path."/SConstruct"
    let l:sconstruct_path = glob(l:pattern, 0, 1)
    if !empty(l:sconstruct_path)
      return ' cd '.l:possible_path.' && bear --append -- scons -j12'
    endif
  endfor
  if &filetype==?'cpp'
    return ' cd '.l:cur_file_path.' && g++ '.expand('%:t').' -o '.fnamemodify(expand('%'), ':t:r').'.exe -Wall -Wextra'
  else
    return ' cd '.l:cur_file_path.' && gcc '.expand('%:t').' -o '.fnamemodify(expand('%'), ':t:r').'.exe -Wall -Wextra'
  endif
endfunction
if !exists('*CompileAndExcute')
  function! CompileAndExcute()
    let l:compile_exec = ':AsyncRun -strip -rows=6 -listed=1 -hidden=1 -focus=0 -post=call\ JumpToTerm()'
    if &filetype==?'cpp' || &filetype==?'c' || &filetype==?'cmake' || &filetype==?'qmake'
        \ || &filetype==?'make' || &filetype==?'xml' || expand('%:t') == 'SConstruct'
      let l:cpp_compilation = CPPCompilation()
      if stridx(l:cpp_compilation, 'bear') != -1
        exec l:compile_exec.l:cpp_compilation.' && build/*.exe'
      else
        exec l:compile_exec.l:cpp_compilation.' && ./'.fnamemodify(expand('%'), ':t:r').'.exe'
      endif
    elseif &filetype==?'python'
      exec l:compile_exec.' python3 %'
    elseif &filetype==?'sh'
      exec l:compile_exec.' ./%'
    elseif &filetype==?'verilog'
      exec l:compile_exec.' iverilog *.v -o %<.vcd && vvp %<.vcd'
    elseif &filetype==?'perl'
      exec l:compile_exec.' perl %'
    elseif &filetype==?'tcl'
      exec l:compile_exec.' tclsh %'
    elseif &filetype==?'markdown'
      exec ':CocCommand markdown-preview-enhanced.openPreview'
    elseif &filetype==?'vim'
      exec ':source ~/.vimrc'
    elseif &filetype==?'help' || &buftype ==?'terminal' || &filetype==?'VimspectorPrompt'
        \ || &filetype==?'vista' || &buftype ==?'nofile' || &filetype==?'nerdtree'
      call JumpToTheMainWin()
      call CompileAndExcute()
    endif
  endfunction
endif
function! CompileCommand()
  let l:compile_only = ':AsyncRun! -strip -rows=6 -hidden=1 -focus=0 -post=call\ JumpToTerm()'
  if &filetype==?'cpp' || &filetype==?'c' || &filetype==?'cmake' || &filetype==?'qmake'
        \ || &filetype==?'make'|| &filetype==?'xml' || expand('%:t') == 'SConstruct'
    exec l:compile_only.CPPCompilation()
  elseif &filetype==?'verilog'
    exec l:compile_only.' iverilog *.v -o %<.vcd'
  elseif &filetype==?'help' || &buftype ==?'terminal' || &filetype==?'VimspectorPrompt'
      \ || &filetype==?'vista' || &buftype ==?'nofile' || &filetype==?'nerdtree'
    call JumpToTheMainWin()
    call CompileCommand()
  endif
endfunction
function! ShowCurrentModule()
  let l:module_line = search('module', 'bnWz')
  let l:module_name = getline(l:module_line)
  let l:module_end_poisition = strridx(l:module_name, '(')
  if(l:module_end_poisition > 0)
    let l:module_name = strpart(l:module_name, 0, l:module_end_poisition)
  endif
  let l:module_name = strpart(l:module_name, stridx(l:module_name, 'module')+7)
  while(strpart(l:module_name, 0 , 1) ==? ' ')
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
    let l:nearest_name = 'No class/struct can be find.'
  endif
  let l:nearest_end_poisition = strridx(l:nearest_name, '{')
  if(l:nearest_end_poisition > 0)
    let l:nearest_name = strpart(l:nearest_name, 0, l:nearest_end_poisition)
  endif
  echo l:nearest_name
endfunction
function! CallShowNearestFunction()
  if &filetype==?'cpp' || &filetype==?'c'
     call ShowNearestClassOrStruct()
  elseif &filetype==?'verilog'
     call ShowCurrentModule()
  endif
endfunction
" Alt+n跳到第n个tab，0<n<10
function! TabPosActivateBuffer(index)
  let s:count = a:index
  exec 'tabfirst'
  exec 'tabnext' s:count
endfunction
function! TabPosInitialize()
  for l:i in range(1, 9)
      exec 'noremap <M-' . l:i . '> :call TabPosActivateBuffer(' . l:i . ')<CR>'
      exec 'inoremap <M-' . l:i . '> <C-o>:call TabPosActivateBuffer(' . l:i . ')<CR>'
  endfor
  exec 'noremap <M-0> :call TabPosActivateBuffer(10)<CR>'
  exec 'inoremap <M-0> <C-o>:call TabPosActivateBuffer(10)<CR>'
endfunction
nnoremap <Space>t :call NUpdateTabTermBuf()<CR>:tabnew<CR>
nnoremap <Space>b :call CloseAndBackTab()<CR>
nnoremap <Space>q :call QuitWin()<CR>
nnoremap <Space>w :w<CR>
noremap <M-S-h> :call MoveTabH()<CR>
noremap <M-S-l> :call MoveTabL()<CR>
inoremap <M-S-h> <C-o>:call MoveTabH()<CR>
inoremap <M-S-l> <C-o>:call MoveTabL()<CR>
noremap <C-M-h> gT
noremap <C-M-l> gt
inoremap <C-M-h> <C-o>gT
inoremap <C-M-l> <C-o>gt
function! CloseAndBackTab()
  call CAllTermsOfCurTab()
  if tabpagenr() > 1 " not the first tab
    exec 'tabp'
    exec '+tabclose'
  elseif tabpagenr('$') == 1 " single tab
    let l:cur_buf = bufnr('%')
    " Iterate over all buffers
    for l:buf in range(1, bufnr('$'))
      if l:buf != l:cur_buf && bufexists(l:buf)
        exec 'silent bwipeout! ' . l:buf
      endif
    endfor
    quit
  else " multiple tabs
    quit
  endif
endfunction
function! QuitWin() " not consider the main win is a term
  let l:cur_tab = tabpagenr()
  let l:cur_win_buf = bufnr('%')
  let l:main_win_buf = l:cur_win_buf
  for l:win in getwininfo()
    if l:win['tabnr'] == l:cur_tab && l:win['bufnr'] < l:main_win_buf
      let l:main_win_buf = l:win['bufnr']
    endif
  endfor
  if l:cur_win_buf != l:main_win_buf " not the main win, close one win
    let l:buf_type = getbufvar(winbufnr(win_getid()), '&buftype')
    if l:buf_type ==? 'terminal'
      call CUpdateTabTermBuf(bufnr())
      quit!
    else
      quit
    endif
  elseif tabpagenr('$') > 1 " multiple tabs, close one tab
    call CAllTermsOfCurTab()
    exec 'tabclose'
  else " single tab
    " Iterate over all buffers
    for l:buf in range(1, bufnr('$'))
      if l:buf != l:main_win_buf && bufexists(l:buf)
        exec 'silent bwipeout! ' . l:buf
      endif
    endfor
    quit
  endif
endfunction
function! MoveTab(boundary, plus_or_minus, plus_or_minus_one, first, last)
  let l:cur_tab=tabpagenr()
  if l:cur_tab ==? a:boundary && tabpagenr('$') > 1
    exec ':tabmove '.a:plus_or_minus[0].(tabpagenr('$') - 1)
    if exists('g:tab_term_buf')
      let l:tmp = g:tab_term_buf[l:cur_tab]
      for l:index in range(a:first, a:last, a:plus_or_minus_one[0])
        let g:tab_term_buf[l:index] = g:tab_term_buf[l:index + a:plus_or_minus_one[0]]
      endfor
      let g:tab_term_buf[a:last] = l:tmp
    endif
  elseif tabpagenr('$') > 1
    exec ':tabmove '.a:plus_or_minus[1]
    if exists('g:tab_term_buf')
      let l:tmp = g:tab_term_buf[l:cur_tab]
      let g:tab_term_buf[l:cur_tab] = g:tab_term_buf[l:cur_tab + a:plus_or_minus_one[1]]
      let g:tab_term_buf[l:cur_tab + a:plus_or_minus_one[1]] = l:tmp
    endif
  endif
endfunction
function! MoveTabH()
  call MoveTab(1, ['+', '-'], [+1, -1], 1, tabpagenr('$'))
endfunction
function! MoveTabL()
  call MoveTab(tabpagenr('$'), ['-', '+'], [-1, +1], tabpagenr('$'), 1)
endfunction
" 比较文件
nnoremap <Space><F4> :vert diffsplit
nnoremap <Space><F5> :call DeleteBlankLine()<CR>
function! DeleteBlankLine()
  exec 'normal! ms'
  let l:mark_enable = 1
  let l:new_column = col('.')
  let l:line_num = line('.')
  " Find the nearest line which contains at least one non-space character.
  if getline('.') =~? '^\s*$'
    let l:mark_enable = 0
    let l:new_column = 1
    let l:down_line_num = search('^\s*\S', 'nW')
    if l:line_num == l:down_line_num
      let l:up_line_num = search('^\s*\S', 'bnW')
      if l:line_num == l:up_line_num
        let l:line_num = 1
      else
        let l:line_num = l:up_line_num
      endif
    else
      let l:line_num = l:down_line_num
    endif
  endif
  exec ':g/^\s*$/d'
  if l:mark_enable == 1
    exec 'normal! `s'
  else
    call setpos('.', [0, l:line_num, l:new_column, 0])
  endif
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
inoremap <M-CR> <ESC>l:call EnterWithoutTraillingComment()<CR>a
nnoremap <C-Space> i<Space><ESC>l
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
  call append(".", l:cur_indent)
  call setpos('.', [0, l:new_line, l:cur_indent_count, 0])
endfunction
" Alt-Enter新建空行
nnoremap <C-M-CR> :set paste<CR>o<ESC>:set nopaste<CR>
inoremap <C-M-CR> <ESC>:set paste<CR>o<ESC>:set nopaste<CR>i
" Alt-h/j/k/l/p/P/u/D/Y/I/A use h/j/k/l/p/P/u/D/Y/I/A in the insert mode like in the normal mode
inoremap <M-h> <C-o>h
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
inoremap <M-l> <C-o>l
inoremap <M-p> <ESC>pa
inoremap <M-S-p> <ESC>Pa
inoremap <M-u> <C-o>u<C-o>l
inoremap <M-r> <C-o><C-r>
inoremap <M-S-d> <C-o>D
inoremap <M-S-y> <C-o>Y
inoremap <M-S-a> <C-o>A
inoremap <M-S-i> <C-o>I
