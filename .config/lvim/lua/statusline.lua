local M = {}

local icons = {
  LSPLoading1 = "%#DiagnosticFloatingInfo# %*",
  LSPLoading2 = "%#DiagnosticFloatingInfo# %*",
  LSPLoaded = "%#DiagnosticFloatingHint# %*",
}

M.get_progress_messages = function()
  local new_messages = {}
  local progress_remove = {}

  for _, client in ipairs(vim.lsp.get_active_clients()) do
    local messages = client.messages
    local data = messages
    for token, ctx in pairs(data.progress) do
      local new_report = {
        name = data.name,
        title = ctx.title or "empty title",
        message = ctx.message,
        percentage = ctx.percentage,
        done = ctx.done,
        progress = true,
      }
      table.insert(new_messages, new_report)

      if ctx.done then
        table.insert(progress_remove, { client = client, token = token })
      end
    end
  end

  for _, item in ipairs(progress_remove) do
    item.client.messages.progress[item.token] = nil
  end

  return new_messages
end

M.get_loading_icon = function()
  local icon_index = math.floor(vim.loop.hrtime() / 12e7) % 2 + 1
  return icons["LSPLoading" .. icon_index]
end

M.lsp_progress = function()
  local message = M.get_progress_messages()[1]

  local result = string.format(
    "%s %s (%s%%%%) %%<%s",
    message.title or "",
    message.message or "",
    message.percentage or 0,
    ((message.percentage or 0) >= 70) and M.get_loading_icon() or icons.LSPLoaded
  )
  return result
end

return M
