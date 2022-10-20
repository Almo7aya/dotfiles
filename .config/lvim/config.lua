-- general
lvim.format_on_save = false
lvim.log.level = "warn"
lvim.colorscheme = "neogruvbox"
vim.opt.cmdheight = 1
vim.opt.relativenumber = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fillchars = {
  vert = "│",
  fold = "░",
  diff = " ", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}

vim.opt.foldlevel = 99
vim.opt.spell = true

-- vim.opt.tabstop = 2
-- vim.o.ch = 0

vim.opt.guifont = { "SauceCodePro Nerd Font", "h12" }

-- same cursor last position
-- vim.cmd([[autocmd BufLeave,BufWinLeave * silent! mkview]])
-- vim.cmd([[autocmd BufReadPost * silent! loadview]])


-- terminal configs
lvim.builtin.terminal.active = false

-- nvimtree configs
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true
lvim.builtin.nvimtree.setup.hijack_cursor = true
lvim.builtin.nvimtree.setup.update_cwd = true
lvim.builtin.nvimtree.setup.reload_on_bufenter = true
lvim.builtin.nvimtree.setup.filesystem_watchers = {
  enable = true,
}
lvim.builtin.nvimtree.setup.view.float = {
  enable = true,
  open_win_config = {
    border = "rounded",
    width = 100,
    height = 30,
    -- to lazy to add centering logic here
    row = 10,
    col = 58,
  },
}

-- gitsigns configs
lvim.builtin.gitsigns.opts.current_line_blame = true
lvim.builtin.gitsigns.opts.yadm.enable = true

-- treesitter configs
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- indent_blankline configs
vim.opt.listchars = {
  space = "₋",
  eol = "⤶",
  trail = "~",
  extends = ">",
  precedes = "<",
  tab = "->",
}
vim.opt.list = true
lvim.builtin.indentlines.options.show_end_of_line = true
lvim.builtin.indentlines.options.show_trailing_blankline_indent = true
lvim.builtin.indentlines.options.char_list = { "▏", "▏", "▏", "▏", "▏", "▏", "▏" }
lvim.builtin.indentlines.options.char = nil
lvim.builtin.indentlines.options.buftype_exclude = { "terminal", "nofile" }
lvim.builtin.indentlines.options.filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "text",
  "LspInstallInfo",
  "lspconfig",
  "mason",
}

-- Lua line configs
lvim.builtin.lualine.sections.lualine_a = { "mode" }

-- which_key configs
lvim.builtin.which_key.setup.plugins.marks = true
lvim.builtin.which_key.setup.plugins.registers = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.z = true
lvim.builtin.which_key.setup.plugins.presets.g = true
lvim.builtin.which_key.setup.plugins.presets.windows = true

-- lvim user custom plugins
lvim.plugins = {
  { "almo7aya/neogruvbox.nvim" },
  {
    "almo7aya/openingh.nvim",
  },
  { "kdheepak/lazygit.nvim" },
  { "christoomey/vim-tmux-navigator" },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.cmd("highlight ExtraWhitespace ctermbg=8 guibg=#282c34")
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_whitespace_confirm = 0
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").on_attach()
    end,
    event = "BufRead",
  },
  {
    "itchyny/vim-cursorword",
    event = { "BufEnter", "BufNewFile" },
    config = function()
      vim.api.nvim_command("augroup user_plugin_cursorword")
      vim.api.nvim_command("autocmd!")
      vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
      vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
      vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
      vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    config = function()
      local ccc = require("ccc")
      ccc.setup({
        highlight_mode = "bg",
        highlighter = {
          auto_enable = true,
        },
      })
    end,
  },
}

-- better mapping
local function map(mode, keys, cmd)
  if mode == "n" then
    lvim.keys.normal_mode[keys] = cmd
  elseif mode == "v" then
    lvim.keys.visual_mode[keys] = cmd
  elseif mode == "i" then
    lvim.keys.insert_mode[keys] = cmd
  elseif mode == "t" then
    lvim.keys.term_mode[keys] = cmd
  end
end

-- show lsp signature_help
map("n", "gh", ":lua vim.lsp.buf.signature_help() <CR>")

-- to show the saved marks
map("n", "mm", ":marks <CR>")
-- disable case toggling with u and U in visual mode and set it to undo
map("v", "u", ":<C-U>earlier <CR>");
map("v", "U", ":<C-U>earlier <CR>");
-- mapping openingh.nvim
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
map("n", "<Leader>gm", ":OpenInGHRepo <CR>")
map("n", "<Leader>gf", ":OpenInGHFile <CR>")
-- mapping for ccc
map("n", "<Leader>lc", ":CccPick <CR>")
-- Disable nonsense recoding
map("n", "q", ":noh <CR>")
-- hop when in visual_mode
map("n", "<S-s>", ":lua require('tsht').nodes()<CR>")
-- better cursor moves in visual mode
map("v", "<S-l>", "g_")
map("v", "<S-h>", "^")
-- back tab
map("i", "<S-Tab>", "<C-d>")
-- resize with arrows
map("n", "<A-k>", ":resize -2<CR>")
map("n", "<A-j>", ":resize +2<CR>")
map("n", "<A-h>", ":vertical resize -2<CR>")
map("n", "<A-l>", ":vertical resize +2<CR>")
-- copy whole file content
map("n", "<Leader>aa", ":silent :%y+ <CR>") -- copy whole file content
-- don't yank text on cut ( x )
map("n", "x", '"_x')
map("v", "x", '"_x')
-- don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP')
-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh <CR>")
-- bufferline --
-- Move to previous/next
map("n", "<S-j>", ":BufferLineCyclePrev<CR>")
map("n", "K", ":BufferLineCycleNext<CR>")
-- hack lsp K map to H and make H switch to next butter
lvim.lsp.buffer_mappings.normal_mode.H = lvim.lsp.buffer_mappings.normal_mode.K
lvim.keys.normal_mode["h"] = false
lvim.lsp.buffer_mappings.normal_mode.K = { ":BufferLineCycleNext<CR>" }
-- Close buffer
map("n", "<S-x>", ":BufferClose<CR>")
map("n", "<C-p>", ":BufferLinePick<CR>")
-- blameline current line
map("n", "<S-l>", ":Gitsigns blame_line<CR>")
-- vsplit and split
lvim.builtin.which_key.mappings.w = ""
map("n", "<Leader>w", "<C-w>")
-- remap saving
map("n", "<Leader>r", ":w <CR>")
-- disable jk, jj and kj mapping for escape since we have system wide jk for escape
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false

-- set additional code-actions
local actions = require("lvim.lsp.null-ls.code_actions")
actions.setup({
  {
    command = "eslint_d",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    command = "gitsigns",
    filetypes = {},
  },
  {
    command = "gitrebase",
    filetypes = {},
  },
})

-- set additional LSPs
require("lvim.lsp.manager").setup("grammarly", nil)

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    command = "eslint_d",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    command = "tsc",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    command = "luacheck",
    filetypes = { "lua" },
  },
  -- {
  --   command = "stylelint",
  --   filetypes = { "scss", "less", "css", "sass" },
  -- },
  {
    command = "vint",
    filetypes = { "vim" },
  },
  {
    command = "yamllint",
    filetypes = { "yaml" },
  },
  {
    command = "zsh",
    filetypes = { "zsh" },
  },
  {
    command = "jsonlint",
    filetypes = { "json" },
  },
  {
    command = "shellcheck",
    filetype = { "sh" },
  },
})

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  {
    command = "prettierd",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  },
  {
    command = "eslint_d",
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
  {
    command = "rustfmt",
    filetypes = { "rust", "rs" },
  },
  {
    command = "stylua",
    filetypes = { "lua" },
  },
  {
    command = "beautysh",
    filetypes = { "bash", "csh", "ksh", "zsh" },
  },
  {
    command = "fixjson",
    filetypes = { "json" },
  },
  {
    command = "taplo",
    filetype = { "toml" },
  },
  {
    command = "shfmt",
    filetype = { "sh" },
  },
})
