function! slidemadness#init() " {{{
  if system('ls') =~ '^Styles.hs'
    let s:hs_header = ["import Styles"]
  else
    let s:hs_header = []
  endif

  call slidemadness#extract_into("cur.hs", s:hs_header, "-- > ")
  call slidemadness#extract_into("cur.vim", ["setlocal background="], "-- :")

  " Navigation
  nnoremap <buffer> == :call slidemadness#edit_next()<cr>
  nnoremap <buffer> -- :call slidemadness#edit_prev()<cr>

  " Default Settings

  set laststatus=0
  set foldmethod=marker
  set foldlevel=0

  " Run the terminal mods
  :! runghc cur.hs
  :! rm cur.hs

  " Load the vim settings
  source cur.vim
  :! rm cur.vim

  redraw!
  normal zm
endfunction " }}}

function! slidemadness#extract_into(intoFile, header, prefix)
  let xs = readfile(expand("%"))
  let matching = deepcopy(a:header)
  for x in xs
    if match(x, a:prefix) == 0
      let clean = substitute(x, a:prefix, "", "")
      call add(matching, clean)
    endif
  endfor
  call writefile(matching, a:intoFile)
endfunction

function! slidemadness#edit_next()
  let file = expand("%:t")
  let slideNum = file + 0
  exec ":e " . string(slideNum + 1) . ".*.slide.*"
endfunction

function! slidemadness#edit_prev()
  let file = expand("%:t")
  let slideNum = file + 0
  exec ":e " . string(slideNum - 1) . ".*.slide.*"
endfunction
