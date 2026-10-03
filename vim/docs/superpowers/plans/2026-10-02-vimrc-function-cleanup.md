# Vimrc Function Cleanup Implementation Plan

> **For agentic workers:** Implement inline using Superpowers TDD, debugging, review, and verification. The user approved this cleanup with “Process”; do not repeat the approval gate or commit without a request.

**Goal:** Apply the approved function audit while preserving shortcuts, debugger layout, and project-debug behavior.

**Architecture:** Keep the configuration in `.vimrc`. Use Vim tab-local variables for terminal ownership and installed Vimspector APIs for debugger operations. Remove redundant code without adding dependencies.

**Tech Stack:** Legacy Vimscript, installed Vim 9.2, vim-plug, QuickUI, Vimspector.

**Spec:** The function audit approved in this conversation, including unsaved-buffer protection, stable terminal ownership, correct debugger arguments, lazy loading, build commands, and native selection/path helpers.

## Global Constraints

- Debug locally; no SSH. Preserve all existing shortcut meanings and mode restrictions.
- Keep QuickUI categories alphabetical and preserve WhichKey registration.
- Preserve Vimspector prompt timers, JSON validation, and unsaved JSON protection.
- Keep the two project-debug functions and their Normal-only shortcuts.
- Preserve intentional terminal termination when closing a tab; never wipe unsaved source buffers.
- No new dependencies, commits, or speculative caches. Retain externally callable helpers such as `ListAllThreads()`.
- Normal scale is tens of tabs and hundreds of mappings. Use tab-local ownership rather than fixed arrays or repeated shifting; iterate actual buffers rather than historical buffer numbers.

## Task 1: Terminal ownership and safe quitting

**Files:** Modify `.vimrc`; add `tests/test_vimrc_functions.vim`.

**Interfaces:** `ToggleTerminal(height=18)`, `NewTab(mode='terminal')`, `QuitWin()`, `CloseAndBackTab()`, `MoveTabH()`, `MoveTabL()` keep their existing callers. Replace global array bookkeeping with `t:term_buf`; no new-tab bookkeeping is needed.

- [x] Add regression checks that show terminal buffers stay with their tabs across moves, dead buffers do not steal another tab's terminal, and more than 19 tabs work. Verify last-window quitting preserves a hidden modified source buffer in a child Vim.
- [x] Run the checks against the old configuration and confirm the observed failures.
- [x] Replace array writes with `let t:term_buf = ...` and reads with `get(t:, 'term_buf', -1)`. Remove array shift helpers and their callers. Keep terminal closing conditional on `getbufvar(buf, '&buftype') ==# 'terminal'`.
- [x] Implement tab moves with native commands: `execute 'tabmove ' . (tabpagenr() == 1 ? '$' : '-1')` and the matching rightward move.
- [x] Quit before cleaning up tracked terminals; use `getbufinfo()` for terminal cleanup only after E947 blocks a clean final exit, and preserve every modified source buffer. Abort quit helpers on errors instead of continuing loops after a failed quit.
- [x] Run focused checks and the existing project-debug regression.

## Task 2: Debugger and lazy plugin operations

**Files:** Modify `.vimrc`; extend `tests/test_vimrc_functions.vim`.

**Interfaces:** Keep public debugger function names and mapping arguments. Add one script-local console helper consuming a GDB command string. The helper submits `'-exec ' . a:command` through `vimspector#Evaluate()` and restores the original window in `finally`.

- [x] Add failing checks for actual numeric process/thread/backtrace arguments, first-use multiple cursors, and debugger disassembly that returns to the originating window or has no supported view.
- [x] Replace console typing with the shared helper; use `vimspector#AddWatch(a:selection)` for watches.
- [x] Check commands with `exists(':VimspectorShowOutput')`; initialize QuickUI once using its configuration state and correctly check autoload function availability.
- [x] Load Visual Multi before replaying its native key; preserve an existing selection only if loading occurred while Visual mode was active.
- [x] Remove empty waits after synchronous `plug#load()` and check required commands/functions once, throwing a useful error on failure. Batch the three Git plugin loads in one call.
- [x] Replace disassembly polling with a validity check and move the existing disassembly and terminal windows using `win_splitmove()` so adapter references and window menus remain valid.
- [x] Return the bookmark filename and replace shell `touch` with native `writefile()`, preserving ownership handling.
- [x] Run focused checks; review unchanged completion timer behavior and shortcut modes.

## Task 3: Native helpers and build commands

**Files:** Modify `.vimrc`; extend `tests/test_vimrc_functions.vim`.

**Interfaces:** Preserve build-system precedence, compiler flags, root-marker priority, public helper names, and copy-result semantics.

- [x] Add failing checks for Verilog compilation, multibyte/exclusive/block selections, and changing directories within one workspace. Characterize existing root/build precedence before refactoring.
- [x] Use `join(getregion(getpos("'<"), getpos("'>"), {'type': visualmode()}), ' ')` for selected text. Use `fnamemodify(root_marker, ':h')` for the workspace directory.
- [x] Select the requested directory once and compare it directly with `getcwd()`; escape constructed file and directory arguments with `fnameescape()`.
- [x] Remove overwritten build-list initializations and duplicate directories. Use `executable('ccache')`, quote shell path/file arguments, add the missing Verilog `&&`, and use `l:compile_only` in the compile-only branch.
- [x] Remove QuickUI's unused weight argument and unnecessary list copying. Combine class/struct searches, use one leading-space substitution, and set global `diffopt` outside the window loop.
- [x] Run both regression scripts, an actual startup/source check, mapping inventory comparison, and `git diff --check`.
- [x] Review the final diff. Stage the verified `.vimrc` at `/tmp/vimspector-completion-debug/vimrc.fixed` and use the already-approved copy command to synchronize `/home/banana/.vimrc`.
- [x] Verify repository and active configurations match; report results and any live-debugger limitations.

## Verification Commands

```sh
vim -Nu NONE -n -i NONE -es -S tests/test_vimrc_functions.vim
vim -Nu NONE -n -i NONE -es -S tests/test_vimspector_project_debug.vim
vim -Nu .vimrc -n -i NONE -es -c 'call timer_stopall()' -c 'call CocTimerStart(0)' -c 'qa!'
git diff --check
cmp .vimrc /home/banana/.vimrc
```

## Verification Results

- Reviewed all 111 original functions. `.vimrc` decreased from 2805 to 2660 lines (145 fewer).
- Both listed regression scripts and the actual startup check passed. New checks reproduce and cover window identity retention, canceled quits, terminal cleanup at final exit, first visual Ctrl-N selection, plugin reload, and real AsyncRun filename parsing/execution.
- Full mapping inventory comparison preserved every key/mode. QuickUI groups/order/descriptions, WhichKey dictionaries/rendering, Vim navigation, and debugger prompt maps matched. Intended RHS changes: `[tc`, `[td`, `[ti`, Shift-F5 remove bookkeeping; visual Ctrl-N restores its original selection.
- Independent review found no remaining critical or important issues. Live GUI/debug-adapter integration is not exercised; debugger commands are captured at the adapter boundary, with actual windows and installed plugin references inspected.
- `git diff --check` passed. No commit was made.

### Representative performance check

Local Vim 9.2.1129 on Linux x86_64, `/bin/sh`, CMake project with 120 source files and three nested source directories. Timed `CPPCompilation()` with `reltime()` for three runs of 50 calls each; compilation itself was not run. Commands: `vim -Nu NONE -n -i NONE -es -S /tmp/vimrc-function-refactor/performance-before.vim` and the corresponding `performance-after.vim` (scripts/config backup/results retained there).

Baseline wall times: 0.204690, 0.207606, 0.201698 seconds. Updated wall times: 0.007097, 0.006970, 0.007216 seconds. Median command-generation time per call decreased from 4.094 ms to 0.142 ms by replacing external ccache probing and unnecessary filesystem work. This measures command preparation only; it makes no compiler or debugger throughput claim. Normal use remains one call per shortcut and tens of tabs; terminal ownership has also been checked with 27 tabs.

- Verified configuration copied to `/home/banana/.vimrc` through the previously approved installation command. `cmp .vimrc /home/banana/.vimrc` passed; backup retained at `/tmp/vimrc-function-refactor/vimrc.active.before`.
