local M = {}

M.anthropic = function()
	return require("codecompanion.adapters").extend("anthropic", {
		env = { api_key = "ANTHROPIC_API_KEY" },
		schema = {
			model = { default = "claude-sonnet-4-6" },
		},
	})
end

M.gemini = function()
	return require("codecompanion.adapters").extend("gemini", {
		env = { api_key = os.getenv("GEMINI_API_KEY") },
		-- schema = {
		--   model = { default = "gemini-2.5-flash" },
		-- },
	})
end

M.githubmodels = function()
	return require("codecompanion.adapters").extend("githubmodels", {
		env = { api_key = "GITHUB_API_KEY" },
	})
end

M.ollama = function()
	return require("codecompanion.adapters").extend("ollama", {
		parameters = { sync = true, think = false },
		schema = {
			model = { default = os.getenv("OLLAMA_MODEL") or "qwen3-nothink" },
		},
	})
end

M.copilot = function()
	return require("codecompanion.adapters").extend("copilot", {
		schema = {
			model = {
				default = "gpt-4.1",
			},
		},
	})
end

M.openrouter_free = function()
	return require("codecompanion.adapters").extend("openai_compatible", {
		env = { api_key = "OPENROUTER_API_KEY" },
		name = "openrouter_free",
		formatted_name = "Open Router Free",
		url = "https://openrouter.ai/api/v1/chat/completions",
		headers = {
			["Authorization"] = "Bearer ${api_key}",
			["HTTP-Referer"] = "https://github.com",
			["X-Title"] = "Neovim",
		},
		parameters = { stream = true },
		schema = {
			model = {
				order = 1,
				mapping = "parameters",
				type = "enum",
				default = "meta-llama/llama-3.1-8b-instruct:free",
				choices = {},
			},
		},
	})
end

M.openrouter_auto = function()
	return require("codecompanion.adapters").extend("openai_compatible", {
		env = { api_key = "OPENROUTER_API_KEY" },
		name = "openrouter_auto",
		formatted_name = "Open Router Auto",
		url = "https://openrouter.ai/api/v1/chat/completions",
		headers = {
			["Authorization"] = "Bearer ${api_key}",
			["HTTP-Referer"] = "https://github.com",
			["X-Title"] = "Neovim",
		},
		parameters = { stream = false },
		schema = {
			model = { default = "openrouter/free", choices = {} },
		},
	})
end

return M
