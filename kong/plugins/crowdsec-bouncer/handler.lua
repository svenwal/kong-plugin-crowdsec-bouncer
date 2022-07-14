local plugin = {
    PRIORITY = 1000, -- set the plugin priority, which determines plugin execution order
    VERSION = "0.1",
  }
  
  function plugin:access(plugin_conf)
    local cs = require "crowdsec"
    cs.Allow(ngx.var.remote_addr)
  end
  
  
  return plugin
