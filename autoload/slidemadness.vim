function! slidemadness#init() " {{{
  " Navigation
  nnoremap <buffer> == :call slidemadness#edit_next()<cr>
  nnoremap <buffer> -- :call slidemadness#edit_prev()<cr>

  " Default Settings

  set laststatus=0
  set foldmethod=marker
  set foldlevel=0

  " Run the terminal mods
  " Some terminal mods require sending escape codes, which aren't
  " propagated properly with a bare :!, exec ":!<stuff" seems
  " to fix it
  if filereadable('Styles.hs')
    let s:hs_header = ["import Styles"]
  else
    let s:hs_header = []
  endif
  if slidemadness#extract_into("cur.hs", s:hs_header, "-- > ")
    exec ":! runghc cur.hs"
    :! rm cur.hs
  endif

  " Load the vim settings
  if slidemadness#extract_into("cur.vim", ["setlocal background="], "-- :")
    source cur.vim
    :! rm cur.vim
  endif

  redraw!
  normal zm
endfunction " }}}

" Extract lines matching the given prefix into a file
"
" If no matching lines are found, do not write a file and return
" zero.
"
" If matching lines are found, write them to the specified file with
" the (possibly empty) header lines prepended and return nonzero.
"
function! slidemadness#extract_into(intoFile, header, prefix)
  let xs = readfile(expand("%"))
  let matches = []
  for x in xs
    if match(x, a:prefix) == 0
      let clean = substitute(x, a:prefix, "", "")
      call add(matches, clean)
    endif
  endfor
  if empty(matches)
    return 0
  else
    call writefile(a:header + matches, a:intoFile)
    return 1
  endif
endfunction

function! slidemadness#edit_next()
  let cur_file = expand("%:t")
  let files = systemlist("ls *.slide.*")
  let cur_index = index(files, cur_file)
  try
    exec ":e " . files[cur_index + 1]
  catch /E684:/
    echo "no more slides"
  endtry
endfunction

function! slidemadness#edit_prev()
  let cur_file = expand("%:t")
  let files = systemlist("ls *.slide.*")
  let cur_index = index(files, cur_file)
  if cur_index > 0
    exec ":e " . files[cur_index - 1]
  else
    echo "on first slide"
  endif
endfunction
