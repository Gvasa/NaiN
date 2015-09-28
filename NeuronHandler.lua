-- neuron file --
-- en nod i genomen (hjärnan) -- 
local NeuronHandler = {}

local function newNeuron()
    local neuron = {}
    neuron.incommingLinks = {}      -- alla inkommande länkar från andra noder -- 
    neuron.value = 0                -- värdet på denna nod --
end

local function printClass(neuron)
    print("                ---- Neuron ----")
    print("                Number of incomming links: " ..  #neuron.incommingLinks)
    print("                Value of neuron: " .. neuron.value)
end

-- binda functioner --
NeuronHandler.newNeuron = newNeuron
NeuronHandler.printClass = printClass

return NeuronHandler