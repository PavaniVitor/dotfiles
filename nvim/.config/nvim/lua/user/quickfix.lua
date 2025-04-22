local removed_qf_items = {}

local function remove_qf_item()
  local curqfidx = vim.fn.line('.') - 1
  local qfall = vim.fn.getqflist()
  local removed = qfall[curqfidx + 1]

  if removed then
    table.remove(qfall, curqfidx + 1)
    vim.fn.setqflist(qfall, 'r')
    table.insert(removed_qf_items, { index = curqfidx + 1, item = removed })

    if #qfall > 0 then
      vim.cmd((math.min(curqfidx + 1, #qfall)) .. 'cfirst')
      vim.cmd('copen')
    else
      vim.cmd('cclose')
    end
  end
end


local function undo_qf_item()
  if #removed_qf_items == 0 then
    print("Nenhum item para restaurar.")
    return
  end

  local qfall = vim.fn.getqflist()
  local last = table.remove(removed_qf_items)

  table.insert(qfall, last.index, last.item)
  vim.fn.setqflist(qfall, 'r')

  vim.cmd((last.index) .. 'cfirst')
  vim.cmd('copen')
end

vim.api.nvim_create_user_command('RemoveQFItem', remove_qf_item, {})
vim.api.nvim_create_user_command('UndoQFItem', undo_qf_item, {})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    vim.keymap.set('n', 'dd', ':RemoveQFItem<CR>', { buffer = true, silent = true })
    vim.keymap.set('n', 'u',  ':UndoQFItem<CR>',   { buffer = true, silent = true })
  end,
})

