local explorer = {}

local function getServers()
 local servers = {}

 servers[0] = {
   name='Hello World Server',
   address='0.0.0.0',
   port='50051'
 }

 return servers
end

function explorer.grpcExplore()
  print(vim.inspect(getServers()))
  local listCmd = "grpcurl -plaintext localhost:50051 list"
  local serviceListOutput = io.popen(listCmd)
  if serviceListOutput ~= nil then
    for serviceLine in serviceListOutput:lines() do
      print("Service: " .. serviceLine)
      local apiCmd = listCmd .. " " .. serviceLine
      local apiOutput = io.popen(apiCmd)
      if apiOutput ~= nil then
        for apiLine in apiOutput:lines() do
          print("\t" .. apiLine)
        end
      end
    end
  end
end

return explorer
