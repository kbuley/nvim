return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    opts.sources = require("cmp").config.sources({
      {
        name = "nvim_lsp",
        entry_filter = function(entry, _)
          local kind = require("cmp").lsp.CompletionItemKind[entry:get_kind()]
          if kind == "Text" then
            return false
          end
          return true
        end,
      },
      { name = "luasnip" },
      { name = "path" },
    })
  end,
}
