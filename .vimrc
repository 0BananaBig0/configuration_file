" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
" 开启24bits RGB支持
set termguicolors
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
let maplocalleader = ","



call plug#begin('~/.vim/plugged')
" Vim theme, No_Lazy
Plug 'dracula/vim', {'as': 'dracula'}
" 彩虹括号
Plug 'luochen1990/rainbow'
" 缩进显示
Plug 'nathanaelkane/vim-indent-guides'
" Highlight opencl 2.0 syntax
Plug 'brgmnn/vim-opencl', {'for': ['opencl']}
" 高亮c++类模板等插件
Plug 'bfrg/vim-c-cpp-modern', {'for': ['c', 'cpp', 'cuda', 'opencl']}
" Python 语法高亮插件
Plug 'vim-python/python-syntax', {'for': ['python']}
" Verilog
Plug 'HonkW93/automatic-verilog', {'for': ['verilog']}
Plug '0BananaBig0/vim-verilog-instance', {'for': ['verilog']}
" Highlight qmake syntax
Plug 'artoj/qmake-syntax-vim', {'for': ['qmake']}
" Markdown目录构建插件, Manual-load and Delay-load
Plug 'mzlogin/vim-markdown-toc', {'on': []}
" 补全插件, 动态检测语法插件, 可鼠标停留显示信息, Delay-load
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Vim快捷键管理和提示插件
Plug 'liuchengxu/vim-which-key', {'on': []}
" Nerdcommenter快速注释插件
Plug 'preservim/nerdcommenter', {'on': []}
" 异步执行shell命令插件
Plug 'skywind3000/asyncrun.vim', {'on': []}
" 菜单栏插件
Plug 'skywind3000/vim-quickui', {'on': []}
" 文件目录插件
Plug 'preservim/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeCWD']}
" 标签窗口列表插件
Plug 'liuchengxu/vista.vim', {'on': ['Vista!!', 'Vista focus']}
" 书签插件，用于写代码注解等等
Plug 'MattesGroeger/vim-bookmarks', {'on': ['BookmarkToggle', 'BookmarkShowAll', 'BookmarkAnnotate']}
" Multiple highlights
Plug 'lfv89/vim-interestingwords', {'on': []}
" Multiple cursors
Plug 'mg979/vim-visual-multi', {'on':[]}
" Git command
Plug 'tpope/vim-fugitive', {'on': []}
" Git status show
Plug 'airblade/vim-gitgutter', {'on': []}
" Git blame info
Plug 'zivyangll/git-blame.vim', {'on': []}
" c/cpp debug
Plug 'puremourning/vimspector', {'on': []}
" 快速查找插件，包括查找文件，当前文件函数，模糊查找字段
Plug 'Yggdroot/LeaderF', {'on': ['Leaderf', 'LeaderfFunction', 'LeaderfBuffer', 'LeaderfFile']}
" LeaderF extension for navigate the marks
Plug 'Yggdroot/LeaderF-marks', {'on': ['Leaderf', 'LeaderfFunction', 'LeaderfBuffer', 'LeaderfFile']}
call plug#end()
" 插件疑似不支持按文件类型加载，手动添加autocmd判断，也不支持利用vim的特性延迟加载
augroup Call_Highlight_Plugin
  autocmd BufNewFile,BufRead */include/* if expand('%:e')=='' && (&filetype == 'conf' || &filetype == '') | set filetype=cpp | endif
  autocmd BufNewFile,BufRead *.launch,*.qrc,*.conf set filetype=xml
  autocmd BufNewFile,BufRead *.v set filetype=verilog
  autocmd BufNewFile,BufRead *.tessent_startup,*.dofile,*.pdl,*.pdl.* set filetype=tcl
  autocmd BufNewFile,BufRead *.stil set filetype=stil
augroup END



colorscheme dracula
noremap <Leader>ppt :<C-u>colorscheme zellner<CR>
                  \ :set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 23<CR>
                  \ :set colorcolumn=0<CR>



" Rainbow setting
" Set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1



" Vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_tab_guides = 0
let g:indent_guides_default_mapping = 0



" Vim-c-cpp-modern
let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
let g:cpp_operator_highlight = 1



" Python-syntax setting
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
  call ConfigureDelayedPlugin()
  call ConfigureManualLoadPlugin()
  call plug#load('nerdcommenter')
  call plug#load('asyncrun.vim')
  call InitializeTabPos()
endfunction
call timer_start(333,'CocTimerStart',{'repeat':1})



function! ConfigureMarkdownPlugin()
  " Coc-markmap, coc-markdownlint setting
  " Watch workflow from the whole file
  noremap <Leader>mm :<C-u>CocCommand markmap.watch<CR>
  " Create markmap html file
  noremap <Leader>mc :<C-u>CocCommand markmap.create --offline<CR>
  nnoremap <Leader>mh <Plug>(coc-markmap-create)
  vnoremap <Leader>mh <Plug>(coc-markmap-create-v)
  noremap <Leader>mf :<C-u>CocCommand markdownlint.fixAll<CR>



  " Vim-markdown-toc setting :GenTocGFM :UpdateToc :RemoveToc generate the menu
  " If you want to go to the last line of the menu, you can press `` in normal mode
  noremap <Leader>mg :<C-u>call CreateMarkdownMenu()<CR>
  noremap <Leader>mu :<C-u>call UpdateMarkdownMenu()<CR>
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
  let g:leader_key_map.m = {'name':"Markdown"}
endfunction



function! ConfigureDelayedPlugin()
  " Vim-which-key setting
  let g:which_key_fallback_to_native_key = 0
  noremap <Leader> :<C-u>WhichKey '\'<CR>
  noremap <LocalLeader> :<C-u>WhichKey '<LocalLeader>'<CR>
  noremap [ :<C-u>WhichKey '['<CR>
  noremap ] :<C-u>WhichKey ']'<CR>
  let g:leader_key_map = {}
  call which_key#register('\', "g:leader_key_map")
  let g:right_bracket_key_map = {}
  call which_key#register(']', "g:right_bracket_key_map")
  call ConfigureMarkdownPlugin()



  " coc.nvim setting, ':verbose imap <tab>'
  " Use tab for trigger completion with characters ahead and navigate.
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
  nmap <LocalLeader>c <Plug>(coc-declaration)
  nmap <LocalLeader>d <Plug>(coc-definition)
  nmap <LocalLeader>f <Plug>(coc-refactor)
  vmap <LocalLeader>f <Plug>(coc-refactor-selected)
  nmap <LocalLeader>i <Plug>(coc-implementation)
  nmap <LocalLeader>j <Plug>(coc-diagnostic-next-error)
  nmap <LocalLeader>k <Plug>(coc-diagnostic-prev-error)
  nmap <LocalLeader>n <Plug>(coc-rename)
  nmap <LocalLeader>r <Plug>(coc-references)
  nmap [a <Plug>(coc-codeaction)
  vmap [a <Plug>(coc-codeaction-selected)
  nmap [l <Plug>(coc-codeaction-line)
  noremap [c :<C-u>call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpDeclaration', 'tabe')<CR>
  noremap [d :<C-u>call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpDefinition', 'tabe')<CR>
  noremap [i :<C-u>call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpImplementation', 'tabe')<CR>
  nmap [j <Plug>(coc-diagnostic-next)
  nmap [k <Plug>(coc-diagnostic-prev)
  nmap [o <Plug>(coc-diagnostic-info)
  noremap [b :<C-u>call CocActionAsync('diagnosticToggleBuffer')<CR>
  noremap [t :<C-u>call CocActionAsync('diagnosticToggle', 1)<CR>
  noremap [h :<C-u>CocCommand document.toggleInlayHint<CR>
  nmap <F7> <Plug>(coc-format)
  vmap <F7> <Plug>(coc-format-selected)
  let g:coc_filetype_map = {'opencl': 'c', 'cuda': 'cpp', 'lex':'cpp', 'yacc':'cpp'}
  " If some LSPs fail to start, navigate to ~/.config/coc/extensions to check if they require downloading any JAR files.
  " If they do, delete the problematic extension and open a new file; it will automatically download the necessary files again.
  let g:coc_global_extensions = ['coc-word', 'coc-tag', 'coc-dictionary', 'coc-snippets','coc-prettier',
           \ 'coc-yaml', 'coc-cmake', 'coc-clangd', 'coc-clang-format-style-options', 'coc-perl', 'coc-vimlsp',
           \ 'coc-sh', 'coc-pyright', 'coc-webview', 'coc-markmap', 'coc-markdown-preview-enhanced',
           \ 'coc-markdownlint', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-xml']
  let g:root_patterns = ['.git', '.hg', '.projections.json', '.project', '.svn', '.root', '.vscode', 'SConstruct']
  function! FindRootPatternPath(target_path)
    let l:root_pattern_path = []
    " Access target_path
    let l:target_path = a:target_path.'/'
    for l:pattern in g:root_patterns
      for l:str_id in range(strlen(l:target_path) - 1, 0, -1)
        if l:target_path[l:str_id]=='/'
          let l:possible_path = strpart(a:target_path, 0, l:str_id)
          if l:possible_path==$HOME || l:possible_path=='/home/'.$SUDO_USER || l:possible_path=='/'
            break
          endif
          let l:root_pattern_path = glob(l:possible_path.'/'.l:pattern, 0, 1)
          if !empty(l:root_pattern_path)
            return l:root_pattern_path
          endif
        endif
      endfor
    endfor
    return l:root_pattern_path
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
    if &filetype=='help' || &buftype=='terminal' || &filetype=='VimspectorPrompt'
        \ || &filetype=='vista' || &buftype=='nofile' || &filetype=='nerdtree'
      call JumpToTheMainWin() " Avoid potential bugs
    endif
    let l:workspace_root = FindRootPatternPath(expand('%:p:h')) " Where we store the opened file
    if empty(l:workspace_root)
      echo 'You had better create a root-pattern file like .git in your project.'
      return expand('%:p:h')
    endif
    for l:str_id in range(strlen(l:workspace_root[0]) - 1, 0, -1)
      if l:workspace_root[0][l:str_id]=='/'
        let l:workspace_root[0] = strpart(l:workspace_root[0], 0, l:str_id)
        break
      endif
    endfor
    return l:workspace_root[0]
  endfunction
  function! CopyFileRelToCPP(cpp_workspace_root, file_name)
    let l:source_file = $HOME.'/.vim/.c_cpp/'.a:file_name
    let l:target_file = a:cpp_workspace_root.'/'.a:file_name
    if filereadable(l:target_file)
      echo 'File '.l:target_file.' has existed.'
    elseif filereadable(l:source_file)
      let l:source_file_content = readfile(l:source_file)
      call writefile(l:source_file_content, l:target_file, 's')
    else
      echo 'File '.l:source_file.' and file '.l:target_file.' do not exist.'
      return 0
    endif
    return 1
  endfunction
  function! ConfigureClangTools()
    let l:cpp_workspace_root = WorkspaceRoot()
    call CopyFileRelToCPP(l:cpp_workspace_root, '.clangd')
    call CopyFileRelToCPP(l:cpp_workspace_root, '.clang-format')
    call CopyFileRelToCPP(l:cpp_workspace_root, '.clang-tidy')
  endfunction
  noremap <Leader><F7> :<C-u>call ConfigureClangTools()<CR>
  noremap K :<C-u>call ShowDocumentation()<CR>
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
  function! GetSelectedContent()
    " Get the start and end positions of the visual selection
    let l:start_pos = getpos("'<")
    let l:end_pos = getpos("'>")
    " Get the l:lines in the selected range
    let l:lines = getline(l:start_pos[1], l:end_pos[1])
    " Handle single-line selection
    if len(l:lines) == 1
        let l:lines = [strpart(l:lines[0], l:start_pos[2] - 1, l:end_pos[2] - l:start_pos[2] + 1)]
    else
        " Adjust the first and last l:lines based on the selection
        let l:lines[0] = strpart(l:lines[0], l:start_pos[2] - 1)
        let l:lines[-1] = strpart(l:lines[-1], 0, l:end_pos[2])
    endif
    return join(l:lines, " ")
  endfunction



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
          \ 'cpp': {'left': '//'},
          \ 'cu': {'left': '//'},
          \ 'opencl': {'left': '//'},
          \ 'lex': {'left': '//'},
          \ 'yacc': {'left': '//'},
          \ 'qmake': {'left': '#'},
          \ 'qml': {'left': '//'},
          \ 'stil': {'left': '/*', 'right': '*/'}
          \ } " Use custom delimiers  to comment source codes.
  let g:NERDCreateDefaultMappings = 0
  map <F3> <plug>NERDCommenterComment
  map <S-F3> <plug>NERDCommenterUncomment



  " Asyncrun setting
  let g:tab_term_buf_size = 33
  function! JumpToTerm(go_to_top = 0, height = 18)
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
      exec 'resize ' . a:height
    endif
    if a:go_to_top != 0
      call feedkeys("gg", 'n')
    endif
  endfunction
  function! ToggleTerminal(height = 18)
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
  function! CUpdateTabTermBuf()
    if exists('g:tab_term_buf')
      if bufexists(g:tab_term_buf[tabpagenr()])
        exec 'silent bwipeout! ' . g:tab_term_buf[tabpagenr()]
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
  let g:asyncrun_save = 1
  let g:asyncrun_mode = 'term'
  noremap <F8> :<C-u>call ToggleTerminal()<CR>
  noremap <LocalLeader><F8> :<C-u>AsyncRun! -strip -rows=3 -hidden=1 -focus=0 -post=call\ JumpToTerm()<Space>
endfunction




function! ConfigureManualLoadPlugin()
  " Vim-quickui setting
  function! QuickuiConfiguration()
    call plug#load('vim-quickui')
    " Clear all the menus
    call quickui#menu#reset()
    " Install a 'File' menu, use [text, command] to represent an item.
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
    " Script inside %{...} will be evaluated and expanded in the string
    call quickui#menu#install('&Option', [
          \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
          \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
          \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
          \ ])
    " Register HELP menu with weight 10000
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
  " Enable to display tips in the cmdline
  let g:quickui_show_tip = 1
  let g:quickui_color_scheme = 'system'
  noremap <Leader>qm :<C-u>call QuickuiOpenMenu()<CR>
  noremap <Leader>qb :<C-u>call QuickuiListBuffer()<CR>
  noremap <Leader>qt :<C-u>call QuickuiPreviewTag()<CR>
  let g:leader_key_map.q = {'name':"Quickui"}



  " NERDTree Setting
  noremap <Leader>nt :<C-u>NERDTreeToggle<CR>
  noremap <Leader>nc :<C-u>NERDTreeCWD<CR>
  let g:NERDTreeFileExtensionHighlightFullName = 1
  let g:NERDTreeExactMatchHighlightFullName = 1
  let g:NERDTreePatternMatchHighlightFullName = 1
  let g:NERDTreeHighlightFolders = 1
  let g:NERDTreeHighlightFoldersFullName = 1
  let g:NERDTreeQuitOnOpen = 1
  let g:NERDTreeDirArrowExpandable = '+'
  let g:NERDTreeDirArrowCollapsible = '-'
  let g:NERDTreeHidden = 0
  let g:leader_key_map.n = {'name':"NERDTree"}



  " Vista setting
  let g:vista_no_mappings = 0
  let g:vista_default_executive = 'coc'
  let g:vista#renderer#enable_icon = 1
  let g:vista_close_on_jump = 1
  let g:vista_cursor_delay = 0
  let g:vista_blink = [0,0]
  let g:vista_top_level_blink = [0,0]
  let g:vista_echo_cursor_strategy = 'echo'
  noremap <Leader>vt :<C-u>Vista!!<CR>
  noremap <Leader>vf :<C-u>Vista focus<CR>
  let g:leader_key_map.v = {'name':"Vista"}



  " Vim-bookmarks setting
  let g:bookmark_no_default_key_mappings = 1
  let g:bookmark_auto_close = 1
  let g:bookmark_auto_save = 1
  " Save bookmarks to $HOME/.vim/.vim-bookmarks or /home/$SUDO_USER/.vim/.vim-bookmarks
  let g:bookmark_save_per_working_dir = 1
  function! g:BMWorkDirFileLocation()
    let l:bookmark_extension = 'bookmarks'
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
  noremap <Leader>bo :<C-u>call plug#load('vim-bookmarks')<CR>
  noremap <Leader>bt :<C-u>BookmarkToggle<CR>
  noremap <Leader>ba :<C-u>BookmarkAnnotate<CR>
  noremap <Leader>bs :<C-u>BookmarkShowAll<CR>
  noremap <Leader>bn :<C-u>BookmarkNext<CR>
  noremap <Leader>bp :<C-u>BookmarkPrev<CR>
  noremap <Leader>bc :<C-u>BookmarkClear<CR>
  noremap <Leader>br :<C-u>BookmarkClearAll<CR>
  nmap <Leader>bu <Plug>BookmarkMoveUp
  nmap <Leader>bd <Plug>BookmarkMoveDown
  nmap <Leader>bl <Plug>BookmarkMoveToLine
  let g:leader_key_map.b = {'name':"Bookmark"}



  " vim-interestingwords
  noremap <Leader>wt :<C-u>call LoadAndSetVimInterestingwords()<CR>
  nnoremap <Leader>wh :call MultipleWordsHighlight('n')<CR>
  vnoremap <Leader>wh :<C-u>call MultipleWordsHighlight('v')<CR>
  function! LoadAndSetVimInterestingwords()
    let g:interestingWordsRandomiseColors = 1
    let g:interestingWordsDefaultMappings = 0
    call plug#load('vim-interestingwords')
    noremap <Leader>w<S-h> :<C-u>call UncolorAllWords()<CR>
    noremap n :<C-u>call WordNavigation(1)<CR>
    noremap <S-n> :<C-u>call WordNavigation(0)<CR>
  endfunction
  function! MultipleWordsHighlight(mode)
    if !exists('*InterestingWords')
      call LoadAndSetVimInterestingwords()
    endif
    call InterestingWords(a:mode)
  endfunction
  let g:leader_key_map.w = {'name':"multi-highlight"}



  " vim-visual-multi setting
  noremap <C-n> :<C-u>call MultipleCursors()<CR>
  function! MultipleCursors(key_map="\<C-n>")
    if !empty(maparg(a:key_map, 'v', 0, 1))
      call LoadVimVisualMulti()
    endif
    call feedkeys(a:key_map, "!")
  endfunction
  function! LoadVimVisualMulti()
    " 1. Save the current visual selection and load vim-viusal-multi
    let l:original_visual_mode = visualmode()
    let [l:start_line, l:start_col] = getpos("'<")[1:2]
    let [l:end_line, l:end_col] = getpos("'>")[1:2]
    call plug#load('vim-visual-multi')
    " 2. Restore the visual selection
    call cursor(l:start_line, l:start_col)
    execute "normal! " . l:original_visual_mode
    call cursor(l:end_line, l:end_col)
  endfunction



  " Vim-fugitive, vim-gitgutter and git-blame setting
  noremap <Leader>git :<C-u>call LoadAndSetGitPlugin()<CR>
  function! LoadAndSetGitPlugin()
    let g:fugitive_no_maps = 1
    let g:gitgutter_map_keys = 0
    map <Leader>gk <Plug>(GitGutterPrevHunk)
    map <Leader>gj <Plug>(GitGutterNextHunk)
    map <Leader>gf <Plug>(GitGutterFold)
    noremap <Leader>gb :<C-u>call gitblame#echo()<CR>
    exec 'normal! ms'
    call plug#load('vim-fugitive')
    call plug#load('vim-gitgutter')
    call plug#load('git-blame.vim')
    set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [%{toupper(&fileencoding)}=0x%B]%m%r
    set statusline+=%=\ %{GitStatus()}%{FugitiveStatusline()}
    set statusline+=\ [%{strftime(\"%m/%d/%y-%a-%H:%M\")}]%<
    exec 'normal! `s'
  endfunction
  function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endfunction
  let g:leader_key_map.g = { 'name':"git", 'i':{'name':"load git plugins"}}



  " Vimspector setting
  function! ConfigureCppDebug()
    let l:cpp_workspace_root = WorkspaceRoot()
    if !isdirectory(l:cpp_workspace_root.'/.vscode')
      call mkdir(l:cpp_workspace_root.'/.vscode', 'p', 0755)
    endif
    call CopyFileRelToCPP(l:cpp_workspace_root, '.vscode/launch.json')
    if CopyFileRelToCPP(l:cpp_workspace_root, '.vimspector.json')
      call NUpdateTabTermBuf()
      exec 'tabe ' . l:cpp_workspace_root.'/.vimspector.json'
    endif
  endfunction
  noremap <F2> :<C-u>call ContinueInVimspector()<CR>
  noremap <S-F2> :<C-u>call RestartVimspector()<CR>
  map ]<F2> <Plug>VimspectorRunToCursor
  map ]<S-F2> <Plug>VimspectorStop
  map ]<C-F2> <Plug>VimspectorPause
  noremap <F4> :<C-u>call ToggleBreakpoint()<CR>
  noremap <S-F4> :<C-u>call vimspector#ClearBreakpoints()<CR>
  map ]<F4> <Plug>VimspectorToggleConditionalBreakpoint
  noremap ]<S-F4> :<C-u>call vimspector#SetAdvancedLineBreakpoint()<CR>
  noremap ]<C-F4> :<C-u>call vimspector#AddAdvancedFunctionBreakpoint()<CR>
  noremap <F5> :<C-u>call plug#load('vimspector')<CR>
  noremap <S-F5> :<C-u>VimspectorReset<CR>
  noremap ]<F5> :<C-u>set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 19<CR>
              \ :<C-u>call LaunchVimspector()<CR>
  noremap <Leader><F5> :<C-u>call ConfigureCppDebug()<CR>
  map <F6> <Plug>VimspectorStepOver
  map <C-F6> <Plug>VimspectorStepInto
  map <S-F6> <Plug>VimspectorStepOut
  map ]<F7> <Plug>VimspectorUpFrame
  map ]<S-F7> <Plug>VimspectorDownFrame
  noremap ]<F8> :<C-u>let g:vimspector_variables_display_mode = 'full'<CR>
  noremap <C-1> :<C-u>call win_gotoid(g:vimspector_session_windows.variables)<CR>
  inoremap <C-1> <C-o>:call win_gotoid(g:vimspector_session_windows.variables)<CR>
  noremap <C-3> :<C-u>call win_gotoid(g:vimspector_session_windows.watches)<CR>
  inoremap <C-3> <C-o>:call win_gotoid(g:vimspector_session_windows.watches)<CR>
  noremap <C-5> :<C-u>call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>
  inoremap <C-5> <C-o>:call win_gotoid(g:vimspector_session_windows.stack_trace)<CR>
  noremap <C-7> :<C-u>call win_gotoid(g:vimspector_session_windows.code)<CR>
  inoremap <C-7> <C-o>:call win_gotoid(g:vimspector_session_windows.code)<CR>
  noremap <C-8> :<C-u>VimspectorShowOutput Console<CR>
  inoremap <C-8> <C-o>:VimspectorShowOutput Console<CR>
  noremap <C-9> :<C-u>call win_gotoid(g:vimspector_session_windows.terminal)<CR>
  inoremap <C-9> <C-o>:call win_gotoid(g:vimspector_session_windows.terminal)<CR>
  noremap <C-0> :<C-u>call ListAllBreakPoints()<CR>
  inoremap <C-0> <C-o>:call ListAllBreakPoints()<CR>
  noremap ]a :<C-u>call ShowAssembleCode()<CR>
  noremap ]s <Plug>VimspectorDisassemble
  map ]c <Plug>VimspectorJumpToProgramCounter
  map ]d <Delete>
  map ]e <Plug>VimspectorBalloonEval
  map ]j <Plug>VimspectorJumpToNextBreakpoint
  map ]k <Plug>VimspectorJumpToPreviousBreakpoint
  noremap ]pc :<C-u>call ControlAllChildrenProcessess()<CR>
  noremap ]pd :<C-u>call DetachAllChildrenProcessess()<CR>
  noremap ]pf :<C-u>call FollowChildrenProcessess()<CR>
  noremap ]pp :<C-u>call FollowParentProcessess()<CR>
  noremap ]pi :<C-u>call ListAllProcessess()<CR>
  noremap ]ps :<C-u>call SwitchToSpecificProcess(
  noremap ]r :<C-u>call ReshapeVimspectorWins()<CR>
  noremap ]ta :<C-u>call CheckAllBacktraces()<CR>
  noremap ]tb :<C-u>call CheckCurrentBacktrace()<CR>
  noremap ]tl :<C-u>call SetBacktraceLimit(
  noremap ]ts :<C-u>call SwitchToSpecificThread(
  noremap ]tc :<C-u>call ContinueAllThreads()<CR>
  noremap ]tt :<C-u>call StopAllThreads()<CR>
  nnoremap ]v :call AddVarToWatch(expand('<cword>'))<CR>
  vnoremap ]v :<C-u> call AddVarToWatch(GetSelectedContent())<CR>
  sign define vimspectorBP            text=B texthl=WarningMsg
  sign define vimspectorBPCond        text=BC texthl=WarningMsg
  sign define vimspectorBPLog         text=BL texthl=SpellRare
  sign define vimspectorBPDisabled    text=BD texthl=LineNr
  sign define vimspectorPC            text=$ texthl=MatchParen linehl=CursorLine
  sign define vimspectorPCBP          text=●>  texthl=MatchParen linehl=CursorLine
  sign define vimspectorCurrentThread text=>   texthl=MatchParen linehl=CursorLine
  sign define vimspectorCurrentFrame  text=>   texthl=Special    linehl=CursorLine
  function! ReshapeVimspectorWins(var = 60, enable_stack_trace = 0)
    let l:cur_winid = win_getid()
    call win_gotoid(g:vimspector_session_windows.code)
    nunmenu WinBar
    wincmd _
    call win_gotoid(g:vimspector_session_windows.output)
    9wincmd _
    call win_gotoid(g:vimspector_session_windows.terminal)
    36wincmd |
    call win_gotoid(g:vimspector_session_windows.variables)
    setlocal wrap
    nunmenu WinBar
    exec a:var.'wincmd |'
    wincmd _
    call win_gotoid(g:vimspector_session_windows.watches)
    setlocal wrap
    nunmenu WinBar
    16wincmd _
    if a:enable_stack_trace
      call win_gotoid(g:vimspector_session_windows.stack_trace)
      3wincmd _
    endif
    call win_gotoid(l:cur_winid)
  endfunction
  function! s:SetUpTerminal()
    call win_gotoid(g:vimspector_session_windows.terminal)
    let l:term_buf_id = winbufnr(g:vimspector_session_windows.terminal)
    hide
    call win_gotoid(g:vimspector_session_windows.output)
    exec 'rightbelow vsplit | b ' . l:term_buf_id
    let g:vimspector_session_windows.terminal = win_getid()
    call ReshapeVimspectorWins()
  endfunction
  function! QuitVimspectorWins()
    let l:quit_success = 0
    if exists("g:vimspector_session_windows.disassembly")
      \ && win_id2win(g:vimspector_session_windows.disassembly) > 0
      call win_gotoid(g:vimspector_session_windows.disassembly)
      quit!
      let l:quit_success = 1
    endif
    if exists("g:vimspector_session_windows.terminal")
      \ && win_id2win(g:vimspector_session_windows.terminal) > 0
      call win_gotoid(g:vimspector_session_windows.terminal)
      quit!
      let l:quit_success = 1
    endif
    return l:quit_success
  endfunction
  function! RestartVimspector()
    call QuitVimspectorWins()
    call vimspector#Restart()
  endfunction
  function! ToggleBreakpoint()
    if !exists("VimspectorShowOutput")
      call plug#load('vimspector')
    endif
    call vimspector#ToggleBreakpoint()
  endfunction
  function! ContinueInVimspector()
    if !exists("g:vimspector_session_windows.code")
      call LaunchVimspector()
      return
    endif
    call vimspector#Continue()
  endfunction
  function! LaunchVimspector()
    if !exists("VimspectorShowOutput")
      call plug#load('vimspector')
    endif
    call JumpToTheMainWin()
    let l:cur_win_id = win_getid()
    if QuitVimspectorWins()
      call win_gotoid(l:cur_win_id)
    endif
    if &filetype=='python'
      call vimspector#LaunchWithSettings(#{configuration: 'python: launch', Test: 'python: launch'})
    elseif &filetype=='tcl'
      call vimspector#LaunchWithSettings(#{configuration: 'tcl: launch', Test: 'tcl: launch'})
    elseif &filetype=='c' || &filetype=='cpp'
      call vimspector#LaunchWithSettings(#{configuration: 'cpp: launch', Test: 'cpp: launch'})
    endif
  endfunction
  function! AddVarToWatch(selection)
    let l:cur_winid = win_getid()
    call win_gotoid(g:vimspector_session_windows.watches)
    exec "normal! i".a:selection."\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! ListAllBreakPoints()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec info breakpoints\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! ShowAssembleCode()
    if exists("g:vimspector_session_windows.disassembly")
      \ && win_id2win(g:vimspector_session_windows.disassembly) > 0
      call win_gotoid(g:vimspector_session_windows.disassembly)
      return
    endif
    let l:cur_winid = win_getid()
    call vimspector#ShowDisassembly()
    while !exists("g:vimspector_session_windows.disassembly")
      \ || win_id2win(g:vimspector_session_windows.disassembly) == 0
      \ || l:cur_winid == win_getid()
      sleep 33m
    endwhile
    let l:dis_buf_id = winbufnr(g:vimspector_session_windows.disassembly)
    hide
    call win_gotoid(g:vimspector_session_windows.code)
    exec 'rightbelow vsplit | b ' . l:dis_buf_id
    let g:vimspector_session_windows.disassembly = win_getid()
    call ReshapeVimspectorWins(30)
    call win_gotoid(g:vimspector_session_windows.disassembly)
    65wincmd |
  endfunction
  function! ControlAllChildrenProcessess()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec set detach-on-fork off\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! DetachAllChildrenProcessess()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec set detach-on-fork on\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! FollowChildrenProcessess()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec set follow-fork-mode child\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! FollowParentProcessess()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec set follow-fork-mode parent\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! ListAllProcessess()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec info inferiors\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! SwitchToSpecificProcess(num=1)
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec inferior a:num\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! ListAllThreads()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec info threads\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! CheckAllBacktraces()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec thread apply all backtrace\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! CheckCurrentBacktrace()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec backtrace\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! SetBacktraceLimit(limit=6)
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec set backtrace limit a:limit\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! SwitchToSpecificThread(num=1)
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec thread a:num\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! ContinueAllThreads()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec thread apply all continue\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  function! StopAllThreads()
    let l:cur_winid = win_getid()
    exec ":VimspectorShowOutput Console"
    exec "normal! i"."-exec thread apply all stop\<CR>"
    call win_gotoid(l:cur_winid)
  endfunction
  augroup Plugin_Configuration | autocmd User VimspectorTerminalOpened call s:SetUpTerminal() | augroup END
  let g:right_bracket_key_map.p = {'name':"VimspectorProcesses"}
  let g:right_bracket_key_map.t = {'name':"VimspectorBacktracesAndThreads"}



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
  " Open the preview window automatically
  let g:Lf_PreviewResult = {'Rg': 1}
endfunction
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
  " Toggle Menu and Toolbar菜单栏和工具栏
  set guioptions-=m
  set guioptions-=T
  noremap <LocalLeader>m :<C-u>call MenuToggle()<CR>
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
" Uncomment the following to have Vim jump to the last position when reopening a file
augroup Local_Autocmd_Group | autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif | augroup END
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
augroup Local_Autocmd_Group
  autocmd FileType * call SetIndent()
  autocmd BufNewFile * call SetTitle()
  " Disable automatic word wrap which is enabled by filetype plugin indent on
  autocmd FileType vim,cmake set textwidth=0
augroup END
set autoindent
set smartindent
set expandtab                 " 把Tab字符用空格代替，和tabstop相关
set list                      " Enable special character display
set listchars=tab:>>¦,trail:• " Show a tab as >>¦, show a trailing space as •
function! SetIndent()
  let l:indent_val=4
  if &filetype=='c' || &filetype=='cpp' || &filetype=='opencl'
        \ || &filetype=='verilog' || &filetype=='json' || expand('%:e')=='icl'
    let l:indent_val = 3
    if &filetype=='c' || &filetype=='cpp'
      set cindent     " 设置使用C/C++语言的自动缩进方式
    endif
  elseif &filetype=='vim'
    let l:indent_val = 2
  endif
  let &tabstop = l:indent_val      " Tab键的显示宽度 and its practical width
  let &softtabstop = l:indent_val  " 按下Tab键时输入的宽度
  let &shiftwidth = l:indent_val   " 设置自动缩进时的缩进长度
endfunction
function! AppendInfo(info, column_limit)
  let l:padding_str_len = 3
  let l:lpadding_strs = &commentstring[0].&commentstring[1]
      \ .repeat(&commentstring[0], l:padding_str_len - 2)
  let l:rpadding_strs = repeat(&commentstring[0], l:padding_str_len - 2)
      \ .&commentstring[1].&commentstring[0]
  let l:start_space_len = (a:column_limit - strdisplaywidth(a:info) - l:padding_str_len * 2) / 2
  let l:end_space_len = a:column_limit - l:start_space_len - strdisplaywidth(a:info) - l:padding_str_len * 2
  call append(line('$'), l:lpadding_strs.repeat(' ', l:start_space_len).a:info.repeat(' ', l:end_space_len).l:rpadding_strs)
endfunction
function! SetTitle()
  if &filetype=='c' || &filetype=='cpp' || expand('%:e')=='cl'
      \ || expand('%:e')=='cu' || expand('%:e')=='qml'
    setlocal commentstring=//\ %s
  endif
  if empty(&commentstring) || empty(&filetype) || (strlen(&commentstring) > 3
      \ && &commentstring[0] != &commentstring[1] && &commentstring[1] != ' ')
    return
  endif
  if &filetype=='sh'
    call setline(1, '#!/usr/bin/env bash')
  elseif &filetype=='csh'
    call setline(1, '#!/usr/bin/env csh')
  elseif &filetype=='perl'
    call setline(1, '#!/usr/bin/env perl')
  elseif expand('%:e')=='tcl'
    call setline(1, '#!/usr/bin/env tclsh')
  endif
  let l:column_limit = split(&colorcolumn, ",")[0]
  let l:top_and_bottom = &commentstring[0].&commentstring[1]
      \ .repeat(&commentstring[0], l:column_limit - 4)
      \ .&commentstring[1].&commentstring[0]
  if &filetype=='sh' || &filetype=='csh' || &filetype=='perl' || &filetype=='tcl'
    call append(line('$'), l:top_and_bottom)
  else
    call setline(1, l:top_and_bottom)
  endif
  call AppendInfo('File Name: '.expand('%:t'), l:column_limit)
  let l:author = 'Huaxiao Liang'
  let l:email = 'hxliang666@qq.com'
  if exists('$GIT_AUTHOR_NAME')
    let l:author = $GIT_AUTHOR_NAME
  elseif exists('$LOG_NAME')
    let l:author = $LOG_NAME
  endif
  if exists('$GIT_AUTHOR_EMAIL')
    let l:email = $GIT_AUTHOR_EMAIL
  elseif exists('$LOG_NAME')
    let l:email = $LOG_NAME
  endif
  call AppendInfo('Author: '.l:author, l:column_limit)
  call AppendInfo('Mail: '.l:email, l:column_limit)
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
  elseif &filetype=='cuda'
    call append(line('$'), '#include <iostream>')
    call append(line('$'), '#include <cuda_runtime.h>')
  elseif &filetype=='make'
    call append(line('$'), '.PHONY:')
  elseif &filetype=='perl'
    call append(line('$'), 'use strict;')
    call append(line('$'), 'use warnings;')
  endif
  call append(line('$'), '')
  call setpos('.', [0, line('$'), 0, 0])
endfunction
noremap <LocalLeader>a :<C-u>call AutoWrap()<CR>
function! AutoWrap()
  let original_win = winnr()
  " 遍历两个 diff 窗口
  for win in range(1, winnr('$'))
    " 切换到目标窗口
    execute win . 'wincmd w'
    setlocal wrap
    setlocal diffopt+=context:3
  endfor
  " 返回原始窗口
  execute original_win . 'wincmd w'
endfunction
noremap <silent><Leader>` :<C-u>call CallShowNearestFunction()<CR>
noremap <silent>`<Leader> :<C-u>call CallShowNearestFunctionNone()<CR>
function! ShowNearestClassOrStruct()
  let l:class_line = search('^class\s\+.\+', 'bcnWz')
  let l:struct_line = search('^struct\s\+.\+', 'bcnWz')
    let l:nearest_name = 'No class/struct can be found.'
  if(l:class_line > l:struct_line)
    let l:nearest_name = getline(l:class_line)
  elseif(l:class_line < l:struct_line)
    let l:nearest_name = getline(l:struct_line)
  else
    let l:nearest_name = 'No class/struct can be found.'
  endif
  let l:nearest_end_poisition = strridx(l:nearest_name, '{')
  if(l:nearest_end_poisition > 0)
    let l:nearest_name = strpart(l:nearest_name, 0, l:nearest_end_poisition)
  endif
  echo l:nearest_name
endfunction
function! ShowCurrentCodeBlockName(name_keyword, show_name, end_keyword)
  if getline('.') =~ a:name_keyword
    let l:block_name = getline('.')
  else
    let l:block_name_line = search(a:name_keyword, 'bcnWz')
    let l:block_name = getline(l:block_name_line)
  endif
  let l:block_end_position = strridx(l:block_name, a:end_keyword)
  if(l:block_end_position > 0)
    let l:block_name = strpart(l:block_name, 0, l:block_end_position)
  endif
  let l:block_name = strpart(l:block_name, stridx(l:block_name, a:show_name) + len(a:show_name) + 1)
  while(strpart(l:block_name, 0 , 1)==' ')
    let l:block_name = strpart(l:block_name, 1)
  endwhile
  echo a:show_name '-->' l:block_name
endfunction
function! ShowCurrentFuncCodeBlockName()
  if &filetype=='tcl'
    if expand('%:e')=='tcl'
      let l:name_keyword = 'proc\s\+.\+\s*{'
      let l:show_name = 'proc'
    else
      let l:name_keyword = '^iProc\s\+.\+\s*{'
      let l:show_name = 'iProc'
    endif
  elseif &filetype=='perl'
      let l:name_keyword = 'sub\s\+.\+\s*{'
      let l:show_name = 'sub'
  elseif &filetype=='python'
      let l:name_keyword = 'def\s\+.\+(.*'
      let l:show_name = 'def'
  elseif &filetype=='make'
      let l:name_keyword = '^define\s\+.\+'
      let l:show_name = 'define'
  elseif &filetype=='vim'
      let l:name_keyword = 'function\s\+.\+(\|function!\s\+.\+('
      let l:show_name = 'function'
  else
    let l:name_keyword = '^module\s\+.\+\s*(\|^Module\s\+.\+\s*{'
    let l:show_name = 'module'
  endif
  if &filetype=='verilog'
    let l:end_keyword = '('
  elseif &filetype=='python'
    let l:end_keyword = ':'
  elseif &filetype=='make' || &filetype=='vim'
    let l:end_keyword = '\n'
  else
    let l:end_keyword = '{'
  endif
  call ShowCurrentCodeBlockName(l:name_keyword, l:show_name, l:end_keyword)
endfunction
function! ShowCurrentNoneFuncCodeBlockName()
  if &filetype=='tcl'
      let l:name_keyword = 'namespace\s\+eval.\+{'
      let l:show_name = 'namespace eval'
  elseif &filetype=='perl'
      let l:name_keyword = 'package\s\+.\+{'
      let l:show_name = 'package'
  elseif &filetype=='python'
      let l:name_keyword = 'class\s\+.\+:'
      let l:show_name = 'class'
  endif
  if &filetype=='python'
    let l:end_keyword = ':'
  else
    let l:end_keyword = '{'
  endif
  call ShowCurrentCodeBlockName(l:name_keyword, l:show_name, l:end_keyword)
endfunction
function! CallShowNearestFunction()
  if &filetype=='cpp' || &filetype=='c'
     call ShowNearestClassOrStruct()
  elseif &filetype=='verilog' || expand('%:e')=='icl' || &filetype=='tcl'
        \ || &filetype=='perl' || &filetype=='python' || &filetype=='make'
        \ || &filetype=='vim'
     call ShowCurrentFuncCodeBlockName()
  endif
endfunction
function! CallShowNearestFunctionNone()
  if &filetype=='cpp' || &filetype=='c'
     call ShowNearestClassOrStruct()
  elseif &filetype=='tcl' || &filetype=='perl' || &filetype=='python'
     call ShowCurrentNoneFuncCodeBlockName()
  endif
endfunction
noremap <LocalLeader><F2> :<C-u>call CompileAndExcute()<CR>
noremap <Leader><F2> :<C-u>call CompileCommand()<CR>
function! CPPCompilation()
  let l:cpp_workspace_root = WorkspaceRoot()
  let l:cur_file_path = expand('%:p:h')
  let l:all_possible_paths = [l:cpp_workspace_root]
  for l:str_id in range(strlen(l:cpp_workspace_root) + 1, strlen(l:cur_file_path))
    if l:cur_file_path[l:str_id]=='/'
      call add(l:all_possible_paths, strpart(l:cur_file_path, 0, l:str_id))
    endif
  endfor
  call add(l:all_possible_paths, l:cur_file_path)
  let l:cmakelist_path = []
  let l:qmakepro_path = []
  let l:makefile_path = []
  let l:sconstruct_path = []
  for l:possible_path in l:all_possible_paths
    let l:pattern = l:possible_path."/CMakeLists.txt"
    " Get the list of matching files (non-recursive)
    let l:cmakelist_path = glob(l:pattern, 0, 1)
    if !empty(l:cmakelist_path)
      let l:cmakelist_path = ' cd '.l:possible_path
          \ .' && cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_VERBOSE_MAKEFILE=ON'
      call system('ccache --version')
      if v:shell_error " Not use ccache
        echo "ccache is not installed."
      else
        let l:cmakelist_path = l:cmakelist_path
              \ .' -DCMAKE_C_COMPILER_LAUNCHER=ccache'
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
  let l:compile_single_file = ' -fsanitize=address,undefined,leak -g -pedantic-errors'
        \ .' -Wall -Wextra -Wconversion -Wsign-conversion -Wshadow '
        \ .expand('%:t').' -o '.fnamemodify(expand('%'), ':t:r').'.exe'
  if &filetype=='cpp'
    return ' cd '.l:cur_file_path.' && g++ -Weffc++'.l:compile_single_file
  elseif &filetype=='cuda'
    return ' cd '.l:cur_file_path.' && nvcc -g '.expand('%:t').' -o '
        \ .fnamemodify(expand('%'), ':t:r').'.exe'
  elseif &filetype=='verilog' || &filetype=='systemverilog'
    return ' cd '.l:cur_file_path.' iverilog *.v -o %<.out && vvp %<.out'
  else
    return ' cd '.l:cur_file_path.' && gcc'.l:compile_single_file
  endif
endfunction
if !(exists('*CompileAndExcute') && &filetype=='vim')
  function! CompileAndExcute()
    let l:compile_exec = ':AsyncRun -strip -rows=3 -listed=1 -hidden=1 -focus=0 -post=call\ JumpToTerm()'
    if &filetype=='python' && expand('%:t') != 'SConstruct' && expand('%:t') != 'SConscript'
      exec l:compile_exec.' /usr/bin/env python3 %'
    elseif &filetype=='sh'
      exec l:compile_exec.' /usr/bin/env sh %'
    elseif &filetype=='csh'
      exec l:compile_exec.' /usr/bin/env csh %'
    elseif &filetype=='verilog'
      let l:verilog_compilation = CPPCompilation()
      exec l:compile_exec.l:verilog_compilation.' && gtkwave %<.vcd'
    elseif &filetype=='perl'
      exec l:compile_exec.' /usr/bin/env perl %'
    elseif &filetype=='tcl'
      exec l:compile_exec.' /usr/bin/env tclsh %'
    elseif &filetype=='markdown'
      exec ':CocCommand markdown-preview-enhanced.openPreview'
    elseif &filetype=='vim'
      exec ':source ~/.vimrc'
    elseif &filetype=='help' || &buftype =='terminal' || &filetype=='VimspectorPrompt'
        \ || &filetype=='vista' || &buftype =='nofile' || &filetype=='nerdtree'
      call JumpToTheMainWin()
      call CompileAndExcute()
    else
      let l:cpp_compilation = CPPCompilation()
      if stridx(l:cpp_compilation, 'bear') != -1
        exec l:compile_exec.l:cpp_compilation
              \.' && if [ -e build/'.fnamemodify(expand('%'), ':t:r').'.exe ]; then'
              \.' build/'.fnamemodify(expand('%'), ':t:r').'.exe;'
              \.'  elif [ -e ./'.fnamemodify(expand('%'), ':t:r').'.exe ]; then'
              \.' ./'.fnamemodify(expand('%'), ':t:r').'.exe;'
              \.'  elif [ -e '.fnamemodify(expand('%:r'), ':p').'.exe ]; then'
              \.' '.fnamemodify(expand('%:r'), ':p').'.exe;'
              \.'  elif [ -d "./build" ] && find ./build -maxdepth 1 -name "*.exe" | grep -q .; then'
              \.' build/*.exe;'
              \.'  elif find . -maxdepth 1 -name "*.exe" | grep -q .; then'
              \.' ./*.exe;'
              \.' else'
              \.' '.expand('%:p:h').'/*.exe;'
              \.' fi'
      elseif ((&filetype=='c' || &filetype=='cpp') && expand('%:e')!~'^h.*') || &filetype=='cuda'
        exec l:compile_exec.l:cpp_compilation.' && ./'.fnamemodify(expand('%'), ':t:r').'.exe'
      endif
    endif
  endfunction
endif
function! CompileCommand()
  let l:compile_only = ':AsyncRun! -strip -rows=3 -hidden=1 -focus=0 -post=call\ JumpToTerm(1)'
  if &filetype=='verilog'
      let l:verilog_compilation = CPPCompilation()
      exec l:compile_exec.l:verilog_compilation
  elseif &filetype=='help' || &buftype =='terminal' || &filetype=='VimspectorPrompt'
      \ || &filetype=='vista' || &buftype =='nofile' || &filetype=='nerdtree'
    call JumpToTheMainWin()
    call CompileCommand()
  else
    let l:cpp_compilation = CPPCompilation()
    if stridx(l:cpp_compilation, 'bear') != -1
          \ || ((&filetype=='c' || &filetype=='cpp')
          \   && expand('%:e')!~'^h.*')
      exec l:compile_only.l:cpp_compilation
    endif
  endif
endfunction
noremap <LocalLeader>t :<C-u>call NUpdateTabTermBuf()<CR>:tabnew<CR>
noremap <LocalLeader>b :<C-u>call CloseAndBackTab()<CR>
noremap <LocalLeader>q :<C-u>call QuitWin()<CR>
noremap <LocalLeader>w :<C-u>w<CR>
noremap <M-S-h> :<C-u>call MoveTabH()<CR>
noremap <M-S-l> :<C-u>call MoveTabL()<CR>
inoremap <M-S-h> <C-o>:call MoveTabH()<CR>
inoremap <M-S-l> <C-o>:call MoveTabL()<CR>
noremap <C-M-h> gT
noremap <C-M-j> gT
noremap <C-M-l> gt
noremap <C-M-k> gt
inoremap <C-M-h> <C-o>gT
inoremap <C-M-j> <C-o>gT
inoremap <C-M-l> <C-o>gt
inoremap <C-M-k> <C-o>gt
function! CloseAndBackTab()
  while winnr('$') > 1 " Prevent the function from closing multiple tabs
    call QuitWin()
  endwhile
  call QuitWin()
  exec 'tabp'
endfunction
function! QuitWin()
  let l:exec_quit='quit'
  if &filetype=='' " Close terms without warnings.
    let l:exec_quit='quit!'
  endif
  if winnr('$') == 1 && tabpagenr('$') > 1 " Multiple tabs, single win
    call CUpdateTabTermBuf()
  elseif winnr('$') == 1 " Single win, single tab
    for l:buf in range(1, bufnr('$')) " Clear term buffers without warnings.
      if l:buf != bufnr('%') && bufexists(l:buf)
        exec 'silent bwipeout! ' . l:buf
      endif
    endfor
  endif
  if exists("g:vimspector_session_windows.disassembly")
    \ && g:vimspector_session_windows.disassembly == win_getid()
    exec l:exec_quit
    unlet g:vimspector_session_windows['disassembly']
    call ReshapeVimspectorWins()
    return
  endif
  exec l:exec_quit
endfunction
function! MoveTab(boundary, plus_or_minus, plus_or_minus_one, first, last)
  let l:cur_tab=tabpagenr()
  if l:cur_tab == a:boundary && tabpagenr('$') > 1
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
noremap <LocalLeader><F4> :<C-u>vert diffsplit<Space>
noremap <LocalLeader><F5> :<C-u>call DeleteBlankLine()<CR>
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
          \ && l:line_num - l:up_line_num < l:down_line_num - l:line_num) " Closest to the up line.
      let l:line_num = l:up_line_num
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
noremap <LocalLeader><F7> :<C-u>call RetabAndDeleteTraillingUselessChars()<CR>
noremap <LocalLeader>u :<C-u>nohlsearch<CR>
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
nnoremap <C-Space> i<Space><ESC>l
function! InsertEnterInNormalMode()
  " 1. 获取当前光标所在位置的行数
  let l:cur_line = line('.')
  let l:new_line = l:cur_line + 1
  " 2. 获取 `l:cur_line` 中的缩进空格数，并生成 n 个空格
  let l:cur_indent_count = indent(l:cur_line)
  let l:cur_indent = repeat(' ', l:cur_indent_count)
  " 3. 进入插入模式，输入回车，然后返回正常模式
  " feedkeys() is an asynchronous function that causes some issues.
  " call feedkeys("i\<CR>\<ESC>", 'n')
  exec "normal! i\<CR>\<ESC>"
  let l:new_column = col('.')
  if l:new_column != 1
    let l:new_column = l:new_column + 1
  endif
  " 4. 如果 `l:new_line` 行为空或只有空格, 给 `l:new_line` 行插入 `l:cur_indent`
  if getline(l:new_line) =~? '^\s*$'
    call setline(l:new_line, l:cur_indent)
    let l:new_column = l:cur_indent_count + 1
  endif
  " 5. 如果 `l:cur_line` 行为空或只有空格，则清除 `l:cur_line` 行的空格
  if getline(l:cur_line) =~? '^\s*$'
    call setline(l:cur_line, '')
  endif
  " 6. 去到 `l:new_line` 行的l:new_column列
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
" Ctrl-Alt/Shift-Enter新建空行
noremap <C-M-CR> :<C-u>put _<CR>
inoremap <C-M-CR> <C-o>:put _<CR>
noremap <C-S-CR> :<C-u>put _<CR>
inoremap <C-S-CR> <C-o>:put _<CR>
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
" Disable Q in normal mode
noremap Q <Nop>
