


set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " use spaces instead of spaces.
set smarttab
set shiftround 
set autoindent
set smartindent

" Sane search
set ignorecase " case insensitive search
set smartcase " if there are uppercase letters, become case-sensitive
set showmatch 


"relative number in normal mode
:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber

:augroup END

command W :execute ':silent w !sudo tee % > /dev/null' | :if v:shell_error | :edit! | :endif
