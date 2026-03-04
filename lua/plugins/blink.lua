return {
  "saghen/blink.cmp",
  dependencies = {
    { "fang2hou/blink-copilot" },
  },
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
      trigger = {
        prefetch_on_insert = false,
        debounce_time = 1000, -- One second
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
    sources = {
      default = { "lsp", "minuet", "copilot", "snippets", "path" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        minuet = {
          name = "minuet",
          module = "minuet.blink",
          score_offset = 8,
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
