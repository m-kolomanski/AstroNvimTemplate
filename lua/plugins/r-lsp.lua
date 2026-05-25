return {
  "AstroNvim/astrolsp",
  opts = {
    handlers = {
      r_language_server = function(server)
        vim.lsp.config(server, {
          cmd = { "R", "--no-echo", "-e", "languageserver::run()" },
          flags = {
            allow_incremental_sync = true,
            debounce_text_changes = 500,
          },
          capabilities = {
            textDocumentSync = {
              willSaveWaitUntil = false,
            },
          },
        })
        vim.lsp.enable(server)
      end,
    },
  },
}
