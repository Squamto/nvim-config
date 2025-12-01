vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "When text is yanked, highlight the selection",
  group = vim.api.nvim_create_augroup('highlight-yqnk', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Coding Style for Kernel",
  group = vim.api.nvim_create_augroup('project-configs', { clear = false }),
  pattern = { "*kernel*/*.c", "*kernel*/*.h" },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 8
    vim.bo.softtabstop = 8
    vim.bo.tabstop = 8

    local namespace = vim.api.nvim_create_namespace('checkpath')

    local function run_checkpatch()
      local filename = vim.api.nvim_buf_get_name(0)
      local cmd = 'scripts/checkpatch.pl --no-tree --no-signoff --terse -f ' .. filename
      local result = vim.system({ cmd }):wait()

      if result.code ~= 0 then
        vim.notify('Error running checkpatch\nstderr: ' .. result.stderr .. '\nstdout: ' .. result.stdout,
          vim.log.levels.ERROR)
        return
      end

      if result.stdout == '' then
        print('No issues found')
        return
      end

      local lines = vim.split(result.stdout, '\n')
      ---@type vim.Diagnostic[]
      local diagnostics = {}

      for _, line in ipairs(lines) do
        local parts = vim.split(line, ':')
        if #parts < 3 then
          goto continue
        end

        -- if filename ~= parts[1] then
        --   vim.api.nvim_err_writeln('filename does not match')
        -- end
        local linenum = tonumber(parts[2])
        local type = parts[3]
        local message = parts[4]
        local severity = vim.diagnostic.severity.INFO

        if type == 'ERROR' then
          severity = vim.diagnostic.severity.ERROR
        elseif type == 'WARNING' then
          severity = vim.diagnostic.severity.WARN
        end

        if linenum == nil or type == nil or message == nil then
          goto continue
        end

        diagnostics[#diagnostics + 1] = {
          source = 'checkpatch',
          lnum = linenum,
          col = 0,
          message = message,
          severity = severity,
        }

        ::continue::
      end

      vim.diagnostic.set(namespace, vim.api.nvim_get_current_buf(), diagnostics)
    end

    vim.keymap.set('n', '<leader>kc', function()
      run_checkpatch()
    end, { silent = true, desc = 'Run checkpatch' })
  end,
})
