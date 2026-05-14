return {
  "AstroNvim/astrolsp",
  opts = {
    handlers = {
      r_language_server = function(server)
        vim.lsp.config(server, {
          cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
        })
        vim.lsp.enable(server)
      end,
    },
  },
}
