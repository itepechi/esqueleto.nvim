local utils = require("esqueleto.utils")

local M = {}

M.default_config = {
  autouse = true,
  directories = { vim.fn.stdpath("config") .. "/skeletons" },
  patterns = {},
  wildcards = {
    expand = true,
    lookup = {
      -- File
      ["filename"] = function() return vim.fn.expand("%:t:r") end,
      ["fileabspath"] = function() return vim.fn.expand("%:p") end,
      ["filerelpath"] = function() return vim.fn.expand("%:p:~") end,
      ["fileext"] = function() return vim.fn.expand("%:e") end,
      ["filetype"] = function() return vim.bo.filetype end,

      -- Date and time
      ["date"] = function() return os.date("%Y%m%d", os.time()) end,
      ["year"] = function() return os.date("%Y", os.time()) end,
      ["month"] = function() return os.date("%m", os.time()) end,
      ["day"] = function() return os.date("%d", os.time()) end,
      ["time"] = function() return os.date("%T", os.time()) end,

      -- System
      ["host"] = utils.capture("hostname", false),
      ["user"] = os.getenv("USER"),

      -- Github
      ["gh-email"] = utils.capture("git config user.email", false),
      ["gh-user"] = utils.capture("git config user.name", false),
    },
  },
}

M.updateconfig = function(config)
  vim.validate({ config = { config, "table", true } })
  config = vim.tbl_deep_extend("force", M.default_config, config or {})

  -- Validate setup
  vim.validate({
    autouse = { config.autouse, "boolean" },
    directories = { config.directories, "table" },
    patterns = { config.patterns, "table" },
    wildcards = { config.wildcards, "table" },
  })

  return config
end

return M
