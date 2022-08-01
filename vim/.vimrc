" Environment {
  set nocompatible
  set termguicolors
  set t_Co=256
" }

" Vim defaults {
  let mapleader = ','
  scriptencoding utf-8
  set timeoutlen=200
  set ttimeoutlen=0
  set updatetime=500
  set noshowmode

  " Language
  set langmenu=en_US
  let $LANG = 'en_US'
" }

" vim-plug {
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
  if has("nvim") && empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  if filereadable(expand("~/.vimrc.plugs"))
    source ~/.vimrc.plugs
  endif
" }

" ii instead of Esc {
  inoremap ii <Esc>
" }

" Vim moving {
  set mouse=a
  set mousehide

  map <S-Down> <C-W>j
  map <S-Up> <C-W>k
  map <S-Right> <C-W>l
  map <S-Left> <C-W>h

  map <S-Left><S-Left> <ESC>:tabprev<CR>
  map <S-Right><S-Right> <ESC>:tabnext<CR>
  map <C-t> <ESC>:tabnew<CR>
  map <C-y> <ESC>:tabclose<CR>

" }

" " Vim style {
  set t_Co=256                                  " Fixes problems of color in vim airline

  set nospell

  syntax enable
  set background=dark

  colorscheme solarized8

  highlight Search cterm=NONE ctermfg=7 ctermbg=4
" }

" Lines {
  set nowrap                                    " Doesn't break lines when too long
  set backspace=indent,eol,start
  set linespace=0                                " No extra space between rows
  set nu                                         " Line numbers on
  set showmatch                                  " Show matching brackets/parenthesis
  set incsearch                                  " Find as you type search
  set hlsearch                                   " Highlight search terms
  set winminheight=0                             " Windows can be 0 line high
  set ignorecase                                 " Case insensitive search
  set smartcase                                  " Case sensitive when uc present
  set wildmenu                                   " Show list instead of just completing
  set wildmode=list:longest,full                 " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]                  " Backspace and cursor keys wrap too
  set scrolljump=5                               " Lines to scroll when cursor leaves screen
  set scrolloff=3                                " Minimum lines to keep above and below cursor
  set foldenable                                 " Auto fold code
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:• " Highlight problematic whitespace
  set expandtab                                  " Tabs to spaces
  set tabstop=2                                  " 2 spaces instead of tabs
  set shiftwidth=2
  set synmaxcol=1024                             " Syntax check should not check very long lines
  set autoread                                   " Automatically reload files when checktime is called and file changed
" }

" Terminal {
  tnoremap <Esc><Esc> <C-\><C-n>
" }

" Copy {
  if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
    noremap <A-v> ^O:set paste<Enter>^R+^O:set nopaste<Enter>
  else " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
    nnoremap <silent> <leader>p :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
    inoremap <silent> <leader>p <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
    nnoremap <silent> <leader>y :.w !pbcopy<CR><CR>
    vnoremap <silent> <leader>y :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
  endif
" }

" Needed directories {
  function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
          \ 'backup': 'backupdir',
          \ 'views': 'viewdir',
          \ 'swap': 'directory' }

    if has('persistent_undo')
      let dir_list['undo'] = 'undodir'
    endif

    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
      let directory = common_dir . '/' . dirname . '/'
      if exists("*mkdir")
        if !isdirectory(directory)
          call mkdir(directory)
        endif
      endif
      if !isdirectory(directory)
        echo "Warning: Unable to create directory: " . directory
        echo "Try: mkdir -p " . directory
      else
        let directory = substitute(directory, " ", "\\\\ ", "g")
        exec "set " . settingname . "=" . directory
      endif
    endfor
  endfunction
  call InitializeDirectories()
" }

" Quickfix {
  " Auto-opening
  autocmd QuickFixCmdPost * nested cwindow | redraw!

  " Automatically fit Quickfix to number of lines
  au FileType qf call AdjustWindowHeight(2, 10)
  function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$") + 1, a:maxheight]), a:minheight]) . "wincmd _"
  endfunction
" }

" Restore cursor when opening a file {
  function! ResCur()
    if line("'\"") <= line("$")
      normal! g`"
      return 1
    endif
  endfunction

  augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
  augroup END
" }

" Files management {
  set backup " Backups are nice ...
  if has('persistent_undo')
    set undofile " So is persistent undo ...
    set undolevels=1000 " Maximum number of changes that can be undone
    set undoreload=10000 " Maximum number lines to save for undo on a buffer reload
  endif
" }

" NerdTree {
   map <Leader>n <plug>NERDTreeTabsToggle<CR>
" }

" Compilation {
  autocmd QuickFixCmdPost * nested cwindow | redraw!
" }

" Saving {
  cmap w!! w !sudo tee % >/dev/null
" }

" Deoplete {
  let g:deoplete#enable_at_startup = 1

  " See also Tern
" }

" Airline {
  set laststatus=2                " Or airline won't activate before a new split

  let g:airline_powerline_fonts = 1
  let g:airline_theme='solarized'
  let g:airline_solarized_bg='dark'
" }

" Ale {
  let g:ale_linters_explicit = 1
  let g:ale_fix_on_save = 0

  let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ 'scss': ['stylelint']
    \ }
  let g:ale_fixers = {
    \ 'javascript': ['eslint'],
    \ 'typescript': ['prettier'],
    \ 'scss': ['stylelint', 'prettier']
    \ }
" }
"
" nvim typescript {
  let g:nvim_typescript#diagnostics_enable=0
  let g:nvim_typescript#max_completion_detail=100
" }

" echodoc {
  let g:echodoc_enable_at_startup = 1
" }

" rg {
  if executable('rg')
    set grepprg=rg\ --vimgrep
    " CtrlP {
      let g:ctrlp_user_command_async = 1
      let g:ctrlp_user_command = 'rg %s --files --hidden --follow --color=never --glob "!.git/*"'
      let g:ctrlp_use_caching = 0
    " }
    " FZF {
      map <C-o> <ESC>:Rg<CR>
    " }
  endif
" }

" JavaScript {
  " mxw/vim-jsx
  let g:jsx_ext_required = 0
" }

" Tern {
  " Use deoplete.
  let g:tern_request_timeout = 1
  let g:deoplete#sources#ternjs#types = 1
  " let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

  "Add extra filetypes
  let g:tern#filetypes = [
        \ 'jsx',
        \ 'javascript.jsx',
        \ 'vue',
        \ ]

  " Use tern_for_vim.
  let g:tern#command = ["tern"]
  let g:tern#arguments = ["--persistent"]

  " Automatically close the preview window when the completion is done
  autocmd CompleteDone * pclose
" }

" Markdown {
  let g:markdown_fenced_languages = [
    \ 'coffee',
    \ 'html',
    \ 'css',
    \ 'erb=eruby',
    \ 'javascript',
    \ 'js=javascript',
    \ 'json=javascript',
    \ 'ruby',
    \ 'sass',
    \ 'xml'
    \ ]
" }

" SQL {
  " Disable dbext
   let g:omni_sql_no_default_maps = 1
" }

" Salt {
  augroup filetypedetect
    au BufRead,BufNewFile *.sls setfiletype yaml
  augroup END
" }

" Project-local .vimrc s {
  set exrc
  set secure
" }
