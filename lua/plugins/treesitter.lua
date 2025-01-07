return {
  "nvim-treesitter/nvim-treesitter",
  built = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ignore_install = {},
      modules = {},
      ensure_installed = {
        "bash",
        "c",
        "gotmpl",
        "graphql",
        "html",
        "javascript",
        "jq",
        "json",
        "jsonc",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "powershell",
        "proto",
        "puppet",
        "python",
        "query",
        "regex",
        "ssh_config",
        "tmux",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
      },

      sync_install = false,

      auto_install = true,

      indent = {
        enable = true,
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    })
  end,
}
