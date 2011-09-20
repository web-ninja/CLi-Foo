" Display linenumberes
:set number

" highlight current line
:set cursorline
set hidden
set scrolloff=10

set nocompatible

let mapleader=','

let g:EasyMotion_leader_key='<Leader>m'

" Turn on the verboseness to see everything vim is doing.
"set verbose=9

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" I like 4 spaces for indenting
set shiftwidth=4

" I like 4 stops
set tabstop=4

" Spaces instead of tabs
set expandtab

" Always  set auto indenting on
set autoindent

" select when using the mouse
:set selectmode=mouse

" 256 color mode
:set t_Co=256

" sweet theme by hcalves http://hcalves.deviantart.com/art/Mustang-Vim-Colorscheme-98974484
:colorscheme mustang
" for some reason the current line has an ugly underline, this removes that
:hi CursorLine cterm=NONE

" MRU seems broken, 
:let MRU_Max_Entries = 20

" get the help docs for my plugins
:helptags ~/.vim/doc

:set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 
:set statusline=2

map <F4> :TlistToggle<Enter>
map <F3> :NERDTreeToggle<Enter>

filetype off

filetype indent plugin on
au FileType php set omnifunc=phpcomplete#CompletePHP
au BufNewFile,BufRead *.html.twig set ft=html.twig
au BufNewFile,BufRead *.twig set syntax=twig
au BufNewFile,BufRead *.less set ft=less

let php_sql_query=1
let php_htmlInStrings=1

set showcmd
set ruler

let php_noShortTags = 1

let g:proj_flags = "icmsT"

:nmap <F5> :Project<Enter>

function! s:ExecuteInShell(command)
	let command = join(map(split(a:command), 'expand(v:val)'))
	let winnr = bufwinnr('^' . command . '$')
	silent! execute  winnr < 0 ? 'botright new ' . fnameescape(command) : winnr . 'wincmd w'
	setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap number
	echo 'Execute ' . command . '...'
	silent! execute 'silent %!'. command
	silent! execute 'resize ' . line('$')
	silent! redraw
	silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
	silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>'
	echo 'Shell command ' . command . ' executed.'
endfunction
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
