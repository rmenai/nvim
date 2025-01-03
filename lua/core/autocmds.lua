local M = {}

-- Listen lsp-progress event and refresh lualine
M.lualine_autocmd = function()
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("lualine_augroup", { clear = true }),
    pattern = "LspProgressStatusUpdated",
    callback = function() require("lualine").refresh() end,
  })
end

-- Commit leetcode changes on neovim leave
M.leetcode_autocmd = function(callback)
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("AutoGitCommit", { clear = true }),
    callback = callback,
  })
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function(opts)
    if opts.file:match("dap%-terminal") then return end
    if opts.file:match("Neotest Output Panel") then return end
    vim.notify("Terminal opened: " .. opts.file, vim.log.levels.INFO)

    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
    vim.wo.foldcolumn = "1"

    vim.cmd("startinsert")
  end,
})

vim.api.nvim_create_autocmd("WinClosed", {
  pattern = "*",
  callback = function(e)
    local closed_win_id = tonumber(e.match)
    local buffer = vim.fn.getwininfo(closed_win_id)[1].bufnr
    local buf_name = vim.api.nvim_buf_get_name(buffer)

    if not vim.startswith(buf_name, "term://") then return end

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

      if filetype ~= "NvimTree" then
        vim.api.nvim_set_current_win(win) -- Focus this window
        return
      end
    end
  end,
})

-- Make :bd and :q behave as usual when tree is visible
vim.api.nvim_create_autocmd({ "BufEnter", "QuitPre" }, {
  nested = false,
  callback = function(e)
    local tree = require("nvim-tree.api").tree

    if not tree.is_visible() then return end

    local winCount = 0
    for _, winId in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_config(winId).focusable then winCount = winCount + 1 end
    end

    if e.event == "QuitPre" and winCount == 2 then vim.api.nvim_cmd({ cmd = "qall" }, {}) end

    if e.event == "BufEnter" and winCount == 1 then
      vim.defer_fn(function()
        tree.toggle({ find_file = true, focus = true })
        tree.toggle({ find_file = true, focus = false })
      end, 10)
    end
  end,
})

return M
