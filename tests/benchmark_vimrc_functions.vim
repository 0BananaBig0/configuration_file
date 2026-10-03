" Run: vim -Nu NONE -n -i NONE -es -S tests/benchmark_vimrc_functions.vim
" Compare revisions with --cmd "let g:vimrc_under_test='/tmp/before.vim'".
" Reports five-sample median milliseconds per call; setup is not timed.
set nocompatible noswapfile hidden noconfirm
let s:repo = expand('<sfile>:p:h:h')
let s:vimrc = get(g:, 'vimrc_under_test', s:repo . '/.vimrc')
execute 'source ' . fnameescape(s:vimrc)
call timer_stopall()
call SetGeneralKeyMaps()
call ConfigureDelayedPlugin()
call ConfigureManualLoadPlugin()
" Isolate helper work from plugins triggered by fixture window changes.
set eventignore=all noconfirm
let s:fixtures = tempname()
call mkdir(s:fixtures, 'p')

function! s:Measure(label, expression, count) abort
  call eval(a:expression)
  let l:samples = []
  for l:sample in range(5)
    let l:start = reltime()
    for l:iteration in range(a:count)
      call eval(a:expression)
    endfor
    call add(l:samples, reltimefloat(reltime(l:start)) * 1000 / a:count)
  endfor
  call sort(l:samples, 'f')
  call writefile([printf('%-32s %.6f ms/call (min %.6f, max %.6f; %d calls/sample)',
        \ a:label, l:samples[2], l:samples[0], l:samples[-1], a:count)], '/dev/stdout', 'a')
endfunction

try
  for [s:size, s:count] in [[20, 300], [1000, 50], [10000, 10]]
    let g:vimrc_bench_dir = s:fixtures . '/' . s:size
    call mkdir(g:vimrc_bench_dir)
    for s:i in range(s:size)
      call writefile([], printf('%s/source-%05d.cpp', g:vimrc_bench_dir, s:i))
    endfor
    for [s:label, s:marker] in [['none', ''], ['early', 'Makefile'], ['late', 'zz-final.mk']]
      if !empty(s:marker)
        call writefile([], g:vimrc_bench_dir . '/' . s:marker)
      endif
      call assert_equal(!empty(s:marker), WorkspaceHasBuildFiles(g:vimrc_bench_dir))
      call s:Measure('build-' . s:label . '-' . s:size,
            \ 'WorkspaceHasBuildFiles(g:vimrc_bench_dir)', s:count)
      if !empty(s:marker)
        call delete(g:vimrc_bench_dir . '/' . s:marker)
      endif
    endfor
  endfor

  " Also measure read-only discovery on the actual repository filesystem.
  let g:vimrc_bench_dir = s:repo
  call s:Measure('build-repository-' . len(readdir(s:repo)),
        \ 'WorkspaceHasBuildFiles(g:vimrc_bench_dir)', 50)

  set winminheight=0 winheight=1
  for s:size in [1, 4, 8]
    silent! only!
    while winnr('$') < s:size
      new
    endwhile
    let s:windows = gettabinfo(tabpagenr())[0].windows
    for s:winid in s:windows
      call setbufvar(winbufnr(s:winid), '&buftype', '')
      call setbufvar(winbufnr(s:winid), '&filetype', 'python')
    endfor
    call s:Measure('source-first-' . s:size, 'JumpToTheMainWin()', 1000)
    call assert_equal(min(s:windows), win_getid())
    for s:winid in s:windows
      call setbufvar(winbufnr(s:winid), '&buftype', 'nofile')
    endfor
    call setbufvar(winbufnr(max(s:windows)), '&buftype', '')
    call s:Measure('source-last-' . s:size, 'JumpToTheMainWin()', 1000)
    call assert_equal(max(s:windows), win_getid())
    call setbufvar(winbufnr(max(s:windows)), '&buftype', 'nofile')
    call s:Measure('source-none-' . s:size, 'JumpToTheMainWin()', 1000)
    call assert_equal(0, JumpToTheMainWin())
  endfor

  call QuickuiInstallKeyMapMenus()
  let g:quickui_cheatsheet_toggle_keys = split('123456789abcdefimop', '\zs')
  let g:quickui_cheatsheet_folded = {}
  call writefile([printf('QuickUI fixture: %d groups, %d mappings, columns=%d',
        \ len(g:quickui_keymap_groups),
        \ eval(join(map(copy(g:quickui_keymap_groups), {_, group -> len(group[1])}), '+')),
        \ &columns)], '/dev/stdout', 'a')
  call s:Measure('quickui-expanded', 'QuickuiBuildKeyMapCheatsheet()', 100)
catch
  call assert_report(v:exception . ' at ' . v:throwpoint)
finally
  silent! tabonly!
  silent! %bwipeout!
  call delete(s:fixtures, 'rf')
endtry
if !empty(v:errors)
  call writefile(v:errors, '/dev/stdout')
  cquit
endif
qa!
