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
  ocamllsp = {},
  basedpyright = {},
  clangd = {
    -- cmd = { 'clangd', '--background-index', '--query-driver=**/arm-none-eabi-*', '--header-insertion=never', '--compile-commands-dir=build/latest' },
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
  ts_ls = {},
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        check = {
          command = "clippy",
        },
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
          map('gt', builtin.lsp_type_definitions, '[G]oto [T]ype Definition')
          map('gr', builtin.lsp_references, '[G]oto [R]eferences')
          map('gI', builtin.lsp_implementations, '[G]oto [I]mplementations')

          map('<leader>ds', builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('<leader>rn', vim.lsp.buf.rename, '[R]ename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlzy [H]ints')
          end
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
