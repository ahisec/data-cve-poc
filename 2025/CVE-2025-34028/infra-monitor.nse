-- File: infra-monitor.nse
description = [[
Performs stealth request comparison for infrastructure diagnostics.
]]
author = "Network Diagnostics Task"
license = "Same as Nmap"
categories = {"discovery", "safe"}

local http = require "http"
local shortport = require "shortport"
local stdnse = require "stdnse"

portrule = shortport.port_or_service({443, 80, 81, 8400}, "http")

local function compare_paths(host, port)
  local base_path = "/ccenter/status"
  local alt_path = base_path .. "?debug=../../../.."

  local a = http.get(host, port, base_path)
  local b = http.get(host, port, alt_path)

  if not a or not b then
    return nil, "Diagnostics incomplete"
  end

  if a.status ~= b.status then
    return true, string.format("Response mismatch: %d vs %d", a.status, b.status)
  end

  if a.body and b.body and #b.body < (#a.body * 0.5) then
    return true, "Content discrepancy observed"
  end

  return false, "Responses matched normally"
end

local function check_deploy_endpoint(host, port)
  local routes = {
    "/ccenter/setup.jsp",
    "/ccenter//deploy.jsp",
    "/ccenter/deploy.jsp%20",
    "/ccenter/%2e/deploy.jsp"
  }

  local headers = {
    ["User-Agent"] = "DiagMonitor/1.0",
    ["Accept"] = "*/*"
  }

  for _, path in ipairs(routes) do
    local r = http.get(host, port, path, {header=headers})
    if r and (r.status == 200 or r.status == 500) then
      return true, string.format("Observed activity at: %s (code: %d)", path, r.status)
    end
  end

  return false, "No unusual behavior observed"
end

action = function(host, port)
  local res = {}

  local waf_like, msg1 = compare_paths(host, port)
  table.insert(res, msg1)

  local deploy_access, msg2 = check_deploy_endpoint(host, port)
  table.insert(res, msg2)

  return table.concat(res, "\n")
end
