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
        \ 'function! vimspector#LaunchWithSettings(settings) abort',
        \ '  call add(g:launch_settings, a:settings)',
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
        \ ['StopAllThreads', [], '-exec interrupt -a']]
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

function! s:DebuggerLaunch() abort
  " Capture the adapter launch while exercising real JSON mode selection.
  let l:root = s:fixtures . '/debug launch'
  call mkdir(l:root . '/.git', 'p')
  call writefile(['# launch fixture'], l:root . '/main.py')
  execute 'edit ' . fnameescape(l:root . '/main.py')
  for [l:filetype, l:module, l:enabled, l:want] in [
        \ ['python', '', v:true, 'python: single-file'],
        \ ['python', 'package.main', v:false, 'python: single-file'],
        \ ['python', 'package.main', v:true, 'python: project'],
        \ ['tcl', '', v:false, 'tcl: launch'],
        \ ['c', '', v:false, 'cpp: launch'],
        \ ['cpp', '', v:false, 'cpp: launch'],
        \ ['cuda', '', v:false, '']]
    call writefile([json_encode({'configurations': {
          \ 'python: project': {'configuration': {
          \ 'module': l:module, 'enable_project_debug': l:enabled}},
          \ 'python: single-file': {}}})], l:root . '/.vimspector.json')
    let &l:filetype = l:filetype
    let g:launch_settings = []
    call LaunchVimspector()
    call assert_equal(empty(l:want) ? [] : [{'configuration': l:want, 'Test': l:want}],
          \ g:launch_settings, l:filetype . ' launches the selected debug configuration once')
  endfor
  unlet g:launch_settings
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

function! s:DebuggerWindowClosing() abort
  " Catch reversed closing order, absent/stale IDs, and crossing tab boundaries.
  enew
  let l:source = win_getid()
  unlet! g:vimspector_session_windows
  call QuitVimspectorWins()
  let g:vimspector_session_windows = {'disassembly': -1, 'terminal': -1}
  call QuitVimspectorWins()
  call assert_equal(l:source, win_getid(), 'missing and stale debugger windows leave focus unchanged')
  new
  let l:disassembly = win_getid()
  new
  let l:terminal = win_getid()
  let g:vimspector_session_windows = {'disassembly': l:disassembly, 'terminal': l:terminal}
  let g:test_closed_debugger_windows = []
  augroup Test_Debugger_Window_Closing
    autocmd!
    autocmd WinClosed * call add(g:test_closed_debugger_windows, str2nr(expand('<afile>')))
  augroup END
  try
    call QuitVimspectorWins()
    call assert_equal([l:disassembly, l:terminal], g:test_closed_debugger_windows,
          \ 'disassembly closes before terminal')
    call assert_equal(l:source, win_getid(), 'source window remains open')

    " Closing disassembly can update the adapter's terminal window reference.
    new
    let l:disassembly = win_getid()
    new
    let l:terminal = win_getid()
    let g:vimspector_session_windows = {'disassembly': l:disassembly}
    execute 'autocmd Test_Debugger_Window_Closing WinClosed ' . l:disassembly
          \ . ' let g:vimspector_session_windows.terminal = ' . l:terminal
    let g:test_closed_debugger_windows = []
    call QuitVimspectorWins()
    call assert_equal([l:disassembly, l:terminal], g:test_closed_debugger_windows,
          \ 'terminal reference is read after disassembly closes')

    " Debugger windows must also close when invoked from another tab.
    tabnew
    let l:other_tab_window = win_getid()
    let g:vimspector_session_windows = {'terminal': l:other_tab_window}
    call win_gotoid(l:source)
    call QuitVimspectorWins()
    call assert_equal([0, 0], win_id2tabwin(l:other_tab_window),
          \ 'debugger window in another tab closes')
    call assert_equal(l:source, win_getid(), 'closing the debugger tab returns to source')
  finally
    autocmd! Test_Debugger_Window_Closing
    unlet! g:vimspector_session_windows g:test_closed_debugger_windows
  endtry
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
  let g:quickui_cheatsheet_folded = {'obsolete': 1}
  call QuickuiOpenKeyMapCheatsheet()
  call assert_false(has_key(g:quickui_cheatsheet_folded, 'obsolete'), 'opening resets old fold state')
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
    call QuickuiKeyMapCheatsheetFilter(l:winid, 'r')
    let g:quickui_cheatsheet_folded.obsolete = 0
    let l:folded = g:quickui_cheatsheet_folded
    call QuickuiKeyMapCheatsheetFilter(l:winid, 'z')
    call assert_true(l:folded is g:quickui_cheatsheet_folded, 'fold all updates the existing dictionary')
    call assert_equal(0, get(l:folded, 'obsolete', -1), 'fold all preserves unrelated entries')
    for l:name in l:names
      call assert_equal(1, get(l:folded, l:name, 0), l:name . ' folds with z')
    endfor
  finally
    call popup_clear()
  endtry
endfunction

function! s:CheatsheetSearch() abort
  call QuickuiOpenKeyMapCheatsheet()
  let l:winid = popup_list()[0]
  try
    for l:direction in ['/', '?']
      call QuickuiStartKeyMapCheatsheetSearch(l:winid, l:direction)
      let g:quickui_cheatsheet_search_input = 'TigerVNC'
      call QuickuiKeyMapCheatsheetFilter(l:winid, "\<CR>")
      let l:lines = getbufline(winbufnr(l:winid), 1, '$')
      let l:matches = filter(range(1, len(l:lines)), {_, n -> l:lines[n - 1] =~# 'TigerVNC'})
      call assert_false(g:quickui_cheatsheet_search_active, 'Enter closes search input')
      call assert_notmatch('^Search ', l:lines[0], 'Enter redraws normal instructions')
      call assert_equal('TigerVNC', g:quickui_cheatsheet_search_pattern)
      call quickui#core#win_execute(l:winid, 'let g:test_cheatsheet_line = line(".")')
      call assert_equal(l:direction ==# '/' ? l:matches[0] : l:matches[-1],
            \ g:test_cheatsheet_line, 'search begins at the correct end of refreshed text')
    endfor
    for l:key in ["\<BS>", "\<C-H>"]
      for [l:input, l:want] in [['', ''], ['a', ''], ['abc', 'ab'],
            \ ['中文', '中'], ["e\u0301", 'e']]
        call QuickuiStartKeyMapCheatsheetSearch(l:winid, '/')
        let g:quickui_cheatsheet_search_input = l:input
        call QuickuiKeyMapCheatsheetFilter(l:winid, l:key)
        call assert_equal(l:want, g:quickui_cheatsheet_search_input,
              \ 'Backspace removes one Unicode character, including on empty input')
        call assert_true(g:quickui_cheatsheet_search_active, 'Backspace keeps search input open')
      endfor
    endfor
    call QuickuiStartKeyMapCheatsheetSearch(l:winid, '/')
    call QuickuiKeyMapCheatsheetFilter(l:winid, "\<CR>")
    call assert_false(g:quickui_cheatsheet_search_active, 'empty Enter closes search input')
    call assert_equal('TigerVNC', g:quickui_cheatsheet_search_pattern, 'empty input keeps the previous pattern')
  finally
    call popup_clear()
    unlet! g:test_cheatsheet_line
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

function! s:CodeBlockNames() abort
  " Catch inverted matching or changed backward searches when reusing the line.
  enew
  let l:lines = ['# heading', 'def First():', '  pass', 'def Second():', '  pass']
  call setline(1, l:lines)
  for [l:line, l:want] in [[1, 'def -->'], [2, 'def --> First'],
        \ [3, 'def --> First'], [4, 'def --> Second'], [5, 'def --> Second']]
    call cursor(l:line, 3)
    let l:position = getpos('.')
    call assert_equal(l:want,
          \ trim(execute("call ShowCurrentCodeBlockName('^def\\s\\+', 'def', '(')")),
          \ 'code-block name comes from the current or nearest preceding definition')
    call assert_equal(l:position, getpos('.'), 'code-block lookup leaves the cursor in place')
  endfor
  call assert_equal(l:lines, getline(1, '$'), 'code-block lookup preserves the buffer')
endfunction

function! s:CodeBlockFiletypes() abort
  " Catch delimiter changes when combining filetype selection branches.
  let l:ignorecase = &ignorecase
  try
    for [l:kind, l:type, l:extension, l:text, l:want] in [
          \ ['Func', 'tcl', 'tcl', 'proc Work {', 'proc --> Work'],
          \ ['Func', 'tcl', 'pdl', 'iProc Work {', 'iProc --> Work'],
          \ ['Func', 'perl', 'pl', 'sub Work {', 'sub --> Work'],
          \ ['Func', 'python', 'py', 'def Work():', 'def --> Work()'],
          \ ['Func', 'make', 'mk', 'define Work', 'define --> Work'],
          \ ['Func', 'vim', 'vim', 'function! Work()', 'function --> Work()'],
          \ ['Func', 'verilog', 'v', 'module Work(input x);', 'module --> Work'],
          \ ['Func', 'icl', 'icl', 'module Work(input x) {', 'module --> Work(input x)'],
          \ ['NoneFunc', 'tcl', 'tcl', 'namespace eval Space {', 'namespace eval --> Space'],
          \ ['NoneFunc', 'perl', 'pl', 'package Space {', 'package --> Space'],
          \ ['NoneFunc', 'python', 'py', 'class Space:', 'class --> Space']]
      for [l:case, l:filetype] in [[0, l:type], [1, l:type], [1, toupper(l:type)]]
        enew!
        execute 'file ' . fnameescape(s:fixtures . '/block.' . l:extension)
        let &ignorecase = l:case
        let &l:filetype = l:filetype
        call setline(1, l:text)
        call cursor(1, 1)
        call assert_equal(l:want, trim(execute('call ShowCurrent' . l:kind . 'CodeBlockName()')),
              \ l:filetype . ' keeps its pattern, label and delimiter')
        bwipeout!
      endfor
    endfor
  finally
    let &ignorecase = l:ignorecase
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

  " A nearer marker wins even when a distant marker has higher priority.
  call writefile([''], l:root . '/src/.root')
  call assert_equal(l:root . '/src', WorkspaceRoot(l:root . '/src'),
        \ 'marker in the starting directory wins over parent Git root')
  call mkdir(l:root . '/src/nested', 'p')
  call assert_equal(l:root . '/src', WorkspaceRoot(l:root . '/src/nested'),
        \ 'nearest ancestor marker wins over parent Git root')
  call writefile(['gitdir: elsewhere'], l:root . '/src/.git')
  call assert_equal(l:root . '/src/.git', FindRootPatternPath(l:root . '/src/nested'),
        \ 'pattern order breaks ties in the nearest marked directory')
  call delete(l:root . '/src/.git')
  call delete(l:root . '/src/.root')
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

function! s:InterpreterCommands() abort
  " Keep AsyncRun's parser; capture its process boundary without launching interpreters.
  let g:asyncrun_mode = 10
  let g:asyncrun_hook = 'CaptureAsyncRun'
  let l:ignorecase = &ignorecase
  try
    for [l:filetype, l:interpreter] in [
          \ ['python', 'python3'], ['sh', 'sh'], ['csh', 'csh'],
          \ ['perl', 'perl'], ['tcl', 'tclsh']]
      let l:file = s:fixtures . "/script ' % # $ ( ) |." . l:filetype
      call writefile(['# interpreter fixture'], l:file)
      execute 'edit ' . fnameescape(l:file)
      let &l:filetype = l:filetype
      let g:build_command = ''
      call CompileAndExcute()
      call assert_equal('/usr/bin/env ' . l:interpreter . ' ' . shellescape(l:file),
            \ trim(g:build_command), l:filetype . ' keeps interpreter and quoted filename')
    endfor

    " SCons exceptions apply to Python, while the original comparisons honor ignorecase.
    let l:root = s:fixtures . '/scons project'
    call mkdir(l:root . '/.git', 'p')
    call writefile(['# scons fixture'], l:root . '/SConstruct')
    for l:name in ['SConstruct', 'SConscript', 'sconstruct']
      let l:file = l:root . '/' . l:name
      call writefile(['# scons fixture'], l:file)
      execute 'edit ' . fnameescape(l:file)
      setlocal filetype=python
      set ignorecase
      let g:build_command = ''
      call CompileAndExcute()
      call assert_match('bear --append -- scons -j12', g:build_command, l:name . ' uses SCons')
      setlocal filetype=sh
      call CompileAndExcute()
      call assert_equal('/usr/bin/env sh ' . shellescape(l:file), trim(g:build_command),
            \ 'SCons filename does not override another interpreter')
    endfor

    execute 'edit ' . fnameescape(s:fixtures . '/main.py')
    let &l:filetype = 'Python'
    for l:ignore in [0, 1]
      let &ignorecase = l:ignore
      let g:build_command = ''
      call CompileAndExcute()
      call assert_equal(l:ignore ? '/usr/bin/env python3 ' . shellescape(s:fixtures . '/main.py') : '',
            \ trim(g:build_command), 'filetype comparisons honor ignorecase')
    endfor
  finally
    let &ignorecase = l:ignorecase
    unlet g:asyncrun_mode g:asyncrun_hook
  endtry
endfunction

function! s:BuildCommands() abort
  " Capture the external AsyncRun boundary instead of launching compilers.
  command! -bang -nargs=* AsyncRun let g:build_command = <q-args>
  let l:root = s:fixtures . '/build [one] project'
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
  for [l:marker, l:want] in [['CMakeLists.txt', 'cmake'], ['app.pro', 'qmake'], ['Makefile', 'make'], ['makefile', 'make'], ['GNUmakefile', 'make'], ['SConstruct', 'scons']]
    call writefile([''], l:root . '/' . l:marker)
    let l:info = {}
    let l:command = CPPCompilation(l:info)
    call assert_match('cd ' . escape(shellescape(l:root), '\.^$~[]*') . ' &&', l:command, 'quoted build root')
    call assert_match(l:want, l:command, l:marker . ' selects its build tool')
    call assert_equal(1, l:info.project, l:marker . ' selects project execution')
    if l:marker ==# 'CMakeLists.txt'
      call assert_match('bear --append -- cmake --build build --parallel 12', l:command,
            \ 'CMake delegates to its generator while retaining Bear capture')
    endif
    call delete(l:root . '/' . l:marker)
  endfor
  call writefile([''], l:root . '/Makefile')
  call writefile([''], l:root . '/src/CMakeLists.txt')
  call assert_match('bear --append -- make -j12', CPPCompilation(), 'root build wins over nested build')
  call delete(l:root . '/Makefile')
  call delete(l:root . '/src/CMakeLists.txt')
  " Parent build files still win over deeper files when the root has none.
  let l:deep = l:root . '/src/nested/deep'
  call mkdir(l:deep, 'p')
  call writefile(['int main() { return 0; }'], l:deep . '/main.cpp')
  execute 'edit ' . fnameescape(l:deep . '/main.cpp')
  call assert_equal(l:root, WorkspaceRoot(), 'deep source keeps its workspace root')
  call writefile([''], l:root . '/src/Makefile')
  call writefile([''], l:deep . '/CMakeLists.txt')
  call assert_match('cd ' . escape(shellescape(l:root . '/src'), '\.^$~[]*') . ' && bear',
        \ CPPCompilation(), 'parent build wins over deeper CMake build')
  call delete(l:root . '/src/Makefile')
  call assert_match('cd ' . escape(shellescape(l:deep), '\.^$~[]*') . ' && cmake',
        \ CPPCompilation(), 'source directory is included in build discovery')
  call delete(l:deep . '/CMakeLists.txt')
  call writefile(['int main() { return 0; }'], l:root . '/src/main file.cpp')
  execute 'edit ' . fnameescape(l:root . '/src/main file.cpp')
  call assert_match("'main file.cpp' -o 'main file.exe'", CPPCompilation(), 'quoted single-file compiler arguments')
  call CompileAndExcute()
  call assert_match("&& '\./main file.exe'", g:build_command, 'quoted compiled-program invocation')
  for [l:filetype, l:extension, l:want] in [
        \ ['c', 'c', 'gcc -fsanitize=address,undefined,leak -g -pedantic-errors'
        \ . " -Wall -Wextra -Wconversion -Wsign-conversion -Wshadow 'main file.c' -o 'main file.exe'"],
        \ ['cuda', 'cu', "nvcc -g 'main file.cu' -o 'main file.exe'"],
        \ ['verilog', 'v', "iverilog *.v -o 'main file.out' && vvp 'main file.out'"]]
    let l:file = l:root . '/src/main file.' . l:extension
    call writefile([''], l:file)
    execute 'edit ' . fnameescape(l:file)
    let &l:filetype = l:filetype
    call assert_equal(' cd ' . shellescape(l:root . '/src') . ' && ' . l:want,
          \ CPPCompilation(), l:filetype . ' keeps its compiler and quoted output')
    if l:filetype ==# 'cuda'
      let g:build_command = ''
      call CompileCommand()
      call assert_match("nvcc -g 'main file.cu' -o 'main file.exe'", g:build_command,
            \ 'compile-only submits the standalone CUDA command')
      call assert_match('JumpToTerm(1)', g:build_command, 'CUDA compile-only terminal behavior')
      call assert_notmatch("&& '\./main file.exe'", g:build_command, 'compile-only does not run CUDA output')
    endif
  endfor
endfunction

function! s:BuildRoutingIgnoresFilenames() abort
  " Keep real AsyncRun parsing, replacing only the external compiler process.
  command! -bang -nargs=+ -range=0 -complete=file AsyncRun
        \ call asyncrun#run('<bang>', '', <q-args>, <count>, <line1>, <line2>)
  let g:asyncrun_mode = 10
  let g:asyncrun_hook = 'CaptureAsyncRun'
  let l:saved_path = $PATH
  let l:bin = s:fixtures . '/routing-bin'
  call mkdir(l:bin)
  call writefile(['#!/bin/sh', 'printf "#!/bin/sh\necho NEW_PROGRAM\n" > main.exe',
        \ 'chmod +x main.exe'], l:bin . '/gcc')
  call setfperm(l:bin . '/gcc', 'rwx------')
  let $PATH = l:bin . ':' . $PATH
  try
    " The second path also defeats searching for a longer command substring.
    for l:name in ['bear-project', 'project && bear --append -- make']
      let l:root = s:fixtures . '/' . l:name
      call mkdir(l:root . '/.git', 'p')
      call mkdir(l:root . '/build')
      call writefile(['int main(void) { return 0; }'], l:root . '/main.c')
      call writefile(['#!/bin/sh', 'echo STALE_PROGRAM'], l:root . '/build/main.exe')
      call setfperm(l:root . '/build/main.exe', 'rwx------')
      execute 'edit ' . fnameescape(l:root . '/main.c')
      setlocal filetype=c
      call CompileAndExcute()
      let l:output = system(g:build_command)
      call assert_equal(0, v:shell_error, 'successful compiler fixture')
      call assert_equal("NEW_PROGRAM\n", l:output, 'run the new single-file executable: ' . l:name)
      call writefile([''], l:root . '/main.h')
      execute 'edit ' . fnameescape(l:root . '/main.h')
      setlocal filetype=c
      let g:build_command = ''
      call CompileCommand()
      call assert_equal('', g:build_command, 'a path containing bear must not enable standalone header compilation')
      call writefile([''], l:root . '/Makefile')
      call CompileCommand()
      call assert_match('bear --append -- make -j12', g:build_command,
            \ 'a real project build still compiles from a header')
    endfor
  finally
    let $PATH = l:saved_path
    unlet g:asyncrun_mode g:asyncrun_hook
  endtry
endfunction

function! s:ProjectExecutableLocations() abort
  " Run the generated shell branch: catch missing locations, quoting and .exe precedence.
  command! -bang -nargs=* AsyncRun let g:build_command = <q-args>
  let l:root = s:fixtures . '/run [one] project'
  call mkdir(l:root . '/.git', 'p')
  call mkdir(l:root . '/build', 'p')
  call mkdir(l:root . '/src', 'p')
  call writefile([''], l:root . '/Makefile')
  call writefile(['int main(void) { return 0; }'], l:root . '/src/main file.c')
  execute 'edit ' . fnameescape(l:root . '/src/main file.c')
  call CompileAndExcute()
  let l:run = strpart(g:build_command, stridx(g:build_command, ' && if ') + 4)
  let l:shells = ['/bin/sh'] + (executable('zsh') ? [exepath('zsh')] : [])
  for l:location in ['build/', '', 'src/']
    let l:native = l:root . '/' . l:location . 'main file'
    call writefile(['#!/bin/sh', 'echo NATIVE_PROGRAM'], l:native)
    call setfperm(l:native, 'rwx------')
    for l:exe in [0, 1]
      if l:exe
        call writefile(['#!/bin/sh', 'echo EXE_PROGRAM'], l:root . '/main file.exe')
        call setfperm(l:root . '/main file.exe', 'rwx------')
      endif
      for l:shell in l:shells
        let l:output = system(shellescape(l:shell) . ' -c '
              \ . shellescape('cd ' . shellescape(l:root) . ' && ' . l:run))
        call assert_equal(0, v:shell_error, l:location . ' execution with ' . l:shell)
        call assert_equal(l:exe ? "EXE_PROGRAM\n" : "NATIVE_PROGRAM\n", l:output,
              \ 'named .exe priority and extensionless fallback: ' . l:location)
      endfor
    endfor
    call delete(l:native)
    call delete(l:root . '/main file.exe')
  endfor
endfunction

function! s:ProjectBuilds() abort
  " Catch generator mismatches and skipped GNUmakefiles with real builds and LSP databases.
  for l:tool in ['cmake', 'ninja', 'make', 'gcc', 'bear']
    if !executable(l:tool)
      call writefile(['SKIP: project integration builds require ' . l:tool], '/dev/stdout')
      return
    endif
  endfor
  for l:generator in ['Ninja', 'Unix Makefiles', 'GNUmakefile']
    let l:root = s:fixtures . '/project ' . l:generator
    call mkdir(l:root . '/.git', 'p')
    call writefile(['#ifndef PROJECT_BUILD', '#error Missing project flags', '#endif',
          \ 'int main(void) { return 0; }'], l:root . '/main.c')
    if l:generator ==# 'GNUmakefile'
      call writefile(['all:', "\tgcc -DPROJECT_BUILD main.c -o main.exe"], l:root . '/GNUmakefile')
    else
      call writefile(['cmake_minimum_required(VERSION 3.16)', 'project(Audit C)',
            \ 'add_executable(main main.c)', 'target_compile_definitions(main PRIVATE PROJECT_BUILD)'],
            \ l:root . '/CMakeLists.txt')
    endif
    execute 'edit ' . fnameescape(l:root . '/main.c')
    let l:command = CPPCompilation()
    if l:generator !=# 'GNUmakefile'
      " Set the generator only for this subprocess; leave the test environment intact.
      let l:command = 'export CMAKE_GENERATOR=' . shellescape(l:generator) . '; ' . l:command
    endif
    let l:output = system(l:command)
    call assert_equal(0, v:shell_error, l:generator . ' builds with project flags: ' . l:output)
    " Execute the real run branch after the build, including extensionless CMake outputs.
    command! -bang -nargs=* AsyncRun let g:build_command = <q-args>
    call CompileAndExcute()
    let l:run = strpart(g:build_command, stridx(g:build_command, ' && if ') + 4)
    let l:output = system('cd ' . shellescape(l:root) . ' && ' . l:run)
    call assert_equal(0, v:shell_error, l:generator . ' executes the built program: ' . l:output)
    let l:database = l:root . '/compile_commands.json'
    call assert_true(filereadable(l:database), l:generator . ' creates the LSP database at the root')
    if filereadable(l:database)
      let l:entries = json_decode(join(readfile(l:database), "\n"))
      call assert_false(empty(filter(l:entries,
            \ {_, entry -> fnamemodify(entry.file, ':t') ==# 'main.c'})),
            \ l:generator . ' records the source compilation')
    endif
  endfor
endfunction

function! s:SystemVerilogBuild() abort
  command! -bang -nargs=* AsyncRun let g:build_command = <q-args>
  let l:root = s:fixtures . '/systemverilog [one] project'
  call mkdir(l:root . '/.git', 'p')
  let l:source = l:root . '/top file.sv'
  call writefile(['module top;', 'initial begin',
        \ 'string message;', 'message = "SV PASS";', '$display("%s", message);',
        \ 'end', 'endmodule'], l:source)
  execute 'edit ' . fnameescape(l:source)
  setlocal filetype=systemverilog
  for l:mixed in [0, 1]
    if l:mixed
      call writefile(['module helper;', 'initial $display("V PASS");', 'endmodule'],
            \ l:root . '/helper file.v')
    endif
    let l:command = CPPCompilation()
    call assert_match('iverilog -g2012 ', l:command, 'enable SystemVerilog syntax')
    call assert_true(stridx(l:command, shellescape(l:source, 1)) >= 0,
          \ 'compile the SystemVerilog source with its spaced filename')
    let g:build_command = ''
    call CompileCommand()
    call assert_match('iverilog -g2012 ', g:build_command, 'compile shortcut runs SystemVerilog')
    call assert_match('JumpToTerm(1)', g:build_command, 'compile shortcut keeps terminal behavior')
    let g:build_command = ''
    call CompileAndExcute()
    call assert_match('iverilog -g2012 ', g:build_command, 'run shortcut runs SystemVerilog')
    call assert_match("&& gtkwave 'top file.vcd'", g:build_command, 'run shortcut opens its waveform')
    if executable('iverilog') && executable('vvp')
      let l:output = system(l:command)
      call assert_equal(0, v:shell_error, 'compile and run SystemVerilog: ' . l:output)
      call assert_equal(l:mixed ? ['SV PASS', 'V PASS'] : ['SV PASS'],
            \ sort(split(l:output, "\n")), 'SV-only and mixed-language sources run')
    endif
  endfor
  " AsyncRun saves the buffer after CPPCompilation() constructs its command.
  let l:unsaved = l:root . '/new file.sv'
  execute 'edit ' . fnameescape(l:unsaved)
  call setline(1, ['module unsaved;', 'initial $display("NEW PASS");', 'endmodule'])
  let l:command = CPPCompilation()
  call assert_true(stridx(l:command, shellescape(l:unsaved, 1)) >= 0,
        \ 'include the new source before AsyncRun saves it')
  write
  if executable('iverilog') && executable('vvp')
    let l:output = system(l:command)
    call assert_equal(0, v:shell_error, 'compile the newly saved source: ' . l:output)
    call assert_equal(['NEW PASS', 'SV PASS', 'V PASS'], sort(split(l:output, "\n")))
  endif
endfunction

try
  for s:check in ['TerminalTabs', 'QuitPreservesSource', 'CancelledQuit', 'DebuggerCommands', 'DebuggerLaunch', 'DebuggerLayout', 'DebuggerWindowClosing', 'LazyPlugins', 'CheatsheetCategories', 'CheatsheetSearch', 'CheatsheetWidths', 'CodeBlockNames', 'CodeBlockFiletypes', 'NativeHelpers', 'AsyncRunPaths', 'InterpreterCommands', 'BuildCommands', 'BuildRoutingIgnoresFilenames', 'ProjectExecutableLocations', 'ProjectBuilds', 'SystemVerilogBuild']
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
