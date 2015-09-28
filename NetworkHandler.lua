-- network file --
local NetworkHandler = {}

local function newNetwork()
    local network = {}
   
    network.neurons = {}
   
    return network
end

local function printClass(network) 
    print("            ---- Network ----")
    print("            Number of neurons: " .. #network.neurons)
end

NetworkHandler.printClass = printClass

return NetworkHandler;