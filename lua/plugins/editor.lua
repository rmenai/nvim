return {
  -- LANGUAGES SUPPORT
  {
    -- LATEX
    "lervag/vimtex",
    ft = { "tex", "plaintex" },
    cmd = { "VimtexInfo", "VimtexCompile", "VimtexStopAll", "VimtexReload" },
    init = function()
      vim.g.vimtex_view_method = "sioyek"
      vim.g.vimtex_view_sioyek_exe = "sioyek.exe"
      vim.g.vimtex_callback_progpath = "wsl nvim"
    end,
  },
  -- LANGUAGE SPECIFIC
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    ft = { "html", "css", "vue", "typescript", "javascript" },
    cmd = { "TailwindSort", "TailwindColorToggle", "TailwindConcealToggle" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("tailwind-tools").setup({
        document_color = {
          enabled = true,
          kind = "background",
          debounce = 0,
        },
      })
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust",
    config = function()
      require("core.patches").patch_runnables()
      require("neotest")
    end,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true,
          },
          crates = {
            enabled = true,
            max_results = 8,
            min_chars = 3,
          },
        },
      })
    end,
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    config = function()
      require("overseer").setup({
        templates = { "builtin", "custom" },
        dap = false,
        strategy = {
          "toggleterm",
          direction = "horizontal",
          auto_scroll = true,
          close_on_exit = false,
        },
      })
    end,
  },

  {
    -- AUTOMATIC PAIRS
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = "hrsh7th/nvim-cmp",
    config = function() require("nvim-autopairs").setup({}) end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "css", "vue", "javascript", "typescript", "markdown" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close_on_slash = true,
        },
      })
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = "BufRead",
    config = function() require("Comment").setup({}) end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup({}) end,
  },
  {
    -- COLOR PREVIEW
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "html", "javascript", "typescript", "vue", "json" },
    cmd = { "ColorizerToggle", "ColorizerDetachFromBuffer" },
    config = function()
      require("colorizer").setup({
        "*",
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          RRGGBBAA = true,
          names = true,
          rgb_fn = true,
          hsl_fn = true,
          css = true,
          css_fn = true,
        },
      })
    end,
  },
  {
    -- BETTER ESCAPE INSERT
    "TheBlob42/houdini.nvim",
    event = "ModeChanged",
    config = function()
      require("houdini").setup({
        mappings = { "jj", "jk" },
        timeout = 200,
        escape_sequences = {
          ["v"] = false,
          ["vs"] = false,
          ["V"] = false,
          ["Vs"] = false,
          ["no"] = false,
          ["nov"] = false,
          ["noV"] = false,
        },
      })
    end,
  },
}
