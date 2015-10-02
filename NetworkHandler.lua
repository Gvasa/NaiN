-- network file --
local NetworkHandler = {}

local function newNetwork()
    local network = {}
   
    network.neurons = {}
   
    return network
end

local function evaluateNetworkForOutput(network)
    --local inputs = UtilHandler.getWorldInputs()                                 -- get all the world inputs
    local inputs = {}

    for i=1, 169 do
        if  math.random() > 0.5 then 
            inputs[i] = 1
        else
            inputs[i] = 0
        end
    end

    table.insert(inputs, 1)                                                        -- add 1 to get 170

    if #inputs ~= NUM_OF_INPUTS then                                            -- check if the given input is as expected
        return
    end

    for i=1, NUM_OF_INPUTS do                                                   -- set the values of all the input nodes in the network
        network.neurons[i].value = inputs[i]
    end
 
    for i=1, #network.neurons do                                                -- here we calculate the value for all the hidden nodes + output nodes
        local currentNeuron = network.neurons[i]
        local sum

        for j=1, #currentNeuron.incommingLinks do                               -- for all the links given a neuron 
            local incLink = currentNeuron.incommingLinks[j]                             

            sum = sum + network.neurons[incLink.into].value*incLink.weight      -- calculated a sumation of all the incoming neurons value weighted with the link weight
        end

        if #currentNeuron.incommingLinks > 0 then                               -- check so we dont send a input node through the sigmoidfunction
            currentNeuron.value = NetworkHandler.sigmoidFunction(sum)           -- send it to the sigmoidfunction
        end

    end
    
    local outputs = {}                                                             -- set if the outputs should be pressed or not
    for i=1, NUM_OF_OUTPUTS do
        local button = "P1 " .. BUTTON_NAMES[i]
        if network.neurons[i+MAX_NODES].value > 0   then                                   -- the sigmoid function returns a value between -0.5 to 0.5
            outputs[button] = true;                                             -- if the value is > 0 = press the button
        else
            outputs[button] = false;
        end
    end

    return outputs                                                               -- return the outputs

end

local function sigmoidFunction(sum) 
    return (2.0 / (1.0 + math.exp(-4.9*sum))) -1   -- detta ger ett intervall från -0.5 till 0.5 där x=0 => y = 0
end

local function printClass(network) 
    print("            ---- Network ----")
    print("            Number of neurons: " .. #network.neurons)
end

NetworkHandler.newNetwork = newNetwork
NetworkHandler.evaluateNetworkForOutput = evaluateNetworkForOutput
NetworkHandler.sigmoidFunction = sigmoidFunction
NetworkHandler.printClass = printClass

return NetworkHandler;