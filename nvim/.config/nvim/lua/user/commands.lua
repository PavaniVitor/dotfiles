local cmd = vim.api.nvim_create_user_command

cmd('W', 'w', {})
cmd('WQ', 'wq', {bang = true})
cmd('Wq', 'wq', {bang = true})
cmd('Q', 'q', {bang=true})
cmd('Jq', '%!jq .', {bang=true})
