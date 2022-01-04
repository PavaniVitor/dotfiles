
" disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" faster scrool with C-e C-y
nnoremap <C-y> 5<C-y>
nnoremap <C-e> 5<C-e>

" move lines with <C-j><C-h>
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" keep cursor centered jumping to next/previous and joining lines
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" insert undo checkpoints on symbols
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap " "<c-g>u
inoremap ' '<c-g>u

" #############
" #  Plugins  #
" #############

" lsp
nnoremap <leader>gd <cmd>lua vim.lsp.buf.definition()<CR> 
nnoremap <leader>gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

" telescope
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>

