local servers = {
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  gopls = {
    cmd = { 'gopls', 'serve' },
    settings = {
      gopls = {
        staticcheck = true,
      },
    },
  },
  zls = {},
  tsserver = {},
  rust_analyzer = {
    ['rust-analyzer'] = {
      check = {
        command = 'clippy',
      },
    },
  },
}

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local builtin = require 'telescope.builtin'

          map('gd', builtin.lsp_definitions, '[G]oto [D]efinitions')
          map('gr', builtin.lsp_references, '[G]oto [R]eferences')
          map('gI', builtin.lsp_implementations, '[G]oto [I]mplementations')

          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<leader>rn', vim.lsp.buf.rename, '[R]ename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('<leader>e', vim.lsp.diagnostic.show_line_diagnostics, '[E]rrors')
          map('<leader>q', vim.lsp.diagnostic.set_loclist, '[Q]uickfix')

        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      for server, config in pairs(servers) do
        require('lspconfig')[server].setup(vim.tbl_deep_extend('force', {
          capabilities = capabilities,
          on_attach = require('fidget').on_attach,
        }, config))
      end
    end,
  },
}
