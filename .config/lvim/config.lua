local utils = require("utils")

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

vim.opt.guifont = { "SauceCodePro Nerd Font", "h12" }

-- terminal configs
lvim.builtin.terminal.active = false

-- dap configs
lvim.builtin.dap.active = false


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
vim.opt.timeoutlen = 40
lvim.builtin.which_key.setup.plugins.marks = true
lvim.builtin.which_key.setup.plugins.registers = true
lvim.builtin.which_key.setup.plugins.presets.operators = true
lvim.builtin.which_key.setup.plugins.presets.motions = true
lvim.builtin.which_key.setup.plugins.presets.text_objects = true
lvim.builtin.which_key.setup.plugins.presets.nav = true
lvim.builtin.which_key.setup.plugins.presets.z = true
lvim.builtin.which_key.setup.plugins.presets.g = true
lvim.builtin.which_key.setup.plugins.presets.windows = true
lvim.builtin.which_key.mappings[":"] = {
  "<cmd>Telescope command_history<CR>",
  "Search recent commands",
}
lvim.builtin.which_key.mappings["s"]["r"] = {
  "<cmd>Telescope resume<CR>",
  "Resume previous search",
}
lvim.builtin.which_key.mappings["m"] = {
  name = "+Marks",
  m = { "<cmd>Telescope marks<CR>", "Marks" },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "+Tweak",
  s = { utils.toggle_spell, "Toggle spell" },
  b = { utils.toggle_background, "Toggle background" },
  S = { utils.toggle_signcolumn, "Toggle sigcolumn" },
  i = { utils.set_indent, "Set indent" },
  n = { utils.change_number, "Toggle number" },
  x = { utils.change_syntax, "Toggle syntax" },
}
lvim.builtin.which_key.mappings["j"] = {
  name = "+Tweak",
  a = { "<C-^>", "Alternate file" },
  j = { "<C-o>", "Older file" },
  k = { "<C-i>", "Newer file" },
}
lvim.builtin.which_key.mappings["."] = {
  "<cmd>Telescope file_browser<CR>",
  "Browse project",
}
lvim.builtin.which_key.mappings["lp"] = {
  "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
  "Goto preview definition",
}
lvim.builtin.which_key.mappings["lD"] = {
  "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
  "Goto preview implementation",
}
lvim.builtin.which_key.mappings["lP"] = {
  "<cmd>lua require('goto-preview').close_all_win()<CR>",
  "Close all preview win",
}

-- cmp configs
lvim.builtin.cmp.experimental.ghost_text = true
table.insert(lvim.builtin.cmp.sources, 1, {
  name = "tmux",
  option = {
    -- Source from all panes in session instead of adjacent panes
    all_panes = false,
    -- Completion popup label
    label = "(tmux)",
  },
})

-- lvim user custom plugins
lvim.plugins = {
  { "almo7aya/neogruvbox.nvim" },
  {
    "almo7aya/openingh.nvim",
  },
  { "andersevenrud/cmp-tmux" },
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
      require("lsp_signature").on_attach({
        bind = true,
        doc_lines = 10,
        floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
        floating_window_above_cur_line = true,
        fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
        hint_enable = true, -- virtual hint enable
        hint_prefix = " ",
        hint_scheme = "String",
        hi_parameter = "Search", -- how your parameter will be highlight
        max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
        max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
        transparency = 80,
        extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
        zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
        debug = false, -- set to true to enable debug logging
        padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
        shadow_blend = 36, -- if you using shadow as border use this set the opacity
        shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
      })
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
  {
    "nvim-telescope/telescope-file-browser.nvim",
    config = function()
      lvim.builtin.telescope.extensions["file_browser"] = {
        theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
      }
      require("telescope").load_extension("file_browser")
    end,
  },
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup({
        width = 120, -- Width of the floating window
        height = 25, -- Height of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
      })
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      -- Lua
      local actions = require("diffview.actions")

      require("diffview").setup({
        diff_binaries = false, -- Show diffs for binaries
        enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { "git" }, -- The git executable followed by default args.
        use_icons = true, -- Requires nvim-web-devicons
        watch_index = true, -- Update views and index buffers when the git index changes.
        icons = { -- Only applies when use_icons is true.
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          -- Configure the layout and behavior of different types of views.
          -- Available layouts:
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see ':h diffview-config-view.x.layout'.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_horizontal",
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
          },
          file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
          },
        },
        file_panel = {
          listing_style = "tree", -- One of 'list' or 'tree'
          tree_options = { -- Only applies when listing_style is 'tree'
            flatten_dirs = true, -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
          },
          win_config = { -- See ':h diffview-config-win_config'
            position = "left",
            width = 35,
            win_opts = {},
          },
        },
        file_history_panel = {
          log_options = { -- See ':h diffview-config-log_options'
            single_file = {
              diff_merges = "combined",
            },
            multi_file = {
              diff_merges = "first-parent",
            },
          },
          win_config = { -- See ':h diffview-config-win_config'
            position = "bottom",
            height = 16,
            win_opts = {},
          },
        },
        commit_log_panel = {
          win_config = { -- See ':h diffview-config-win_config'
            win_opts = {},
          },
        },
        default_args = { -- Default args prepended to the arg-list for the listed commands
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {}, -- See ':h diffview-config-hooks'
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            ["<tab>"] = actions.select_next_entry, -- Open the diff for the next file
            ["<s-tab>"] = actions.select_prev_entry, -- Open the diff for the previous file
            ["gf"] = actions.goto_file, -- Open the file in a new split in the previous tabpage
            ["<C-w><C-f>"] = actions.goto_file_split, -- Open the file in a new split
            ["<C-w>gf"] = actions.goto_file_tab, -- Open the file in a new tabpage
            ["<leader>e"] = actions.focus_files, -- Bring focus to the file panel
            ["<leader>b"] = actions.toggle_files, -- Toggle the file panel.
            ["g<C-x>"] = actions.cycle_layout, -- Cycle through available layouts.
            ["[x"] = actions.prev_conflict, -- In the merge_tool: jump to the previous conflict
            ["]x"] = actions.next_conflict, -- In the merge_tool: jump to the next conflict
            ["<leader>co"] = actions.conflict_choose("ours"), -- Choose the OURS version of a conflict
            ["<leader>ct"] = actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
            ["<leader>cb"] = actions.conflict_choose("base"), -- Choose the BASE version of a conflict
            ["<leader>ca"] = actions.conflict_choose("all"), -- Choose all the versions of a conflict
            ["dx"] = actions.conflict_choose("none"), -- Delete the conflict region
          },
          diff1 = { --[[ Mappings in single window diff layouts ]]
          },
          diff2 = { --[[ Mappings in 2-way diff layouts ]]
          },
          diff3 = {
            -- Mappings in 3-way diff layouts
            { { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
            { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            { { "n", "x" }, "1do", actions.diffget("base") }, -- Obtain the diff hunk from the BASE version of the file
            { { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
            { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          file_panel = {
            ["j"] = actions.next_entry, -- Bring the cursor to the next file entry
            ["<down>"] = actions.next_entry,
            ["k"] = actions.prev_entry, -- Bring the cursor to the previous file entry.
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry, -- Open the diff for the selected entry.
            ["o"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["-"] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
            ["S"] = actions.stage_all, -- Stage all entries.
            ["U"] = actions.unstage_all, -- Unstage all entries.
            ["X"] = actions.restore_entry, -- Restore entry to the state on the left side.
            ["L"] = actions.open_commit_log, -- Open the commit log panel.
            ["<c-b>"] = actions.scroll_view(-0.25), -- Scroll the view up
            ["<c-f>"] = actions.scroll_view(0.25), -- Scroll the view down
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["gf"] = actions.goto_file,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["i"] = actions.listing_style, -- Toggle between 'list' and 'tree' views
            ["f"] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
            ["R"] = actions.refresh_files, -- Update stats and entries in the file list.
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files,
            ["g<C-x>"] = actions.cycle_layout,
            ["[x"] = actions.prev_conflict,
            ["]x"] = actions.next_conflict,
          },
          file_history_panel = {
            ["g!"] = actions.options, -- Open the option panel
            ["<C-A-d>"] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
            ["y"] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
            ["L"] = actions.open_commit_log,
            ["zR"] = actions.open_all_folds,
            ["zM"] = actions.close_all_folds,
            ["j"] = actions.next_entry,
            ["<down>"] = actions.next_entry,
            ["k"] = actions.prev_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["o"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"] = actions.scroll_view(-0.25),
            ["<c-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["gf"] = actions.goto_file,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files,
            ["g<C-x>"] = actions.cycle_layout,
          },
          option_panel = {
            ["<tab>"] = actions.select_entry,
            ["q"] = actions.close,
          },
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

-- S for nvim-spectre
map("n", "S", "<cmd>lua require('spectre').open()<CR>")
-- Disable nonsense recoding and map it to diffview
map("n", "q", ":DiffviewClose <CR>")
-- saving with C-s
map("n", "<C-s>", ":w! <CR>")
-- show telescope spell_suggest
map("n", "z-", "<cmd>Telescope spell_suggest<CR>")
-- show lsp signature_help
map("n", "gh", ":lua vim.lsp.buf.signature_help() <CR>")
-- disable case toggling with u and U in visual mode and set it to undo
map("v", "u", ":<C-U>earlier <CR>")
map("v", "U", ":<C-U>earlier <CR>")
-- mapping openingh.nvim
map("n", "<Leader>gm", ":OpenInGHRepo <CR>")
map("n", "<Leader>gf", ":OpenInGHFile <CR>")
-- mapping for ccc
map("n", "<Leader>lc", ":CccPick <CR>")
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
-- disable jk, jj and kj mapping for escape since we have system wide jk for escape
lvim.keys.insert_mode["jk"] = false
lvim.keys.insert_mode["kj"] = false
lvim.keys.insert_mode["jj"] = false

-- set additional code-actions
local actions = require("lvim.lsp.null-ls.code_actions")
actions.setup({
  {
    command = "eslint",
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

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

local clangd_flags = {
  "--fallback-style=google",
  "--background-index",
  "-j=12",
  "--all-scopes-completion",
  "--pch-storage=disk",
  "--clang-tidy",
  "--log=error",
  "--completion-style=detailed",
  "--header-insertion=iwyu",
  "--header-insertion-decorators",
  "--enable-config",
  "--offset-encoding=utf-16",
  "--ranking-model=heuristics",
  "--folding-ranges",
}

local clangd_bin = "clangd"

local opts = {
  cmd = { clangd_bin, unpack(clangd_flags) },
}
require("lvim.lsp.manager").setup("clangd", opts)

-- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  {
    command = "eslint",
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
    command = "eslint",
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
