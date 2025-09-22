return {
  "jedrzejboczar/devcontainers.nvim",
  dependencies = {
    "miversen33/netman.nvim", -- optional to browse files in docker container
  },
  opts = {
    docker_cmd = "podman",
    devcontainers_cli_cmd = { "bash", "-c", "devcontainer \"$@\" | sed '1d'", "--" },
    log = {
      level = "debug",
    },
  },
}
