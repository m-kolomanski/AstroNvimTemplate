return {
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "pyright" },
    },
  },
  {
    "Astro/astrolsp",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = vim.fn.trim(vim.fn.system("uv run which python")),
            },
          },
        },
      },
    },
  },
}
