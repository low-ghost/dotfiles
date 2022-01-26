ts_config = require('nvim-treesitter.configs')

ts_config.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@comment.outer",
        ["ic"] = "@comment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<space>np"] = "@parameter.inner",
      },
      swap_previous = {
        ["<space>nP"] = "@parameter.inner",
      },
    },
    lsp_interop = {
      enable = false,
    },
  },
  enable = true,
}
