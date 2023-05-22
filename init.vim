call plug#begin('~/.local/share/nvim/plugged')

Plug 'iruzo/matrix-nvim
Plug 'terrortylor/nvim-comment'
Plug 'christoomey/vim-tmux-navigator'
Plug 'windwp/nvim-autopairs'
Plug 'joshdick/onedark.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'CRAG666/code_runner.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'lukas-reineke/lsp-format.nvim'

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
require'lsp-format'.setup{}
require'lspconfig'.pyright.setup{ on_attach = require("lsp-format").on_attach }
require'lspconfig'.gopls.setup{ on_attach = require("lsp-format").on_attach }
require'lspconfig'.tsserver.setup{ on_attach = require("lsp-format").on_attach }
require'lspconfig'.clangd.setup{ on_attach = require("lsp-format").on_attach }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities

local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            require'luasnip'.lsp_expand(args.body)
        end,
    },

mapping = {
    ['<Tab>'] = cmp.mapping.confirm {
        select = true,
        },
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),
},

sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
}
})

require("nvim-treesitter.configs").setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
        colors = { '#fa9512', '#33daff', '#c172d9', '#fa6262', '#aae46f', '#5eff8e' },
    },
}

require('nvim-autopairs').setup()
require('nvim-tree').setup()
require('indent_blankline').setup{}
require('lualine').setup {
    options = { theme = 'onedark' }
}

require('code_runner').setup {
    startinsert = true,
    term = {
        size = 15,
    },
    filetype = {
        python = "python -u",
        javascript = "node",
        cpp = "cd $dir && g++ $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        c = "cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir/$fileNameWithoutExt",
        go = "go run $fileName",
        sh = "bash $fileName",
        asm = "nasm -f elf64 $fileName && ld $fileNameWithoutExt.o -o $fileNameWithoutExt && ./$fileNameWithoutExt",
        vlang = "v run $fileName"
    },
}
EOF

" Ctrl + s to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>
inoremap <C-s> <Esc>:w<CR>
" Ctrl + s to save


" Mappings
nnoremap <silent> <C-b> :NvimTreeToggle<CR>
nnoremap <F5> :RunCode<CR>
nnoremap <C-_> :CommentToggle<cr>
vnoremap <C-_> :CommentToggle<cr>
" Mappings

colorscheme onedark

hi Normal guibg=NONE ctermbg=NONE
