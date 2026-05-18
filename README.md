# vim-gvim-config
My little Vim (gVim) config file. I used this one for an online Vim course. So the config file has only some minor adjustments and only some plugins. The config file is optimized to work for gVim on Windows, but it also can be used on Linux and MacOS with some little changes. The comments in the file are mostly in german language, because this is my native language. If there are some wishes, to change or add also english comments, feel free to ask.
## Install / use
To use this file, it can be downloaded, cloned or copy-pasted. The standard folder for `_vimrc` (Windows) or `.vimrc` (Linux, MacOS) is as follows:

| OS | Filepath |
| :---: | :--- |
| Linux | `~/.vimrc` |
| MacOS | `~/.vimrc` |
| Windows | `C:\Program Files\Vim\_vimrc` |

If you use the file (.vimrc, _vimrc) for Linux or MacOS, you should change (comment, comment out) the following lines according to your OS (comments in vimscript starting with `" ...`):
```vim
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
```

For use on Linux or MacOS you can delete the following lines at the end of the file:
```vim
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
```
