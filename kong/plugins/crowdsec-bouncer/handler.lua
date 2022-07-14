local config = require "kong.plugins.crowdsec-bouncer.libs.config"
local iputils = require "kong.plugins.crowdsec-bouncer.libs.iputils"
local http = require "resty.http"
local cjson = require "cjson"
local recaptcha = require "kong.plugins.crowdsec-bouncer.libs.recaptcha"
local utils = require "kong.plugins.crowdsec-bouncer.libs.utils"
local ban = require "kong.plugins.crowdsec-bouncer.libs.ban"

local plugin = {
    PRIORITY = 200,
    VERSION = "0.1",
  }

-- contain runtime = {}
local runtime = {}
-- remediations are stored in cache as int (shared dict tags)
-- we need to translate IDs to text with this.
runtime.remediations = {}
runtime.remediations["1"] = "ban"
runtime.remediations["2"] = "captcha"


local csmod = {}


  function plugin:init_worker()
  end
  
  function plugin:access(plugin_conf)
    local cs = require "kong.plugins.crowdsec-bouncer.crowdsec"
        local ok, err = cs.init("/etc/crowdsec/bouncers/crowdsec-openresty-bouncer.conf", "crowdsec-openresty-bouncer/v0.0.7")
        if ok == nil then
                ngx.log(ngx.ERR, "[Crowdsec] " .. err)
                error()
        end
    cs.Allow(ngx.var.remote_addr)
  end
  
  
  return plugin
