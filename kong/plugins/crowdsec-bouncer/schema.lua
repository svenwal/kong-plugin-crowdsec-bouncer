local typedefs = require "kong.db.schema.typedefs"

-- Grab pluginname from module name
local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

local schema = {
  name = plugin_name,
  fields = {
    { protocols = typedefs.protocols_http },
    { config = {
        type = "record",
        fields = {
          { api_url = {
              type = "string",
              default = "http://localhost:8080",
              required = true,
              }},
          { api_key = {
              type = "string",
              required = true,
              }},
          { bouncing_on_type = {
              type = "string",
              default = "all",
              required = true,
              }},
          { fallback_remediation = {
              type = "string",
              default = "ban",
              required = true,
              }},
          { mode = {
              type = "string",
              default = "stream",
              required = true,
              }},
        },
        entity_checks = {
        },
      },
    },
  },
}

return schema
