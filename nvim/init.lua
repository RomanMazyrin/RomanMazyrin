-- ============================================================
-- General options
-- ============================================================

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

vim.opt.mouse = "a"

vim.opt.laststatus = 2
vim.opt.shortmess:append("F")
vim.opt.showmode = false

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 100

-- Cursor:
-- block in normal mode
-- vertical bar in insert mode
vim.opt.guicursor =
    "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.opt.ignorecase = true
vim.opt.smartcase = true


-- ============================================================
-- Useful defaults
-- ============================================================

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.scrolloff = 4

vim.opt.undofile = true


-- ============================================================
-- Plugins
-- Neovim 0.12 built-in package manager
-- ============================================================

-- vim.pack stores plugins inside:
-- ~/.local/share/nvim/site/pack/...
--
-- Make sure that Neovim's data/site directory is in packpath.
local site_path = vim.fn.stdpath("data") .. "/site"

if not vim.o.packpath:find(site_path, 1, true) then
    vim.opt.packpath:prepend(site_path)
end


vim.pack.add({
    {
        src = "https://github.com/catppuccin/nvim",
        name = "catppuccin",
    },
    {
        src = "https://github.com/folke/tokyonight.nvim",
        name = "tokyonight",
    },
    {
        src = "https://github.com/christoomey/vim-tmux-navigator",
        name = "vim-tmux-navigator",
    },

    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        name = "nvim-treesitter",
    },
}, {
    confirm = false,
    load = true,
})


-- ============================================================
-- Catppuccin
-- ============================================================

require("catppuccin").setup({
    flavour = "mocha",
})

vim.cmd.colorscheme("tokyonight-night")


-- ============================================================
-- Tree-sitter
-- ============================================================

local treesitter = require("nvim-treesitter")

-- Languages that we want Tree-sitter support for.
--
-- install() is a no-op for parsers which are already installed,
-- so keeping this here is fine.
treesitter.install({
    "bash",
    "c",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "sql",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
})


-- Automatically enable Tree-sitter highlighting whenever
-- a parser for the current filetype is available.
local treesitter_group =
    vim.api.nvim_create_augroup("treesitter_start", {
        clear = true,
    })

vim.api.nvim_create_autocmd("FileType", {
    group = treesitter_group,

    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})


-- ============================================================
-- Statusline
-- ============================================================

vim.opt.statusline = table.concat({
    " %F",          -- full file path
    "%=",           -- push remaining items to right
    "%l:%c (%L) ",  -- current line:column (total lines)
})


-- ============================================================
-- Sign column
-- ============================================================

vim.api.nvim_set_hl(0, "SignColumn", {
    bg = "NONE",
})


-- ============================================================
-- Automatically create missing parent directories on save
-- ============================================================

local auto_mkdir_group =
    vim.api.nvim_create_augroup("auto_mkdir", {
        clear = true,
    })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = auto_mkdir_group,

    callback = function(args)
        local dir = vim.fn.fnamemodify(args.file, ":p:h")

        if dir ~= "" then
            vim.fn.mkdir(dir, "p")
        end
    end,
})


-- ============================================================
-- YAML
-- ============================================================

local yaml_group =
    vim.api.nvim_create_augroup("yaml_settings", {
        clear = true,
    })

vim.api.nvim_create_autocmd("FileType", {
    group = yaml_group,
    pattern = "yaml",

    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.autoindent = true
    end,
})


-- ============================================================
-- Keymaps
-- ============================================================

-- Clear search highlight with Escape.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
