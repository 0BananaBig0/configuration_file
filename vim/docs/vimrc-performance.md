# Vimrc function performance review

Reviewed all 115 function definitions on 2026-10-03, using commit `4901b67`
as the baseline. Two functions were changed. This is a review of all functions,
not a claim that every function or interaction is faster.

## Changes

- `WorkspaceHasBuildFiles()` uses Vim's native `match()` on the directory listing
  instead of a Vimscript loop over every filename. It keeps sorted discovery,
  exact marker names, case-sensitive suffixes, and readability checks. Directories
  with matching names are skipped, and subsequent candidates are still checked.
- `JumpToTheMainWin()` sorts the current tab's window IDs numerically and stops
  at the first eligible window. It selects the same lowest eligible ID as before.
  It still returns zero without changing focus when there is no eligible window.

Plugin loading, helper-definition phases, filesystem search boundaries, root
selection, and `hi sym_hilight guifg='White' guibg='Black'` are unchanged. No
persistent caches were added.

## Measurements

Environment: Vim 9.2 patches 1–1129, x86-64 WSL2 Linux
6.18.33.2-microsoft-standard-WSL2, AMD Ryzen 7 H 260. Synthetic directory fixtures
were on `/tmp` (tmpfs); the actual repository was on FUSE. Measurements are
five-sample medians after a warm-up call. Initialization, fixture creation, and
plugin autocommands are excluded from the per-call timings. Runs were sequential.

| Case | Before, ms/call | After, ms/call |
| --- | ---: | ---: |
| 20 ordinary files, no build marker | 0.061348 | 0.026246 |
| 20 ordinary files, early `Makefile` | 0.019396 | 0.022516 |
| 1,000 ordinary files, no build marker | 2.481919 | 0.601060 |
| 10,000 ordinary files, no build marker | 26.238231 | 6.504520 |
| 10,000 ordinary files, early `Makefile` | 2.455466 | 2.499437 |
| 10,000 ordinary files, late `zz-final.mk` | 26.663869 | 6.473115 |
| Actual repository, 71 entries, FUSE | 17.181210 | 16.719897 |
| 4 source windows, oldest eligible | 0.022532 | 0.008125 |
| 8 source windows, oldest eligible | 0.039173 | 0.008058 |
| 8 windows, only newest eligible | 0.039907 | 0.044037 |
| 8 auxiliary windows, none eligible | 0.039111 | 0.045706 |
| QuickUI, 19 expanded groups / 242 mappings | 5.370480 | 5.367660 |

The native scan is about four times faster for large local directories with no
match or a late match. Early matches gain nothing; the 20-file case costs about
3 extra microseconds. Filesystem latency dominates the actual repository case,
whose overlapping sample ranges do not establish a meaningful speedup.

Window selection is about five times faster with eight windows when the oldest
window is eligible. A last-match or no-match scan costs about 4–7 extra
microseconds. Sorting changes window-list work from O(w) to O(w log w), while
avoiding most buffer-option lookups in the common first-match case. The benchmark
covers 1, 4, and 8 windows; it does not establish gains for hundreds of splits.

Directory-list storage remains O(n), and `readdir()` still sorts in O(n log n).
The improvement removes interpreted per-entry work, not filesystem I/O. Whole
benchmark processes took 12.88 s before and 9.48 s after, with peak RSS of 13,448
and 13,484 KiB respectively. These include setup and are not startup timings or
a memory improvement claim. QuickUI was measured but not changed.

## Reproduce

Run from the repository root with the existing Vim plugins installed:

```sh
git show 4901b67:.vimrc > /tmp/vimrc-before-performance.vim
/usr/bin/time -f 'wall=%e s peak_rss=%M KiB' \
  vim -Nu NONE -n -i NONE -es \
  --cmd "let g:vimrc_under_test='/tmp/vimrc-before-performance.vim'" \
  -S tests/benchmark_vimrc_functions.vim
/usr/bin/time -f 'wall=%e s peak_rss=%M KiB' \
  vim -Nu NONE -n -i NONE -es -S tests/benchmark_vimrc_functions.vim
```

The benchmark creates and removes its own temporary fixtures and only reads the
repository directory. It reports sample minima/maxima and checks lookup results.
No timing thresholds are added to correctness tests.

## Functions retained

- Plugin configuration, loaders, mappings, and timer callbacks: their ordering,
  FileType replay, and loading side effects must remain intact.
- Workspace paths, build-command generation, copy helpers, bookmarks, and debugger
  JSON: live filesystem/process state must remain visible on every invocation.
  Caching could miss newly created markers, file edits, or a terminal changing cwd.
- Terminal, tab, debugger-window, and quit helpers: window transitions, autocommands,
  process lifetime, modified-buffer handling, and focus restoration are observable.
- QuickUI and WhichKey: formatting depends on current mappings, options, dimensions,
  fold state, and search input. Rendering was already about 5.4 ms locally; no
  additional rendering cache was justified by this measurement.
- Editing, headers, indentation, selection, and code-block searches: existing
  built-ins do the bulk of the work. Combining editing passes can change undo,
  marks, search state, or event behavior; limiting searches can change the result.
- Small predicates and debugger forwarding wrappers: no demonstrated gain justified
  replacing them or duplicating their logic.

External plugin execution, a live debugger, GUI operation, and large-buffer
interactive latency were not benchmarked. No speedup is claimed for them.

## Verification

The three existing Vim test suites cover configuration, function behavior, and
project debugging. Added cases protect lowest-window-ID selection despite screen
order, exact/case-sensitive filenames, `nomagic`, and continuing past a directory
whose name matches a build marker. They pass before and after the optimization.
An independent review also compared the old/new filename predicates across case
and magic options and unusual filenames.
