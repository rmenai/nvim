return {
  {
    -- AUTO CWD
    "ahmedkhalf/project.nvim",
    lazy = false,
    config = function()
      require("project_nvim").setup({
        patterns = {
          ".git",
          "_darcs",
          ".hg",
          ".bzr",
          ".svn",
          "Makefile",
          "package.json",
          "main.py",
          "dune-project",
        },
      })
    end,
  },
  {
    "aserowy/tmux.nvim",
    lazy = false,
    config = function()
      require("tmux").setup({
        navigation = {
          enable_default_keybindings = true,
          cycle_navigation = false,
          persist_zoom = false,
        },
        resize = {
          enable_default_keybindings = true,
          resize_step_x = 2,
          resize_step_y = 2,
        },
      })
    end,
  },
  {
    -- AUTO SAVE
    "pocco81/auto-save.nvim",
    ft = { "html", "css", "typescript", "javascript", "vue", "tex", "markdown" },
    keys = "<F12>",
    config = function()
      require("auto-save").setup({
        enabled = true,
      })

      -- Set up mappings
      require("core.mappings").map_autosave()
    end,
  },
  {
    "rcarriga/nvim-notify",
    lazy = false,
    config = function()
      require("notify").setup({
        level = "error",
      })

      vim.notify = require("notify")
    end,
  },
}
