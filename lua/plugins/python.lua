return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "pyright" },
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      handlers = {
        pyright = function(server)
          vim.lsp.config(server, {
            settings = {
              python = {
                pythonPath = vim.fn.trim(vim.fn.system("uv run which python")),
              },
            },
          })
          vim.lsp.enable(server)
        end,
      },
    },
  },
}
