local skynet = require 'skynet'
local dc = require 'skynet.datacenter'

local _M = {}

-- System ID
_M.id = function()
	return dc.get("CLOUD", "ID") or dc.wait("SYS", "ID")
end

_M.hw_id = function()
	return dc.wait("SYS", "ID")
end

_M.beta = function()
	return dc.get("SYS", "USING_BETA")
end

_M.set_beta = function(value)
	dc.set("SYS", "USING_BETA", value)
end

_M.auth_code = function()
	return dc.get("SYS", "AUTH_CODE")
end

_M.set_auto_code = function(value)
	dc.set("SYS", "AUTH_CODE", value)
end

_M.pkg_host_url = function()
	return dc.get("SYS", "PKG_HOST_URL")
end

_M.set_pkg_host_url = function(value)
	dc.set("SYS", "PKG_HOST_URL", value)
end

_M.cnf_host_url = function()
	return dc.get("SYS", "CNF_HOST_URL")
end

_M.set_cnf_host_url = function(value)
	dc.set("SYS", "CNF_HOST_URL", value)
end

_M.cfg_auto_upload = function()
	return dc.get('SYS', "CFG_AUTO_UPLOAD")
end

_M.set_cfg_auto_upload = function(value)
	dc.set('SYS', 'CFG_AUTO_UPLOAD', value)
end

_M.time = skynet.time
_M.starttime = skynet.starttime

--[[
_M.datacenter = dc
_M.skynet = skynet
_M.cjson = require 'cjson'
_M.curl = require 'curl'
_M.serialchannel = require 'serialchannel'
_M.socketchannel = require 'socketchannel'
_M.basexx = require 'basexx'
]]--

return _M
