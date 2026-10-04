" Run: vim -Nu NONE -n -i NONE -es -S tests/test_vimspector_project_debug.vim
set nocompatible noswapfile
let s:repo = expand('<sfile>:p:h:h')
execute 'source ' . fnameescape(get(g:, 'vimrc_under_test', s:repo . '/vimrc'))
call timer_stopall()
call SetGeneralKeyMaps()
call ConfigureDelayedPlugin()
call ConfigureManualLoadPlugin()
call InitializeTabPos()
let s:fixtures = tempname()

function! s:OpenWorkspace(name)
  let l:root = s:fixtures . '/' . a:name
  call mkdir(l:root . '/.git', 'p')
  call mkdir(l:root . '/src', 'p')
  call writefile(['print("test")'], l:root . '/src/main.py')
  execute 'edit ' . fnameescape(l:root . '/src/main.py')
  return l:root
endfunction

function! s:ProjectFlag(root)
  return json_decode(join(readfile(a:root . '/.vimspector.json'), "\n"))
        \ .configurations['python: project'].configuration.enable_project_debug
endfunction

function! s:DoNotCopyIntoHome() abort
  " Catch home-directory writes and .vscode creation before the copy check.
  let l:original_home = $HOME
  let l:home = s:fixtures . '/home'
  call mkdir(l:home . '/.vim/.c_cpp/.vscode', 'p')
  call writefile(readfile(s:repo . '/.c_cpp/.vimspector.json'),
        \ l:home . '/.vim/.c_cpp/.vimspector.json')
  for l:name in ['.clangd', '.clang-format', '.clang-tidy', '.vscode/launch.json']
    call writefile(['template'], l:home . '/.vim/.c_cpp/' . l:name)
  endfor
  call writefile(['print("test")'], l:home . '/main.py')
  call system('ln -s ' . shellescape(l:home) . ' ' . shellescape(s:fixtures . '/home-link'))
  call assert_equal(0, v:shell_error, 'create home symlink fixture')
  try
    let $HOME = l:home
    execute 'edit ' . fnameescape(l:home . '/main.py')
    call assert_equal(l:home, WorkspaceRoot(), 'home without a project marker')
    for l:root in [l:home, l:home . '/', s:fixtures . '/home-link']
      call assert_equal(0, CopyFileRelToCPP(l:root, '.vimspector.json'),
            \ 'skip home destination: ' . l:root)
      call assert_false(filereadable(l:home . '/.vimspector.json'))
    endfor
    let l:tab_count = tabpagenr('$')
    call ConfigureCppDebug(1)
    call ConfigureCppDebug()
    call ConfigureClangTools()
    call assert_equal(l:tab_count, tabpagenr('$'), 'home setup opens no config tab')
    call assert_equal(l:home . '/main.py', expand('%:p'))
    call assert_false(isdirectory(l:home . '/.vscode'), 'home setup creates no .vscode')
    for l:name in ['.vimspector.json', '.clangd', '.clang-format', '.clang-tidy']
      call assert_false(filereadable(l:home . '/' . l:name), 'no home copy: ' . l:name)
    endfor
  finally
    let $HOME = l:original_home
  endtry
endfunction

try
  call s:DoNotCopyIntoHome()
  " Catch ambiguous copy results and overwriting files that already exist.
  let s:root = s:OpenWorkspace('copy-result')
  call assert_equal(2, CopyFileRelToCPP(s:root, '.vimspector.json'), 'new copy')
  call writefile(['keep existing file'], s:root . '/.vimspector.json')
  call assert_equal(1, CopyFileRelToCPP(s:root, '.vimspector.json'), 'existing file')
  call assert_equal(['keep existing file'], readfile(s:root . '/.vimspector.json'))
  call assert_equal(0, CopyFileRelToCPP(s:root, 'missing-template-for-test'))
  call assert_false(filereadable(s:root . '/missing-template-for-test'))

  " Catch a copy path that leaves single-file workspaces in project mode.
  let s:root = s:OpenWorkspace('single')
  call ConfigureCppDebug()
  call assert_equal(v:false, s:ProjectFlag(s:root), 'new single-file workspace')
  call assert_equal(s:root . '/.vimspector.json', expand('%:p'))

  if !exists('*EnableProjectDebug') || !exists('*DisableProjectDebug')
        \ || !exists('*WorkspaceHasBuildFiles')
    call assert_report('project debug toggles/build detection are missing')
  else
    " Catch wrong targets, JSON reformatting, and stale open buffers.
    let s:original = readfile(s:root . '/.vimspector.json')
    call EnableProjectDebug()
    call assert_equal(v:true, s:ProjectFlag(s:root))
    call assert_equal(v:true, json_decode(join(getline(1, '$'), "\n"))
          \ .configurations['python: project'].configuration.enable_project_debug)
    call assert_false(&modified)
    call DisableProjectDebug()
    call assert_equal(s:original, readfile(s:root . '/.vimspector.json'))

    " A visible debugger config must not prevent adding VS Code integration.
    let s:config_window = win_getid()
    let s:tab_count = tabpagenr('$')
    call append('$', 'unsaved fixture change')
    let s:config_text = getline(1, '$')
    call ConfigureCppDebug(1)
    call assert_true(filereadable(s:root . '/.vscode/launch.json'), 'add VS Code config with debugger config open')
    call assert_equal(s:config_window, win_getid(), 'reuse the open config window')
    call assert_equal(s:tab_count, tabpagenr('$'), 'do not open a duplicate config tab')
    call assert_equal(s:original, readfile(s:root . '/.vimspector.json'), 'preserve config on disk')
    call assert_equal(s:config_text, getline(1, '$'), 'preserve unsaved config changes')
    call assert_true(&modified)
    if filereadable(s:root . '/.vscode/launch.json')
      call writefile(['keep VS Code settings'], s:root . '/.vscode/launch.json')
      call ConfigureCppDebug(1)
      call assert_equal(['keep VS Code settings'], readfile(s:root . '/.vscode/launch.json'))
    endif
    edit!

    " Catch accidental overwrite of manual choices when setup is repeated.
    call EnableProjectDebug()
    execute 'edit ' . fnameescape(s:root . '/src/main.py')
    call ConfigureCppDebug()
    call assert_equal(v:true, s:ProjectFlag(s:root))
    tabclose
    call ConfigureCppDebug()
    call assert_equal(v:true, s:ProjectFlag(s:root), 'existing config without an open tab')

    " Catch a scan that misses supported markers or mistakes directories for files.
    let s:root = s:OpenWorkspace('markers')
    for s:marker in ['app.pro', 'common.pri', '.qmake.conf', '.qmake.cache',
          \ 'CMakeLists.txt', 'helpers.cmake', 'CMakePresets.json',
          \ 'CMakeUserPresets.json', 'Makefile', 'makefile', 'GNUmakefile', 'rules.mk', 'SConstruct']
      call assert_false(WorkspaceHasBuildFiles(), 'empty root before ' . s:marker)
      call writefile([''], s:root . '/' . s:marker)
      call assert_true(WorkspaceHasBuildFiles(), s:marker)
      call delete(s:root . '/' . s:marker)
    endfor
    call mkdir(s:root . '/Makefile')
    call writefile([''], s:root . '/src/CMakeLists.txt')
    call assert_false(WorkspaceHasBuildFiles(), 'only files directly in the root')

    " Keep exact names and suffix matching, including with 'nomagic'.
    let s:saved_magic = &magic
    try
      for [s:magic, s:marker, s:want] in [
            \ [1, 'notMakefile', 0], [1, 'MAKEFILE', 0],
            \ [1, 'CMakeListsXtxt', 0], [1, 'rules.mk.backup', 0],
            \ [1, '.hidden.mk', 1], [1, 'app.pro', 1],
            \ [0, 'rulesXmk', 0], [0, 'rules.mk', 1],
            \ [0, 'CMakeListsXtxt', 0], [0, 'CMakeLists.txt', 1]]
        let &magic = s:magic
        call writefile([''], s:root . '/' . s:marker)
        call assert_equal(s:want, WorkspaceHasBuildFiles(s:root),
              \ 'build marker ' . s:marker . ' with magic=' . s:magic)
        call delete(s:root . '/' . s:marker)
      endfor
    finally
      let &magic = s:saved_magic
    endtry

    " An already resolved root must be checked independently of the active workspace.
    let s:explicit_root = s:root
    call writefile([''], s:explicit_root . '/CMakeLists.txt')
    let s:root = s:OpenWorkspace('other-workspace')
    call assert_false(WorkspaceHasBuildFiles(), 'active workspace has no build files')
    call assert_true(WorkspaceHasBuildFiles(s:explicit_root), 'check the supplied workspace root')
    call assert_equal(s:root . '/src/main.py', expand('%:p'), 'explicit root check keeps source focus')

    " Catch incorrect defaults in either setup variant, including spaced paths.
    for [s:name, s:marker, s:vscode, s:want] in [
          \ ['cmake project', 'CMakeLists.txt', 0, v:true],
          \ ['qmake', 'app.pro', 0, v:true],
          \ ['make', 'Makefile', 0, v:true],
          \ ['scons', 'SConstruct', 0, v:true],
          \ ['vscode', '', 1, v:false]]
      let s:root = s:OpenWorkspace(s:name)
      if !empty(s:marker)
        call writefile([''], s:root . '/' . s:marker)
      endif
      call ConfigureCppDebug(s:vscode)
      call assert_equal(s:want, s:ProjectFlag(s:root), s:name)
      call assert_equal(s:root . '/.vimspector.json', expand('%:p'))
      if s:vscode
        call assert_true(filereadable(s:root . '/.vscode/launch.json'))
      endif
    endfor

    " Catch edits to other configurations or loss of compact JSON formatting.
    let s:root = s:OpenWorkspace('compact')
    let s:data = json_decode(join(readfile(s:repo . '/.c_cpp/.vimspector.json'), "\n"))
    let s:data.variables = {'enable_project_debug': v:true}
    let s:compact = json_encode(s:data)
    call writefile([s:compact], s:root . '/.vimspector.json')
    call assert_equal(1, DisableProjectDebug())
    let s:updated = json_decode(join(readfile(s:root . '/.vimspector.json'), "\n"))
    call assert_equal(v:false, s:updated.configurations['python: project'].configuration.enable_project_debug)
    call assert_equal(v:true, s:updated.variables.enable_project_debug)
    call EnableProjectDebug()
    call assert_equal([s:compact], readfile(s:root . '/.vimspector.json'))

    " Catch missing/malformed files or an unsaved buffer being overwritten.
    let s:root = s:OpenWorkspace('invalid')
    call assert_equal(0, EnableProjectDebug())
    call writefile(['invalid JSON'], s:root . '/.vimspector.json')
    call assert_equal(0, DisableProjectDebug())
    call assert_equal(['invalid JSON'], readfile(s:root . '/.vimspector.json'))
    for s:incomplete in ['{}', '{"configurations":{"python: project":{"configuration":{}}}}']
      call writefile([s:incomplete], s:root . '/.vimspector.json')
      call assert_equal(0, EnableProjectDebug())
      call assert_equal([s:incomplete], readfile(s:root . '/.vimspector.json'))
    endfor
    call writefile(readfile(s:repo . '/.c_cpp/.vimspector.json'), s:root . '/.vimspector.json')
    execute 'edit ' . fnameescape(s:root . '/.vimspector.json')
    call append('$', 'unsaved change')
    let s:disk = readfile(s:root . '/.vimspector.json')
    call assert_equal(0, DisableProjectDebug())
    call assert_equal(s:disk, readfile(s:root . '/.vimspector.json'))
    call assert_equal('unsaved change', getline('$'))

    " Catch shortcuts that change the wrong mode or leak into Insert/Terminal.
    edit!
    call feedkeys(']ms', 'xt')
    call assert_equal(v:false, s:ProjectFlag(s:root))
    call feedkeys(']mp', 'xt')
    call assert_equal(v:true, s:ProjectFlag(s:root))
    for s:key in [']mp', ']ms']
      call assert_equal('', maparg(s:key, 'i'))
      call assert_equal('', maparg(s:key, 't'))
      call assert_equal('', maparg(s:key, 'v'))
    endfor
    call assert_equal('+Python Debug Mode', g:right_bracket_key_map.m.name)
    call QuickuiInstallKeyMapMenus()
    let s:entries = filter(copy(filter(copy(g:quickui_keymap_groups),
          \ {_, group -> group[0] ==# 'Vimspector'})[0][1]),
          \ {_, entry -> index([']mp', ']ms'], entry[0]) >= 0})
    call assert_equal(2, len(s:entries))
  endif
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
call writefile(['PASS: Vimspector project modes, copy defaults, build markers and shortcuts'], '/dev/stdout')
qa!
