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

" A calendar-integration
Plugin 'git@github.com:mattn/calendar-vim.git'

call vundle#end()
" End: Manage plugins
filetype plugin on

syntax on

let mapleader = ","

let g:gruvbox_contrast_dark = 'hard'
let g:vimwiki_table_mappings = 0
let g:vimwiki_folding = 'expr'
let g:vimwiki_list = [{'path': '~/Development/nemoinho/gitea.nehrke.info/nemoinho/vimwiki/', 'auto_export': 1}]
let g:vimwiki_autowriteall = 0
let g:vimwiki_url_maxsave = 0
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
nnoremap <leader>cd :cd %:p:h<CR>
nnoremap <Leader>gg :Goyo<CR>
nnoremap <Leader>l :set nu! relativenumber! wrap!<CR>
nnoremap <leader>m :make<CR>
nnoremap <Leader>q :qa!<CR>
nnoremap gv :vertical wincmd f<CR>

" Open shell with Ctrl+d to enable a toggle between a shell and vim
nnoremap <silent> <C-d> :botright terminal ++close<CR>
inoremap <silent> <C-d> <Esc>:botright terminal ++close<CR>

" Handle nerdtree and other utility-windows
nnoremap <Leader>, :NERDTreeFocus<CR>
nnoremap <Leader>c :NERDTreeClose<CR>
nnoremap <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>u :UndotreeToggle<CR>

" Git
nnoremap <Leader>ga. :Git add %<CR>
nnoremap <Leader>gaa :Git add .<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gc :Git commit<CR>
nnoremap <Leader>gd :Git diff<CR>
nnoremap <Leader>gl :Git lg<CR>
nnoremap <Leader>gp :Git push -u origin<CR>
nnoremap <Leader>gs :Git status<CR>
nnoremap <Leader>tw :set textwidth=72<CR>

" Install these files to ~/.vim/spell/
" http://ftp.vim.org/vim/runtime/spell/en.utf-8.spl
" http://ftp.vim.org/vim/runtime/spell/de.utf-8.spl
nnoremap <Leader>ss :set spell!<CR>
nnoremap <Leader>sd :set spelllang=de_de<CR>
nnoremap <Leader>se :set spelllang=en_us<CR>

" Tabularize
nnoremap <Leader>t, :Tabularize /,/l1<CR>
nnoremap <Leader>tc :Tabularize /;/l1<CR>
nnoremap <Leader>tp :Tabularize /\|/l1<CR>
nnoremap <Leader>tt :Tabularize /\|/l1<CR>

" diffs
if &diff
    nnoremap <Leader>1 :diffget LOCAL<CR>
    nnoremap <Leader>2 :diffget BASE<CR>
    nnoremap <Leader>3 :diffget REMOTE<CR>
endif

augroup configgroup
    autocmd!
    autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldlevel=5
    autocmd FileType yaml set tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldlevel=4

    " Close when only Nerdtree would remain
    autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Copy global wrap in diff (This way I can use the same behavior in diff as in normal views)
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif

    autocmd FileType asciidoc nnoremap <silent> <C-a> :call system('asciidoctor *.adoc')<CR>
    autocmd FileType asciidoc nnoremap <silent> <C-s> :call system('asciidoctor-pdf *.adoc')<CR>

    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
    autocmd BufRead,BufNewFile *.wiki set wrap nonumber norelativenumber
    "autocmd BufRead,BufNewFile *.wiki Goyo 80 | set wrap
    autocmd FileType vimwiki set tabstop=2 softtabstop=2 shiftwidth=2 expandtab foldlevel=10
    autocmd FileType vimwiki nnoremap <Leader>d :VimwikiDiaryIndex<CR>
    autocmd FileType vimwiki nnoremap <Leader>to :VimwikiTOC<CR>
    autocmd FileType vimwiki nnoremap <Leader>q :Goyo!<CR>:q<CR>
    autocmd FileType vimwiki nnoremap <silent> <Leader>x :call system('git add . && git commit -m "Auto commit" && git push')<CR>
    autocmd FileType vimwiki nnoremap ZZ :Goyo!<CR>:x<CR>
    " Fix broken backspace functionality on mac
    if has("unix")
        let s:uname = system("uname -s")
        if s:uname == "Darwin"
            autocmd FileType vimwiki nnoremap <C-H> <Plug>VimwikiGoBackLink
        endif
    endif
augroup end
