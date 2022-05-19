call plug#begin('/home/asdf/.local/share/nvim/plugged')
Plug 'christoomey/vim-tmux-navigator'
Plug 'windwp/nvim-autopairs'
Plug 'joshdick/onedark.vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'CRAG666/code_runner.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'KarimElghamry/vim-auto-comment'
Plug 'p00f/nvim-ts-rainbow'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'williamboman/nvim-lsp-installer'
Plug 'nvim-treesitter/nvim-treesitter'

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
    { name = 'cmdline' },
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
        go = "go run $fileName"
    },
}
EOF

" Format on save
nnoremap <C-s> :lua vim.lsp.buf.formatting()<CR>:w<CR>
inoremap <C-s> <Esc> :lua vim.lsp.buf.formatting()<CR>:w<CR>
inoremap <C-s> <Esc> :lua vim.lsp.buf.formatting()<CR>:w<CR>
" Format on save


" Mappings
nnoremap <silent> <C-b> :NvimTreeToggle<CR>
nnoremap <C-M-n> :RunCode<CR>
vnoremap <silent><F11> :AutoInLineComment<CR>
nnoremap <silent><F11> :AutoInLineComment<CR>
vnoremap <silent><F12> :AutoBlockComment<CR>
nnoremap <silent><F12> :AutoBlockComment<CR>
" Mappings


" Assemble
autocmd FileType asm nnoremap <silent> <F5> :w<CR>:!yasm -f elf64 % && ld %<.o -o %<<CR>
" Assemble

colorscheme onedark

hi Normal guibg=NONE ctermbg=NONE
