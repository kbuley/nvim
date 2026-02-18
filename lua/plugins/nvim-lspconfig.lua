return {
  "neovim/nvim-lspconfig",
  opts = {
    cmd_env = { GOFUMPT_SPLIT_LONG_LINES = "on" },
    servers = {
      azure_pipelines_ls = false, -- Disable automatic setup - we'll handle it manually
      bashls = {},
      cssls = {},
      gopls = {
        settings = {
          gopls = {
            buildFlags = { "-tags=integration" },
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
          },
          yaml = {
            schemaStore = {
              enable = false,
            },
          },
        },
      },
      marksman = {
        settings = {
          markdownlint = {
            config = {
              MD013 = {
                line_length = 100,
                code_block_line_length = 120,
              },
            },
          },
        },
      },
      puppet = { cmd = { "puppet-languageserver", "--stdio" } },
    },
  },
  init = function()
    -- Custom commands for switching between YAML and Azure Pipeline modes
    vim.api.nvim_create_user_command("AzurePipeline", function()
      -- Stop yamlls if running
      local yaml_clients = vim.lsp.get_clients({ name = "yamlls", bufnr = 0 })
      for _, client in ipairs(yaml_clients) do
        vim.lsp.stop_client(client.id)
      end

      -- Start Azure Pipeline LSP with proper schema config
      vim.lsp.start({
        name = "azure_pipelines_ls",
        cmd = { "azure-pipelines-language-server", "--stdio" },
        root_dir = vim.fn.getcwd(),
        single_file_support = true,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json",
            },
            schemas = {
              ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "*.yml",
            },
          },
        },
      })

      vim.bo.filetype = "azure-pipelines"
      vim.notify("Azure Pipeline LSP started with schema support", vim.log.levels.INFO)
    end, { desc = "Switch to Azure Pipeline mode with specialized LSP" })

    vim.api.nvim_create_user_command("YamlMode", function()
      -- Stop Azure Pipeline LSP if running
      local azure_clients = vim.lsp.get_clients({ name = "azure_pipelines_ls", bufnr = 0 })
      for _, client in ipairs(azure_clients) do
        vim.lsp.stop_client(client.id)
      end

      -- Switch back to YAML filetype and restart yamlls
      vim.bo.filetype = "yaml"
      vim.defer_fn(function()
        vim.cmd("LspStart yamlls")
        vim.notify("Switched back to YAML mode", vim.log.levels.INFO)
      end, 200)
    end, { desc = "Switch back to regular YAML mode" })

    -- Optional: Add keymaps for quick switching
    vim.keymap.set("n", "<leader>cap", "<cmd>AzurePipeline<cr>", { desc = "Azure Pipeline mode" })
    vim.keymap.set("n", "<leader>cay", "<cmd>YamlMode<cr>", { desc = "YAML mode" })
  end,
}
