-- neuron file --
local NeuronHandler = {}

local function newNeuron()
    local neuron = {}
    neuron.incommingGenes = {}
    neuron.value = 0
end

local function printClass(neuron)
    if(neuron.value ~= nil) then
        print("Neuron - Value: " ..  neuron.value)
    end
end

NeuronHandler.newNeuron = newNeuron
NeuronHandler.printClass = printClass

return NeuronHandler