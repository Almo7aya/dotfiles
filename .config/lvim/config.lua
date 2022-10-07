-- general
lvim.format_on_save = false
lvim.log.level = "warn"
lvim.colorscheme = "neogruvbox"
vim.opt.cmdheight = 1
vim.opt.relativenumber = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.fillchars = "fold: "
vim.opt.foldlevel = 99
vim.opt.spell = true

-- to hide commandff line neovim 8
vim.o.ch = 0

vim.opt.guifont = { "Fisa Code", "h12" }

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

lvim.builtin.alpha.active = true

lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true

lvim.builtin.gitsigns.opts.current_line_blame = true

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

-- indent_blankline config
-- 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
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

-- lvim user custom plugins
lvim.plugins = {
  { "almo7aya/neogruvbox.nvim" },
  { "almo7aya/openingh.nvim" },
  { "kdheepak/lazygit.nvim" },
  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require("wilder")
      wilder.setup({ modes = { ":", "/", "?" } })
      wilder.set_option(
        "renderer",
        wilder.popupmenu_renderer({
          highlighter = wilder.basic_highlighter(),
          left = { " ", wilder.popupmenu_devicons() },
          right = { " ", wilder.popupmenu_scrollbar() },
        })
      )
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            -- sets the language to use, 'vim' and 'python' are supported
            language = "python",
            -- 0 turns off fuzzy matching
            -- 1 turns on fuzzy matching
            -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
            fuzzy = 1,
          }),
          wilder.python_search_pipeline({
            -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
            pattern = wilder.python_fuzzy_pattern(),
            -- omit to get results in the order they appear in the buffer
            -- sorter = wilder.python_difflib_sorter(),
            -- can be set to 're2' for performance, requires pyre2 to be installed
            -- see :h wilder#python_search() for more details
            engine = "re",
          })
        ),
      })
    end,
  },
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

-- mapping openingh.nvim
map("n", "<Leader>gm", ":OpenInGHRepo <CR>")
map("n", "<Leader>gf", ":OpenInGHFile <CR>")

-- mapping for ccc
map("n", "<C-c>", ":CccPick <CR>")

-- Disable nonsense recoding
map("n", "q", ":noh <CR>")

-- navigate in insert_mode
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")

-- hop when in visual_mode
map("n", "<S-s>", ":lua require('tsht').nodes()<CR>")

-- enter command more when clicking ;
map("n", ";", ":")

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
map("n", "<Leader>aa", ":%y+ <CR>") -- copy whole file content
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
map("n", "<S-q>", ":BufferClose<CR>")
map("n", "<C-p>", ":BufferLinePick<CR>")

-- Open terminals
map("n", "<Leader>th", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
map("n", "<Leader>tv", ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
map("n", "<Leader>tw", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")

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
