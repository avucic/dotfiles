local M = {}

local function openrouter_models()
  local handle =
    io.popen "curl -s https://openrouter.ai/api/v1/models | jq -r '.data[] | select(.pricing.prompt == \"0\") | .id'"

  if not handle then return {} end

  local result = {}
  for model in handle:lines() do
    result[model] = model
  end

  handle:close()
  return result
end

M.adapters = {
  gemini = function()
    return require("codecompanion.adapters").extend("gemini", {
      env = {
        --   -- url = "http[s]://open_compatible_ai_url", -- optional: default value is ollama url http://127.0.0.1:11434
        api_key = os.getenv "GEMINI_API_KEY", -- optional: if your endpoint is authenticated
        --   chat_url = "/v1/chat/completions", -- optional: default value, override if different
      },
    })
  end,
  ollama = function()
    return require("codecompanion.adapters").extend("ollama", {
      -- Remove or change this line: name = "qwen",
      parameters = {
        sync = true,
      },
      schema = {
        model = {
          default = "deepseek-coder", -- This is the model that should be used
        },
      },
    })
  end,
  openrouter_free = function()
    return require("codecompanion.adapters").extend("openai_compatible", {
      env = {
        api_key = "OPENROUTER_API_KEY",
      },

      name = "openrouter",
      formatted_name = "Open Router Free",

      url = "https://openrouter.ai/api/v1/chat/completions",

      headers = {
        ["Authorization"] = "Bearer " .. os.getenv "OPENROUTER_API_KEY",
        ["HTTP-Referer"] = "https://github.com",
        ["X-Title"] = "Neovim",
      },

      parameters = {
        stream = true,
      },

      schema = {
        model = {
          order = 1,
          mapping = "parameters",
          type = "enum",
          default = "meta-llama/llama-3.1-8b-instruct:free",
          choices = openrouter_models(),
        },
      },
    })
  end,

  openrouter_auto = function()
    return require("codecompanion.adapters").extend("openai_compatible", {
      env = {
        api_key = "OPENROUTER_API_KEY",
      },

      name = "openrouter",
      formatted_name = "Open Router Auto",

      url = "https://openrouter.ai/api/v1/chat/completions",

      headers = {
        ["Authorization"] = "Bearer " .. os.getenv "OPENROUTER_API_KEY",
        ["HTTP-Referer"] = "https://github.com",
        ["X-Title"] = "Neovim",
      },

      parameters = {
        stream = true,
      },

      schema = {
        model = {
          default = "openrouter/free",
          choices = {},
        },
      },
    })
  end,
  -- openrouter_auto = function()
  --   return {
  --     name = "openrouter",
  --     url = "https://openrouter.ai/api/v1/chat/completions",
  --     formatted_name = "Open Router Auto",
  --     roles = {
  --       llm = "assistant",
  --       user = "user",
  --       tool = "tool",
  --     },
  --     opts = {
  --       stream = true,
  --       tools = true,
  --       vision = true,
  --     },
  --     features = {
  --       text = true,
  --       tokens = true,
  --     },
  --     headers = {
  --       ["Authorization"] = "Bearer " .. os.getenv "OPENROUTER_API_KEY",
  --       ["HTTP-Referer"] = "https://github.com",
  --       ["X-Title"] = "Neovim",
  --       -- ["Content-Type"] = "application/json",
  --     },
  --
  --     parameters = {
  --       stream = true,
  --     },
  --
  --     messages = {
  --       role = "role",
  --       content = "content",
  --     },
  --     schema = {
  --       model = { default = "openrouter/free" },
  --       choices = nil,
  --     },
  --   }
  -- end,
}

return M
