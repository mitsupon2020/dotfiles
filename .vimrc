inoremap <silent> jj <ESC>

"clpbj
set clipboard=unnamed
syntax enable


"filer
let g:netrw_banner = 0
let g:netrw_liststyle = 3

"tabをspace2つにする
set expandtab
set tabstop=2

"smart indent
set autoindent

"indentをspace2つにする
set shiftwidth=2

"制御文字を見えるようにする
"記号もかえる
"https://qiita.com/pollenjp/items/459a08a2cc59485fa08b
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

filetype plugin on
"color schemeをちょっとだけ変更
"MatchParen     xxx term=reverse ctermbg=6 guibg=DarkCyan
"autocmd ColorScheme * highlight MatchParen ctermfg=6 guifg=#008800
"highlight MatchParen ctermfg=6 guifg=#008800
"au ColorScheme * hi MatchParen cterm=bold ctermfg=214 ctermbg=black
"set background=dark
"うまく行かない
hi MatchParen cterm=bold ctermbg=none ctermfg=Magenta

"モードによるカーソルの切り替え
"https://qiita.com/Linda_pp/items/9e0c94eb82b18071db34
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモー,ド時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
"dash
"command! DashNim silent !open -g dash://nimrod:"<cword>"
"command! DashDef silent !open -g dash://"<cword>"
"nmap K :DashDef<CR>\|:redraw!<CR>

"undo history
if has('persistent_undo')
	let undo_path = expand('~/.vim/undo')
	exe 'set undodir=' .. undo_path
	set undofile
endif

"emacs like keybind in insert mode
"inoremap <C-p> <Up>
"inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
"inoremap <C-a> <HOME>
"inoremap <C-e> <END>
"inoremap <C-d> <Del>
"inoremap <C-h> <BS>
"inoremap <C-k> <Esc>D

inoremap <C-r> <C-p>

"haskell
command Hrun terminal bash %
