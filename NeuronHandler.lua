-- neuron file --
-- en nod i genomen (hjärnan) -- 
local NeuronHandler = {}

local function newNeuron()
    local neuron = {}
    neuron.incommingGenes = {}      -- alla inkommande länkar från andra noder -- 
    neuron.value = 0                -- värdet på denna nod --
end

local function printClass(neuron)
    if(neuron.value ~= nil) then
        print("Neuron - Value: " ..  neuron.value)
    end
end

-- binda functioner --
NeuronHandler.newNeuron = newNeuron
NeuronHandler.printClass = printClass

return NeuronHandler