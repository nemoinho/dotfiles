" Start: Manage plugins
set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Plugin-Manager
Plugin 'git@github.com:VundleVim/Vundle.vim'

" A wiki within vim
Plugin 'git@github.com:vimwiki/vimwiki'

" A navigable visualization of vim's file-history
Plugin 'git@github.com:mbbill/undotree'

" A handy file-browser for vim
Plugin 'git@github.com:scrooloose/nerdtree'

" Utilities which are required by vim-snipmate
Plugin 'git@github.com:MarcWeber/vim-addon-mw-utils'
" Utilities which are required by vim-snipmate
Plugin 'git@github.com:tomtom/tlib_vim'
" Manage snippets as short cuts for vim
Plugin 'git@github.com:garbas/vim-snipmate'

" Add support for typecript-syntax
Plugin 'git@github.com:leafgarland/typescript-vim'

" Improve foldings on yaml-files (These are otherwise really unconvenient in vim)
Plugin 'git@github.com:pedrohdz/vim-yaml-folds'

" Add git-support, especially the command :Git
Plugin 'git@github.com:tpope/vim-fugitive'

" Autoformat tables in vim
Plugin 'git@github.com:godlygeek/tabular'

" Add git-status-marker in nerdtree
Plugin 'git@github.com:Xuyuanp/nerdtree-git-plugin'

" Enable syntax-checks
Plugin 'git@github.com:vim-syntastic/syntastic'

" Add markers for changed lines
Plugin 'git@github.com:airblade/vim-gitgutter'

" A magigical search-term for pretty much everything within vim
Plugin 'git@github.com:ctrlpvim/ctrlp.vim'

" Add a bunch of  support for csv-files
Plugin 'git@github.com:chrisbra/csv.vim'

" A navigable view of the tags/marks within a file
Plugin 'git@github.com:preservim/tagbar'

" Add support for js-syntax
Plugin 'git@github.com:jelera/vim-javascript-syntax'

" A 'surround' command similiar to the 'inner' commands (cs'" to change quotes)
Plugin 'git@github.com:tpope/vim-surround'

" A cool theme with good readability
Plugin 'git@github.com:lifepillar/vim-gruvbox8'

" A tool to remove every noisy output to concentrate on writing!
Plugin 'git@github.com:junegunn/goyo.vim'

" Add support for hcl (terraform, packer, etc.)
Plugin 'git@github.com:jvirtanen/vim-hcl'

" Add closing-tags in HTML/XML
Plugin 'git@github.com:alvan/vim-closetag.git'

" A tool to build HTML with a simplified selector-language
Plugin 'git@github.com:mattn/emmet-vim.git'

" Add a status/tabline at the bottom
Plugin 'git@github.com:vim-airline/vim-airline.git'

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
let g:tagbar_ctags_bin = '~/.local/opt/ctags/bin/ctags'

set bg=dark
" Settings
set listchars=tab:›\ ,trail:·,nbsp:_,extends:»,precedes:«
set list
set hlsearch
set number
set relativenumber
set nowrap
set linebreak
" Enable vim configs in the first or last lines of a file
set modeline
set modelineexpr

set tabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start

highlight LineNr ctermfg=7
highlight CusrsorLineNr ctermbg=green
highlight CusrsorLine ctermbg=green

colorscheme gruvbox8


" General utilities
nmap <Leader>gg :Goyo<CR>
nmap <Leader>l :set nu! relativenumber! wrap!<CR>
nmap <Leader>tw :set textwidth=72<CR>
nmap <Leader>q :qa!<CR>
nmap gv :vertical wincmd f<CR>
nnoremap <leader>cd :cd %:p:h<CR>

" Open shell with Ctrl+d to enable a toggle between a shell and vim
nnoremap <silent> <C-d> :botright terminal ++close<CR>
inoremap <silent> <C-d> <Esc>:botright terminal ++close<CR>

" Handle nerdtree and other utility-windows
nmap <Leader>, :NERDTreeFocus<CR>
nmap <Leader>c :NERDTreeClose<CR>
nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>t :TagbarToggle<CR>
nmap <Leader>u :UndotreeToggle<CR>

" Git
nmap <Leader>ga. :Git add %<CR>
nmap <Leader>gaa :Git add .<CR>
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gc :Git commit<CR>
nmap <Leader>gd :Git diff<CR>
nmap <Leader>gl :Git lg<CR>
nmap <Leader>gp :Git push -u origin<CR>
nmap <Leader>gs :Git status<CR>

" Install these files to ~/.vim/spell/
" http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl
" http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl
nmap <Leader>ss :set spell!<CR>
nmap <Leader>sd :set spelllang=de_de<CR>
nmap <Leader>se :set spelllang=en_us<CR>

" Tabularize
nmap <Leader>t, :Tabularize /,/l1<CR>
nmap <Leader>tc :Tabularize /;/l1<CR>
nmap <Leader>tp :Tabularize /\|/l1<CR>
nmap <Leader>tt :Tabularize /\|/l1<CR>

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
    " Close when only Nerdtree would remain
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup end
augroup diffgroup
    autocmd!
    " Copy global wrap in diff (This way I can use the same behavior in diff as in normal views)
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif
    if &diff
        nmap <Leader>1 :diffget LOCAL<CR>
        nmap <Leader>2 :diffget BASE<CR>
        nmap <Leader>3 :diffget REMOTE<CR>
    endif
augroup end
augroup vimwikigroup
    autocmd!
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
    autocmd FileType vimwiki set tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldlevel=10
    autocmd FileType vimwiki nmap <Leader>d :VimwikiDiaryIndex<CR>
    autocmd FileType vimwiki nmap <Leader>to :VimwikiTOC<CR>
    autocmd FileType vimwiki noremap ZZ :Goyo!<CR>:q<CR>
    " Fix broken backspace functionality on mac
    if has("unix")
        let s:uname = system("uname -s")
        if s:uname == "Darwin"
            autocmd FileType vimwiki nnoremap <C-H> <Plug>VimwikiGoBackLink
        endif
    endif
augroup end
