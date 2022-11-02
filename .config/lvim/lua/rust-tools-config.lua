local M = {}

M.setup = function()
  local rt = require("rust-tools")
  local opts = {
    tools = {
      executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
      reload_workspace_from_cargo_toml = true,
      inlay_hints = {
        auto = true,
        only_current_line = true,
        show_parameter_hints = true,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
      },
      hover_actions = {
        auto_focus = true,
      },
      autoSetHints = true,
    },
    server = {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      },

      on_init = require("lvim.lsp").common_on_init,
      on_attach = function(client, bufnr)
        require("lvim.lsp").common_on_attach(client, bufnr)
        local rt_ = require("rust-tools")
        -- Hover actions
        vim.keymap.set("n", "<C-space>", rt_.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<leader>lA", rt_.code_action_group.code_action_group, { buffer = bufnr })
      end,
    },
    runnables = {
      use_telescope = true,
    },

    dap = {
      adapter = {
        type = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
        name = "rt_lldb",
      },
    },
  }

  rt.setup(opts)
end

return M
