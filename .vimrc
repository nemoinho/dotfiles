" Start: Manage plugins
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'git@github.com:VundleVim/Vundle.vim.git'

Plugin 'git@github.com:MarcWeber/vim-addon-mw-utils.git'
Plugin 'git@github.com:Xuyuanp/nerdtree-git-plugin.git'
Plugin 'git@github.com:airblade/vim-gitgutter.git'
Plugin 'git@github.com:alvan/vim-closetag.git'
Plugin 'git@github.com:chrisbra/csv.vim.git'
Plugin 'git@github.com:ctrlpvim/ctrlp.vim.git'
Plugin 'git@github.com:garbas/vim-snipmate.git'
Plugin 'git@github.com:godlygeek/tabular.git'
Plugin 'git@github.com:jelera/vim-javascript-syntax.git'
Plugin 'git@github.com:junegunn/goyo.vim.git'
Plugin 'git@github.com:leafgarland/typescript-vim.git'
Plugin 'git@github.com:majutsushi/tagbar.git'
Plugin 'git@github.com:mattn/emmet-vim.git'
Plugin 'git@github.com:mbbill/undotree.git'
Plugin 'git@github.com:morhetz/gruvbox.git'
Plugin 'git@github.com:pedrohdz/vim-yaml-folds.git'
Plugin 'git@github.com:scrooloose/nerdtree.git'
Plugin 'git@github.com:tomtom/tlib_vim.git'
Plugin 'git@github.com:tpope/vim-fugitive.git'
Plugin 'git@github.com:tpope/vim-surround.git'
Plugin 'git@github.com:vim-airline/vim-airline.git'
Plugin 'git@github.com:vim-syntastic/syntastic.git'
Plugin 'git@github.com:vimwiki/vimwiki.git'

call vundle#end()
" End: Manage plugins
filetype plugin on

syntax on

let mapleader = ","
let g:gruvbox_contrast_dark = 'hard'
let g:vimwiki_table_mappings = 0
let g:vimwiki_folding = 'expr'
let g:vimwiki_list = [{'path': '~/Development/nemoinho/gitea.nehrke.info/nemoinho/vimwiki/', 'auto_export': 1}]
let g:NERDTreeGitStatusShowIgnored = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:snipMate = { 'snippet_version' : 1 }

set bg=dark
set listchars=tab:›\ ,trail:·,nbsp:_,extends:»,precedes:«
set list
set hlsearch
set number
set nowrap
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

highlight LineNr ctermfg=7
highlight CusrsorLineNr ctermbg=green
highlight CusrsorLine ctermbg=green

colorscheme gruvbox

" sorted alphabetically to avoid conflicts, even if it's harder to read!
imap <silent> <C-d> <Esc>:botright terminal ++close<CR>
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
nmap <Leader>, :NERDTreeFocus<CR>
nmap <Leader>c :NERDTreeClose<CR>
nmap <Leader>d :VimwikiDiaryIndex<CR>
nmap <Leader>f <C-w>w
nmap <Leader>g :Goyo<CR>
nmap <Leader>ga. :Git add %<CR>
nmap <Leader>gaa :Git add .<CR>
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gd :Git diff<CR>
nmap <Leader>gg :Goyo<CR>
nmap <Leader>gl :Git lg<CR>
nmap <Leader>gp :Git push -u origin<CR>
nmap <Leader>gs :Git status<CR>
nmap <Leader>l :set nu! relativenumber! wrap!<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>q :qa!<CR>
nmap <Leader>sd :set spelllang=de_de<CR>
nmap <Leader>se :set spelllang=en_us<CR>
nmap <Leader>ss :set spell!<CR>
nmap <Leader>t, :Tabularize /,/l1<CR>
nmap <Leader>tc :Tabularize /;/l1<CR>
nmap <Leader>tp :Tabularize /\|/l1<CR>
nmap <Leader>tt :Tabularize /\|/l1<CR>
nmap <Leader>u :UndotreeToggle<CR>
nmap <Leader>w :set wrap!<CR>
nmap <silent> <C-d> <Esc>:botright terminal ++close<CR>
nmap gv :vertical wincmd f<CR>

augroup jsgroup
    autocmd!
    autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldlevel=5
augroup end
augroup yamlgroup
    autocmd!
    autocmd FileType yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldlevel=4
augroup end
augroup nerdtreegroup
    autocmd!
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup end
augroup diffgroup
    autocmd!
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif
augroup end
augroup vimwikigroup
    autocmd!
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
    "autocmd BufWritePost 20*-*-*.wiki execute 'silent ! vim -c VimwikiDiaryIndex -c VimwikiDiaryGenerateLinks -c x'
    autocmd FileType vimwiki set tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldlevel=10
    autocmd FileType vimwiki nmap <Leader>we <Plug>VimwikiTabnewLink
    autocmd FileType vimwiki nmap <Leader>to :VimwikiTOC<CR>
    autocmd FileType vimwiki noremap ZZ :Goyo!<CR>:q<CR>
    " Fix broken backspace functionality on mac
    autocmd FileType vimwiki nmap <C-H> <Plug>VimwikiGoBackLink
    "autocmd BufRead,BufNewFile *.wiki :Goyo 80
    "autocmd FileType vimwiki nmap <Leader>tp :Tabularize /\|/l0<CR>
    "autocmd FileType vimwiki nmap <Leader>tt :Tabularize /\|/l0<CR>
    inoremap <silent> <Bar>   <Bar>

    " Autocommit stuff
    "autocmd BufWritePost $HOME/vimwiki/* execute 'silent ! FILE=$(basename %); cd $(dirname %); if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 ; then git add $FILE > /dev/null 2>&1; git commit -m $FILE > /dev/null 2>&1; git push > /dev/null 2>&1; fi'
augroup end

" Utility function to format tables in real time
" (only for pipe-separated tables)
function! s:align()
  let p = '^\s*|\s.*\s|\s*'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
