return {
  "milanglacier/minuet-ai.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("minuet").setup({
      provider = "openai_fim_compatible",
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM", -- ollama doesn't need a real key
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },
      notify = false,
      -- tune these for local latency
      request_timeout = 4,
      throttle = 500,
      debounce = 200,
    })
  end,
}
