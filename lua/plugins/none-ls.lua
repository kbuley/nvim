return {
  "nvimtools/none-ls.nvim", -- or "jose-elias-alvarez/null-ls.nvim" if using an older setup
  opts = function(_, opts)
    -- Filter out HCL formatters (e.g., packerfmt) from the sources
    opts.sources = vim.tbl_filter(function(source)
      -- Remove any formatting source that supports hcl
      if source.filetypes and vim.tbl_contains(source.filetypes, "hcl") then
        return false
      end
      return true
    end, opts.sources or {})
  end,
}
