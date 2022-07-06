"If you want to use my .vimrc, make sure your vim version is bigger than 8.1.1564
"If you use neovim, make sure its versio is bigger than 0.5.0
"There some depedencies you should have:
"(1)*llvm* and *clang* , make sure their versions are bigger than 10.0,ale and coc will need them
"(2)nodejs and yarn, make sure nodejs version is bigger than 12.12. coc will need them
"Also,markdown-preview.nvim needs yarn.
"(3)universial ctags, git clone https://github.com/universal-ctags/ctags.git
"(4)gnu global(gtags), https://ftp.gnu.org/pub/gnu/global/
"(5)the (3) (4) and gen_tags.vim may not be needed if you only write c/c++ and python,
"because coc and ale can support the function so that we can jump to the
"definition and reference without tags by LSP（Language Server Protocol）and better than tags.
"(6)compiledb,python3 -m pip install compiledb. It can support compile_commands.json for clangd if
"you use make to manage your project. If you use cmake, add set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
"to your CMakeLists.txt, that can support compile_commands.json. After the
"compile_commands.json created, you should copy it or link it so that we can
"find it in your root of your projece.Also you can modify the value of g:ale_c_build_dir_names in your .vimrc
"(7)vimplug,https://github.com/junegunn/vim-plug,this can help you manage your plugin of vim
"(8)if you use python, you also need to execute the following commands:
"python3 -m pip install pysnooper ipdb pylint yapf futures isort pyright
"(9)python3 -m pip install pygments vim-vint cmakelang
"(10)if you want to use my coc-settings.json, you can copy it from
"/home/hxliang/.vim to /home/you/.vim. And there are some dependencies you
"should have:first,run the following command in your vim :CocInstall coc-tag coc-cmake coc-sh coc-markdownlint
"coc-css coc-json coc-pyright coc-yaml coc-cl coc-clangd coc-dictionary coc-snippets coc-vimlsp coc-word;
"second,run the following command in your terminal:python3 -m pip install hdl-checker ,if you write the verilog;
"last, install verilator,verible and sudo npm install -g @imc-trading/svlangserver
"if your write the verilog. https://github.com/chipsalliance/verible
"(11)install ripgrep,if you want to use 'leaderf rg' command in .vimrc . https://github.com/BurntSushi/ripgrep
"(12)if your vim tell you that it can't find some models, you can do that
"first, ale use iverilog or verilator check the verilog syntax
"last,at the top of your verilog file add the following statement:
"`include "/path/to/xxx.v"
"ps:xxx.v must include those models which had been told that vim misses by ale
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
"gen_tags: GenCtags GenGTAGS ClearCtags ClearGTAGS
"leaderf: LeaderfFunction



set nocompatible  " 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限
" 侦测文件类型
set t_Co=256             " 开启256色支持
set updatetime=33   " 不少插件的信息更新都会需要这个时间
" 使用localleader映射的快捷键必须出现在let g:maplocalleader = ' '之后
let g:maplocalleader = ' '



let g:plug_url_format = "https://git::@github.91chi.fun//https://github.com/%s.git"
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' } " vim theme
Plug 'luochen1990/rainbow' " 彩虹括号
Plug 'nathanaelkane/vim-indent-guides' " 缩进显示
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 补全插件  build from source code by using yarn: https://yarnpkg.com
Plug 'preservim/nerdtree',{'on': 'NERDTreeToggle'}  " 文件目录插件
Plug 'liuchengxu/vista.vim',{'on':'Vista!!'}  " 标签窗口列表插件
Plug 'MattesGroeger/vim-bookmarks',{'on':['BookmarkToggle','BookmarkShowAll','BookmarkAnnotate']} " 书签插件，用于写代码注解等等
Plug 'Banana-Two/fcitx.vim',{'branch':'fcitx4','on':[]} " Esc退出变回英文输入法，进入insert模式切换为原来的输入法
Plug 'lfv89/vim-interestingwords',{'on':[]} " Multiple highlights
Plug 'tpope/vim-fugitive',{'on':[]} " Git command
Plug 'airblade/vim-gitgutter',{'on':[]} " Git status show
Plug 'puremourning/vimspector',{'on':[]} " c/cpp debug
Plug 'jsfaint/gen_tags.vim', {'on':['GenGTAGS','GenCtags','ClearGTAGS','ClearGtags']} " 异步生成tags插件，命令是GenGTAGS,GenCtags，存储在~/.cache/tags_dir中
Plug 'Yggdroot/LeaderF', {'on': ['Leaderf','LeaderfFunction','LeaderfBuffer','LeaderfFile']}  " 快速查找插件，包括查找文件，当前文件函数，模糊查找字段
Plug 'Yggdroot/LeaderF-marks', {'on': ['Leaderf','LeaderfFunction','LeaderfBuffer','LeaderfFile']} " LeaderF extension for navigate the marks.
Plug 'sbdchd/neoformat',{'on':['Neoformat']} " 代码格式化插件
Plug 'bfrg/vim-cpp-modern', {'on':[]}  " 高亮c++类模板等插件
Plug 'vim-python/python-syntax', {'on':[]} " python 语法高亮插件
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " markdown实时预览插件
Plug 'godlygeek/tabular', {'on': []} " markdown表格插件
Plug 'dense-analysis/ale',{'on':[]}  " 动态检测语法插件,可鼠标停留显示信息
Plug 'liuchengxu/vim-which-key', { 'on': [] } " vim快捷键管理和提示插件
Plug 'mzlogin/vim-markdown-toc',{'on':[]} " markdown目录构建插件
Plug 'preservim/nerdcommenter', {'on':[]} " nerdcommenter快速注释插件
Plug 'skywind3000/asyncrun.vim',{'on':[]} " 异步执行shell命令插件，如果需要打开新终端，请去github看skywind3000/asyncrun.extra插件
Plug 'skywind3000/vim-quickui' " 菜单栏插件
Plug 'taketwo/vim-ros',{'on':[]} " roslaunch语法高亮
Plug 'Banana-Two/verilog_indent',{'for': ['verilog', 'systemverilog']} " verilog indent file
call plug#end()



colorscheme dracula
" 设置光标格式竖纹：ver33  下划线：hor20   方块：block,其中数字为百分比
set guicursor=c-i:ver33-Cursor
set guicursor+=a:blinkon0
nnoremap <silent><Leader>ppt :colorscheme zellner<CR>:set guifont=DejaVuSansMono\ Nerd\ Font\ Mono\ 23<CR>:IndentGuidesDisable<CR>
autocmd FileType verilog nnoremap <silent><Leader>` :call Show_Current_Module()<CR>
function! Show_Current_Module()
  let module_line = search('module','bnWz')
  let module_name = getline(module_line)
  let module_end_poisition = strridx(module_name,'(')
  if(module_end_poisition > 0)
    let module_name = strpart(module_name,0,module_end_poisition)
  endif
  let module_name = strpart(module_name,stridx(module_name,'module')+7)
  while(strpart(module_name, 0 , 1) == ' ')
    let module_name = strpart(module_name,1)
  endwhile
  echo "module -->" module_name
endfunction
autocmd FileType c,cpp nnoremap <silent><Leader>` :call Show_Nearest_Class_Or_Struct()<CR>
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
" 插件疑似不支持按文件类型加载，手动添加autocmd判断，也不支持利用vim的特性延迟加载
augroup Call_Highlight_Plugin
  autocmd FileType cpp,c silent call plug#load('vim-cpp-modern')
  autocmd FileType python silent call plug#load('python-syntax')
  autocmd VimEnter,BufRead *.launch setfiletype roslaunch
  autocmd BufRead *.launch silent call plug#load('vim-ros')
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
    exec "CocStart"
    augroup Lazy_Call_Plugin
      autocmd FileType c,cpp,python,verilog silent call plug#load('ale')
      autocmd FileType markdown silent call plug#load('vim-markdown-toc')
      autocmd FileType markdown silent call plug#load('tabular')
      autocmd FileType c,cpp,cmake silent call Format_C_CPP_CMAKE()
    augroup END
    silent call Lazy_On_Plugin_Configuration()
    silent call Lazy_Plugin_Configuration()
    silent call plug#load('vim-which-key')
    silent call plug#load('nerdcommenter')
    silent call plug#load('asyncrun.vim')
endfunction
silent call timer_start(333,'CocTimerStart',{'repeat':1})
function Lazy_On_Plugin_Configuration()
  " Use tab for trigger completion with characters ahead and navigate.After we select the word we needn't press enter key
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin before putting this into your config.
  " ctrl+j: jump to the next parameter in the completed function, 
  " ctrl+k:jump to the previous parameter in the completed function
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  " Make <CR> auto-select the first completion item
  inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() :"\<CR>"
  nmap <silent><Localleader>d <Plug>(coc-definition)
  nmap <silent><Localleader>c <Plug>(coc-declaration)
  nmap <silent><Localleader>i <Plug>(coc-implementation)
  nmap <silent><Localleader>r <Plug>(coc-references)
  nmap <silent><Localleader>n <Plug>(coc-rename)
  nmap <silent><Localleader>f <Plug>(coc-refactor)
  nnoremap <silent>[td :silent call CocAction('jumpDefinition', 'tabe')<CR>
  nnoremap <silent>[tc :silent call CocAction('jumpDeclaration', 'tabe')<CR>
  nnoremap <silent>[ti :silent call CocAction('jumpImplementation', 'tabe')<CR>
  nnoremap <silent>[tr :silent call CocAction('jumpReferences', 'tabe')<CR>
  nmap <silent><Localleader>an <plug>(coc-diagnostic-next)
  nmap <silent><Localleader>ap <plug>(coc-diagnostic-prev)
  nmap <silent><Localleader>en <plug>(coc-diagnostic-next-error)
  nmap <silent><Localleader>ep <plug>(coc-diagnostic-prev-error)



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
  " 有部分字体不支持vista的特殊符号即特殊符号显示乱码，因此需要禁用特殊符号，1启用，0禁用
  let g:vista#renderer#enable_icon = 1
  let g:vista_close_on_jump = 1
  let g:vista_cursor_delay = 0
  let g:vista_blink = [0,0]
  let g:vista_top_level_blink = [0,0]
  let g:vista_echo_cursor_strategy = "floating_win"



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
    if location == '.git'
      " current directory is workspace or current file path has .git directory
      let path_to_pro = getcwd()
    elseif strlen(strpart(location,0,1)) == 1
      " can find .git, but current directory not has .git
      let path_to_pro = strpart(location,0,strridx(location,'/.git'))
    endif
    if len(location) > 0
      if strpart(path_to_pro,0,1)!='/'
        let path_to_pro='/'.path_to_pro
      endif
      let pro_dir = strpart(path_to_pro,strridx(path_to_pro,'/'))
      let pro_to_file = strpart(cur_file_path,stridx(cur_file_path,pro_dir)+strlen(pro_dir))
      let location = simplify(location.'/.vim-bookmarks'.pro_to_file)
    else
      " the bookmarks of the root and common user both are saved in the same directory
      if strpart(cur_file_path,0,5) == '/root'
        let pro_to_file = cur_file_path
      elseif strpart($SUDO_USER,0,1) == ''
        let pro_to_file = strpart(cur_file_path,strlen($HOME))
      else
        let pro_to_file = strpart(cur_file_path,strlen('/home/'.$SUDO_USER))
      endif
      if strpart($SUDO_USER,0,1) == ''
        let location = $HOME.'/.vim/.vim-bookmarks'.pro_to_file
      else
        let location = '/home/'.$SUDO_USER.'/.vim/.vim-bookmarks'.pro_to_file
      endif
    endif
    if !isdirectory(location)
      call mkdir(location,"p")
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
  nnoremap <silent><Leader>git :silent call plug#load('vim-fugitive')<CR>:silent call plug#load('vim-gitgutter')<CR>:set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [ASCII=0x%B]%m%r<CR>:set statusline+=%=\ %{GitStatus()}%{FugitiveStatusline()}\ [%{strftime(\"%d/%m/%y-%H:%M\")}]%<<CR>
  let g:fugitive_no_maps = 1
  let g:gitgutter_map_keys = 0
  function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endfunction
  let g:gitgutter_map_keys = 0
  nmap <Leader>gp <Plug>(GitGutterPrevHunk)
  nmap <Leader>gn <Plug>(GitGutterNextHunk)
  nmap <Leader>gf <Plug>(GitGutterFold)



  " vimspector setting
  function! Cpp_Workspace_Configuration()
    let root_location = finddir('.git', '.;')
    if (strlen(root_location) == 0)
      let root_location = expand('%:p:h')
    elseif (root_location == '.git')
      let root_location = '.'
    else
      let root_location = strpart(root_location,0,strridx(root_location,'/.git'))
    endif
    let root_location = root_location.'/.vimspector.json'
    if !filereadable(root_location)
      let cpp_json_content = readfile($HOME.'/.vim/.vimspectorjson/cpp.json')
      call writefile(cpp_json_content,root_location,"s")
    endif
      exec 'tabe ' . root_location
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
  nnoremap <silent>]<F5> :set guifont=FantasqueSansMono\ Nerd\ Font\ Mono\ 19<CR>:silent call plug#load('vimspector')<CR>:call vimspector#Launch()<CR>
  nnoremap <silent><Leader><F5> :silent call Cpp_Workspace_Configuration()<CR>
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
  function s:SetUpTerminal()
    call win_gotoid( g:vimspector_session_windows.terminal )
    3wincmd |
  endfunction
  augroup VimspectorCustom
    autocmd!
    autocmd User VimspectorUICreated call s:SetUpUI()
    autocmd User VimspectorTerminalOpened call s:SetUpTerminal()
  augroup END



  " gen_tags setting
  if (&filetype=='cpp')||(&filetype=='c')
    let g:gen_tags#ctags_opts = ['--c++-kinds=+pxzl', '--c-kinds=+pxzl']
    let g:gen_tags#gtags_opts = ['-c', '--verbose']
  endif
  let g:gen_tags#ctags_auto_update = 0
  let g:gen_tags#gtags_auto_update = 0
  let $GTAGSCONF='/usr/local/share/gtags/gtags.conf'
  let $GTAGSLABEL = 'native-pygments'



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
          \ "--max-columns=150",
          \ "--type-add web:*.{html,css,js}*",
          \ "--glob=!git/*",
          \ "--hidden"
      \ ]
  let g:Lf_PreviewInPopup = 1
  " open the preview window automatically
  let g:Lf_PreviewResult = {'Rg': 1 }
  let g:Lf_ShortcutB = '<Leader>fb'
  let g:Lf_ShortcutF = '<Leader>ff'



  " autoformat setting
  augroup Lazy_Call_Format
    autocmd FileType verilog,json nmap <silent><F7> <Plug>(coc-format)
    autocmd FileType verilog,json vmap <silent><F7> <Plug>(coc-format-selected)
    autocmd FileType markdown nmap <silent><F7> <Plug>(coc-codeaction)
    autocmd FileType markdown vmap <silent><F7> <Plug>(coc-codeaction-selected)
    autocmd FileType python nnoremap <silent><F7> :ALEFix<CR>
  augroup END
endfunction
function Format_C_CPP_CMAKE()
  " 默认调用软件为clang-format, style options:LLVM, GNU, Google, Chromium, Microsoft, Mozilla, WebKit
  let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-style="{BasedOnStyle: GNU, AccessModifierOffset: 0, AlignConsecutiveMacros: AcrossEmptyLinesAndComments, AllowShortBlocksOnASingleLine: Always, AlwaysBreakAfterDefinitionReturnType: None, AlwaysBreakAfterReturnType: None, AlwaysBreakTemplateDeclarations: Yes, BreakBeforeBinaryOperators: None, BreakBeforeBraces: Allman, BreakInheritanceList: AfterComma, BreakConstructorInitializers: AfterColon, ConstructorInitializerIndentWidth: 2, ContinuationIndentWidth: 2, IndentAccessModifiers: true, IndentCaseBlocks: true, SpaceAfterTemplateKeyword: false, SpaceBeforeParens: Never, SpaceBeforeRangeBasedForLoopColon: false, Standard: Latest, TabWidth: 2}"'],
            \ }
  let g:neoformat_cmake_cmakeformat = {
            \ 'exe': 'cmake-format',
            \ }
  let g:neoformat_enabled_cpp = ['clangformat']
  let g:neoformat_enabled_c = ['clangformat']
  let g:neoformat_enabled_cmake = ['cmakeformat']
  noremap <silent><F7> :Neoformat<CR>
  let g:neoformat_only_msg_on_error = 1
  let g:neoformat_basic_format_retab = 1
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



" markdown-preview.nvim setting
let g:mkdp_browser = '/usr/bin/firefox'
autocmd FileType markdown nmap <silent><Localleader><F2> <Plug>MarkdownPreview



function Lazy_Plugin_Configuration()
  " ale setting
  let g:ale_enabled = 0
  " Go To Definition (:ALEGoToDefinition),[d will create new tab
  nnoremap <silent>[ud :ALEGoToDefinition <CR>
  nnoremap <silent>[d :ALEGoToDefinition -tab<CR>
  " Finding references (:ALEFindReferences),[r will create new tab
  nnoremap <silent>[ur :ALEFindReferences <CR>
  nnoremap <silent>[r :ALEFindReferences -tab<CR>
  " On leaving insert mode, check the file
  let g:ale_lint_on_insert_leave = 1
  " When you save a buffer, check the file
  " let g:ale_lint_on_save = 1
  " When this option is set to `1`, highlights will be set for problems.
  let g:ale_set_highlights = 1
  " 自定义error和warning图标
  let g:ale_sign_error = '✗'
  let g:ale_sign_warning = '⚡'
  " 显示Linter名称,出错或警告等相关信息
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  " 打开文件时进行检查
  let g:ale_lint_on_enter = 0
  " 普通模式下，[a前往上一个错误或警告，[n前往下一个错误或警告
  nmap <silent>[a <Plug>(ale_previous_wrap)
  nmap <silent>[n <Plug>(ale_next_wrap)
  " [c触发或关闭语法检查syntax change
  nnoremap <silent>[c :ALEToggle<CR>
  " [l查看错误或警告的详细信息
  nnoremap <silent>[l :ALEDetail<CR>
  " 使用clang对c和c++进行语法检查，对python使用pylint进行语法检查
  " 因为clangtidy和clangcheck仅在文件打开和保存时运行，所以由它们
  " 产生的警告或者错误标记只有通过保存文件来消除.谨慎选择语法检测器，
  " 性能不好的语法检测器会导致ale和vim-which-key造成冲突，导致写入或退出插入模式后会卡顿，例如旧版iverilog
  let g:ale_linters = {
  \   'python': ['pylint'],
  \   'verilog':['verilator'],
  \}
  " disable the plist generation.
  let g:ale_cpp_clangcheck_options = '-extra-arg -Xanalyzer -extra-arg -analyzer-output=text'
  " set python3 to be default python
  let g:ale_python_executable = 'python3'
  let g:ale_python_pylint_use_global = 1
  " 使coc和ale可以同时工作,01不同时工作，10同时工作
  let g:ale_disable_lsp = 0
  let g:ale_lsp_suggestions = 1
  let g:ale_fixers = {
              \ 'python': ['yapf', 'isort'],
              \ }
  let g:ale_c_clangtidy_executable = ''
  let g:ale_cpp_clangtidy_executable = ''
  let g:ale_c_clangd_executable = ''
  let g:ale_cpp_clangd_executable = ''



  " vim-which-key setting
  let g:which_key_fallback_to_native_key=1
  nnoremap <silent><Leader> :WhichKey '<Leader>'<CR>
  nnoremap <silent><Localleader> :WhichKey '<Localleader>'<CR>
  nnoremap <silent>[ :WhichKey '['<CR>
  nnoremap <silent>] :WhichKey ']'<CR>



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
              \ [ "&Close", 'echo 2' ],
              \ [ "--", '' ],
              \ [ "&Save\tCtrl+s", 'echo 3'],
              \ [ "Save &As", 'echo 4' ],
              \ [ "Save All", 'echo 5' ],
              \ [ "--", '' ],
              \ [ "E&xit\tAlt+x", 'echo 6' ],
              \ ])
  " items containing tips, tips will display in the cmdline
  call quickui#menu#install('&Edit', [
              \ [ '&Copy', 'echo 1', 'help 1' ],
              \ [ '&Paste', 'echo 2', 'help 2' ],
              \ [ '&Find', 'echo 3', 'help 3' ],
              \ ])
  " script inside %{...} will be evaluated and expanded in the string
  call quickui#menu#install("&Option", [
        \ ['Set &Spell %{&spell? "Off":"On"}', 'set spell!'],
        \ ['Set &Cursor Line %{&cursorline? "Off":"On"}', 'set cursorline!'],
        \ ['Set &Paste %{&paste? "Off":"On"}', 'set paste!'],
        \ ])
  " register HELP menu with weight 10000
  call quickui#menu#install('H&elp', [
        \ ["&Cheatsheet", 'help index', ''],
        \ ['T&ips', 'help tips', ''],
        \ ['--',''],
        \ ["&Tutorial", 'help tutor', ''],
        \ ['&Quick Reference', 'help quickref', ''],
        \ ['&Summary', 'help summary', ''],
        \ ], 10000)
  " enable to display tips in the cmdline
  let g:quickui_show_tip = 1
  " color scheme for the menu plugin,five color schemes we can choose default is
  " borland,another four are gruvbox, solarized,papercol dark and papercol light
  if has("gui_running")
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
if has("gui_running")
  if !has('nvim')
    " set guifont=Monospace\ 18   " 设置字体
    " set guifont=DejaVuSansMono\ Nerd\ Font\ Mono\ 19   " 设置字体
    set guifont=FantasqueSansMono\ Nerd\ Font\ Mono\ 21   " 设置字体
  endif
  set lines=60 columns=80    " 设定窗口大小
  set guioptions-=r " 隐藏滚动栏
  set guitablabel=%t " tab只显示文件名不显示标签
endif
set shortmess+=c
set showcmd
set foldmethod=manual
" \ 打印空格
" [FORMAT=%{&fenc}-%{&ff}]显示正在编辑的文件的编码和所在类系统类型
" [TYPE=%Y]正在编辑的文件类型
" [POS=%l,%v,%L][%p%%]当前光标所在位置，显示为行数，列数,总行数和百分比
" [ASCII=%b]当前光标下的ascii十进制数值
" [HEX=0x%B]当前光标下的ascii十六进制数值
" %m如果缓冲区已修改则表示为[+]，%M显示结果没有[]
" %r如果缓冲区为只读则显示为[RO]，%R显示结果没有[]
" %=左对齐和右对齐项目之间的分割点
" [%F%w]正在编辑的绝对路径/文件名，%f为相对路径
" [%{strftime(\"%d/%m/%y-%H:%M\")}]日/月/年-时:分
" %<状态行过长，在何处换行，缺省则是在开头
set statusline=[TYPE=%Y]\ [POS=%l,%v,%L]\ [ASCII=0x%B]%m%r
set statusline+=%=\ [%{strftime(\"%d/%m/%y-%H:%M\")}]%<
set laststatus=2    " 当窗口多于一个时显示状态行(1),总是显示状态行(2)
set ttimeoutlen=0        " 设置<ESC>键响应时间
set timeoutlen=666 " setting keymapping timeout
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
set ruler                   " 总是显示光标位置
set cursorline              " 突出显示当前行
set novisualbell " 不要闪烁
" 命令行（在状态行下）的高度，默认为1，这里是2
set cmdheight=2
" 显示行号
set number
" merge signcolumn and number column into one
set signcolumn=number
" Uncomment the following to have Vim jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set enc=utf-8 " 把当前文件转换为当前系统编码进行处理，这里为utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936,big5,latin1 " 打开文件时进行解码的猜测列表
" Tab键的显示宽度
set tabstop=2
" 按下Tab键时输入的宽度
set softtabstop=2
" 把Tab字符用空格代替，和tabstop相关
set expandtab
" 设置自动缩进时的缩进长度
set shiftwidth=2
" 设置当文件被改动时自动载入
set autoread
" 共享剪贴板
set clipboard=unnamedplus
" 设置魔术正则语法
set magic
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 缩进
set autoindent
autocmd FileType c,cpp set cindent " 设置使用C/C++语言的自动缩进方式
set smartindent "
" 历史记录数
set history=1000
" 禁止生成临时文件
set nobackup
set noswapfile
" 行内替换
set gdefault
" 保存全局变量
set viminfo+=!
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
" 增强模式中的命令行自动完成/补全操作
set wildmode=list:longest
" 使回格键（backspace）正常处理indent, eol, start等
set backspace=2
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
set ws
" 搜索和补全时忽略大小写,智能大小写,逐字符高亮
set ignorecase
set smartcase
set hlsearch
set incsearch
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 新文件标题
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.v exec ":call SetTitle()"
func SetTitle()
  if &filetype=='sh'
    call setline(1,"\#########################################################################")
    call append(line("."), "\# File Name: ".expand("%"))
    call append(line(".")+1, "\# Author: 16hxliang3")
    call append(line(".")+2, "\# mail: 16hxliang3@stu.edu.cn")
    call append(line(".")+3, "\# Created Time: ".strftime("%c"))
    call append(line(".")+4, "\#########################################################################")
    call append(line(".")+5, "\#!/bin/bash")
    call append(line(".")+6, "")
  else
    call setline(1, "/*************************************************************************")
    call append(line("."), "  > File Name: ".expand("%"))
    call append(line(".")+1, "  > Author: 16hxliang3")
    call append(line(".")+2, "  > Mail: 16hxliang3@stu.edu.cn ")
    call append(line(".")+3, "  > Created Time: ".strftime("%c"))
    call append(line(".")+4, " ************************************************************************/")
    call append(line(".")+5, "")
  endif
  if &filetype=='cpp'
    call append(line(".")+6, "#include<iostream>")
    call setline(line(".")+8, "")
  elseif &filetype=='c'
    call append(line(".")+6, "#include<stdio.h>")
    call setline(line(".")+8, "")
  elseif &filetype=='verilog'
    call append(line(".")+6,"module ")
  endif
  " 新建文件后，自动定位到文件末尾
  exec "silent normal! G"
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType c,cpp,python,sh,verilog silent call Complie_Command()
function Complie_Command()
  " 按F2编译运行,因为ale在退出插入模式后会自动检测语法，所以编译后运行可能会自动退出结果界面
  if &filetype=='cpp'
    nnoremap <silent><Localleader><F2> :AsyncRun! -save=1 g++ % -o E%<.exe -g && ./E%<.exe <CR>
    nnoremap <silent><Leader><F2> :AsyncRun! -save=1 g++ % -o E%<.exe -g <CR>
    nnoremap <silent><Localleader><Leader> :w<CR>:AsyncRun! -save=1 make<CR>
  elseif &filetype=='c'
    nnoremap <silent><Localleader><F2> :AsyncRun! -save=1 gcc % -o E%<.exe -g && ./E%<.exe <CR>
    nnoremap <silent><Leader><F2> :AsyncRun! -save=1 gcc % -o E%<.exe -g <CR>
    nnoremap <silent><Localleader><Leader> :w<CR>:AsyncRun! -save=1 make<CR>
  elseif &filetype=='python'
    nnoremap <silent><Localleader><F2> :AsyncRun! -save=1 python3 % <CR>
  elseif &filetype=='sh'
    nnoremap <silent><Localleader><F2> :AsyncRun! -save=1 ./% <CR>
  elseif &filetype=='verilog'
    nnoremap <silent><Localleader><F2> :AsyncRun! -save=1 iverilog *.v -o %<.vcd && vvp %<.vcd <CR>
  endif
endfunction
" Toggle Menu and Toolbar菜单栏和工具栏
if has("gui_running")
  set guioptions-=m
  set guioptions-=T
  nnoremap <silent><Localleader>m :call MENU_TOOGLE()<CR>
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
" alt+n跳到第n个tab，0<n<10
function! TabPos_ActivateBuffer(num)
    let s:count = a:num
    exe "tabfirst"
    exe "tabnext" s:count
endfunction
function! TabPos_Initialize()
for i in range(1, 9)
        exe "noremap <silent><M-" . i . "> :call TabPos_ActivateBuffer(" . i . ")<CR>"
    endfor
    exe "noremap <silent><M-0> :call TabPos_ActivateBuffer(10)<CR>"
endfunction
if has('nvim')
  autocmd UIEnter * silent call TabPos_Initialize()
else
  autocmd GUIEnter * silent call TabPos_Initialize()
endif
nnoremap <silent><Localleader>b :call Close_and_Back_Tab()<CR>
function! Close_and_Back_Tab()
  exec "tabp"
  exec "+tabclose"
endfunction
nnoremap <silent><Localleader>q :q<CR>
nnoremap <silent><Localleader>w :w<CR>
nnoremap <silent><Localleader><F4> :%retab!<CR>
" 比较文件
nnoremap <Localleader><F5> :vert diffsplit 
nnoremap <silent><Localleader><F6> :call Delete_Blank_Line()<CR>
function! Delete_Blank_Line()
  exec "silent normal! m`"
  exec "silent :g/^\s*$/d"
  exec "silent normal! ``"
endfunction
nnoremap <silent><Localleader><F7> :call Delete_Trailling_Space()<CR>
function! Delete_Trailling_Space()
  exec "silent normal! m`"
  exec "silent :%s/\\s\\+$//e"
  exec "silent normal! ``"
endfunction
" Press Enter at normal mode <space>Enter，格式和当前行保持一致
nnoremap <silent><Localleader><CR> i<CR><ESC>
" Ctrl-Enter新建行和当前行格式保持一致,normal模式下仅对注释类型有效
nnoremap <silent><C-CR> o<ESC>
inoremap <silent><C-CR> <ESC>o
" Alt-Enter新建空行
nnoremap <silent><M-CR> o<ESC>g$d0
inoremap <silent><M-CR> <ESC>o<ESC>g$d0i
