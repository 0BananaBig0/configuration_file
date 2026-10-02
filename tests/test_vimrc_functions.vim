" Run: vim -Nu NONE -n -i NONE -es -S tests/test_vimrc_functions.vim
set nocompatible noswapfile hidden noconfirm
let s:repo = expand('<sfile>:p:h:h')
let s:vimrc = get(g:, 'vimrc_under_test', s:repo . '/.vimrc')
execute 'source ' . fnameescape(s:vimrc)
call timer_stopall()
call SetGeneralKeyMaps()
call ConfigureDelayedPlugin()
call ConfigureManualLoadPlugin()
set noconfirm
autocmd! Local_Autocmd_Group
let &shell = '/bin/sh'
let s:fixtures = tempname()
call mkdir(s:fixtures . '/.git', 'p')
call writefile(['print("test")'], s:fixtures . '/main.py')

function! s:TerminalTabs() abort
  " Catch terminal ownership that follows tab numbers instead of actual tabs.
  execute 'edit ' . fnameescape(s:fixtures . '/main.py')
  call ToggleTerminal()
  let l:first = bufnr()
  call assert_equal('terminal', &buftype)
  call ToggleTerminal()
  call NewTab('empty_tab')
  call ToggleTerminal()
  let l:second = bufnr()
  call ToggleTerminal()
  tabfirst
  call MoveTabH()
  call ToggleTerminal()
  call assert_equal(l:first, bufnr(), 'terminal follows tab moved left across boundary')
  call ToggleTerminal()
  call MoveTabL()
  execute 'bwipeout! ' . l:first
  call NewTab('empty_tab')
  tablast
  call ToggleTerminal()
  call assert_equal(l:second, bufnr(), 'dead terminal in another tab cannot steal this one')
  call ToggleTerminal()
  call MoveTabL()
  call ToggleTerminal()
  call assert_equal(l:second, bufnr(), 'terminal follows tab moved right across boundary')
  call ToggleTerminal()

  " Catch fixed-size tracking that fails as the number of tabs grows.
  for l:i in range(1, 24)
    call NewTab('empty_tab')
  endfor
  call assert_equal(27, tabpagenr('$'), 'no fixed terminal-tracking limit')
  call CloseAndBackTab()
  call assert_equal(26, tabpagenr('$'), 'close exactly one tab')
  tablast
  call ToggleTerminal()
  let l:closed = bufnr()
  call ToggleTerminal()
  call CloseAndBackTab()
  call assert_false(bufexists(l:closed), 'closing a tab terminates its tracked terminal')
endfunction

function! s:QuitPreservesSource() abort
  " Use a child Vim because the old QuitWin exits after discarding the buffer.
  let l:child = s:fixtures . '/quit.vim'
  let l:result = s:fixtures . '/quit.json'
  call writefile([
        \ 'set nocompatible noswapfile hidden noconfirm',
        \ 'source ' . fnameescape(s:vimrc),
        \ 'call timer_stopall()',
        \ 'call SetGeneralKeyMaps()',
        \ 'set noconfirm',
        \ 'file ' . fnameescape(s:fixtures . '/unsaved.py'),
        \ 'call setline(1, "unsaved source changes")',
        \ 'let g:source_buf = bufnr()',
        \ 'let g:terminal_buf = term_start("/bin/sh", {"hidden": 1, "term_kill": "term"})',
        \ 'enew',
        \ 'setlocal filetype=python',
        \ 'set nohidden',
        \ 'try',
        \ '  call QuitWin()',
        \ 'catch',
        \ 'endtry',
        \ 'call writefile([json_encode({"exists": bufexists(g:source_buf), "modified": getbufvar(g:source_buf, "&modified"), "terminal": bufexists(g:terminal_buf)})], ' . string(l:result) . ')',
        \ 'qa!',
        \ ], l:child)
  call system(join(map([exepath('vim'), '-Nu', 'NONE', '-n', '-i', 'NONE', '-es', '-S', l:child], 'shellescape(v:val)'), ' '))
  call assert_equal(0, v:shell_error, 'quit check child Vim')
  let l:saved = json_decode(join(readfile(l:result), "\n"))
  call assert_true(l:saved.exists, 'QuitWin keeps hidden source buffers')
  call assert_true(l:saved.modified, 'QuitWin keeps unsaved source changes')
  call assert_true(l:saved.terminal, 'failed last-window quit keeps hidden terminal')

  call writefile([
        \ 'source ' . fnameescape(s:vimrc),
        \ 'call timer_stopall()',
        \ 'call SetGeneralKeyMaps()',
        \ 'set noconfirm',
        \ 'let g:terminal_buf = term_start("/bin/sh", {"hidden": 1, "term_kill": "term"})',
        \ 'setlocal filetype=python',
        \ 'call QuitWin()',
        \ 'cquit 7',
        \ ], l:child)
  call system(join(map([exepath('vim'), '-Nu', 'NONE', '-n', '-i', 'NONE', '-es', '-S', l:child], 'shellescape(v:val)'), ' '))
  call assert_equal(0, v:shell_error, 'native exit handles configured hidden terminal')
endfunction

function! s:CancelledQuit() abort
  call NewTab('empty_tab')
  call ToggleTerminal()
  let l:terminal = bufnr()
  call ToggleTerminal()
  setlocal filetype=python
  call setline(1, 'unsaved source')
  set nohidden noconfirm
  let l:tab_count = tabpagenr('$')
  try
    call QuitWin()
  catch /^Vim\%((\a\+)\)\=:E37/
  endtry
  call assert_equal(l:tab_count, tabpagenr('$'), 'failed quit keeps the tab')
  call assert_true(&modified, 'failed quit keeps source changes')
  call assert_true(bufexists(l:terminal), 'failed quit keeps its terminal')
  set hidden
endfunction

function! s:CaptureConsole(text) abort
  let g:debugger_command = a:text
endfunction

function! s:DebuggerCommands() abort
  " Replace only the external adapter boundary; keep real prompt/windows.
  call mkdir(s:fixtures . '/autoload', 'p')
  call writefile([
        \ 'function! vimspector#Evaluate(expr) abort',
        \ '  let g:debugger_command = a:expr',
        \ '  call win_gotoid(g:test_console_win)',
        \ 'endfunction',
        \ 'function! vimspector#AddWatch(expr) abort',
        \ '  let g:watch_expression = a:expr',
        \ 'endfunction',
        \ 'function! vimspector#ShowDisassembly() abort',
        \ '  if get(g:, "test_create_disassembly", 0)',
        \ '    let l:origin = win_getid()',
        \ '    new',
        \ '    let g:test_disassembly_win = win_getid()',
        \ '    let g:vimspector_session_windows.disassembly = win_getid()',
        \ '    nnoremenu WinBar.Disassembly :echo 1<CR>',
        \ '    call win_gotoid(l:origin)',
        \ '  endif',
        \ 'endfunction',
        \ ], s:fixtures . '/autoload/vimspector.vim')
  execute 'source ' . fnameescape(s:fixtures . '/autoload/vimspector.vim')
  enew
  let l:original_win = win_getid()
  split
  enew
  setlocal buftype=prompt
  let g:test_console_win = win_getid()
  call prompt_setcallback(bufnr(), function('s:CaptureConsole'))
  command! -nargs=1 VimspectorShowOutput call win_gotoid(g:test_console_win)
  for [l:name, l:args, l:want] in [
        \ ['ListAllBreakPoints', [], '-exec info breakpoints'],
        \ ['ControlAllChildrenProcessess', [], '-exec set detach-on-fork off'],
        \ ['DetachAllChildrenProcessess', [], '-exec set detach-on-fork on'],
        \ ['FollowChildrenProcessess', [], '-exec set follow-fork-mode child'],
        \ ['FollowParentProcessess', [], '-exec set follow-fork-mode parent'],
        \ ['ListAllProcessess', [], '-exec info inferiors'],
        \ ['SwitchToSpecificProcess', [7], '-exec inferior 7'],
        \ ['ListAllThreads', [], '-exec info threads'],
        \ ['CheckAllBacktraces', [], '-exec thread apply all backtrace'],
        \ ['CheckCurrentBacktrace', [], '-exec backtrace'],
        \ ['SetBacktraceLimit', [4], '-exec set backtrace limit 4'],
        \ ['SwitchToSpecificThread', [9], '-exec thread 9'],
        \ ['ContinueAllThreads', [], '-exec thread apply all continue'],
        \ ['StopAllThreads', [], '-exec thread apply all stop']]
    call win_gotoid(l:original_win)
    let g:debugger_command = ''
    call call(function(l:name), l:args)
    call assert_equal(l:want, g:debugger_command, l:name . ' adapter command')
    call assert_equal(l:original_win, win_getid(), l:name . ' restores focus')
  endfor
  call win_gotoid(l:original_win)
  let g:vimspector_session_windows = {'watches': g:test_console_win}
  let g:watch_expression = ''
  call AddVarToWatch('items[index + 1]')
  call assert_equal('items[index + 1]', g:watch_expression, 'watch submitted through adapter API')
  call assert_equal(l:original_win, win_getid(), 'watch leaves focus unchanged')

  " A disconnected/unsupported adapter must return without polling forever.
  let l:child = s:fixtures . '/disassembly.vim'
  call writefile([
        \ 'source ' . fnameescape(s:vimrc),
        \ 'call timer_stopall()',
        \ 'call SetGeneralKeyMaps()',
        \ 'call ConfigureDelayedPlugin()',
        \ 'call ConfigureManualLoadPlugin()',
        \ 'source ' . fnameescape(s:fixtures . '/autoload/vimspector.vim'),
        \ 'let g:vimspector_session_windows = {}',
        \ 'call ShowAssembleCode()',
        \ 'qa!',
        \ ], l:child)
  call system(join(map(['timeout', '2s', exepath('vim'), '-Nu', 'NONE', '-n', '-i', 'NONE', '-es', '-S', l:child], 'shellescape(v:val)'), ' '))
  call assert_equal(0, v:shell_error, 'unsupported disassembly returns promptly')
  unlet g:vimspector_session_windows
endfunction

function! s:DebuggerLayout() abort
  enew
  let g:vimspector_session_windows = {'code': win_getid()}
  nnoremenu WinBar.Test :echo 1<CR>
  for l:name in ['variables', 'watches', 'output', 'terminal']
    new
    let g:vimspector_session_windows[l:name] = win_getid()
    nnoremenu WinBar.Test :echo 1<CR>
  endfor
  let l:terminal_win = win_getid()
  call term_start('/bin/sh', {'curwin': 1, 'term_kill': 'term'})
  let l:terminal_buf = bufnr()
  doautocmd User VimspectorTerminalOpened
  call assert_true(win_id2win(l:terminal_win) > 0, 'terminal callback preserves adapter window')
  call assert_equal(l:terminal_win, g:vimspector_session_windows.terminal)
  call assert_equal(l:terminal_buf, winbufnr(l:terminal_win))
  call win_gotoid(g:vimspector_session_windows.code)
  let g:test_create_disassembly = 1
  call ShowAssembleCode()
  call assert_true(win_id2win(g:test_disassembly_win) > 0, 'disassembly preserves adapter window')
  call assert_equal(g:test_disassembly_win, win_getid(), 'disassembly receives focus')
  call assert_equal(g:test_disassembly_win, g:vimspector_session_windows.disassembly)
  call assert_match('Disassembly', execute('nmenu WinBar'), 'disassembly keeps window menu')
  let g:test_create_disassembly = 0
  unlet g:vimspector_session_windows
endfunction

function! s:LazyPlugins() abort
  let l:child = s:fixtures . '/visual-multi.vim'
  let l:result = s:fixtures . '/visual-multi.json'
  call writefile([
        \ 'set nocompatible noswapfile',
        \ 'source ' . fnameescape(s:vimrc),
        \ 'call timer_stopall()',
        \ 'call SetGeneralKeyMaps()',
        \ 'call ConfigureDelayedPlugin()',
        \ 'call ConfigureManualLoadPlugin()',
        \ 'autocmd! Local_Autocmd_Group',
        \ 'set clipboard=',
        \ 'call setline(1, "alpha beta alpha")',
        \ 'call cursor(1, 1)',
        \ 'call feedkeys("vll\<C-n>", "xt")',
        \ 'call writefile([json_encode(VMInfos().patterns)], ' . string(l:result) . ')',
        \ 'qa!',
        \ ], l:child)
  call system(join(map([exepath('vim'), '-Nu', 'NONE', '-n', '-i', 'NONE', '-es', '-S', l:child], 'shellescape(v:val)'), ' '))
  call assert_equal(0, v:shell_error, 'visual first-use child Vim')
  call assert_equal(['alp'], json_decode(join(readfile(l:result), "\n")), 'first visual Ctrl-N keeps selection')

  " Opening QuickUI must not reset menus after their initial configuration.
  call ConfigureQuickui()
  call quickui#menu#install('&Keep', [['Test', 'echo 1']])
  call ConfigureQuickui()
  call assert_notequal(v:null, quickui#menu#section('&Keep'), 'repeated configuration keeps existing menus')
  call QuickuiOpenMenu()
  call popup_clear()
  call assert_notequal(v:null, quickui#menu#section('&Keep'), 'opening keeps existing menus')
  for l:open in ['QuickuiListBuffer', 'QuickuiPreviewTag']
    call call(function(l:open), [])
    call popup_clear()
    call assert_notequal(v:null, quickui#menu#section('&Keep'), l:open . ' keeps existing menus')
  endfor
  for l:open in ['QuickuiOpenMenu', 'QuickuiListBuffer', 'QuickuiPreviewTag']
    unlet! g:quickui_keymap_groups
    call call(function(l:open), [])
    call popup_clear()
    call assert_true(exists('g:quickui_keymap_groups'), l:open . ' initializes menus')
  endfor

  " Catch the first Ctrl-N that replays itself before loading Visual Multi.
  enew
  call setline(1, 'alpha beta alpha')
  call cursor(1, 1)
  call MultipleCursors()
  if exists('g:loaded_visual_multi')
    call feedkeys('', 'xt')
    call assert_equal(1, VMInfos().total, 'first invocation selects one real region')
    VMClear
    call ConfigureManualLoadPlugin()
    call assert_equal('<Plug>(VM-Find-Under)', maparg('<C-n>', 'n'), 'reload preserves native multiple-cursor mapping')
  else
    call assert_report('first MultipleCursors invocation did not load Visual Multi')
    nnoremap <C-n> <Nop>
    call feedkeys('', 'x')
  endif
endfunction

function! s:CheatsheetCategories() abort
  call popup_clear()
  call QuickuiOpenKeyMapCheatsheet()
  let l:winid = popup_list()[0]
  try
    let l:names = map(copy(g:quickui_keymap_groups), {_, group -> group[0]})
    call assert_true(index(l:names, 'TigerVNC') >= 0, 'TigerVNC is included in the cheatsheet')
    call assert_equal(sort(copy(l:names)), l:names, 'categories remain alphabetical')
    " A new category must not leave the last category without a usable fold key.
    for [l:index, l:name] in items(l:names)
      let l:key = get(g:quickui_cheatsheet_toggle_keys, l:index, '?')
      call QuickuiKeyMapCheatsheetFilter(l:winid, l:key)
      call assert_false(g:quickui_cheatsheet_folded[l:name], l:name . ' unfolds with its key')
      call assert_true(index(getbufline(winbufnr(l:winid), 1, '$'),
            \ '[' . l:key . '] ' . l:name . ': [-]') >= 0, l:name . ' renders when unfolded')
      call QuickuiKeyMapCheatsheetFilter(l:winid, l:key)
      call assert_true(g:quickui_cheatsheet_folded[l:name], l:name . ' folds with the same key')
    endfor
  finally
    call popup_clear()
  endtry
endfunction

function! s:CheatsheetWidths() abort
  let l:saved = [&ambiwidth, &listchars, &fillchars]
  try
    set listchars= fillchars= ambiwidth=single
    for [l:text, l:width, l:expected] in [
          \ ['abcdef', 4, 'abc…'], ['中文名', 5, '中文…'],
          \ ["e\u0301xyz", 3, "e\u0301x…"], ['中', 2, '中'],
          \ ['abcdef', 1, '…'], ['abc', 0, ''], ['abc', -1, '']]
      call assert_equal(l:expected, QuickuiCheatsheetTruncate(l:text, l:width),
            \ 'truncate by display columns, preserving combining characters')
    endfor
    let l:line = QuickuiCheatsheetKeyMapLine(['中', 'desc', 'n'], 26)
    call assert_equal(16, strdisplaywidth(strpart(l:line, 0, stridx(l:line, 'desc'))),
          \ 'description starts after the full key column')
    let l:group = QuickuiCheatsheetGroup(['Test',
          \ [['中', '左', 'n'], ['right', '右', 'n']]], 62, '1')
    call assert_equal(34, strdisplaywidth(strpart(l:group[2], 0, stridx(l:group[2], 'right'))),
          \ 'second mapping stays aligned after wide text')
    set ambiwidth=double
    for [l:width, l:expected] in [[1, ''], [2, '…'], [4, '中…']]
      call assert_equal(l:expected, QuickuiCheatsheetTruncate('中文名', l:width),
            \ 'reserve the actual display width of the ellipsis')
    endfor
  finally
    let [&ambiwidth, &listchars, &fillchars] = l:saved
  endtry
endfunction

function! s:NativeHelpers() abort
  " With gdefault, explicit /g would leave repeated unwanted characters behind.
  enew
  set gdefault
  setlocal expandtab tabstop=4
  call setline(1, ["a\r\rb\u200b\u200bc   ", "\talpha\tbeta  ", 'plain'])
  call cursor(1, 1)
  call RetabAndDeleteTraillingUselessChars()
  call assert_equal(['abc', '    alpha   beta', 'plain'], getline(1, '$'),
        \ 'cleanup removes every CR and zero-width space, expands tabs and trims whitespace')

  " Catch byte slicing and ignored line/block/exclusive selection modes.
  enew
  call setline(1, ['αβγ', 'abcde'])
  normal! v
  execute "normal! \<Esc>"
  call setpos("'<", [0, 1, 3, 0])
  call setpos("'>", [0, 1, 3, 0])
  set selection=inclusive
  call assert_equal('β', GetSelectedContent(), 'whole multibyte character')
  call setpos("'>", [0, 1, 5, 0])
  set selection=exclusive
  call assert_equal('β', GetSelectedContent(), 'exclusive character selection')
  normal! V
  execute "normal! \<Esc>"
  call setpos("'<", [0, 1, 3, 0])
  call setpos("'>", [0, 2, 2, 0])
  call assert_equal('αβγ abcde', GetSelectedContent(), 'complete linewise selection')
  call setline(1, ['abcde', 'ABCDE'])
  execute "normal! \<C-v>\<Esc>"
  call setpos("'<", [0, 1, 2, 0])
  call setpos("'>", [0, 2, 4, 0])
  set selection=inclusive
  call assert_equal('bcd BCD', GetSelectedContent(), 'rectangular selection')
  set selection=exclusive
  call assert_equal('bc BC', GetSelectedContent(), 'exclusive rectangular selection')
  set selection=inclusive

  " Catch directory shortcuts that compare roots rather than target paths.
  let l:root = s:fixtures . '/project | space'
  call mkdir(l:root . '/.git', 'p')
  call mkdir(l:root . '/src', 'p')
  call writefile(['print("test")'], l:root . '/src/main.py')
  execute 'edit! ' . fnameescape(l:root . '/src/main.py')
  execute 'lcd ' . fnameescape(l:root)
  call EnterIntoWorkspaceOrFilePath(0)
  call assert_equal(l:root . '/src', getcwd(), 'enter file directory inside same workspace')
  call EnterIntoWorkspaceOrFilePath()
  call assert_equal(l:root, getcwd(), 'enter workspace root from a subdirectory')
  " Workspace navigation must not overwrite Insert-mode redo.
  for l:mode in ['n', 'i', 't']
    call assert_match('EnterIntoWorkspaceOrFilePath()', maparg('<M-s>', l:mode),
          \ 'Alt-S enters the workspace in mode ' . l:mode)
  endfor
  call assert_equal('<C-O><C-R>', maparg('<M-r>', 'i'), 'Alt-R keeps Insert-mode redo')
  call EnterIntoWorkspaceOrFilePath(0)
  call feedkeys("\<M-s>", 'xt')
  call assert_equal(l:root, getcwd(), 'Alt-S actually enters the workspace')
  call NewTab('empty_tab')
  call assert_equal(l:root . '/src', getcwd(), 'new tab inherits launch directory with special characters')
  call CloseAndBackTab()

  " A closer low-priority marker must not change existing Git-root priority.
  call writefile([''], l:root . '/src/.root')
  call assert_equal(l:root, WorkspaceRoot(l:root . '/src'))
  " Auxiliary buffers use the source window; ordinary splits keep their focus.
  let l:source_win = win_getid()
  for l:filetype in ['help', 'VimspectorPrompt', 'vista', 'nerdtree', 'python']
    belowright new
    let &l:filetype = l:filetype
    if l:filetype ==# 'python'
      setlocal buftype=nofile
    endif
    let l:aux_win = win_getid()
    call assert_equal(l:root, WorkspaceRoot(), l:filetype . ' uses source workspace')
    call assert_equal(l:source_win, win_getid(), l:filetype . ' restores source focus')
    call win_execute(l:aux_win, 'close')
  endfor
  belowright split
  let l:ordinary_win = win_getid()
  call assert_equal(l:root, WorkspaceRoot())
  call assert_equal(l:ordinary_win, win_getid(), 'ordinary source split keeps focus')
  close
  execute 'lcd ' . fnameescape(s:repo)
endfunction

function! CaptureAsyncRun(opts) abort
  let g:build_command = a:opts.cmd
endfunction

function! s:AsyncRunPaths() abort
  " Keep the real Ex/AsyncRun parser; capture only its process-launch boundary.
  let g:asyncrun_mode = 10
  let g:asyncrun_hook = 'CaptureAsyncRun'
  let l:file = s:fixtures . "/main ' % # $ ( ) |.py"
  call writefile(['print("PATH PASS")'], l:file)
  execute 'edit ' . fnameescape(l:file)
  setlocal filetype=python
  call CompileAndExcute()
  let l:output = system(g:build_command)
  call assert_equal(0, v:shell_error, 'real AsyncRun handles special filenames')
  call assert_equal("PATH PASS\n", l:output)
  unlet g:asyncrun_mode g:asyncrun_hook
endfunction

function! s:BuildCommands() abort
  " Capture the external AsyncRun boundary instead of launching compilers.
  command! -bang -nargs=* AsyncRun let g:build_command = <q-args>
  let l:root = s:fixtures . '/build project'
  call mkdir(l:root . '/.git', 'p')
  call mkdir(l:root . '/src', 'p')
  call writefile(['module main; endmodule'], l:root . '/src/main.v')
  execute 'edit ' . fnameescape(l:root . '/src/main.v')
  setlocal filetype=verilog
  let g:build_command = ''
  try
    call CompileCommand()
  catch
    call assert_report('compile-only Verilog: ' . v:exception)
  endtry
  if !empty(g:build_command)
    call assert_match('cd ' . escape(shellescape(l:root . '/src'), '\.^$~[]*') . ' && iverilog', g:build_command, 'valid Verilog command after cd')
    call assert_match('&& vvp', g:build_command)
    call assert_match('JumpToTerm(1)', g:build_command, 'compile-only terminal behavior')
  endif

  call writefile(['int main() { return 0; }'], l:root . '/src/main.cpp')
  execute 'edit ' . fnameescape(l:root . '/src/main.cpp')
  setlocal filetype=cpp
  for [l:marker, l:want] in [['CMakeLists.txt', 'cmake'], ['app.pro', 'qmake'], ['Makefile', 'make'], ['SConstruct', 'scons']]
    call writefile([''], l:root . '/' . l:marker)
    call assert_match('cd ' . escape(shellescape(l:root), '\.^$~[]*') . ' &&', CPPCompilation(), 'quoted build root')
    call assert_match(l:want, CPPCompilation(), l:marker . ' selects its build tool')
    call delete(l:root . '/' . l:marker)
  endfor
  call writefile([''], l:root . '/Makefile')
  call writefile([''], l:root . '/src/CMakeLists.txt')
  call assert_match('bear --append -- make -j12', CPPCompilation(), 'root build wins over nested build')
  call delete(l:root . '/Makefile')
  call delete(l:root . '/src/CMakeLists.txt')
  call writefile(['int main() { return 0; }'], l:root . '/src/main file.cpp')
  execute 'edit ' . fnameescape(l:root . '/src/main file.cpp')
  call assert_match("'main file.cpp' -o 'main file.exe'", CPPCompilation(), 'quoted single-file compiler arguments')
  call CompileAndExcute()
  call assert_match("&& '\./main file.exe'", g:build_command, 'quoted compiled-program invocation')
endfunction

try
  for s:check in ['TerminalTabs', 'QuitPreservesSource', 'CancelledQuit', 'DebuggerCommands', 'DebuggerLayout', 'LazyPlugins', 'CheatsheetCategories', 'CheatsheetWidths', 'NativeHelpers', 'AsyncRunPaths', 'BuildCommands']
    try
      call call(function('s:' . s:check), [])
    catch
      call assert_report(s:check . ': ' . v:exception . ' at ' . v:throwpoint)
    finally
      silent! tabonly!
      silent! %bwipeout!
    endtry
  endfor
finally
  call delete(s:fixtures, 'rf')
endtry
if !empty(v:errors)
  call writefile(v:errors, '/dev/stdout')
  cquit
endif
call writefile(['PASS: Vimrc terminals, quitting, debugger, plugins, selections, directories and builds'], '/dev/stdout')
qa!
