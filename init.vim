call plug#begin('~/.vim/plugged')

" Plugins
Plug 'git@github.com:itchyny/lightline.vim.git'
Plug 'git@github.com:christoomey/vim-tmux-navigator.git'
Plug 'git@github.com:windwp/nvim-autopairs.git'
Plug 'git@github.com:joshdick/onedark.vim.git'
Plug 'git@github.com:nvim-treesitter/nvim-treesitter.git', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'git@github.com:KarimElghamry/vim-auto-comment.git'
Plug 'git@github.com:p00f/nvim-ts-rainbow.git'
Plug 'git@github.com:kyazdani42/nvim-tree.lua.git'

" Autocompletion
Plug 'git@github.com:neovim/nvim-lspconfig.git'
Plug 'git@github.com:hrsh7th/nvim-cmp.git'
Plug 'git@github.com:hrsh7th/cmp-nvim-lsp.git'
Plug 'git@github.com:hrsh7th/cmp-path.git'
Plug 'git@github.com:hrsh7th/cmp-buffer.git'
Plug 'git@github.com:hrsh7th/cmp-cmdline.git'
Plug 'git@github.com:hrsh7th/cmp-vsnip.git'
Plug 'git@github.com:hrsh7th/vim-vsnip.git'
Plug 'git@github.com:williamboman/nvim-lsp-installer.git'

call plug#end()

set termguicolors
set completeopt=menu,menuone,noselect
set number
set rnu
set updatetime=750
set mouse=a
set cursorline
set clipboard=unnamedplus
set laststatus=2
set noshowmode
set showmatch
set shortmess+=c
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set splitbelow
set hidden


lua <<EOF

local lsp_installer = require('nvim-lsp-installer')

lsp_installer.on_server_ready(function(server)
    local opts = {}
    server:setup(opts)
end)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
    end,
},
mapping = {
    ['<Tab>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        },
    },
sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
}
})

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
      colors = { '#33daff', '#fa9512', '#c172d9', '#fa6262', '#aae46f', '#5eff8e' },
  },
  indent = {
      enable = true,
  },
}
require('nvim-autopairs').setup{}

require'nvim-tree'.setup()

EOF


if has ('nvim')
    autocmd TermOpen term://* startinsert
endif

" Lightline color
let g:lightline = { 'colorscheme': 'one' }

" Human readable hex
nnoremap <silent> <F2> :%!xxd<CR>

" Revert to normal binary
nnoremap <silent> <F3> :%!xxd -r<CR>

" File explorer
nnoremap <silent> <C-b> :NvimTreeToggle<CR>

" Save
nnoremap <C-s> :lua vim.lsp.buf.formatting()<CR>:w<CR>
inoremap <C-s> <Esc> :lua vim.lsp.buf.formatting()<CR>:w<CR>
inoremap <C-s> <Esc> :lua vim.lsp.buf.formatting()<CR>:w<CR>

" Map F9 to run code depending on file type
autocmd FileType bash nnoremap <silent> <C-M-n> :w<CR>:split \| terminal bash %<CR>
autocmd FileType sh nnoremap <silent> <C-M-n> :w<CR>:split \| terminal bash %<CR>
autocmd FileType python nnoremap <silent> <C-M-n> :w<CR>:split \| terminal python %<CR>
autocmd FileType c nnoremap <silent> <C-M-n> :split \| terminal ./%<<CR>
autocmd FileType cpp nnoremap <silent> <C-M-n> :split \| terminal ./%<<CR>
autocmd FileType asm nnoremap <silent> <C-M-n> :split \| terminal ./%<<CR>
autocmd FileType rust nnoremap <silent> <C-M-n> :split \| terminal cargo run<CR>
autocmd FileType javascript nnoremap <silent> <C-M-n> :split \| terminal node %<CR>

" Map F10 to run code with arguments depending on file type
autocmd FileType bash nnoremap <silent> <F10> :w<CR>:split \| terminal bash % 
autocmd FileType sh nnoremap <silent> <F10> :w<CR>:split \| terminal bash % 
autocmd FileType python nnoremap <silent> <F10> :w<CR>:split \| terminal python % 
autocmd FileType c nnoremap <silent> <F10> :split \| terminal ./%< 
autocmd FileType cpp nnoremap <silent> <F10> :split \| terminal ./%< 
autocmd FileType rust nnoremap <silent> <F10> :split \| terminal cargo run

" Map F5 to compile code
autocmd FileType c nnoremap <silent> <F5> :w<CR>:!gcc % -o %<<CR>
autocmd FileType cpp nnoremap <silent> <F5> :w<CR>:!g++ % -o %<<CR>
autocmd FileType asm nnoremap <silent> <F5> :w<CR>:!yasm -f elf64 % && ld %<.o -o %<<CR>
autocmd FileType rust nnoremap <silent> <F5> :split \| terminal cargo build<CR>

colorscheme onedark

" Transparent BG
hi Normal guibg=NONE ctermbg=NONE
