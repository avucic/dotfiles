return function(_, _opts)
  vim.cmd([[
command! NeotestSummary lua require("neotest").summary.toggle()
command! NeotestFile lua require("neotest").run.run(vim.fn.expand("%"))
command! Neotest lua require("neotest").run.run(vim.fn.getcwd())
command! NeotestNearest lua require("neotest").run.run()
command! NeotestDebug lua require("neotest").run.run({ strategy = "dap" })
command! NeotestAttach lua require("neotest").run.attach()
command! NeotestOutput lua require("neotest").output.open()
]])
  -- get neotest namespace (api call creates or returns namespace)
  local neotest_ns = vim.api.nvim_create_namespace("neotest")
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
        return message
      end,
    },
  }, neotest_ns)

  require("neotest").setup({
    output_panel = {
      enabled = false,
    },
    output = {
      enabled = true,
    },
    quickfix = {
      enabled = false,
    },
    diagnostic = {
      enabled = false,
    },
    consumers = {
      -- overseer = require("neotest.consumers.overseer"),
    },

    -- your neotest config here
    adapters = {
      -- require("neotest-go"),
      require("neotest-rust"),
      require("neotest-python"),
      require("neotest-rspec")({
        rspec_cmd = function()
          return vim.tbl_flatten({
            "bundle",
            "exec",
            "rspec",
          })
        end,
      }),
    },
  })
end
