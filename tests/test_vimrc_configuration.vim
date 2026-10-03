" Run: vim -Nu NONE -n -i NONE -es -S tests/test_vimrc_configuration.vim
set nocompatible noswapfile
let s:repo = expand('<sfile>:p:h:h')
execute 'source ' . fnameescape(get(g:, 'vimrc_under_test', s:repo . '/.vimrc'))
call timer_stopall()
" Plugin helpers become available in their owning configuration phase.
let s:vimrc_sid = filter(getscriptinfo(),
      \ {_, script -> script.name ==# fnamemodify(get(g:, 'vimrc_under_test', s:repo . '/.vimrc'), ':p')})[0].sid
for s:helper in ['ConfigureMarkdownPlugin', 'ConfigureWhichKey',
      \ '<SNR>' . s:vimrc_sid . '_ShortcutGroups',
      \ '<SNR>' . s:vimrc_sid . '_WhichKeyMap',
      \ '<SNR>' . s:vimrc_sid . '_ShowVisualWhichKey',
      \ '<SNR>' . s:vimrc_sid . '_UserHome']
  call assert_false(exists('*' . s:helper), s:helper . ' waits for plugin configuration')
endfor
call SetGeneralKeyMaps()
call ConfigureDelayedPlugin()
call assert_true(exists('*ConfigureMarkdownPlugin'), 'delayed Markdown helper is available')
call assert_true(exists('*ConfigureWhichKey'), 'delayed WhichKey helper is available')
call assert_true(exists('*<SNR>' . s:vimrc_sid . '_ShortcutGroups'), 'shared metadata is available after delayed configuration')
call assert_true(exists('*<SNR>' . s:vimrc_sid . '_WhichKeyMap'), 'WhichKey builder is available after delayed configuration')
call assert_false(exists('*<SNR>' . s:vimrc_sid . '_UserHome'), 'manual home helper waits for manual configuration')
call ConfigureManualLoadPlugin()
call assert_true(exists('*<SNR>' . s:vimrc_sid . '_UserHome'), 'manual home helper is available')
set hidden noconfirm
let s:fixtures = tempname()
call mkdir(s:fixtures . '/.git', 'p')

function! s:ManualConfigurationReload() abort
  " Reconfiguration must replace its handler without clearing CoC's handler.
  let l:coc = autocmd_get({'group': 'Plugin_Configuration_Group', 'event': 'CursorHold'})
  call assert_false(empty(l:coc), 'CoC highlight handler exists before reconfiguration')
  call ConfigureManualLoadPlugin()
  call assert_equal(1, len(autocmd_get({'group': 'Plugin_Configuration_Group',
        \ 'event': 'User', 'pattern': 'VimspectorTerminalOpened'})),
        \ 'manual reconfiguration registers the terminal handler once')
  call assert_equal(l:coc, autocmd_get({'group': 'Plugin_Configuration_Group',
        \ 'event': 'CursorHold'}), 'manual reconfiguration preserves CoC highlighting')
endfunction

function! s:FiletypeLoading() abort
  " Keep native detection and the plugin runtime-path state of existing files.
  call mkdir(s:fixtures . '/include', 'p')
  for [l:path, l:lines, l:type, l:plugin] in [
        \ ['/coq.v', ['Definition answer := 42.'], 'coq', 'automatic-verilog'],
        \ ['/include/existing', ['ordinary content'], '', 'vim-c-cpp-modern']]
    let l:loaded = stridx(&runtimepath, '/' . l:plugin) >= 0
    call writefile(l:lines, s:fixtures . l:path)
    execute 'edit! ' . fnameescape(s:fixtures . l:path)
    call assert_equal(l:type, &filetype, 'existing file keeps native detection')
    call assert_equal(l:loaded, stridx(&runtimepath, '/' . l:plugin) >= 0,
          \ 'existing file preserves plugin runtime-path state')
  endfor
endfunction

function! s:UnicodeFiles() abort
  " Catch a BOM being decoded with the wrong byte order before ucs-bom runs.
  for [l:name, l:bytes, l:encoding] in [
        \ ['utf16le', 0zFFFE680065006C006C006F000A00, 'utf-16le'],
        \ ['utf32le', 0zFFFE000068000000650000006C0000006C0000006F0000000A000000, 'ucs-4le'],
        \ ['utf8', 0zEFBBBF68656C6C6F0A, 'utf-8']]
    let l:path = s:fixtures . '/' . l:name . '.txt'
    call writefile(l:bytes, l:path)
    execute 'edit! ' . fnameescape(l:path)
    call assert_equal('hello', getline(1), l:name . ' decodes correctly')
    call assert_true(&bomb, l:name . ' retains its BOM')
    call assert_equal(l:encoding, &fileencoding, l:name . ' detects byte order')
  endfor
endfunction

function! s:ExistingFileTypes() abort
  " Catch files losing their configured syntax after saving and reopening.
  for [l:ext, l:want] in [['dofile', 'tcl'], ['pdl', 'tcl'],
        \ ['pdl.test', 'tcl'], ['tessent_startup', 'tcl'], ['stil', 'stil'],
        \ ['launch', 'xml'], ['qrc', 'xml'], ['conf', 'xml']]
    let l:path = s:fixtures . '/existing.' . l:ext
    call writefile(['ordinary content'], l:path)
    execute 'edit! ' . fnameescape(l:path)
    call assert_equal(l:want, &filetype, 'existing ' . l:ext . ' detection')
    execute 'edit! ' . fnameescape(s:fixtures . '/new.' . l:ext)
    call assert_equal(l:want, &filetype, 'new ' . l:ext . ' detection')
  endfor
endfunction

function! s:LocalOptions() abort
  " Catch filetype-specific formatting leaking into unrelated new buffers.
  let l:saved = &g:textwidth
  try
    for l:ft in ['vim', 'cmake']
      enew!
      setglobal textwidth=72
      let &l:filetype = l:ft
      call assert_equal(0, &l:textwidth, l:ft . ' disables wrapping locally')
      call assert_equal(72, &g:textwidth, l:ft . ' preserves the default')
      enew!
      call assert_equal(72, &l:textwidth, 'unrelated buffer keeps wrapping')
    endfor
  finally
    let &g:textwidth = l:saved
  endtry

  " Catch the Enter helper changing paste mode, including on editing errors.
  for l:paste in [0, 1]
    enew!
    call setline(1, '  abc')
    call cursor(1, 4)
    let &paste = l:paste
    call EnterWithoutTraillingComment()
    call assert_equal(['  a', '  bc'], getline(1, '$'), 'split without comment continuation')
    call assert_equal(l:paste, &paste, 'Enter restores paste mode')
  endfor
  enew!
  setlocal nomodifiable
  set nopaste
  try
    call EnterWithoutTraillingComment()
  catch
  endtry
  call assert_false(&paste, 'failed Enter restores paste mode')
  setlocal modifiable
  set nopaste
endfunction

function! s:EnterIndentation() abort
  " Catch tabs becoming spaces and display columns being used as byte columns.
  let l:path = s:fixtures . '/Makefile'
  for l:helper in ['InsertEnterInNormalMode', 'EnterWithoutTraillingComment']
    for [l:prefix, l:expandtab, l:expected] in [
          \ ["\t", 0, "\t"], ["\t  ", 0, "\t  "],
          \ ['    ', 1, '    '], ["\t", 1, '    ']]
      call writefile(['all:', l:prefix . '@echo one'], l:path)
      execute 'edit! ' . fnameescape(l:path)
      let &l:expandtab = l:expandtab
      call cursor(2, strlen(getline(2)) + 1)
      call call(function(l:helper), [])
      call assert_equal(l:expected, getline(3), l:helper . ' preserves indentation policy')
      call assert_equal(strlen(l:expected) + 1, col('.'), l:helper . ' cursor follows indentation')
      normal! i@echo two
      call assert_equal(l:expected . '@echo two', getline(3), l:helper . ' inserts after indentation')
      if !l:expandtab && executable('make')
        write
        let l:output = system('make -n -f ' . shellescape(l:path))
        call assert_equal(0, v:shell_error, l:helper . ' keeps valid Make recipes: ' . l:output)
        call assert_equal("echo one\necho two\n", l:output)
      endif
    endfor
  endfor
endfunction

function! s:AltEnterIndentation() abort
  " Splitting within indentation must not duplicate the retained whitespace.
  for l:insert in [0, 1]
    for [l:prefix, l:expandtab, l:expected] in [
          \ ['    ', 1, '    '], ["\t", 0, "\t"],
          \ ["\t  ", 0, "\t  "], ["\t  ", 1, '      ']]
      for l:column in range(1, strlen(l:prefix) + 1)
        enew!
        setlocal filetype=python
        let &l:expandtab = l:expandtab
        call setline(1, ['if True:', l:prefix . 'print("test")'])
        call cursor(2, l:column)
        call feedkeys((l:insert ? 'i' : '') . "\<M-CR>"
              \ . (l:insert ? '' : 'i') . "X\<Esc>", 'xt')
        call assert_equal(['if True:', strpart(l:prefix, 0, l:column - 1),
              \ l:expected . 'Xprint("test")'], getline(1, '$'),
              \ 'Alt+Enter preserves indentation and insertion position: '
              \ . string([l:insert, l:prefix, l:expandtab, l:column]))
      endfor
    endfor
    enew!
    setlocal filetype=python expandtab
    call setline(1, '    first  second')
    call cursor(1, 10)
    call feedkeys((l:insert ? 'i' : '') . "\<M-CR>"
          \ . (l:insert ? '' : 'i') . "X\<Esc>", 'xt')
    call assert_equal(['    first', '    X  second'], getline(1, '$'),
          \ 'Alt+Enter retains spaces after code at the split')
  endfor
endfunction

function! s:HeaderWidth() abort
  " Catch presentation mode and hidden column guides breaking file headers.
  let l:saved = &colorcolumn
  try
    for [l:label, l:columns] in [['presentation', '0'], ['no-guide', '']]
      enew!
      let &colorcolumn = l:columns
      execute 'edit! ' . fnameescape(s:fixtures . '/' . l:label . '.sh')
      call assert_equal('#!/usr/bin/env bash', getline(1), 'header keeps shebang')
      call assert_equal(80, strdisplaywidth(getline(2)), l:label . ' header width')
      call assert_match('File Name:', getline(3), l:label . ' contains filename')
    endfor
  finally
    let &colorcolumn = l:saved
  endtry
endfunction

function! s:HeaderFileKinds() abort
  " Catch changed extension checks dropping shebangs, comments, or includes.
  for [l:name, l:filetype, l:comment, l:shebang, l:tail] in [
        \ ['header.h', 'cpp', '// %s', '', ['#pragma once', '#include <iostream>']],
        \ ['header.H', 'cpp', '// %s', '', ['#pragma once', '#include <iostream>']],
        \ ['main.cpp', 'cpp', '// %s', '', ['#include <iostream>']],
        \ ['kernel.cl', 'opencl', '// %s', '', []],
        \ ['kernel.cu', 'cuda', '// %s', '', ['#include <iostream>', '#include <cuda_runtime.h>']],
        \ ['view.qml', 'qml', '// %s', '', []],
        \ ['main.tcl', 'tcl', '# %s', '#!/usr/bin/env tclsh', []],
        \ ['commands.pdl', 'tcl', '# %s', '', []]]
    enew!
    execute 'file ' . fnameescape(s:fixtures . '/' . l:name)
    let &l:filetype = l:filetype
    let &l:commentstring = '# %s'
    call SetTitle()
    call assert_equal(l:comment, &l:commentstring, l:name . ' keeps comment style')
    if !empty(l:shebang)
      call assert_equal(l:shebang, getline(1), l:name . ' keeps shebang')
    else
      call assert_notmatch('^#!', getline(1), l:name . ' has no added shebang')
    endif
    if !empty(l:tail)
      call assert_equal(l:tail, getline(line('$') - len(l:tail), line('$') - 1),
            \ l:name . ' keeps generated includes and header guard')
    endif
    call assert_equal('', getline('$'), l:name . ' keeps final blank line')
  endfor
endfunction

function! s:SourceWindow() abort
  " Catch selecting an old auxiliary window instead of the actual source.
  enew!
  setlocal buftype=nofile filetype=help
  let l:aux = win_getid()
  belowright new
  let l:source = win_getid()
  call writefile(['print("test")'], s:fixtures . '/source.py')
  execute 'edit! ' . fnameescape(s:fixtures . '/source.py')
  call win_gotoid(l:aux)
  call JumpToTheMainWin()
  call assert_equal(l:source, win_getid(), 'old auxiliary window is skipped')
  call win_gotoid(l:aux)
  call assert_equal(s:fixtures, WorkspaceRoot(), 'workspace comes from source')
  call assert_equal(l:source, win_getid(), 'workspace navigation selects source')
  " Screen order must not replace the existing lowest-window-ID preference.
  leftabove new
  setlocal buftype= filetype=python
  let l:newer_source = win_getid()
  call assert_equal(1, JumpToTheMainWin(), 'an eligible source is found')
  call assert_equal(l:source, win_getid(), 'oldest eligible window wins over screen order')
  call win_execute(l:newer_source, 'close!')
  call win_gotoid(l:source)
  close!
  call assert_equal(0, JumpToTheMainWin(), 'no source window has an explicit result')
  " Both compile helpers must terminate when no eligible window exists.
  call CompileCommand()
  call CompileAndExcute()
endfunction

function! s:InitializeDirectoriesPreservesWindow() abort
  let l:windows = []
  for l:name in ['first', 'second']
    let l:root = s:fixtures . '/' . l:name
    call mkdir(l:root . '/.git', 'p')
    call writefile(['text'], l:root . '/main.txt')
    execute 'tabedit ' . fnameescape(l:root . '/main.txt')
    call add(l:windows, [win_getid(), l:root])
    belowright split
    call add(l:windows, [win_getid(), l:root])
  endfor
  call win_gotoid(l:windows[0][0])
  call InitializeCwdForEachTab()
  call assert_equal(l:windows[0][0], win_getid(), 'directory initialization restores the original split and tab')
  for [l:winid, l:root] in l:windows
    let [l:tabnr, l:winnr] = win_id2tabwin(l:winid)
    call assert_equal(l:root, getcwd(l:winnr, l:tabnr), 'each source window gets its workspace directory')
  endfor
  belowright new
  setlocal buftype=nofile
  let l:aux = win_getid()
  call InitializeCwdForEachTab()
  call assert_equal(l:aux, win_getid(), 'directory initialization restores auxiliary-window focus')
endfunction

function! s:LiteralRootMarkers() abort
  " Catch treating bracket characters in directory names as glob patterns.
  let l:root = s:fixtures . '/project [one]'
  call mkdir(l:root . '/.git', 'p')
  call mkdir(l:root . '/src', 'p')
  call writefile([''], l:root . '/src/.root')
  enew!
  call assert_equal(l:root . '/src', WorkspaceRoot(l:root . '/src'),
        \ 'literal paths select the nearer .root marker')
endfunction

function! s:VisualWhichKey() abort
  " Exercise the prefix's emitted command through the installed WhichKey parser.
  enew!
  call setline(1, ['alpha beta', 'ABCDE'])
  nnoremap [f :let g:whichkey_selection = 'normal'<CR>
  xnoremap [f :<C-u>let g:whichkey_selection = GetSelectedContent()<CR>
  let l:command = substitute(maparg('[', 'x'), '^:<C-U>\|<CR>$', '', 'g')
  for [l:column, l:keys, l:want] in [[1, 'vll', 'alp'], [3, 'vhh', 'alp'],
        \ [1, 'Vj', 'alpha beta ABCDE'], [1, "\<C-v>jl", 'al AB']]
    call cursor(1, l:column)
    execute 'normal! ' . l:keys
    execute "normal! \<Esc>"
    call assert_equal(l:want, GetSelectedContent(), 'fixture establishes the selection')
    let g:whichkey_selection = ''
    call feedkeys('f', 't')
    execute l:command
    call feedkeys('', 'xt')
    call assert_equal(l:want, g:whichkey_selection, 'WhichKey keeps selection type and extent')
  endfor
  call popup_clear()
  call ConfigureDelayedPlugin()
endfunction

function! s:VimVisualNavigation() abort
  " Catch changed search flags, regex escaping, and lost Visual selections.
  let l:selection = &selection
  try
    for l:setting in ['inclusive', 'exclusive']
      let &selection = l:setting
      for l:visual in ['vll', 'Vj', "\<C-V>jl"]
        for [l:line, l:key, l:want] in [[2, 'ks', 1], [2, 'js', 8],
              \ [2, 'jc', 5], [9, 'kc', 6]]
          enew!
          call setline(1, ['function! First()', '  let x = 1', 'endfunction', '',
                \ '" first comment', '" continued comment', 'let x = 0',
                \ 'function! Second()', '  let y = 2', 'endfunction', '',
                \ '" last comment', 'let z = 3'])
          setlocal filetype=vim
          " Mapping dispatch distinguishes modes even when -es makes mode() return ce.
          nnoremap <buffer> <F12> <Cmd>let g:vim_navigation_selection = ['normal', getpos('v')]<CR>
          xnoremap <buffer> <F12> <Cmd>let g:vim_navigation_selection = ['visual', getpos('v')]<CR>
          call cursor(l:line, 2)
          let g:vim_navigation_selection = []
          call feedkeys(l:visual . ',' . l:key . "\<F12>", 'xt')
          call assert_equal(l:want, line('.'), l:key . ' keeps its search direction')
          call assert_equal('visual', g:vim_navigation_selection[0],
                \ l:key . ' keeps Visual mode active')
          call assert_equal(l:line, g:vim_navigation_selection[1][1],
                \ l:key . ' preserves the selection anchor')
          execute "normal! \<Esc>"
        endfor
      endfor
    endfor
    for [l:line, l:key] in [[2, 'je'], [9, 'ke']]
      call cursor(l:line, 2)
      call feedkeys('vll,' . l:key, 'xt')
      call assert_equal(3, line('.'), l:key . ' finds the nearest function end')
      execute "normal! \<Esc>"
    endfor
  finally
    let &selection = l:selection
    unlet! g:vim_navigation_selection
  endtry
endfunction

function! s:MarkdownMenu() abort
  " Catch first-use TOC loading after an unnamed buffer's FileType event.
  enew!
  setlocal filetype=markdown
  call setline(1, ['# Title', '', '## Section', 'body'])
  call cursor(3, 2)
  call CreateMarkdownMenu()
  call assert_equal('markdown', &l:filetype, 'TOC loading restores the Markdown filetype')
  call assert_true(index(getline(1, '$'), '- [Title](#title)') >= 0,
        \ 'Markdown menu contains the heading link')
  call assert_equal(['# Title', '', '## Section', 'body'], getline(line('$') - 3, '$'),
        \ 'Markdown menu preserves the document')
  call assert_equal('## Section', getline('.'), 'Markdown menu restores the source line')
  call assert_equal(2, col('.'), 'Markdown menu restores the source column')
  enew!
  setlocal filetype=text
  call LoadMarkdownToc(':UpdateToc')
  call assert_equal('text', &l:filetype, 'TOC loading preserves other filetypes')
endfunction

function! s:ShortcutHelp() abort
  " Keep each plugin's own shortcut descriptions and hierarchy.
  call assert_equal('Generate parameters', g:leader_key_map.a.p.p)
  call assert_equal('Load Git plugins', g:leader_key_map.g.i.t)
  call assert_equal('Restore editor appearance', g:leader_key_map.p.e.r)
  call assert_equal('Clear all word highlights', g:leader_key_map.w.H)
  call assert_equal('Next unmatched delimiter', g:local_key_map.jd)
  call assert_equal('which_key_ignore', g:local_key_map.j.name)
  call assert_equal('Set advanced line breakpoint', g:right_bracket_key_map['<S-F4>'])
  call assert_equal('Enable Python project debugging', g:right_bracket_key_map.m.p)
  call assert_equal('Refactor selection or symbol', g:left_bracket_key_map.f)
  call assert_equal('Open declaration in new tab', g:left_bracket_key_map.tc)
  call assert_equal('Open definition in new tab', g:left_bracket_key_map.td)
  call assert_equal('Open implementation in new tab', g:left_bracket_key_map.ti)
  call QuickuiInstallKeyMapMenus()
  call assert_equal(['Refactor symbol', 'Refactor selection'], map(filter(deepcopy(g:quickui_keymap_groups),
        \ {_, group -> group[0] ==# 'COC'})[0][1]->filter({_, row -> row[0] ==# '[f'}),
        \ {_, row -> row[1]}))
  enew!
  call setline(1, 'hello_world')
  call cursor(1, 2)
  call assert_equal('hello_world', expand('<cword>'), 'keyword cleanup retains letters')
endfunction

try
  for s:check in ['ManualConfigurationReload', 'FiletypeLoading', 'UnicodeFiles', 'ExistingFileTypes', 'LocalOptions',
        \ 'EnterIndentation', 'AltEnterIndentation', 'HeaderWidth', 'HeaderFileKinds', 'SourceWindow', 'LiteralRootMarkers', 'VisualWhichKey',
        \ 'InitializeDirectoriesPreservesWindow', 'VimVisualNavigation', 'MarkdownMenu', 'ShortcutHelp']
    try
      call call(function('s:' . s:check), [])
    catch
      call assert_report(s:check . ': ' . v:exception . ' at ' . v:throwpoint)
    finally
      silent! tabonly!
      silent! only!
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
call writefile(['PASS: Vimrc encodings, filetypes, option isolation, headers, source windows and Visual WhichKey'], '/dev/stdout')
qa!
