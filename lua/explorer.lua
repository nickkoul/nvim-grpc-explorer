local explorer = {}

local function generateServerUrl(server)
  return server.address .. ":" .. server.port
end

local function getServers()
 local servers = {}

 servers[0] = {
   name='Hello World Server',
   address='0.0.0.0',
   port='50051'
 }

 return servers
end

local function getServices(server)
  local listCmd = "grpcurl -plaintext " .. generateServerUrl(server) .. " list"
  local serviceListOutput = io.popen(listCmd)

  if serviceListOutput == nil then
    return {}
  end

  local services = {}
  for line in serviceListOutput:lines() do
    table.insert(services, line)
  end

  return services
end

local function getApis(server, service)
  local apiCmd = "grpcurl -plaintext " .. generateServerUrl(server) .. " list " .. service
  local apiOutput = io.popen(apiCmd)

  if apiOutput == nil then
    return {}
  end

  local apis = {}
  for line in apiOutput:lines() do
    table.insert(apis, line)
  end

  return apis
end


function explorer.grpcExplore()
  local servers = getServers()
  for _, server in pairs(servers) do
    print(server.name .. " - " .. generateServerUrl(server))
    local services = getServices(server)
    for _, service in pairs(services) do
      print("\t Service: " .. service)
      local apis = getApis(server, service)
      for _, api in pairs(apis) do
        print("\t\t" .. api)
      end
    end
  end
end

return explorer
