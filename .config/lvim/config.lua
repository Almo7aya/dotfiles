-- general
lvim.format_on_save                = false
lvim.log.level                     = "warn"
lvim.colorscheme                   = "neogruvbox"
vim.opt.cmdheight                  = 1
vim.opt.relativenumber             = true
vim.opt.foldmethod                 = "expr"
vim.opt.foldexpr                   = "nvim_treesitter#foldexpr()"
vim.opt.fillchars                  = "fold: "
vim.opt.foldlevel                  = 99

vim.opt.guifont = { "FiraCode Nerd Font Mono", "h12" }


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

lvim.builtin.gitsigns.opts.current_line_blame = true;

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
  space = "␣",
  eol = "↴",
  trail = "~",
  extends = ">",
  precedes = "<",
  tab = "->"
}

vim.opt.list = true

lvim.builtin.indentlines.options.show_end_of_line = true
lvim.builtin.indentlines.options.show_trailing_blankline_indent = true

lvim.builtin.indentlines.options.char_list = { "▏", "¦", "┆", "┊", "⦚", "⸾", "‖" }

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
  "mason"
}

-- lvim user custom plugins
lvim.plugins = {
  { "almo7aya/neogruvbox.nvim" },
  { "kdheepak/lazygit.nvim" },
  { "nvim-treesitter/nvim-treesitter-context" },
  {
    "gelguy/wilder.nvim",
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '/', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        left = { ' ', wilder.popupmenu_devicons() },
        right = { ' ', wilder.popupmenu_scrollbar() },
      }))
    end
  },
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.cmd('highlight ExtraWhitespace ctermbg=8 guibg=#282c34')
      vim.g.better_whitespace_enabled = 1
      vim.g.strip_whitespace_on_save = 1
      vim.g.strip_whitespace_confirm = 0
    end
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    event = "BufRead",
    config = function()
      require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.api.nvim_set_keymap("n", "s", ":HopWord<cr>", { silent = true })
      -- vim.api.nvim_set_keymap("n", "S", ":HopChar2<cr>", { silent = true })
      -- place this in one of your configuration file(s)
      vim.api.nvim_set_keymap('', 'f',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
        , {})
      vim.api.nvim_set_keymap('', 'F',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
        , {})
      vim.api.nvim_set_keymap('', 't',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
        , {})
      vim.api.nvim_set_keymap('', 'T',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
        , {})
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function() require "lsp_signature".on_attach() end,
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
      vim.api.nvim_command("augroup END")
    end
  },
  { "ziontee113/color-picker.nvim",
    config = function()
      local opts = { noremap = true, silent = true }

      vim.keymap.set("n", "<C-c>", "<cmd>PickColor<cr>", opts)
      vim.keymap.set("i", "<C-c>", "<cmd>PickColorInsert<cr>", opts)

      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandRGB<cr>", opts)
      -- vim.keymap.set("n", "your_keymap", "<cmd>ConvertHEXandHSL<cr>", opts)

      require("color-picker").setup({ -- for changing icons & mappings
        -- ["icons"] = { "ﱢ", "" },
        -- ["icons"] = { "ﮊ", "" },
        -- ["icons"] = { "", "ﰕ" },
        -- ["icons"] = { "", "" },
        -- ["icons"] = { "", "" },
        ["icons"] = { "ﱢ", "" },
        ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        ["keymap"] = { -- mapping example:
          ["U"] = "<Plug>ColorPickerSlider5Decrease",
          ["O"] = "<Plug>ColorPickerSlider5Increase",
        },
        ["background_highlight_group"] = "Normal", -- default
        ["border_highlight_group"] = "FloatBorder", -- default
        ["text_highlight_group"] = "Normal", --default
      })

      vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
    end
  },
  {
    "Akianonymus/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        filetypes = { "*" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = false, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = false, -- CSS rgb() and rgba() functions
          hsl_fn = false, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = true, -- Enable tailwind colors
          virtualtext = "■",
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      }
    end
  },
  {
    "David-Kunz/markid",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        markid = { enable = true }
      }
    end
  },
  {
    "mfussenegger/nvim-treehopper",
    config = function()
      require("tsht").config.hint_keys = { "h", "j", "f", "d", "n", "v", "s", "l", "a" }
    end
  }
}

-- better mapping
local function map(mode, keys, cmd)
  if (mode == "n") then
    lvim.keys.normal_mode[keys] = cmd
  elseif (mode == "v") then
    lvim.keys.visual_mode[keys] = cmd
  elseif (mode == "i") then
    lvim.keys.insert_mode[keys] = cmd
  elseif (mode == "t") then
    lvim.keys.term_mode[keys] = cmd
  end
end

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
-- better escape
map("i", "JK", "<Esc>")
map("i", "jl", "<Esc>")
map("i", "JL", "<Esc>")
-- copy whole file content
map("n", "<Leader>aa", ":%y+ <CR>") -- copy whole file content
-- don't yank text on cut ( x )
map("n", "x", '"_x')
map("v", "x", '"_x')
-- don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP')
-- use ESC to turn off search highlighting
map("n", "<Esc>", ":noh <CR>")
-- Escapes terminal
map("t", "JK", "<C-\\><C-n>")
-- bufferline --
-- Move to previous/next
map('n', '<S-j>', ':BufferLineCyclePrev<CR>')
map('n', 'K', ':BufferLineCycleNext<CR>')

-- hack lsp K map to H and make H switch to next butter
lvim.lsp.buffer_mappings.normal_mode.H = lvim.lsp.buffer_mappings.normal_mode.K
lvim.keys.normal_mode["h"] = false
lvim.lsp.buffer_mappings.normal_mode.K = { ":BufferLineCycleNext<CR>" }

-- Close buffer
map('n', '<S-q>', ':BufferClose<CR>')
map('n', '<C-p>', ':BufferLinePick<CR>')

-- Open terminals
map("n", "<Leader>th",
  ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
map("n", "<Leader>tv",
  ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
map("n", "<Leader>tw",
  ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")

-- disable jk, jj and kj mapping for escape since we have system wide jk for escape
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false
