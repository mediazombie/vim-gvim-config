" Standardverhalten von Vim
if &compatible
  set nocompatible
endif

" Alle Signaltöne global deaktivieren (Windows)
set belloff=all

" ---------------------------------------------------------------------------------

" Start Plugin-Manager - Infos siehe: https://vimawesome.com/
call plug#begin()

Plug 'scrooloose/nerdtree'          " Dateimanager (Explorer)
Plug 'vim-airline/vim-airline'      " Bessere, schönere Statusbar (inkl. Git-integration)
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'                 " Dark-Mode Theme
Plug 'ctrlpvim/ctrlp.vim'           " Fuzzysearch in Projektverzeichnis
Plug 'sirver/ultisnips'             " Vordfinierte Textbausteine verwenden
Plug 'tpope/vim-surround'           " Umschliessende Elemente ändern, löschen, hinzufügen
" Folgende Befehle sind möglich: cs<zeichen-alt><zeichen-neu> (z.B. cs*") bei tags `cst<zeichen-neu>`
" Umschliessendes Zeichen löschen `ds<zeichen-aktuell>`
Plug 'scrooloose/syntastic'         " Syntax überprüfungs-hacks für Vim
Plug 'fatih/vim-go'                 " go-Entwickler plugin für Vim
Plug 'rust-lang/rust.vim'           " Rust Plugin, syntax und formatierung
Plug 'tpope/vim-fugitive'           " Git wrapper plugin für Vim

call plug#end()

" ---------------------------------------------------------------------------------

" syntastic (Syntax hervorhebung) - Einstellungen
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_check_on_wq = 0

" ---------------------------------------------------------------------------------

" Statusbar Theme und Fonts einstellen

" aktiviert die Powerline-Symbole für Airline
let g:airline_powerline_fonts = 1

" Falls die Symbole immer noch nicht stimmen, kann man sie erzwingen:
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Setzt das Murmur-Theme
let g:airline_theme='murmur'
" let g:airline_theme='one'

" Font setzen
set guifont=DejaVu_Sans_Mono_for_Powerline:h11

" Fenstergrösse festlegen
set lines=50
set columns=170

" Dark Mode aktivieren
" set guifont=Consolas:h11 " Font definieren
syntax on " enable würde hier auch funktionieren, hat aber nicht die gleiche Funktion
colorscheme one
set background=dark " for the dark version
" set background=light " for the light version

" ---------------------------------------------------------------------------------

" Dateispezifische Syntaxhevorhebung aktivieren
filetype plugin indent on
" Automatisch bei Tabulator und Zeilunmbruch in der Tiefe stehen bleiben
set autoindent
" Tab in Leerzeichen umwandeln
set expandtab
" Buffer wechseln ohne Buffer (Datei) zu entladen
set hidden
" Encoding auf UTF-8 einstellen
set encoding=utf-8
" Hervorhebung bei Suche aktivieren
set hlsearch " deaktivieren mit `:nohlsearch`
" Anzahl gespeicherter eingegebener Befehle
set history=1000

" ---------------------------------------------------------------------------------

" Zeilennummern und relative Zeilennummern aktivieren
set number
set relativenumber
set numberwidth=5
set colorcolumn=81

" Offset für das scrollen auf 7 Zeilen einstellen
set scrolloff=7

" Auswahlmenuband bei Autovervollständigen von Befehlen
set wildmenu

" Fold-Spalte anzeigen
set foldcolumn=1

" Undo-Datei aktivieren und Pfad definieren
" Pfad für Undo-Dateien unter Windows definieren
if !isdirectory($USERPROFILE . '/.vim/undo-dir')
    call mkdir($USERPROFILE . '/.vim/undo-dir', 'p', 0700)
endif

set undodir=$USERPROFILE/.vim/undo-dir

" Pfad für Undo-Dateien unter Linux/MacOS definieren
" if !isdirectory($HOME . '/.vim/undo-dir')
"    call mkdir($HOME . '/.vim/undo-dir', 'p', 0700)
" endif

" set undodir=$HOME/.vim/undo-dir

set undofile

" Empfohlene Werte für die Undo-Tiefe
set undolevels=1000
set undoreload=10000

" Stummschalten von Fehlersignalen (Audible Bell)
set noerrorbells
set novisualbell
set t_vb=

" ---------------------------------------------------------------------------------

" Verhindert, dass Windows die Alt-Taste für die Menüleiste abfängt
set winaltkeys=no

" Eigene Tastatur-Mappings
let mapleader=" "

map <leader>w :w<cr> " Speichern
map <leader>q :q<cr> " Schliessen
imap <leader>w :w<cr>l
vmap <leader>w :w<cr>

" Funktion zum Umschalten des Zeilenumbruchs
function! ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap
        setlocal nolinebreak
        " Zeilenumbruch-Indikator entfernen
        setlocal showbreak=
    else
        echo "Wrap ON"
        setlocal wrap
        setlocal linebreak
        " Optional: Ein schönes Symbol am Anfang der umbrochenen Zeile
        setlocal showbreak=+++
    endif
endfunction

" Automatische Einstellungen für Text und Markdown
augroup FileTypeWrap
  autocmd!
  " Dateitypen txt und md aktivieren
  autocmd BufNewFile,BufRead *.txt,*.md setlocal wrap        " Visueller Umbruch aktivieren
  autocmd BufNewFile,BufRead *.txt,*.md setlocal linebreak  " Nur bei ganzen Wörtern umbrechen
  autocmd BufNewFile,BufRead *.txt,*.md setlocal nolist      " list verhindert linebreak-Funktion
  autocmd BufNewFile,BufRead *.txt,*.md setlocal textwidth=0 " Keine harten Umbrüche setzen
  autocmd BufNewFile,BufRead *.txt,*.md setlocal wrapmargin=0
augroup END

" Mapping auf F3 setzen (Normal und Insert Mode)
nnoremap <F3> :call ToggleWrap()<CR>
inoremap <F3> <C-o>:call ToggleWrap()<CR>

" Zeilen im Visual-Mode hoch und runter verschieben (Alt+j und Alt+k)
vmap <M-j> :m '>+1<CR>gv=gv " <CR>
vmap <M-k> :m '>-2<CR>gv=gv " <CR>

" Schnellwechsel zwischen offenen Dateien (Buffern)
map <Tab> :bnext<CR>
map <S-Tab> :bprevious<CR>

" In Visual-Zeilen-Modus wechseln / Visual-Block-Modus wechseln
" map <leader>V V
" map <leader>v <C-v>

map <leader>s :setlocal spell!<cr> " Rechtschreibprüfung umschalten
map <leader>y :%y+<cr>:%y<cr> " Ganzen Buffer in das Register `+` speichern zur weiteren Verwendung in anderer Datei

" NERDTree (File Explorer) Mapping
map <leader>n :NERDTreeFocus<CR>
map <leader>e :NERDTree<CR>
map <C-t> :NERDTreeToggle<CR>
" map <C-f> :NERDTreeFind<CR>

" Zwischen Fenstern mittels Ctrl-L, Ctrl-J, usw. wechseln
map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

" ---------------------------------------------------------------------------------

" Aktiviert die volle Farbundstützung unter Windows
" set termguicolors

" GUI-Einstellungen (Greift nur in gVim)
if has("gui_running")
    " Entfernt störende GUI-Elemente wie Scrollbars/Menüs für mehr Platz (Optional)
    set guioptions-=m  " Menüleiste weg
    set guioptions-=T  " Toolbar weg
    set guioptions-=r  " Rechte Scrollbar weg

    " Schriftart festlegen
    set guifont=DejaVu_Sans_Mono_for_Powerline:h11

    " Fenstergrösse erzwingen
    set lines=50
    set columns=170

    " Fix, falls Windows die Grösse beim Rendern blockiert:
    " Erzwingt ein Neuzeichnen des Fensters mit den Wunschmassen
    let &lines=50
    let &columns=170
endif
