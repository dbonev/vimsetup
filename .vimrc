if has("gui_macvim")
	colorscheme vividchalk
endif

if has("gui_macvim")
    let macvim_hig_shift_movement = 1
endif

:set nu
:set rnu
:set tabstop=4
:set shiftwidth=4
:set ruler
:set nowrap
:set smartindent
:set ignorecase
:set smartcase
:set incsearch
:set laststatus=2
" highlight search and set space (in normal mode) to clear the highlight
:set hlsearch
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

:command W w
:command Q q
:command Wq wq
:command CDF :cd %:p:h
:command DIFF :w !diff % -

:set expandtab
:set tabstop=4

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
:set clipboard=unnamedplus
map <F4> :e %:p:s,.h$,.X123X,:s,.m$,.h,:s,.X123X$,.m,<CR>

" this remaps autocomplete to be Ctrl-Space instead of Ctrl-N
if has("gui_running")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif
execute pathogen#infect()
let NERDTreeShowLineNumbers=1
"autocmd BufEnter * NERDTreeMirror
silent! nmap <C-t> :NERDTreeToggle<CR>
silent! nmap <F8> :TagbarToggle<CR>
silent! nmap <C-m> :NERDTreeMirror<CR>
silent! nmap <C-s> :NERDTreeFind<CR>
silent! nmap <C-q> :set wrap<CR>:set lbr<CR>
silent! nmap <C-p> :CtrlP .<CR>
:let g:notes_directories=['~/Dropbox/Notes']

"let g:NERDTreeMapActivateNode="<F3>"
"let g:NERDTreeMapPreview="<F4>"
