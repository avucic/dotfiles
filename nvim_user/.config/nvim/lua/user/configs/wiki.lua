local M = {}

function M.setup()
  vim.g.wiki_root = vim.env.ZK_NOTEBOOK_DIR
  vim.g.wiki_filetypes = { "md" }
  vim.g.wiki_link_extension = ".md"
  vim.g.wiki_link_target_type = "md"
  vim.g.wiki_tag_scan_num_lines = "all"
  vim.g.wiki_write_on_nav = 1
  vim.g.wiki_list_todo = 1
  vim.g.wiki_mappings_use_defaults = "local"

  vim.g.wiki_journal = {
    name = "journal/daily",
    frequency = "daily",
    date_format = {
      daily = "%Y-%m-%d",
      weekly = "%Y_w%V",
      monthly = "%Y_m%m",
    },
    index_use_journal_scheme = 0,
  }
end

function M.config() end

return M
