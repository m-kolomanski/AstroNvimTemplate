return {
  "AstroNvim/astrocore",
  opts = {
    autocmds = {
      signature_help_r = {
        {
          event = "TextChangedI",
          pattern = "*.R",
          callback = function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.fn.col(".") - 1
            local char = line:sub(col, col)
            -- trigger on ( or ,
            -- also keep open on space/newline if line contains a comma (inside function call)
            if char == "(" or char == "," then
              vim.lsp.buf.signature_help()
            elseif char == " " or char == "" then
              -- check if we're still inside a function call
              local before_cursor = line:sub(1, col)
              if before_cursor:match("%(") and not before_cursor:match("%)%s*$") then
                vim.lsp.buf.signature_help()
              end
            end
          end,
        },
      },
    },
  },
}
