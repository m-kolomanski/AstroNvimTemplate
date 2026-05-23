local function safe_signature_help()
  local client = vim.lsp.get_clients({ bufnr = 0 })[1]
  if not client then return end
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  vim.lsp.buf_request(0, "textDocument/signatureHelp", params,
    function(err, result, ctx, config)
      if err then return end
      if type(result) ~= "table" then return end
      if type(result.signatures) ~= "table" then return end
      if #result.signatures == 0 then return end
      vim.lsp.handlers["textDocument/signatureHelp"](err, result, ctx, config)
    end
  )
end

return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      i = {
        ["<C-e>"] = { function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_config(win).relative ~= "" then
            vim.api.nvim_win_close(win, true)
          end
        end
      end, desc = "Dismiss signature help" },
      },
    },
    autocmds = {
      signature_help_r = {
        {
          event = "TextChangedI",
          pattern = "*",
          callback = function()
            local line = vim.api.nvim_get_current_line()
            local col = vim.fn.col(".") - 1
            local before_cursor = line:sub(1, col)
            -- count unescaped quotes before cursor; odd = inside string
            local _, quote_count = before_cursor:gsub('"', '')
            if quote_count % 2 ~= 0 then return end
            local char = line:sub(col, col)
            if char == "(" or char == "," then
              safe_signature_help()
            elseif char == " " then
              if before_cursor:match(",%s*$") then
                safe_signature_help()
              end
            end
          end,
        },
      },
    },
  },
}
