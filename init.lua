require('plugins')
require('base')

vim.api.nvim_create_user_command('CppMan', function(args)
  local output = vim.fn.system('cppman ' .. vim.fn.shellescape(args.args))
  vim.cmd('new')
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, '\n'))
end, { nargs = 1 })

vim.opt.fillchars = { eob = " " }
