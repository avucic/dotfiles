local M = {}

function M.generate_branch_name_to_clipboard()
  local ticket_number = vim.fn.input "Enter ticket number: "
  if ticket_number == "" then
    print "Ticket number cannot be empty. Aborting."
    return
  end

  local title = vim.fn.input "Enter title: "
  if title == "" then
    print "Title cannot be empty. Aborting."
    return
  end

  -- Format the title: convert to lowercase, replace spaces with hyphens, remove non-alphanumeric/hyphen
  local formatted_title = title:lower():gsub("%s+", "-"):gsub("[^%w%-]+", "")

  local output = string.format("%s-%s", ticket_number, formatted_title)

  -- Copy to clipboard (register '+')
  vim.fn.setreg("+", output)

  print(string.format("Copied to clipboard: %s", output))
end

return M
