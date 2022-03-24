local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

-- local status_ruby_dap_ok, dapruby = pcall(require, dap-ruby)
-- if not status_ruby_dap_ok then
--   return
-- end
--
--
-- dapruby.setup()
require("dap-ruby").setup()
require("dap-go").setup({})

dap.adapters.ruby = {
	type = "executable",
	command = "bundle",
	args = { "exec", "readapt", "stdio" },
}

dap.configurations.ruby = {
	{
		type = "ruby",
		request = "launch",
		name = "Rails",
		program = "bundle",
		programArgs = { "exec", "rails", "s" },
		useBundler = true,
	},

	{
		name = "Debug rspec spec",
		type = "ruby",
		request = "launch",
		cwd = "${workspaceFolder}",
		program = "${workspaceFolder}/bin/rspec",
		useBundler = true,
		pathToBundler = "${workspaceFolder}/bin/bundle",
		showDebuggerOutput = true,
		pathToRDebugIDE = "${workspaceFolder}/bin/rdebug-ide",
		args = "[${file}:${lineNumber}]",
		env = {
			RAILS_ENV = "test",
			BUNDLE_GEMFILE = "Gemlocal",
			DISABLE_SPRING = true,
		},
	},
}
