return {
  {
    "leoluz/nvim-dap-go",
    opts = {
      dap_configurations = {
        {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
        },
      },
    },
    ft = "go"
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      ui.setup()

      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
      vim.keymap.set('n', '<leader>gb', dap.run_to_cursor)

      vim.keymap.set('n', '<leader>?', function()
        ui.eval(nil, { enter = true })
      end)

      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[D]ebug [C]ontinue' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = '[D]ebug [O]ver' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = '[D]ebug [I]nto' })
      vim.keymap.set('n', '<leader>dr', dap.step_out, { desc = '[D]ebug Out ([R]eturn)' })
      vim.keymap.set('n', '<leader>dx', dap.restart, { desc = '[D]ebug Restart' })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end

      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      local pick_file = function(prompt, cwd, on_done)
        local pickers = require('telescope.builtin')
        local actions = require('telescope.actions')
        local actions_state = require('telescope.actions.state')
        pickers.find_files {
          cwd = cwd or vim.fn.getcwd(),
          hidden = true,
          prompt_title = prompt,
          attach_mappings = function(bufnr, map)
            map('i', '<CR>', function()
              local entry = actions_state.get_selected_entry()
              actions.close(bufnr)
              on_done(entry.path)
            end)
            return true
          end,
        }
      end

      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = { 'gdb', '--interpreter=dap', "--eval-command", "set print pretty on" },
      }

      ---@type table<integer, string>
      local programs_per_buffer = {}

      dap.configurations.cpp =
      {
        {
          name = "Attach",
          type = "gdb",
          request = "attach",
          pid = require('dap.utils').pick_process,
        },
        {
          name = "Launch previous",
          type = "gdb",
          request = "launch",
          program = function()
            return coroutine.create(function(dap_run)
              local bufnr = vim.api.nvim_get_current_buf()
              vim.print('bufnr', bufnr)
              if programs_per_buffer[bufnr] then
                coroutine.resume(dap_run, programs_per_buffer[bufnr])
                return
              end

              pick_file('Select a file', vim.fn.getcwd(), function(file)
                programs_per_buffer[bufnr] = file
                coroutine.resume(dap_run, file)
              end)
            end)
          end,
          cwd = '${workspaceFolder}',
        },
        {
          name = "Launch",
          type = "gdb",
          request = "launch",
          program = function()
            return coroutine.create(function(dap_run)
              pick_file('Select a file', vim.fn.getcwd(), function(file)
                coroutine.resume(dap_run, file)
              end)
            end)
          end,
        },
      }
    end,
  },
}
