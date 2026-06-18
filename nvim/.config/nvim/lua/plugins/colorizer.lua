return {
  {
    'NvChad/nvim-colorizer.lua',
    cmd  = { 'ColorizerToggle', 'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer' },
    opts = {
      user_default_options = {
        names = false,
        mode  = 'background',
      },
    },
  },
}
