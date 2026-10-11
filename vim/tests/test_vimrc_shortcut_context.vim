" Run: vim -Nu NONE -n -i NONE -es -S tests/test_vimrc_shortcut_context.vim
set nocompatible noswapfile hidden noconfirm
let s:repo = expand('<sfile>:p:h:h')
execute 'source ' . fnameescape(get(g:, 'vimrc_under_test', s:repo . '/vimrc'))
call timer_stopall()
call SetGeneralKeyMaps()
call ConfigureDelayedPlugin()
call ConfigureManualLoadPlugin()
set noundofile noconfirm
let s:whichkey_sid = filter(getscriptinfo(),
      \ {_, script -> script.name =~# '/autoload/which_key.vim$'})[0].sid
let s:fixtures = tempname()

function! s:Runtime(mode, prefix) abort
  call call(function('<SNR>' . s:whichkey_sid . '_cache_key'), [a:mode, a:prefix])
  return call(function('<SNR>' . s:whichkey_sid . '_create_runtime'), [a:mode, a:prefix])
endfunction

function! s:ReplayFlat(visual, prefix, key) abort
  let l:runtime = s:Runtime(a:visual ? 'v' : 'n', a:prefix)
  let l:view = winsaveview()
  " Set the installed dispatcher's mode without blocking for menu input.
  call feedkeys("\<Esc>", 't')
  call which_key#start(a:visual, 0, a:prefix)
  call call(function('<SNR>' . s:whichkey_sid . '_execute'), [l:runtime[a:key][0]])
  call winrestview(l:view)
  call feedkeys("\<F12>\<Esc>", 'xt')
endfunction

function! s:Vim9CommentNavigation() abort
  enew!
  call setline(1, ['vim9script', 'def First()', '  return', 'enddef',
        \ 'var text = "# string"', '# first comment', '# continued comment',
        \ 'var x = 0', 'def Second()', 'enddef'])
  setlocal filetype=vim
  for [l:line, l:key, l:want] in [[2, 'jc', 6], [10, 'kc', 7]]
    call cursor(l:line, 1)
    call s:ReplayFlat(0, ',', l:key)
    call assert_equal(l:want, line('.'), 'Vim9 Normal comment block boundary: ' . l:key)
    call cursor(l:line, 1)
    normal! vl
    let l:anchor = getpos('v')
    execute "normal! \<Esc>"
    call s:ReplayFlat(1, ',', l:key)
    call assert_equal('visual', g:shortcut_context_selection[0], 'Vim9 comment search keeps Visual mode')
    call assert_equal(l:anchor, g:shortcut_context_selection[1], 'Vim9 comment search keeps anchor')
    call assert_equal(l:want, g:shortcut_context_selection[2][1], 'Vim9 Visual comment block boundary: ' . l:key)
  endfor
  " Editing the directive must change the search without reinstalling mappings.
  call setline(1, '" legacy script')
  call setline(6, '" first comment')
  call setline(7, '" continued comment')
  call cursor(2, 1)
  call s:ReplayFlat(0, ',', 'jc')
  call assert_equal(6, line('.'), 'legacy comments remain available after editing the directive')
endfunction

function! s:VisualDiagnostics() abort
  enew!
  let l:normal = s:Runtime('n', '[')
  let l:visual = s:Runtime('v', '[')
  for l:key in ['jd', 'je', 'kd', 'ke']
    call assert_true(has_key(l:normal, l:key), 'Normal diagnostics remain available: ' . l:key)
    call assert_false(has_key(l:visual, l:key), 'Visual menu omits Normal-only diagnostic: ' . l:key)
    call assert_false(has_key(get(l:visual, l:key[0], {}), l:key[1]),
          \ 'Visual submenu omits Normal-only diagnostic: ' . l:key)
  endfor
  call assert_true(has_key(l:visual, 'td'), 'Visual tab jumps remain available')
endfunction

function! s:VisualNavigation() abort
  for [l:line, l:key, l:want] in [[2, 'js', 8], [2, 'ks', 1],
        \ [2, 'je', 3], [9, 'ke', 3], [2, 'jc', 5], [9, 'kc', 6]]
    for l:selection in ['vll', 'vhh', 'Vj', "\<C-v>jl"]
      enew!
      call setline(1, ['function! First()', '  let x = 1', 'endfunction', '',
            \ '" first comment', '" continued comment', 'let x = 0',
            \ 'function! Second()', '  let y = 2', 'endfunction'])
      setlocal filetype=vim
      call cursor(l:line, 4)
      execute 'normal! ' . l:selection
      let l:anchor = getpos('v')
      execute "normal! \<Esc>"
      call s:ReplayFlat(1, ',', l:key)
      call assert_equal('visual', g:shortcut_context_selection[0], l:key . ' keeps Visual mode')
      call assert_equal(l:anchor, g:shortcut_context_selection[1], l:key . ' keeps the selection anchor')
      let l:want_line = index(['Vj', "\<C-v>jl"], l:selection) >= 0
            \ ? get({'je': 10}, l:key, l:want) : l:want
      call assert_equal(l:want_line, g:shortcut_context_selection[2][1], l:key . ' keeps its search direction')
    endfor
  endfor
endfunction

function! s:FiletypeNavigation() abort
  let l:keys = ['js', 'je', 'jc', 'ks', 'ke', 'kc']
  enew!
  setlocal filetype=vim
  call setline(1, '" keep a separate Vim buffer while visiting other filetypes')
  let l:vim_buffer = bufnr('%')
  for l:mode in ['n', 'v']
    let l:runtime = s:Runtime(l:mode, ',')
    for l:key in l:keys
      call assert_true(has_key(l:runtime, l:key), 'Vim menu includes ' . l:key)
    endfor
  endfor
  for l:filetype in ['text', 'python', 'cpp']
    enew!
    let &l:filetype = l:filetype
    for l:mode in ['n', 'v']
      let l:runtime = s:Runtime(l:mode, ',')
      for l:key in l:keys
        call assert_false(has_key(l:runtime, l:key), l:filetype . ' menu omits Vim navigation: ' . l:key)
      endfor
      call assert_true(has_key(l:runtime, 'jd'), 'general delimiter navigation remains available')
    endfor
  endfor
  execute 'buffer ' . l:vim_buffer
  call assert_true(has_key(s:Runtime('n', ','), 'js'), 'returning to Vim restores its menu')
  let l:mappings = [maparg(',js', 'n'), maparg(',js', 'x')]
  setlocal filetype=text
  call assert_equal(l:mappings, [maparg(',js', 'n'), maparg(',js', 'x')],
        \ 'changing filetype preserves existing buffer mappings')
  for l:mode in ['n', 'v']
    call assert_true(has_key(s:Runtime(l:mode, ','), 'js'),
          \ 'retained buffer mapping stays available after changing filetype')
  endfor
endfunction

function! s:CurrentBufferMapping() abort
  enew!
  setlocal filetype=text
  nnoremap ,js <Cmd>let g:shortcut_context_mapping = 'global fallback'<CR>
  xnoremap ,js <Cmd>let g:shortcut_context_mapping = 'global fallback'<CR>
  nnoremap <buffer> ,js <Cmd>let g:shortcut_context_mapping = 'current buffer'<CR>
  xnoremap <buffer> ,js <Cmd>let g:shortcut_context_mapping = 'current buffer'<CR>
  call setline(1, 'selection')
  for l:want in ['current buffer', 'global fallback']
    for l:visual in [0, 1]
      if l:visual
        normal! vl
        execute "normal! \<Esc>"
      endif
      let g:shortcut_context_mapping = ''
      call s:ReplayFlat(l:visual, ',', 'js')
      call assert_equal(l:want, g:shortcut_context_mapping,
            \ 'flat menu uses the buffer mapping or falls back to the global mapping')
    endfor
    if l:want ==# 'current buffer'
      nunmap <buffer> ,js
      xunmap <buffer> ,js
    endif
  endfor
  nunmap ,js
  xunmap ,js
  for l:mode in ['n', 'v']
    call assert_false(has_key(s:Runtime(l:mode, ','), 'js'),
          \ 'menu omits navigation without a local or global mapping')
  endfor
endfunction

function! s:MetadataReload() abort
  enew!
  setlocal filetype=vim
  call QuickuiInstallKeyMapMenus()
  let l:search = filter(copy(g:quickui_keymap_groups), {_, group -> group[0] ==# 'Search'})[0]
  let l:row = filter(copy(l:search[1]), {_, row -> row[0] ==# '<LocalLeader>js'})[0]
  let l:row[1] = 'changed QuickUI copy'
  call ConfigureWhichKey()
  call assert_equal('Next function start', s:Runtime('n', ',').js[1],
        \ 'QuickUI changes do not alter shared WhichKey metadata')
  execute 'source ' . fnameescape(get(g:, 'vimrc_under_test', s:repo . '/vimrc'))
  call timer_stopall()
  call SetGeneralKeyMaps()
  call ConfigureDelayedPlugin()
  call ConfigureManualLoadPlugin()
  let l:search = filter(copy(g:quickui_keymap_groups), {_, group -> group[0] ==# 'Search'})[0]
  let l:row = filter(copy(l:search[1]), {_, row -> row[0] ==# '<LocalLeader>js'})[0]
  call assert_equal('Next function start', l:row[1], 'reload refreshes an existing QuickUI snapshot')
  call assert_match('\[vim\] Next function start', QuickuiCheatsheetKeyMapLine(l:row, 80),
        \ 'QuickUI identifies Vim-only shortcuts')
endfunction

function! s:NewTabDirectory() abort
  let l:root = s:fixtures . '/project | space'
  call mkdir(l:root . '/.git', 'p')
  call mkdir(l:root . '/src', 'p')
  call mkdir(l:root . '/build', 'p')
  let l:other = s:fixtures . '/other project'
  call mkdir(l:other . '/.git', 'p')
  let l:standalone = s:fixtures . '/standalone'
  call mkdir(l:standalone, 'p')
  call writefile(['source'], l:root . '/src/main.txt')
  call writefile(['standalone'], l:standalone . '/main.txt')
  for [l:file, l:cwd, l:want] in [
        \ [l:root . '/src/main.txt', l:root, l:root],
        \ [l:root . '/src/main.txt', l:root . '/src', l:root . '/src'],
        \ [l:root . '/src/main.txt', l:root . '/build', l:root . '/build'],
        \ [l:root . '/src/main.txt', l:other, l:root],
        \ [l:standalone . '/main.txt', l:other, l:standalone]]
    execute 'edit ' . fnameescape(l:file)
    execute 'lcd ' . fnameescape(l:cwd)
    let l:root_patterns = g:root_patterns
    try
      if l:file ==# l:standalone . '/main.txt'
        " Ancestor markers such as /tmp/.git must not mark this standalone fixture.
        let g:root_patterns = ['.vimrc-test-root']
      endif
      call NewTab('empty_tab')
    finally
      let g:root_patterns = l:root_patterns
    endtry
    call assert_equal(l:want, getcwd(), 'empty tab applies the previous file and cwd workspace rule')
    call assert_equal('', bufname('%'), 'new editing tab remains empty')
    tabclose!
    call assert_equal(l:cwd, getcwd(), 'new tab leaves the source window cwd unchanged')
  endfor
  execute 'edit ' . fnameescape(l:root . '/src/main.txt')
  for l:mode in ['empty_tab', 'terminal']
    execute 'lcd ' . fnameescape(l:root)
    call NewTab(l:mode)
    call assert_equal(l:mode ==# 'terminal' ? l:root . '/src' : l:root,
          \ getcwd(), l:mode . ' uses its directory rule')
    if l:mode ==# 'terminal'
      let l:terminal = bufnr('%')
      call assert_equal(l:root . '/src', GetLaunchPath(), 'terminal process uses the source directory')
      call mkdir(l:root . '/elsewhere', 'p')
      call term_sendkeys(l:terminal, 'cd ' . shellescape(l:root . '/elsewhere') . "\n")
      let l:deadline = reltime()
      while GetLaunchPath() !=# l:root . '/elsewhere' && reltimefloat(reltime(l:deadline)) < 3
        sleep 10m
      endwhile
      call assert_equal(l:root . '/elsewhere', GetLaunchPath(), 'fixture changes the terminal directory')
      call NewTab('empty_tab')
      call assert_equal(l:root . '/src', getcwd(), 'empty tab retains cwd within the terminal workspace')
      tabclose!
      call NewTab('terminal')
      let l:child_terminal = bufnr('%')
      call assert_equal(l:root . '/elsewhere', getcwd(), 'terminal tab inherits the live terminal directory')
      call assert_equal(l:root . '/elsewhere', GetLaunchPath(), 'child terminal launches in the live directory')
      tabclose!
      execute 'bwipeout! ' . l:child_terminal
      tabclose!
      execute 'bwipeout! ' . l:terminal
    else
      tabclose!
    endif
  endfor
endfunction

nnoremap <F12> <Cmd>let g:shortcut_context_selection = ['normal', getpos('v'), getpos('.')]<CR>
xnoremap <F12> <Cmd>let g:shortcut_context_selection = ['visual', getpos('v'), getpos('.')]<CR>
try
  for s:check in ['VisualDiagnostics', 'VisualNavigation', 'Vim9CommentNavigation', 'FiletypeNavigation',
        \ 'CurrentBufferMapping', 'NewTabDirectory', 'MetadataReload']
    try
      call call(function('s:' . s:check), [])
    catch
      call assert_report(s:check . ': ' . v:exception . ' at ' . v:throwpoint)
    endtry
  endfor
finally
  call popup_clear()
  silent! tabonly!
  silent! %bwipeout!
  call delete(s:fixtures, 'rf')
endtry
if !empty(v:errors)
  call writefile(v:errors, '/dev/stdout')
  cquit
endif
call writefile(['PASS: shortcut modes, filetypes, mapping context and new-tab directories'], '/dev/stdout')
qa!
