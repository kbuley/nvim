--[[
  Getting you where you want with the fewest keystrokes.
--]]
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    require('harpoon'):setup()
    local conf = require('telescope.config').values

    local make_finder = function()
      local paths = {}
      for _, item in ipairs(harpoon:list().items) do
        table.insert(paths, item.value)
      end

      return require('telescope.finders').new_table {
        results = paths,
      }
    end

    local function toggle_telescope()
      require('telescope.pickers')
        .new({}, {
          prompt_title = 'Harpoon',
          finder = make_finder(),
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
          attach_mappings = function(prompt_buffer_number, map)
            map('i', '<C-d>', function()
              local state = require 'telescope.actions.state'
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_buffer_number)

              harpoon:list():remove(selected_entry)
              current_picker:refresh(make_finder())
            end)

            return true
          end,
        })
        :find()
    end

    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = '[H]arpoon [A]dd' })
    vim.keymap.set('n', '<C-e>', function()
      --  harpoon.ui:toggle_quick_menu(harpoon:list())
      vim.keymap.set('n', '<C-e>', function()
        toggle_telescope()
      end, { desc = 'Open harpoon window' })
    end)
    vim.keymap.set('n', '<leader>hl', function()
      toggle_telescope()
    end, { desc = '[H]arpoon [L]ist' })
    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set('n', '<C-S-P>', function()
      harpoon:list():prev { ui_nav_wrap = true }
    end)
    vim.keymap.set('n', '<C-S-N>', function()
      harpoon:list():next { ui_nav_wrap = true }
    end)
  end,
}
