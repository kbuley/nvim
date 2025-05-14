return {
  "saghen/blink.cmp",
  dependencies = {
    "fang2hou/blink-copilot",
  },
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      trigger = {
        show_in_snippet = false,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      ghost_text = {
        enabled = false,
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      nerd_font_variant = "normal",
    },
    sources = {
      default = { "lsp", "copilot", "snippets", "path" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
      transform_items = function(_, items)
        return vim.tbl_filter(function(item)
          return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
        end, items)
      end,
    },
  },
}
