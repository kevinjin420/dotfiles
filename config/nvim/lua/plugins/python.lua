return {
  -- Ensure basedpyright is installed via Mason
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "basedpyright" })
    end,
  },

  -- Configure basedpyright and disable standard pyright
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {},
        pyright = { enabled = false },
      },
    },
  },
}
