return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    sources = { "filesystem" },
    filesystem = {
      bind_to_cwd = true,
      sync_root_with_cwd = true,
    },
  },
}
