if false then return {} else
return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
      -- require('nvim-treesitter').setup(opts)
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local nvim_treesitter = require('nvim-treesitter')
          local installed = nvim_treesitter.get_installed('parsers')

          if not vim.list_contains(installed, args.match) then
            local available = nvim_treesitter.get_available()
            if not vim.tbl_contains(available, args.match) then
              return
            end
            print('Trying to install parser for ' .. args.match)
            nvim_treesitter.install(args.match):await(function(success)
              print(vim.inspect(success))
              if success then
                print('Parser installed')
                vim.treesitter.start()
              else
                print('Parser for ' .. args.match .. ' not installed')
              end
            end)
            return
          end

          vim.treesitter.start()
        end,
      })
    end,
  },
  'nvim-treesitter/nvim-treesitter-context',
}
end
