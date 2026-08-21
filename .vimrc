" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
" 开启24bits RGB支持
set termguicolors
" 不少插件的信息更新都会需要这个时间
set updatetime=333
" 设置<ESC>键响应时间
set ttimeoutlen=0
" Setting keymapping timeout
set timeoutlen=666
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 打开文件时进行解码的猜测列表
set fileencodings=utf-8,utf-16,utf-32,ucs-bom,shift-jis,gb18030,big5,latin1
" 把当前文件转换为当前系统编码进行处理，这里为utf-8
set encoding=utf-8
scriptencoding utf-8
" 禁止生成临时文件
set nobackup
set nowritebackup
set noswapfile
let maplocalleader = ","



augroup Auto_Set_FileType
  autocmd!
  autocmd BufNewFile */include/* if expand('%:e')=='' && (&filetype == 'conf' || &filetype == '') | setlocal filetype=cpp | endif
  autocmd BufNewFile *.launch,*.qrc,*.conf setlocal filetype=xml
  autocmd BufNewFile *.v setlocal filetype=verilog
  autocmd BufNewFile *.tessent_startup,*.dofile,*.pdl,*.pdl.* setlocal filetype=tcl
  autocmd BufNewFile *.stil setlocal filetype=stil
augroup END



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
let g:coc_start_at_startup = 0
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
" Highlight qmake syntax
Plug 'artoj/qmake-syntax-vim', {'for': ['qmake']}
" Vim快捷键管理和提示插件, Delay-load
Plug 'liuchengxu/vim-which-key', {'on': []}
" 补全插件, 动态检测语法插件, 可鼠标停留显示信息, Delay-load
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Markdown目录构建插件, Manual-load and Delay-load
Plug 'mzlogin/vim-markdown-toc', {'on': []}
" Nerdcommenter快速注释插件, Delay-load
Plug 'preservim/nerdcommenter', {'on': []}
" % match plugins, Delay-load
Plug 'andymass/vim-matchup', {'on': []}
" 异步执行shell命令插件, Delay-load
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
" Verilog
Plug 'HonkW93/automatic-verilog', {'for': ['verilog']}
Plug '0BananaBig0/vim-verilog-instance', {'for': ['verilog']}
call plug#end()



colorscheme dracula
hi Terminal guibg=#282a36 guifg=#f8f8f2
noremap <Leader>ppt :<C-u>colorscheme zellner<CR>
                  \ :set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 23<CR>
                  \ :set colorcolumn=0<CR>
noremap <Leader>per :<C-u>colorscheme dracula<CR>
                  \ :<C-u>hi Terminal guibg=#282a36 guifg=#f8f8f2<CR>
                  \ :set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 18<CR>
                  \ :set colorcolumn=80,120,160<CR>



" After 333ms, call the coc.nvim, markdown-preview and so on
function! CocTimerStart(timer)
  exec 'CocStart'
  call ConfigureDelayedPlugin()
  call ConfigureManualLoadPlugin()
  call InitializeTabPos()
  " Create an array to store the most recent terminal buffer for each tab
  let g:tab_term_buf_size = 33
  if !exists('g:tab_term_buf')
    let g:tab_term_buf = repeat([-1], g:tab_term_buf_size)
  endif
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
  function! LoadMarkdownToc(function_name)
      call plug#load('vim-markdown-toc')
      while !exists(a:function_name)
      endwhile
  endfunction
  function! CreateMarkdownMenu()
    exec 'normal! ms'
    if !exists(':GenTocGFM')
      call LoadMarkdownToc(':GenTocGFM')
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
      call LoadMarkdownToc(':UpdateToc')
    endif
    exec ':UpdateToc'
    let l:new_line = l:previous_line + (line('$') - l:previous_total_line_count)
    call setpos('.', [0, l:new_line, l:previous_column, 0])
  endfunction
endfunction



function! ConfigureWhichKey()
  let g:which_key_use_floating_win = 0
  let g:which_key_fallback_to_native_key = 0
  call plug#load('vim-which-key')
  noremap <Leader> :<C-u>WhichKey '\'<CR>
  noremap <LocalLeader> :<C-u>WhichKey ','<CR>
  noremap [ :<C-u>WhichKey '['<CR>
  noremap ] :<C-u>WhichKey ']'<CR>
  let g:leader_key_map = {
        \ 'a': {
          \ 'name': '+Automatic Verilog',
          \ 'a': 'Generate arguments',
          \ 'd': 'Generate definition',
          \ 'i': 'Generate instance',
          \ 'p': {
            \ 'name': '+Parameters',
            \ 'p': 'Generate parameters',
            \ 'v': 'Generate parameter values',
            \ },
          \ 'r': 'Generate registers',
          \ 'w': 'Generate wires',
          \ },
        \ 'b': {
          \ 'name': '+Bookmarks',
          \ 'a': 'Annotate bookmark',
          \ 'c': 'Clear bookmark',
          \ 'd': 'Move bookmark down',
          \ 'l': 'Move bookmark to line',
          \ 'n': 'Next bookmark',
          \ 'o': 'Load bookmark plugin',
          \ 'p': 'Previous bookmark',
          \ 'r': 'Clear all bookmarks',
          \ 's': 'Show all bookmarks',
          \ 't': 'Toggle bookmark',
          \ 'u': 'Move bookmark up',
          \ },
        \ 'g': {
          \ 'name': '+Git',
          \ 'b': 'Show line blame',
          \ 'f': 'Fold unchanged lines',
          \ 'i': {
            \ 'name': '+Plugin',
            \ 't': 'Load Git plugins',
            \ },
          \ 'j': 'Next hunk',
          \ 'k': 'Previous hunk',
          \ },
        \ 'm': {
          \ 'name': '+Markdown',
          \ 'c': 'Create Markmap HTML',
          \ 'f': 'Fix Markdown lint errors',
          \ 'g': 'Generate table of contents',
          \ 'h': 'Create Markmap',
          \ 'm': 'Watch Markmap',
          \ 'u': 'Update table of contents',
          \ },
        \ 'n': {
          \ 'name': '+NERDTree',
          \ 'c': 'Open tree at working directory',
          \ 't': 'Toggle file tree',
          \ },
        \ 'p': {
          \ 'name': '+Appearance',
          \ 'e': {
            \ 'name': '+Editor',
            \ 'r': 'Restore editor appearance',
            \ },
          \ 'p': {
            \ 'name': '+Presentation',
            \ 't': 'Use presentation appearance',
            \ },
          \ },
        \ 'q': {
          \ 'name': '+QuickUI',
          \ 'b': 'List buffers',
          \ 'c': 'Open keymap cheatsheet',
          \ 'm': 'Open menu',
          \ 't': 'Preview tag',
          \ },
        \ 'v': {
          \ 'name': '+Vista',
          \ 'f': 'Focus symbol window',
          \ 't': 'Toggle symbol window',
          \ },
        \ 'w': {
          \ 'name': '+Multiple Highlights',
          \ 'h': 'Highlight word',
          \ 'H': 'Clear all word highlights',
          \ 't': 'Load highlight plugin',
          \ },
        \ '<F2>': 'Compile only',
        \ '<F5>': 'Create C/C++ debug files',
        \ '<F7>': 'Create Clang configuration files',
        \ '`': 'Show nearest function or class',
        \ }
  let g:local_key_map = {
        \ 'a': 'Wrap all diff windows',
        \ 'b': 'Close tab and go back',
        \ 'j': {'name': 'which_key_ignore'},
        \ 'jc': 'Next comment block',
        \ 'jd': 'Next unmatched delimiter',
        \ 'je': 'Next function end',
        \ 'js': 'Next function start',
        \ 'k': {'name': 'which_key_ignore'},
        \ 'kc': 'Previous comment block',
        \ 'kd': 'Previous unmatched delimiter',
        \ 'ke': 'Previous function end',
        \ 'ks': 'Previous function start',
        \ 'm': 'Toggle GUI menu and toolbar',
        \ 'q': 'Quit window',
        \ 't': 'Open new tab',
        \ 'u': 'Clear search highlight',
        \ 'w': 'Write file',
        \ '<F2>': 'Compile and execute',
        \ '<F4>': 'Open vertical diff',
        \ '<F5>': 'Delete blank lines',
        \ '<F7>': 'Retab and clean trailing characters',
        \ '<F8>': 'Run asynchronous command',
        \ }
  let g:left_bracket_key_map = {
        \ 'a': 'Code action',
        \ 'b': 'Toggle buffer diagnostics',
        \ 'c': 'Go to declaration',
        \ 'd': 'Go to definition',
        \ 'f': 'Refactor selection or symbol',
        \ 'g': 'Toggle diagnostics globally',
        \ 'h': 'Toggle inlay hints',
        \ 'i': 'Go to implementation',
        \ 'j': {'name': 'which_key_ignore'},
        \ 'jd': 'Next diagnostic',
        \ 'je': 'Next error diagnostic',
        \ 'k': {'name': 'which_key_ignore'},
        \ 'kd': 'Previous diagnostic',
        \ 'ke': 'Previous error diagnostic',
        \ 'l': 'Line code action',
        \ 'n': 'Rename symbol',
        \ 'o': 'Show diagnostic information',
        \ 'r': 'Show references',
        \ 't': {'name': 'which_key_ignore'},
        \ 'tc': 'Open declaration in new tab',
        \ 'td': 'Open definition in new tab',
        \ 'ti': 'Open implementation in new tab',
        \ }
  let g:right_bracket_key_map = {
        \ 'a': 'Show assembly',
        \ 'c': 'Jump to program counter',
        \ 'd': 'Delete character',
        \ 'e': 'Evaluate expression',
        \ 'j': 'Next breakpoint',
        \ 'k': 'Previous breakpoint',
        \ 'p': {'name': 'which_key_ignore'},
        \ 'pc': 'Control child processes',
        \ 'pd': 'Detach child processes',
        \ 'pf': 'Follow child processes',
        \ 'pi': 'List processes',
        \ 'pp': 'Follow parent process',
        \ 'ps': 'Switch process',
        \ 'r': 'Reshape debugger windows',
        \ 's': 'Show disassembly',
        \ 't': {'name': 'which_key_ignore'},
        \ 'ta': 'Show all backtraces',
        \ 'tb': 'Show current backtrace',
        \ 'tc': 'Continue all threads',
        \ 'tl': 'Set backtrace limit',
        \ 'ts': 'Switch thread',
        \ 'tt': 'Stop all threads',
        \ 'v': 'Add variable to watches',
        \ '<F2>': 'Run to cursor',
        \ '<S-F2>': 'Stop debugger',
        \ '<C-F2>': 'Pause debugger',
        \ '<F4>': 'Toggle conditional breakpoint',
        \ '<S-F4>': 'Set advanced line breakpoint',
        \ '<C-F4>': 'Add function breakpoint',
        \ '<F5>': 'Launch debugger',
        \ '<F7>': 'Move up stack frame',
        \ '<S-F7>': 'Move down stack frame',
        \ '<F8>': 'Show full variable values',
        \ }
  call which_key#register(get(g:, 'mapleader', "\\"), "g:leader_key_map")
  call which_key#register(get(g:, 'maplocalleader', ','), "g:local_key_map")
  call which_key#register('[', "g:left_bracket_key_map")
  call which_key#register(']', "g:right_bracket_key_map")
endfunction



function! ConfigureDelayedPlugin()
  " Vim-which-key setting
  call ConfigureWhichKey()
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
  nmap [c <Plug>(coc-declaration)
  noremap [tc :<C-u>call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpDeclaration', 'tabe')<CR>
  nmap [d <Plug>(coc-definition)
  noremap [td :<C-u>call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpDefinition', 'tabe')<CR>
  nmap [f <Plug>(coc-refactor)
  vmap [f <Plug>(coc-refactor-selected)
  nmap [i <Plug>(coc-implementation)
  noremap [ti :<C-u>call NUpdateTabTermBuf()<CR>:call CocActionAsync('jumpImplementation', 'tabe')<CR>
  nmap [je <Plug>(coc-diagnostic-next-error)
  nmap [jd <Plug>(coc-diagnostic-next)
  nmap [ke <Plug>(coc-diagnostic-prev-error)
  nmap [kd <Plug>(coc-diagnostic-prev)
  nmap [n <Plug>(coc-rename)
  nmap [r <Plug>(coc-references)
  nmap [a <Plug>(coc-codeaction)
  vmap [a <Plug>(coc-codeaction-selected)
  nmap [l <Plug>(coc-codeaction-line)
  nmap [o <Plug>(coc-diagnostic-info)
  noremap [b :<C-u>call CocActionAsync('diagnosticToggleBuffer')<CR>
  noremap [g :<C-u>call CocActionAsync('diagnosticToggle', 1)<CR>
  noremap [h :<C-u>CocCommand document.toggleInlayHint<CR>
  nmap <F7> <Plug>(coc-format)
  vmap <F7> <Plug>(coc-format-selected)
  let g:coc_filetype_map = {'opencl': 'c', 'cuda': 'cpp', 'lex':'cpp', 'yacc':'cpp'}
  " If some LSPs fail to start, navigate to ~/.config/coc/extensions to check if they require downloading any JAR files.
  " If they do, delete the problematic extension and open a new file; it will automatically download the necessary files again.
  let g:coc_global_extensions = ['coc-word', 'coc-tag', 'coc-dictionary', 'coc-snippets','coc-prettier',
           \ 'coc-yaml', 'coc-cmake', 'coc-clangd', 'coc-clang-format-style-options', 'coc-perl', 'coc-vimlsp',
           \ 'coc-sh', 'coc-pyright', 'coc-webview', 'coc-markmap', 'coc-markdown-preview-enhanced',
           \ 'coc-markdownlint', 'coc-json', 'coc-css', 'coc-tsserver', 'coc-xml', 'https://github.com/Kuro96/coc-ai']
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
  augroup Plugin_Configuration | autocmd! | autocmd CursorHold * call CocActionAsync('highlight') | augroup END
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
  call plug#load('nerdcommenter')
  map <F3> <plug>NERDCommenterComment
  map <S-F3> <plug>NERDCommenterUncomment



  " vim-matchup configuration
  " --------------------------------------------------------------------------
  " 2. 全局开关（在 plug#begin / 插件加载前设，match-up 读取这些变量初始化）
  " --------------------------------------------------------------------------
  let g:matchup_enabled = 1                " 总开关
  let g:matchup_motion_enabled = 1        " [% ]% g% 等，便宜，开着
  let g:matchup_text_obj_enabled = 1       " i% a%，便宜，开着
  let g:matchup_surround_enabled = 1       " ds% cs%，可选

  silent! nunmap [%
  silent! xunmap [%
  silent! ounmap [%
  silent! nunmap ]%
  silent! xunmap ]%
  silent! ounmap ]%
  nmap <silent> <LocalLeader>kd <Plug>(matchup-[%)
  xmap <silent> <LocalLeader>kd <Plug>(matchup-[%)
  omap <silent> <LocalLeader>kd <Plug>(matchup-[%)
  nmap <silent> <LocalLeader>jd <Plug>(matchup-]%)
  xmap <silent> <LocalLeader>jd <Plug>(matchup-]%)
  omap <silent> <LocalLeader>jd <Plug>(matchup-]%)

  " --- matchparen 模块（这是性能大头）---
  let g:matchup_matchparen_enabled = 1     " 开高亮，但用下面选项把它压稳
  let g:matchup_matchparen_deferred = 1    " ★★★ 关键：延迟高亮，CursorMoved 不再同步算
  let g:matchup_matchparen_deferred_show_delay = 60   " 光标停 60ms 后出高亮
  let g:matchup_matchparen_deferred_hide_delay = 600  " 移走 600ms 后消高亮
  let g:matchup_matchparen_timeout = 160   " ★ 从默认 300 压到 160ms，超时放弃不重算
  let g:matchup_matchparen_insert_timeout = 60        " 插入模式不变
  let g:matchup_matchparen_stopline = 600   " ★ 高亮搜索只扫上下 400 行（默认无独立上限，跟 delim_stopline 走）
  let g:matchup_matchparen_singleton = 0   " 没配对的不单高亮，省一次 match

  " --- 分隔符引擎（影响 motion/text-obj 速度）---
  let g:matchup_delim_stopline = 1500      " motions 上下各搜 1500 行，默认 1500 可不改
  let g:matchup_delim_noskips = 1          " ★ 不在 comment/string 里做 keyword 匹配，C++ 大文件省不少

  " --- 不需要的功能关掉 ---
  let g:matchup_mouse_enabled = 0          " 你没鼠标需求就关
  let g:matchup_transmute_enabled = 0      " 实验性的，关

  let g:matchup_matchparen_offscreen = {
        \ 'method':    'popup',
        \ 'fullwidth': 1,
        \ 'highlight': 'Pmenu',
        \ 'border':    1,
        \ 'syntax_hl': 1,
        \ 'scrolloff': 1,
        \ }
  let s:matchup_loaded = 0

  function! ConfigureVimNavigationKeyMaps()
    silent! nunmap <buffer> [[
    silent! xunmap <buffer> [[
    silent! nunmap <buffer> ]]
    silent! xunmap <buffer> ]]
    silent! nunmap <buffer> []
    silent! xunmap <buffer> []
    silent! nunmap <buffer> ][
    silent! xunmap <buffer> ][
    silent! nunmap <buffer> ["
    silent! xunmap <buffer> ["
    silent! nunmap <buffer> ]"
    silent! xunmap <buffer> ]"
    nnoremap <silent><buffer> <LocalLeader>ks m':call search('^\s*\(fu\%[nction]\\|\(export\s\+\)\?def\)\>', "bW")<CR>
    xnoremap <silent><buffer> <LocalLeader>ks m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|\(export\s\+\)\?def\)\>', "bW")<CR>
    nnoremap <silent><buffer> <LocalLeader>js m':call search('^\s*\(fu\%[nction]\\|\(export\s\+\)\?def\)\>', "W")<CR>
    xnoremap <silent><buffer> <LocalLeader>js m':<C-U>exe "normal! gv"<Bar>call search('^\s*\(fu\%[nction]\\|\(export\s\+\)\?def\)\>', "W")<CR>
    nnoremap <silent><buffer> <LocalLeader>ke m':call search('^\s*end\(f\%[unction]\\|\(export\s\+\)\?def\)\>', "bW")<CR>
    xnoremap <silent><buffer> <LocalLeader>ke m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|\(export\s\+\)\?def\)\>', "bW")<CR>
    nnoremap <silent><buffer> <LocalLeader>je m':call search('^\s*end\(f\%[unction]\\|\(export\s\+\)\?def\)\>', "W")<CR>
    xnoremap <silent><buffer> <LocalLeader>je m':<C-U>exe "normal! gv"<Bar>call search('^\s*end\(f\%[unction]\\|\(export\s\+\)\?def\)\>', "W")<CR>
    nnoremap <silent><buffer> <LocalLeader>jc :call search('\%(^\s*".*\n\)\@<!\%(^\s*"\)', "W")<CR>
    xnoremap <silent><buffer> <LocalLeader>jc :<C-U>exe "normal! gv"<Bar>call search('\%(^\s*".*\n\)\@<!\%(^\s*"\)', "W")<CR>
    nnoremap <silent><buffer> <LocalLeader>kc :call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")<CR>
    xnoremap <silent><buffer> <LocalLeader>kc :<C-U>exe "normal! gv"<Bar>call search('\%(^\s*".*\n\)\%(^\s*"\)\@!', "bW")<CR>
  endfunction

  function! s:EnsureMatchupForCurrentBuffer() abort
      if !s:matchup_loaded
          call plug#load('vim-matchup')
          let s:matchup_loaded = 1
      endif

      " if buffer does not exist
      if empty(&l:filetype)
          return
      endif

      " Each buffer and filetype only execute duautocmd onece.
      if get(b:, 'matchup_lazy_replayed_ft', '') ==# &l:filetype
          return
      endif
      let b:matchup_lazy_replayed_ft = &l:filetype
      execute 'doautocmd <nomodeline> FileType ' . fnameescape(&l:filetype)
  endfunction

  augroup Vim-Matchup_Augroup
    autocmd!
    " --------------------------------------------------------------------------
    " 3. 大文件 / 特定 ft 按 buffer 关 matchparen（可选但推荐）
    " --------------------------------------------------------------------------
    " C/C++ 头文件经常 3000+ 行，嵌套模板 rainbow 已经在烧了，matchparen 也别添乱
    autocmd FileType c,cpp,opencl,verilog
          \ if line('$') > 2000
            \ | let b:matchup_matchparen_enabled = 0
            \ | let b:matchup_matchparen_fallback = 0
          \ | endif
    autocmd FileType vim call ConfigureVimNavigationKeyMaps()
    " 切换 buffer、打开分屏或 tab 时都会覆盖到
    autocmd BufEnter * ++nested call <SID>EnsureMatchupForCurrentBuffer()
  augroup END
  if &filetype ==# 'vim'
    call ConfigureVimNavigationKeyMaps()
  endif



  " Asyncrun setting
  let g:asyncrun_save = 1
  let g:asyncrun_mode = 'term'
  call plug#load('asyncrun.vim')
  function! JumpToTerm(go_to_top = 0, height = 18)
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
    let l:terminal_directory = GetLaunchDir()
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
        exec 'belowright ' . a:height . ' new'
        let l:terminal_options = {
              \ 'curwin': 1,
              \ 'norestore': 1,
              \ 'term_finish': 'open',
              \ 'term_kill': 'term',
              \ 'cwd': l:terminal_directory,
              \ }
        let l:terminal_buf = term_start(&shell, l:terminal_options)
        exec 'resize ' . a:height
        let g:tab_term_buf[l:cur_tab] = l:terminal_buf
      endif
      if &buftype ==# 'terminal' && !exists('b:asyncrun_bid')
        let l:terminal_job = term_getjob(bufnr('%'))
        if job_status(l:terminal_job) ==# 'run' && mode() !=# 't'
          silent! normal! i
        endif
      endif
    endif
  endfunction
  function! UpdateTabTermBuf(id_first, id_last, plus_or_minus_one)
    for l:term_index in range(a:id_first, a:id_last, a:plus_or_minus_one[1])
      let g:tab_term_buf[l:term_index + a:plus_or_minus_one[0]] = g:tab_term_buf[l:term_index]
    endfor
  endfunction
  function! CUpdateTabTermBuf(auto_close_terminal=1)
    let l:tab_term_buf = g:tab_term_buf[tabpagenr()]
    call UpdateTabTermBuf(tabpagenr() + 1, tabpagenr('$') + 2, [-1, +1])
    if bufexists(l:tab_term_buf) && a:auto_close_terminal == 1
      exec 'silent bwipeout! ' . l:tab_term_buf
    endif
  endfunction
  function! NUpdateTabTermBuf()
    call UpdateTabTermBuf(tabpagenr('$'), tabpagenr() + 1, [+1, -1])
    let g:tab_term_buf[tabpagenr() + 1] = - 1
  endfunction
  noremap <F8> :<C-u>call ToggleTerminal()<CR>
  tnoremap <F8> <C-w>:call ToggleTerminal()<CR>
  noremap <LocalLeader><F8> :<C-u>AsyncRun! -cwd=$(VIM_FILEDIR) -strip -rows=3 -hidden=1 -focus=0 -post=call\ JumpToTerm()<Space>
endfunction




function! ConfigureManualLoadPlugin()
  " Vim-quickui setting
  let g:quickui_show_tip = 1
  let g:quickui_color_scheme = 'system'
  function! QuickuiInstallKeyMapGroup(name, key_maps, weight)
    let l:name = substitute(a:name, '&', '', 'g')
    call add(g:quickui_keymap_groups, [l:name, deepcopy(a:key_maps)])
  endfunction
  function! QuickuiInstallKeyMapMenus()
    let g:quickui_keymap_groups = []
    let l:search_key_maps = [
          \ ['<LocalLeader>ks', 'Previous function start', 'n'],
          \ ['<LocalLeader>ke', 'Previous function end', 'n'],
          \ ['<LocalLeader>kc', 'Previous comment block', 'n'],
          \ ['<LocalLeader>js', 'Next function start', 'n'],
          \ ['<LocalLeader>je', 'Next function end', 'n'],
          \ ['<LocalLeader>jc', 'Next comment block', 'n'],
          \ ['<Leader>`', 'Show nearest function or class', 'n'],
          \ ['`<Leader>', 'Show nearest non-function block', 'n'],
          \ ['<LocalLeader>u', 'Clear search highlight', 'n'],
          \ ]
    let l:general_key_maps = [
          \ ['<LocalLeader>a', 'Wrap all diff windows', 'n'],
          \ ['<LocalLeader><F5>', 'Delete blank lines', 'n'],
          \ ['<LocalLeader><F7>', 'Retab and clean trailing characters', 'n'],
          \ ['<C-CR>', 'Insert an indented line', 'n'],
          \ ['<M-CR>', 'Enter without trailing comment', 'n'],
          \ ['<M-CR>', 'Enter without trailing comment', 'i'],
          \ ['<C-Space>', 'Insert one space', 'n'],
          \ ['<C-M-CR>', 'Insert a blank line', 'n'],
          \ ['<C-M-CR>', 'Insert a blank line', 'i'],
          \ ['<C-S-CR>', 'Insert a blank line', 'n'],
          \ ['<C-S-CR>', 'Insert a blank line', 'i'],
          \ ['<M-h>', 'Move left', 'i'],
          \ ['<M-j>', 'Move down', 'i'],
          \ ['<M-k>', 'Move up', 'i'],
          \ ['<M-l>', 'Move right', 'i'],
          \ ['<M-p>', 'Put before cursor', 'i'],
          \ ['<M-S-p>', 'Put after cursor', 'i'],
          \ ['<M-u>', 'Undo', 'i'],
          \ ['<M-r>', 'Redo', 'i'],
          \ ['<M-S-d>', 'Delete to end of line', 'i'],
          \ ['<M-S-y>', 'Yank line', 'i'],
          \ ['<M-S-a>', 'Append at end of line', 'i'],
          \ ['<M-S-i>', 'Insert at first non-blank', 'i'],
          \ ['Q', 'Disabled Ex mode', 'n'],
          \ ]
    call extend(l:general_key_maps, [
          \ ['<LocalLeader>w', 'Write file', 'n'],
          \ ['<LocalLeader>q', 'Quit window', 'n'],
          \ ['<M-q>', 'Quit window', 'n', 'N/I/T'],
          \ ['<LocalLeader>t', 'Open new tab', 'n'],
          \ ['<M-t>', 'Open new tab', 'n', 'N/I/T'],
          \ ['<LocalLeader>b', 'Close tab and go back', 'n'],
          \ ['<M-b>', 'Close tab and go back', 'n', 'N/I/T'],
          \ ['<C-S-t>', 'Open terminal in a new tab', 'n', 'N/I/T'],
          \ ['<F8>', 'Toggle tracked terminal for current tab', 'n', 'N/T'],
          \ ['<LocalLeader><F4>', 'Open vertical diff', 'n'],
          \ ['<M-S-h>', 'Move tab left', 'n'],
          \ ['<M-S-h>', 'Move tab left', 'i'],
          \ ['<M-S-l>', 'Move tab right', 'n'],
          \ ['<M-S-l>', 'Move tab right', 'i'],
          \ ['<C-M-h>', 'Go to previous tab', 'n'],
          \ ['<C-M-h>', 'Go to previous tab', 'i'],
          \ ['<C-M-j>', 'Go to previous tab', 'n'],
          \ ['<C-M-j>', 'Go to previous tab', 'i'],
          \ ['<C-M-l>', 'Go to next tab', 'n'],
          \ ['<C-M-l>', 'Go to next tab', 'i'],
          \ ['<C-M-k>', 'Go to next tab', 'n'],
          \ ['<C-M-k>', 'Go to next tab', 'i'],
          \ ['<M-1>', 'Go to tab 1', 'n', 'N/I/T'],
          \ ['<M-2>', 'Go to tab 2', 'n', 'N/I/T'],
          \ ['<M-3>', 'Go to tab 3', 'n', 'N/I/T'],
          \ ['<M-4>', 'Go to tab 4', 'n', 'N/I/T'],
          \ ['<M-5>', 'Go to tab 5', 'n', 'N/I/T'],
          \ ['<M-6>', 'Go to tab 6', 'n', 'N/I/T'],
          \ ['<M-7>', 'Go to tab 7', 'n', 'N/I/T'],
          \ ['<M-8>', 'Go to tab 8', 'n', 'N/I/T'],
          \ ['<M-9>', 'Go to tab 9', 'n', 'N/I/T'],
          \ ['<M-0>', 'Go to tab 10', 'n', 'N/I/T'],
          \ ['gf', 'Open file under cursor', 'n'],
          \ ['<C-w>f', 'Open file in a split', 'n'],
          \ ['<C-w>gf', 'Open file in a tab', 'n'],
          \ ['<C-w>"+', 'Paste clipboard in terminal', 't'],
          \ ['<C-S-v>', 'Paste clipboard in terminal', 't'],
          \ ['gx', 'Open word or URL under cursor', 'n', 'N/V'],
          \ ['<C-\><C-n>', 'Enter Normal mode from terminal', 't'],
          \ ])
    call extend(l:general_key_maps, [
          \ ['<Leader><F2>', 'Compile only', 'n'],
          \ ['<LocalLeader><F2>', 'Compile and execute', 'n'],
          \ ['<Leader><F7>', 'Create Clang configuration files', 'n'],
          \ ])
    call extend(l:general_key_maps, [
          \ ['<Leader>ppt', 'Use presentation appearance', 'n'],
          \ ['<Leader>per', 'Restore editor appearance', 'n'],
          \ ['<LocalLeader>m', 'Toggle GUI menu and toolbar', 'n'],
          \ ])
    call QuickuiInstallKeyMapGroup('&General', l:general_key_maps, 300)
    call QuickuiInstallKeyMapGroup('&Search', l:search_key_maps, 200)
    call QuickuiInstallKeyMapGroup('&Codex', [
          \ ['<Ctrl-g>', 'Open editor for multiline prompt', 'n', 'CLI'],
          \ ['@', 'Find a workspace file for the prompt', 'n', 'CLI'],
          \ ['<Up>/<Down>', 'Restore draft history', 'n', 'CLI'],
          \ ['<Ctrl-r>', 'Search prompt history', 'n', 'CLI'],
          \ ['<Ctrl-o>', 'Copy latest completed output', 'n', 'CLI'],
          \ ['!', 'Run a local shell command', 'n', 'CLI'],
          \ ['<Tab>', 'Queue a follow-up while working', 'n', 'CLI'],
          \ ['<Enter>', 'Steer the current turn while working', 'n', 'CLI'],
          \ ['<Esc><Esc>', 'Edit previous message and fork', 'n', 'CLI'],
          \ ['<Ctrl-c>', 'Close the Codex session', 'n', 'CLI'],
          \ ['<Ctrl-l>', 'Clear view but keep current chat', 'n', 'CLI'],
          \ ['<Alt-r>', 'Toggle raw scrollback', 'n', 'CLI'],
          \ ['/', 'Open the slash-command menu', 'n', 'CLI'],
          \ ], 600)
    call QuickuiInstallKeyMapGroup('&COC', [
          \ ['<TAB>', 'Select next completion item', 'i'],
          \ ['<S-TAB>', 'Select previous completion item', 'i'],
          \ ['<CR>', 'Confirm completion', 'i'],
          \ ['K', 'Show documentation', 'n'],
          \ ['[c', 'Go to declaration', 'n'],
          \ ['[tc', 'Open declaration in a new tab', 'n'],
          \ ['[d', 'Go to definition', 'n'],
          \ ['[td', 'Open definition in a new tab', 'n'],
          \ ['[f', 'Refactor symbol', 'n'],
          \ ['[f', 'Refactor selection', 'x'],
          \ ['[i', 'Go to implementation', 'n'],
          \ ['[ti', 'Open implementation in a new tab', 'n'],
          \ ['[je', 'Next error diagnostic', 'n'],
          \ ['[jd', 'Next diagnostic', 'n'],
          \ ['[ke', 'Previous error diagnostic', 'n'],
          \ ['[kd', 'Previous diagnostic', 'n'],
          \ ['[n', 'Rename symbol', 'n'],
          \ ['[r', 'Show references', 'n'],
          \ ['[a', 'Code action', 'n'],
          \ ['[a', 'Code action for selection', 'x'],
          \ ['[l', 'Line code action', 'n'],
          \ ['[o', 'Show diagnostic information', 'n'],
          \ ['[b', 'Toggle buffer diagnostics', 'n'],
          \ ['[g', 'Toggle diagnostics globally', 'n'],
          \ ['[h', 'Toggle inlay hints', 'n'],
          \ ['<F7>', 'Format document', 'n'],
          \ ['<F7>', 'Format selection', 'x'],
          \ ], 700)
    call QuickuiInstallKeyMapGroup('&Matchup', [
          \ ['%', 'Jump to matching delimiter', 'n', 'N/V/O'],
          \ ['g%', 'Jump to matching delimiter from before cursor', 'n', 'N/V/O'],
          \ ['z%', 'Jump inside next match', 'n', 'N/V/O'],
          \ ['a%', 'Select around matching delimiters', 'x', 'V/O'],
          \ ['i%', 'Select inside matching delimiters', 'x', 'V/O'],
          \ ['cs%', 'Change surrounding delimiters', 'n'],
          \ ['ds%', 'Delete surrounding delimiters', 'n'],
          \ ['<LocalLeader>kd', 'Previous unmatched delimiter', 'n', 'N/V/O'],
          \ ['<LocalLeader>jd', 'Next unmatched delimiter', 'n', 'N/V/O'],
          \ ], 800)
    call QuickuiInstallKeyMapGroup('&Vimspector', [
          \ ['<F2>', 'Continue debugging', 'n'],
          \ ['<S-F2>', 'Restart debugging', 'n'],
          \ [']<F2>', 'Run to cursor', 'n'],
          \ [']<S-F2>', 'Stop debugger', 'n'],
          \ [']<C-F2>', 'Pause debugger', 'n'],
          \ ['<F4>', 'Toggle breakpoint', 'n'],
          \ ['<S-F4>', 'Clear all breakpoints', 'n'],
          \ [']<F4>', 'Toggle conditional breakpoint', 'n'],
          \ [']<S-F4>', 'Set advanced line breakpoint', 'n'],
          \ [']<C-F4>', 'Add function breakpoint', 'n'],
          \ ['<F5>', 'Load Vimspector', 'n'],
          \ ['<S-F5>', 'Reset Vimspector', 'n'],
          \ [']<F5>', 'Launch debugger', 'n'],
          \ ['<Leader><F5>', 'Create C/C++ debug files', 'n'],
          \ ['<F6>', 'Step over', 'n'],
          \ ['<C-F6>', 'Step into', 'n'],
          \ ['<S-F6>', 'Step out', 'n'],
          \ [']<F7>', 'Move up stack frame', 'n'],
          \ [']<S-F7>', 'Move down stack frame', 'n'],
          \ [']<F8>', 'Show full variable values', 'n'],
          \ ['<C-1>', 'Focus variables window', 'n', 'N/I'],
          \ ['<C-3>', 'Focus watches window', 'n', 'N/I'],
          \ ['<C-5>', 'Focus stack trace window', 'n', 'N/I'],
          \ ['<C-7>', 'Focus code window', 'n', 'N/I'],
          \ ['<C-8>', 'Show debugger console', 'n', 'N/I'],
          \ ['<C-9>', 'Focus debugger terminal', 'n', 'N/I'],
          \ ['<C-0>', 'List all breakpoints', 'n', 'N/I'],
          \ [']a', 'Show assembly', 'n'],
          \ [']s', 'Show disassembly', 'n'],
          \ [']c', 'Jump to program counter', 'n'],
          \ [']d', 'Delete character', 'n'],
          \ [']e', 'Evaluate expression', 'n'],
          \ [']j', 'Next breakpoint', 'n'],
          \ [']k', 'Previous breakpoint', 'n'],
          \ [']pc', 'Control child processes', 'n'],
          \ [']pd', 'Detach child processes', 'n'],
          \ [']pf', 'Follow child processes', 'n'],
          \ [']pp', 'Follow parent process', 'n'],
          \ [']pi', 'List processes', 'n'],
          \ [']ps', 'Switch process', 'n'],
          \ [']r', 'Reshape debugger windows', 'n'],
          \ [']ta', 'Show all backtraces', 'n'],
          \ [']tb', 'Show current backtrace', 'n'],
          \ [']tl', 'Set backtrace limit', 'n'],
          \ [']ts', 'Switch thread', 'n'],
          \ [']tc', 'Continue all threads', 'n'],
          \ [']tt', 'Stop all threads', 'n'],
          \ [']v', 'Add variable to watches', 'n', 'N/V'],
          \ ], 900)
    call QuickuiInstallKeyMapGroup('&QuickUI', [
          \ ['<Leader>qc', 'Open keymap cheatsheet', 'n'],
          \ ['<Leader>qm', 'Open menu', 'n'],
          \ ['<Leader>qb', 'List buffers', 'n'],
          \ ['<Leader>qt', 'Preview tag', 'n'],
          \ ], 1000)
    call QuickuiInstallKeyMapGroup('&NERDTree', [
          \ ['<Leader>nt', 'Toggle file tree', 'n'],
          \ ['<Leader>nc', 'Open tree at working directory', 'n'],
          \ ], 1100)
    call QuickuiInstallKeyMapGroup('&Vista', [
          \ ['<Leader>vt', 'Toggle symbol window', 'n'],
          \ ['<Leader>vf', 'Focus symbol window', 'n'],
          \ ], 1200)
    call QuickuiInstallKeyMapGroup('&Bookmarks', [
          \ ['<Leader>bo', 'Load bookmark plugin', 'n'],
          \ ['<Leader>bt', 'Toggle bookmark', 'n'],
          \ ['<Leader>ba', 'Annotate bookmark', 'n'],
          \ ['<Leader>bs', 'Show all bookmarks', 'n'],
          \ ['<Leader>bn', 'Next bookmark', 'n'],
          \ ['<Leader>bp', 'Previous bookmark', 'n'],
          \ ['<Leader>bc', 'Clear bookmark', 'n'],
          \ ['<Leader>br', 'Clear all bookmarks', 'n'],
          \ ['<Leader>bu', 'Move bookmark up', 'n'],
          \ ['<Leader>bd', 'Move bookmark down', 'n'],
          \ ['<Leader>bl', 'Move bookmark to line', 'n'],
          \ ], 1300)
    call QuickuiInstallKeyMapGroup('&InterestingWords', [
          \ ['<Leader>wt', 'Load highlight plugin', 'n'],
          \ ['<Leader>wh', 'Highlight word', 'n'],
          \ ['<Leader>wh', 'Highlight selection', 'x'],
          \ ['<Leader>w<S-h>', 'Clear all word highlights', 'n'],
          \ ['n', 'Next highlighted word', 'n'],
          \ ['<S-n>', 'Previous highlighted word', 'n'],
          \ ], 1400)
    call QuickuiInstallKeyMapGroup('&VisualMulti', [
          \ ['<C-n>', 'Start multiple cursors', 'n'],
          \ ], 1500)
    call QuickuiInstallKeyMapGroup('&Git', [
          \ ['<Leader>git', 'Load Git plugins', 'n'],
          \ ['<Leader>gk', 'Previous hunk', 'n'],
          \ ['<Leader>gj', 'Next hunk', 'n'],
          \ ['<Leader>gf', 'Fold unchanged lines', 'n'],
          \ ['<Leader>gb', 'Show line blame', 'n'],
          \ ], 1600)
    call QuickuiInstallKeyMapGroup('&Markdown', [
          \ ['<Leader>mm', 'Watch Markmap', 'n'],
          \ ['<Leader>mc', 'Create Markmap HTML', 'n'],
          \ ['<Leader>mh', 'Create Markmap', 'n'],
          \ ['<Leader>mh', 'Create Markmap from selection', 'x'],
          \ ['<Leader>mf', 'Fix Markdown lint errors', 'n'],
          \ ['<Leader>mg', 'Generate table of contents', 'n'],
          \ ['<Leader>mu', 'Update table of contents', 'n'],
          \ ], 1700)
    call QuickuiInstallKeyMapGroup('&NERDCommenter', [
          \ ['<F3>', 'Comment', 'n', 'N/V/O'],
          \ ['<S-F3>', 'Uncomment', 'n', 'N/V/O'],
          \ ], 1800)
    call QuickuiInstallKeyMapGroup('&AsyncRun', [
          \ ['<LocalLeader><F8>', 'Run asynchronous command', 'n'],
          \ ], 1900)
    call QuickuiInstallKeyMapGroup('&AutoVerilog', [
          \ ['<Leader>ai', 'Generate instance', 'n'],
          \ ['<Leader>aa', 'Generate arguments', 'n'],
          \ ['<Leader>app', 'Generate parameters', 'n'],
          \ ['<Leader>apv', 'Generate parameter values', 'n'],
          \ ['<Leader>ar', 'Generate registers', 'n'],
          \ ['<Leader>aw', 'Generate wires', 'n'],
          \ ['<Leader>ad', 'Generate definition', 'n'],
          \ ], 2000)
    call QuickuiInstallKeyMapGroup('&WhichKey', [
          \ ['<Leader>', 'Show Leader mappings', 'n'],
          \ ['<LocalLeader>', 'Show LocalLeader mappings', 'n'],
          \ ['[', 'Show left-bracket mappings', 'n'],
          \ [']', 'Show right-bracket mappings', 'n'],
          \ ], 2100)
  endfunction
  function! QuickuiCheatsheetTruncate(text, width)
    if a:width <= 0
      return ''
    endif
    if strdisplaywidth(a:text) <= a:width
      return a:text
    endif
    return strcharpart(a:text, 0, a:width - 1).'…'
  endfunction
  function! QuickuiCheatsheetKeyMapLine(key_map, width)
    let l:mode_name = get({'n': 'N', 'x': 'V', 'i': 'I', 'o': 'O'},
          \ a:key_map[2], toupper(a:key_map[2]))
    let l:mode_name = len(a:key_map) > 3 ? a:key_map[3] : l:mode_name
    let l:key = a:key_map[0].' ['.l:mode_name.']'
    let l:key_width = min([22, max([12, a:width / 2])])
    let l:description_width = a:width - l:key_width - 3
    let l:key = QuickuiCheatsheetTruncate(l:key, l:key_width)
    let l:description = QuickuiCheatsheetTruncate(a:key_map[1], l:description_width)
    return '  '.printf('%-'.l:key_width.'s', l:key).' '.l:description
  endfunction
  function! QuickuiCheatsheetGroup(group, width, toggle_key)
    let l:folded = get(g:quickui_cheatsheet_folded, a:group[0], 0)
    let l:fold_mark = l:folded ? '[+]' : '[-]'
    let l:title = '['.a:toggle_key.'] '.a:group[0].': '.l:fold_mark
    let l:lines = [l:title, repeat('-', min([a:width, strlen(l:title)]))]
    if l:folded
      return l:lines
    endif
    let l:mapping_column_width = (a:width - 2) / 2
    for l:key_map_id in range(0, len(a:group[1]) - 1, 2)
      let l:left = QuickuiCheatsheetKeyMapLine(
            \ a:group[1][l:key_map_id], l:mapping_column_width)
      let l:left .= repeat(' ', max([0,
            \ l:mapping_column_width - strdisplaywidth(l:left)]))
      let l:right = ''
      if l:key_map_id + 1 < len(a:group[1])
        let l:right = QuickuiCheatsheetKeyMapLine(
              \ a:group[1][l:key_map_id + 1], l:mapping_column_width)
      endif
      call add(l:lines, l:left.'  '.l:right)
    endfor
    call add(l:lines, '')
    return l:lines
  endfunction
  function! QuickuiCheatsheetCategoryRows(width)
    let l:group_count = len(g:quickui_keymap_groups)
    let l:row_count = 3
    let l:groups_per_row = (l:group_count + l:row_count - 1) / l:row_count
    let l:cell_width = (a:width - (l:groups_per_row - 1)) / l:groups_per_row
    let l:rows = []
    for l:row_id in range(0, l:row_count - 1)
      let l:cells = []
      let l:first_group_id = l:row_id * l:groups_per_row
      if l:first_group_id >= l:group_count
        break
      endif
      let l:last_group_id = min([
            \ l:first_group_id + l:groups_per_row - 1, l:group_count - 1])
      for l:group_id in range(l:first_group_id, l:last_group_id)
        let l:group = g:quickui_keymap_groups[l:group_id]
        let l:toggle_key = get(g:quickui_cheatsheet_toggle_keys, l:group_id, '?')
        let l:fold_mark = get(g:quickui_cheatsheet_folded, l:group[0], 0) ? '+' : '-'
        let l:cell = '['.l:toggle_key.']'.l:fold_mark.' '.l:group[0]
        let l:cell = QuickuiCheatsheetTruncate(l:cell, l:cell_width)
        let l:cell .= repeat(' ', max([0, l:cell_width - strdisplaywidth(l:cell)]))
        call add(l:cells, l:cell)
      endfor
      call add(l:rows, substitute(join(l:cells, ' '), '\s\+$', '', ''))
    endfor
    return l:rows
  endfunction
  function! QuickuiBuildKeyMapCheatsheet()
    let g:quickui_cheatsheet_toggle_keys = split('123456789abcdefimo', '\zs')
    if !exists('g:quickui_cheatsheet_folded')
      let g:quickui_cheatsheet_folded = {}
      for l:group in g:quickui_keymap_groups
        let g:quickui_cheatsheet_folded[l:group[0]] = 1
      endfor
    endif
    let l:window_width = max([40, &columns - 8])
    let l:window_width = min([180, l:window_width])
    let l:lines = QuickuiCheatsheetCategoryRows(l:window_width)
    call add(l:lines, '')
    let l:group_id = 0
    for l:group in g:quickui_keymap_groups
      let l:toggle_key = get(g:quickui_cheatsheet_toggle_keys, l:group_id, '?')
      if !get(g:quickui_cheatsheet_folded, l:group[0], 0)
        call extend(l:lines, QuickuiCheatsheetGroup(
              \ l:group, l:window_width, l:toggle_key))
      endif
      let l:group_id += 1
    endfor
    if get(g:, 'quickui_cheatsheet_search_active', 0)
      let l:instructions = 'Search '.g:quickui_cheatsheet_search_direction
            \ .g:quickui_cheatsheet_search_input.'_   Enter: search   Esc: cancel'
      let l:instructions_second_line = ''
    else
      let l:instructions = '1-9/a-f/i/m/o: fold   z/r: fold/unfold all   gg/G: top/bottom   /?: search   n/N: next/prev'
      let l:instructions_second_line = 'j/k/PgUp/PgDn: scroll   Space: page down   Esc/q: close'
    endif
    return [[QuickuiCheatsheetTruncate(l:instructions, l:window_width),
          \ QuickuiCheatsheetTruncate(l:instructions_second_line, l:window_width), ''] + l:lines,
          \ l:window_width]
  endfunction
  function! QuickuiRefreshKeyMapCheatsheet(winid)
    let [l:lines, l:window_width] = QuickuiBuildKeyMapCheatsheet()
    call popup_settext(a:winid, l:lines)
    let l:window_height = min([max([6, &lines - 6]), len(l:lines)])
    call popup_move(a:winid, {
          \ 'minwidth': l:window_width,
          \ 'maxwidth': l:window_width,
          \ 'minheight': l:window_height,
          \ 'maxheight': l:window_height,
          \ })
  endfunction
  function! QuickuiRunKeyMapCheatsheetSearch(winid, backwards)
    if !exists('g:quickui_cheatsheet_search_pattern')
      return
    endif
    let l:pattern = '\V'.escape(g:quickui_cheatsheet_search_pattern, '\')
    let l:flags = a:backwards ? 'bW' : 'W'
    let l:command = 'call clearmatches()'
          \ .' | call matchadd("Search", '.string(l:pattern).')'
          \ .' | call search('.string(l:pattern).', '.string(l:flags).')'
          \ .' | normal! zz'
    call quickui#core#win_execute(a:winid, l:command)
  endfunction
  function! QuickuiStartKeyMapCheatsheetSearch(winid, direction)
    let g:quickui_cheatsheet_folded = {}
    let g:quickui_cheatsheet_search_active = 1
    let g:quickui_cheatsheet_search_input = ''
    let g:quickui_cheatsheet_search_direction = a:direction
    call QuickuiRefreshKeyMapCheatsheet(a:winid)
  endfunction
  function! QuickuiKeyMapCheatsheetFilter(winid, key)
    if get(g:, 'quickui_cheatsheet_search_active', 0)
      if a:key ==# "\<Esc>" || a:key ==# "\<C-C>"
        let g:quickui_cheatsheet_search_active = 0
        call QuickuiRefreshKeyMapCheatsheet(a:winid)
      elseif a:key ==# "\<CR>"
        let g:quickui_cheatsheet_search_active = 0
        if !empty(g:quickui_cheatsheet_search_input)
          let g:quickui_cheatsheet_search_pattern = g:quickui_cheatsheet_search_input
          call QuickuiRefreshKeyMapCheatsheet(a:winid)
          if g:quickui_cheatsheet_search_direction ==# '?'
            call quickui#core#win_execute(a:winid, 'normal! G$')
          else
            call quickui#core#win_execute(a:winid, 'normal! gg0')
          endif
          call QuickuiRunKeyMapCheatsheetSearch(a:winid,
                \ g:quickui_cheatsheet_search_direction ==# '?')
        else
          call QuickuiRefreshKeyMapCheatsheet(a:winid)
        endif
      elseif a:key ==# "\<BS>" || a:key ==# "\<C-H>"
        let l:length = strchars(g:quickui_cheatsheet_search_input)
        let g:quickui_cheatsheet_search_input = strcharpart(
              \ g:quickui_cheatsheet_search_input, 0, max([0, l:length - 1]))
        call QuickuiRefreshKeyMapCheatsheet(a:winid)
      elseif a:key =~# '^[[:print:]]$'
        let g:quickui_cheatsheet_search_input .= a:key
        call QuickuiRefreshKeyMapCheatsheet(a:winid)
      endif
      return 1
    endif
    if a:key ==# "\<Esc>" || a:key ==# "\<C-C>" || a:key ==# 'q' || a:key ==# 'x'
      call popup_close(a:winid, 0)
      return 1
    endif
    if a:key ==# 'g'
      if get(g:, 'quickui_cheatsheet_pending_g', 0)
        let g:quickui_cheatsheet_pending_g = 0
        call quickui#utils#scroll(a:winid, 'TOP')
      else
        let g:quickui_cheatsheet_pending_g = 1
      endif
      return 1
    endif
    let g:quickui_cheatsheet_pending_g = 0
    if a:key ==# 'G'
      call quickui#utils#scroll(a:winid, 'BOTTOM')
      return 1
    endif
    let l:group_id = index(g:quickui_cheatsheet_toggle_keys, a:key)
    if l:group_id >= 0 && l:group_id < len(g:quickui_keymap_groups)
      let l:group_name = g:quickui_keymap_groups[l:group_id][0]
      let g:quickui_cheatsheet_folded[l:group_name]
            \ = !get(g:quickui_cheatsheet_folded, l:group_name, 0)
      call QuickuiRefreshKeyMapCheatsheet(a:winid)
      return 1
    elseif a:key ==# 'z'
      for l:group in g:quickui_keymap_groups
        let g:quickui_cheatsheet_folded[l:group[0]] = 1
      endfor
      call QuickuiRefreshKeyMapCheatsheet(a:winid)
      return 1
    elseif a:key ==# 'r'
      let g:quickui_cheatsheet_folded = {}
      call QuickuiRefreshKeyMapCheatsheet(a:winid)
      return 1
    elseif a:key ==# '/' || a:key ==# '?'
      call QuickuiStartKeyMapCheatsheetSearch(a:winid, a:key)
      return 1
    elseif a:key ==# 'n' || a:key ==# 'N'
      if exists('g:quickui_cheatsheet_search_pattern')
        let l:backwards = get(g:, 'quickui_cheatsheet_search_direction', '/') ==# '?'
        if a:key ==# 'N'
          let l:backwards = !l:backwards
        endif
        call QuickuiRunKeyMapCheatsheetSearch(a:winid, l:backwards)
      endif
      return 1
    elseif a:key ==# ' '
      call quickui#utils#scroll(a:winid, 'PAGEDOWN')
      return 1
    endif
    let l:keymap = quickui#utils#keymap()
    if has_key(l:keymap, a:key)
      let l:action = l:keymap[a:key]
      if l:action ==# 'ESC'
        call popup_close(a:winid, 0)
      elseif l:action !=# 'ENTER' && l:action !=# 'NEXT' && l:action !=# 'PREV'
        call quickui#utils#scroll(a:winid, l:action)
      endif
      return 1
    endif
    return popup_filter_yesno(a:winid, a:key)
  endfunction
  function! QuickuiOpenKeyMapCheatsheet()
    if !exists('g:quickui_keymap_groups')
      call QuickuiConfiguration()
    endif
    let g:quickui_cheatsheet_folded = {}
    for l:group in g:quickui_keymap_groups
      let g:quickui_cheatsheet_folded[l:group[0]] = 1
    endfor
    let g:quickui_cheatsheet_search_active = 0
    let g:quickui_cheatsheet_pending_g = 0
    unlet! g:quickui_cheatsheet_search_pattern g:quickui_cheatsheet_search_direction
    let [l:lines, l:window_width] = QuickuiBuildKeyMapCheatsheet()
    let l:window_height = min([max([6, &lines - 6]), len(l:lines)])
    let l:options = {
          \ 'title': 'Keymap Cheatsheet',
          \ 'w': l:window_width,
          \ 'h': l:window_height,
          \ 'maxwidth': l:window_width,
          \ 'maxheight': max([6, &lines - 6]),
          \ 'resize': 1,
          \ }
    if has('nvim')
      call quickui#textbox#open(l:lines, l:options)
    else
      let l:winid = quickui#textbox#create(l:lines, l:options)
      call popup_setoptions(l:winid, {'filter': function('QuickuiKeyMapCheatsheetFilter')})
    endif
  endfunction
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
    call QuickuiInstallKeyMapMenus()
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
  noremap <Leader>qc :<C-u>call QuickuiOpenKeyMapCheatsheet()<CR>
  noremap <Leader>qm :<C-u>call QuickuiOpenMenu()<CR>
  noremap <Leader>qb :<C-u>call QuickuiListBuffer()<CR>
  noremap <Leader>qt :<C-u>call QuickuiPreviewTag()<CR>



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



  " Vista setting
  noremap <Leader>vt :<C-u>Vista!!<CR>
  noremap <Leader>vf :<C-u>Vista focus<CR>
  let g:vista_no_mappings = 0
  let g:vista_default_executive = 'coc'
  let g:vista#renderer#enable_icon = 1
  let g:vista_close_on_jump = 1
  let g:vista_cursor_delay = 0
  let g:vista_blink = [0,0]
  let g:vista_top_level_blink = [0,0]
  let g:vista_echo_cursor_strategy = 'echo'



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



  " vim-interestingwords
  noremap <Leader>wt :<C-u>call LoadAndSetVimInterestingwords()<CR>
  nnoremap <Leader>wh :call MultipleWordsHighlight('n')<CR>
  vnoremap <Leader>wh :<C-u>call MultipleWordsHighlight('v')<CR>
  function! LoadAndSetVimInterestingwords()
    let g:interestingWordsRandomiseColors = 1
    let g:interestingWordsDefaultMappings = 0
    call plug#load('vim-interestingwords')
    while !exists('*UncolorAllWords')
    endwhile
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
    while !exists('*FugitiveStatusline')
    endwhile
    set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [%{toupper(&fileencoding)}=0x%B]%m%r
    set statusline+=%=\ %{GitStatus()}%{FugitiveStatusline()}
    set statusline+=\ [%{strftime(\"%m/%d/%y-%a-%H:%M\")}]%<
    exec 'normal! `s'
  endfunction
  function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endfunction



  " Vimspector setting
  function! JumpToTabIfExists(filepath)
    " 1. Get the buffer number for the absolute file path
    let l:bufnr = bufnr(fnamemodify(a:filepath, ':p'))
    " Return early and do nothing if the buffer does not exist
    if l:bufnr == -1
      return 0
    endif
    " 2. Find all window IDs displaying this buffer across all tabs
    let l:winids = win_findbuf(l:bufnr)
    " 3. Jump to the first matching window/tab if found
    if !empty(l:winids)
      call win_gotoid(l:winids[0])
    endif
    return 1
  endfunction
  function! ConfigureCppDebug()
    let l:cpp_workspace_root = WorkspaceRoot()
    let l:json_file_path = l:cpp_workspace_root.'/.vimspector.json'
    if JumpToTabIfExists(l:json_file_path)
      return
    endif
    if !isdirectory(l:cpp_workspace_root.'/.vscode')
      call mkdir(l:cpp_workspace_root.'/.vscode', 'p', 0755)
    endif
    call CopyFileRelToCPP(l:cpp_workspace_root, '.vscode/launch.json')
    if CopyFileRelToCPP(l:cpp_workspace_root, '.vimspector.json')
      call NUpdateTabTermBuf()
      exec 'tabe ' . l:json_file_path
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
  noremap <S-F5> :<C-u>call CUpdateTabTermBuf(0)<CR>:VimspectorReset<CR>
  noremap ]<F5> :<C-u>set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 16<CR>
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
    let g:tab_term_buf[tabpagenr()] = bufnr('%')
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

  " automatic-verilog
  noremap <Leader>ai :call g:AutoInst(0)<ESC>
  noremap <Leader>aa :call g:AutoArg()<ESC>
  noremap <Leader>app :call g:AutoPara(0)<ESC>
  noremap <Leader>apv :call g:AutoParaValue(0)<ESC>
  noremap <Leader>ar :call g:AutoReg()<ESC>
  noremap <Leader>aw :call g:AutoWire()<ESC>
  noremap <Leader>ad :call g:AutoDef()<ESC>
  " vim-verilog-instance
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
      exec 'tnoremap <M-' . l:i . '> <C-w>:call TabPosActivateBuffer(' . l:i . ')<CR>'
  endfor
  exec 'noremap <M-0> :<C-u>call TabPosActivateBuffer(10)<CR>'
  exec 'inoremap <M-0> <C-o>:call TabPosActivateBuffer(10)<CR>'
  exec 'tnoremap <M-0> <C-w>:call TabPosActivateBuffer(10)<CR>'
endfunction



" 会使vim看起来不友好的命令
if has('gui_running')
  set guifont=FantasqueSansM\ Nerd\ Font\ Mono\ 18
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
  autocmd!
  autocmd FileType * call SetIndent()
  autocmd BufNewFile * call SetTitle()
  " Disable automatic word wrap which is enabled by filetype plugin indent on
  autocmd FileType vim,cmake set textwidth=0
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
    setlocal cindent     " 设置使用C/C++语言的自动缩进方式
  elseif &filetype=='vim'
    let l:indent_val = 2
  endif
  let &l:tabstop = l:indent_val      " Tab键的显示宽度 and its practical width
  let &l:softtabstop = l:indent_val  " 按下Tab键时输入的宽度
  let &l:shiftwidth = l:indent_val   " 设置自动缩进时的缩进长度
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
    let l:compile_exec = ':AsyncRun -cwd=$(VIM_FILEDIR) -strip -rows=3 -listed=1 -hidden=1 -focus=0 -post=call\ JumpToTerm()'
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
  let l:compile_only = ':AsyncRun! -cwd=$(VIM_FILEDIR) -strip -rows=3 -hidden=1 -focus=0 -post=call\ JumpToTerm(1)'
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
" When pressing <Shift-*>, the $, #, : and @ should not be included in the selection.
set iskeyword-=$
set iskeyword-=#
set iskeyword-=:
set iskeyword-=@
" When pressing <Shift-*>, the / and . should be included in the selection.
set iskeyword+=/
set iskeyword+=.
noremap <C-S-t> :<C-u>call NewTab()<CR>
inoremap <C-S-t> <C-o>:call NewTab()<CR>
tnoremap <C-S-t> <C-w>:call NewTab()<CR>
noremap <LocalLeader>t :<C-u>call NewTab('empty_tab')<CR>
noremap <M-t> :<C-u>call NewTab('empty_tab')<CR>
inoremap <M-t> <C-o>:call NewTab('empty_tab')<CR>
tnoremap <M-t> <C-w>:call NewTab('empty_tab')<CR>
noremap <LocalLeader>b :<C-u>call CloseAndBackTab()<CR>
noremap <M-b> :<C-u>call CloseAndBackTab()<CR>
inoremap <M-b> <C-o>:call CloseAndBackTab()<CR>
tnoremap <M-b> <C-w>:call CloseAndBackTab()<CR>
noremap <LocalLeader>q :<C-u>call QuitWin()<CR>
noremap <M-q> :<C-u>call QuitWin()<CR>
inoremap <M-q> <C-o>:call QuitWin()<CR>
tnoremap <M-q> <C-w>:call QuitWin()<CR>
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
function! GetLaunchDir() abort
  if &buftype ==# 'terminal'
    let l:terminal_job = term_getjob(bufnr('%'))
    if job_status(l:terminal_job) ==# 'run'
      let l:terminal_pid = get(job_info(l:terminal_job), 'process', 0)
      if l:terminal_pid > 0
        let l:target_dir = resolve('/proc/'.l:terminal_pid.'/cwd')
        if isdirectory(l:target_dir)
          return l:target_dir
        endif
      endif
    endif
    return getcwd()
  endif
  let l:file_directory = expand('%:p:h')
  return isdirectory(l:file_directory) ? l:file_directory : getcwd()
endfunction
function! NewTab(mode = 'terminal') abort
  let l:target_dir = GetLaunchDir()
  call NUpdateTabTermBuf()
  tabnew
  if a:mode ==# 'empty_tab'
      exec 'tcd ' . l:target_dir
  else
    let l:terminal_options = {
          \ 'curwin': 1,
          \ 'norestore': 1,
          \ 'term_finish': 'close',
          \ 'term_kill': 'term',
          \ 'cwd': l:target_dir,
          \ }
    let g:tab_term_buf[tabpagenr()] = term_start(&shell, l:terminal_options)
  endif
endfunction
function! CloseAndBackTab()
  let l:exec_tabp='tabp'
  if tabpagenr() == tabpagenr('$')
    let l:exec_tabp=''
  fi
  while winnr('$') > 1 " Prevent the function from closing multiple tabs
    call QuitWin()
  endwhile
  call QuitWin()
  exec l:exec_tabp
endfunction
function! QuitWin()
  let l:exec_quit='quit'
  " Fix a bug that when QuitWin is called in single-terminal-tab, two tabs are closed.
  " Because CUpdateTabTermBuf closes all terminals in a tab and then quit closes a win in another tab.
  if &buftype=='terminal' && tabpagenr('$') > 1
    let l:exec_quit=''
  elseif &filetype=='' " Close terms without warnings.
    let l:exec_quit='quit!'
  endif
  if winnr('$') == 1 && tabpagenr('$') > 1 " Multiple tabs, single win
    call CUpdateTabTermBuf()
  elseif winnr('$') == 1 " Single win, single tab
    for l:buf in range(1, bufnr('$') + 1) " Clear term buffers without warnings.
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
    let l:tmp = g:tab_term_buf[l:cur_tab]
    for l:index in range(a:first, a:last, a:plus_or_minus_one[0])
      let g:tab_term_buf[l:index] = g:tab_term_buf[l:index + a:plus_or_minus_one[0]]
    endfor
    let g:tab_term_buf[a:last] = l:tmp
  elseif tabpagenr('$') > 1
    exec ':tabmove '.a:plus_or_minus[1]
    let l:tmp = g:tab_term_buf[l:cur_tab]
    let g:tab_term_buf[l:cur_tab] = g:tab_term_buf[l:cur_tab + a:plus_or_minus_one[1]]
    let g:tab_term_buf[l:cur_tab + a:plus_or_minus_one[1]] = l:tmp
  endif
endfunction
function! MoveTabH()
  call MoveTab(1, ['+', '-'], [+1, -1], 1, tabpagenr('$'))
endfunction
function! MoveTabL()
  call MoveTab(tabpagenr('$'), ['-', '+'], [-1, +1], tabpagenr('$'), 1)
endfunction
tnoremap <C-S-v> <C-w>"+
" Define the main command (capital E) – safe and explicit
command! -nargs=1 -complete=file E call s:EditWithWorkspaceCheck(<q-args>)
function! s:EditWithWorkspaceCheck(filename) abort
  " Step 1: Get workspace root (guaranteed to be a valid path)
  let l:root = WorkspaceRoot()
  " Step 2: Get current tab's local working directory
  let l:tab_cwd = getcwd()
  " Normalise paths (resolve symlinks, remove trailing slashes)
  let l:tab_cwd = fnamemodify(l:tab_cwd, ':p:h')
  " Step 3: Change tab-local cwd only if we're outside the workspace tree
  if stridx(l:tab_cwd, l:root . '/') != 0 && l:tab_cwd !=# l:root
    execute 'tcd ' . l:root
  endif
  " Step 4: Open the file
  execute 'edit ' . a:filename
endfunction
