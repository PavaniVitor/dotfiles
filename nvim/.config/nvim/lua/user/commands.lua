local cmd = vim.api.nvim_create_user_command

cmd('WQ', 'wq', {})
cmd('Wq', 'wq', {})
cmd('W', 'w', {})
cmd('Q', 'q', {})

