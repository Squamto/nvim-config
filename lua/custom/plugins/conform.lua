return {
  {
    'stevearc/conform.nvim',
    keys = {
      {
        '<leader>df',
        function()
          require('conform').format { lsp_format = 'fallback' }
        end,
        desc = '[D]ocument [F]ormat',
      },
    },
    opts = {
      notify_on_error = true,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 1000,
          lsp_format = disable_filetypes[vim.bo[bufnr].filetype] and 'never' or 'fallback',
        }
      end,
    },
  },
}
