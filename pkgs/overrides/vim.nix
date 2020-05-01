{ pkgs }:

pkgs.neovim.override {
  withPython = false;
  withPython3 = true;
  withRuby = false;
  withNodeJs = false;

  vimAlias = true;
  viAlias = true;

  configure = {
    customRC = ''
      set nocompatible
      filetype off
      let mapleader = ","

      " basics
      set bg=light
      set go=a
      set mouse=a
      set clipboard=unnamedplus
      set number relativenumber
      filetype plugin indent on
      filetype plugin on
      syntax on
      set clipboard=unnamedplus
      set encoding=utf-8

      "vimwiki
      let g:vimwiki_list = [{'path': '~/vimwiki/',
              \ 'syntax': 'markdown', 'ext': '.md'}]
      autocmd FileType vimwiki inoremap <leader>t <Esc>:VimwikiTable<Enter>

      "airline
      let g:airline_theme='base16color'

      " autocomplete
      set wildmode=longest,list,full

      "super tab
      set completeopt=longest,menuone

      " Disable automatic commenting on newline
      autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

      " Goyo
      map <leader>g :Goyo<CR> :colorscheme default<CR>

      " Spell-check set to <leader>o, 'o' for 'orthography':
      map <leader>o :setlocal spell! spelllang=fr,en<CR>

      " Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
      set splitbelow splitright

      " Shortcutting split navigation, saving a keypress:
      	map <C-h> <C-w>h
      	map <C-j> <C-w>j
      	map <C-k> <C-w>k
      	map <C-l> <C-w>l

      " Automatically deletes all trailing whitespace on save.
      	autocmd BufWritePre * %s/\s\+$//e

      " Navigating with guides
      	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
      	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
      	map <leader><leader> <Esc>/<++><Enter>"_c4l

      " open up vim.nix
        map <leader>v <Esc>:vsplit /etc/nixos/pkgs/overrides/vim.nix<Enter>

      " open up ranger
        map <leader>f <Esc>:RangerVSplit<Enter>

      " set nohlsearch
      	nnoremap <Esc> :noh<return><Esc>

      " Sourcing from home for quick changes
      if $USER != 'root'
        if filereadable("~/.extravimrc")
          source ~/.extravimrc
        endif
      endif

      """LATEX
        " Compile document, be it groff/LaTeX/markdown/etc.
        autocmd FileType tex,md,go,py,vimwiki map <leader>c :w! \| !compiler <c-r>%<CR>

        " Open corresponding .pdf/.html or preview
        autocmd FileType tex,md,vimwiki map <leader>p :!openpreview <c-r>%<CR><CR>

        " Runs a script that cleans out tex build files whenever I close out of a .tex file.
      	autocmd VimLeave *.tex !texclear %

      	" Word count:
      	autocmd FileType tex map <leader>w :w !detex \| wc -w<CR>

      	" Code snippets
        autocmd FileType tex inoremap <leader>fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
      	autocmd FileType tex inoremap <leader>fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><Esc>3kA
      	autocmd FileType tex inoremap <leader>exe \begin{exe}<Enter>\ex<Space><Enter>\end{exe}<Enter><Enter><++><Esc>3kA
      	autocmd FileType tex inoremap <leader>em \emph{}<++><Esc>T{i
      	autocmd FileType tex inoremap <leader>bf \textbf{}<++><Esc>T{i
      	autocmd FileType tex inoremap <leader>un \underline{}<++><Esc>T{i
      	autocmd FileType tex inoremap <leader>colo {\color{}<++>}<++><Esc>T{i
      	autocmd FileType tex inoremap <leader>graph \includegraphics[]{<++>}<++><Esc>T[i
      	autocmd FileType tex vnoremap <leader> <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
      	autocmd FileType tex inoremap <leader>it \textit{}<++><Esc>T{i
      	autocmd FileType tex inoremap <leader>ct \textcite{}<++><Esc>T{i
      	autocmd FileType tex inoremap <leader>cp \parencite{}<++><Esc>T{i
      	autocmd FileType tex inoremap <leader>x \begin{xlist}<Enter>\ex<Space><Enter>\end{xlist}<Esc>kA<Space>
      	autocmd FileType tex inoremap <leader>ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
      	autocmd FileType tex inoremap <leader>ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
      	autocmd FileType tex inoremap <leader>li <Enter>\item<Space>
      	autocmd FileType tex inoremap <leader>ref \ref{}<Space><++><Esc>T{i
      	autocmd FileType tex inoremap <leader>tabl \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
      	autocmd FileType tex inoremap <leader>tabu \begin{tabu}<Space>to<Space>\textwidth<Space>{}<Enter><++><Enter>\end{tabu}<Enter><Enter><++><Esc>4k2f{a
      	autocmd FileType tex inoremap <leader>ot \begin{tableau}<Enter>\inp{<++>}<Tab>\const{<++>}<Tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><Esc>5kA{}<Esc>i
      	autocmd FileType tex inoremap <leader>can \cand{}<Tab><++><Esc>T{i
      	autocmd FileType tex inoremap <leader>ce \begin{center}<Enter><Enter>\end{center}<Enter><Enter><++><Esc>3kA
      	autocmd FileType tex inoremap <leader>bl \begin{block}{}<Enter><++><Enter>\end{block}<Enter><Enter><++><Esc>4k2f}i
      	autocmd FileType tex inoremap <leader>fig \begin{figure}<Enter><Enter>\end{figure}<Enter><Enter><++><Esc>3kA
      	autocmd FileType tex inoremap <leader>wfig \begin{wrapfigure}{}{<++>}<Enter><++><Enter>\end{wrapfigure}<Enter><Enter><++><Esc>4k2f{a
      	autocmd FileType tex inoremap <leader>abst \begin{abstract}<Enter><Enter>\end{abstract}<Enter><Enter><++><Esc>3kA
      	autocmd FileType tex inoremap <leader>con \const{}<Tab><++><Esc>T{i
      	autocmd FileType tex inoremap <leader>a \href{}{<++>}<Space><++><Esc>2T{i
      	autocmd FileType tex inoremap <leader>sc \textsc{}<Space><++><Esc>T{i
      	autocmd FileType tex inoremap <leader>chap \chapter{}<Enter><Enter><++><Esc>2kf}i
      	autocmd FileType tex inoremap <leader>sec \section{}<Enter><Enter><++><Esc>2kf}i
      	autocmd FileType tex inoremap <leader>ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
      	autocmd FileType tex inoremap <leader>sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
      	autocmd FileType tex inoremap <leader>para \paragraph{}<Enter><Enter><++><Esc>2kf}i
      	autocmd FileType tex inoremap <leader>st <Esc>F{i*<Esc>f}i
      	autocmd FileType tex inoremap <leader>beg \begin{DELRN}<Enter><++><Enter>\end{DELRN}<Enter><Enter><++><Esc>4k0fR:MultipleCursorsFind<Space>DELRN<Enter>c
      	autocmd FileType tex inoremap <leader>up <Esc>/usepackage<Enter>o\usepackage{}<Esc>i
      	autocmd FileType tex inoremap <leader>tt \texttt{}<Space><++><Esc>T{i
      	autocmd FileType tex inoremap <leader>bt \blindtext
      	autocmd FileType tex inoremap <leader>nu $\varnothing$
      	autocmd FileType tex inoremap <leader>colu \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<Esc>5kA
      	autocmd FileType tex inoremap <leader>rn (\ref{})<++><Esc>F}i

        colorscheme default


    '';
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = [
        goyo-vim
        vim-airline
        vim-airline-themes
        vim-nix
        supertab
        wal-vim
        ranger-vim
        vimwiki
      ];
      opt = [ ];
    };
  };
}
