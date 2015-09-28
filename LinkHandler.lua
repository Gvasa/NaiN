-- link file --
-- detta är koppling mellan neuronerna --
local LinkHandler = {}


local function newLink()
    local link = {}
    
    link.into = 0           -- till vilken neuron ska den in i --
    link.out = 0            -- från vilken neuron den kommer ifrån --
    link.weight = 0.0       -- vikten för out-värdet --
    link.enabled = true     -- om länken skall va aktiverad eller ej --
    link.innovation = 0     -- unikt generationtal, specifik för varje länk, en länk har samma generationstal i flera generationer -- 
                            -- får bara nytt generationstal ifall en helt ny länk skapas --
    return link
end

local function copyLink(link)
    local newLink = LinkHanlder.newLink()
    newLink.into        = link.into
    newlink.out         = link.out
    newlink.wieght      = link.weight
    newlink.enable      = link.enable
    newLink.innovation  = link.innovation

    return newLink
end

local function getRandomNeuron(links, mayBeInput)
    local neurons = {}

    if mayBeInput then
        for i=1, NUM_OF_INPUTS do
            neurons[i] = true
        end
    end

    for i=1, NUM_OF_OUTPUTS do
        neurons[i+MAX_NODES] = true
    end

    for i=1, #links do 
        if mayBeInput or links[i].into > NUM_OF_INPUTS then
            neurons[links[i].into] = true
        end 
        if mayBeInput or links[i].out > NUM_OF_INPUTS then
            neurons[links[i].out] = true
        end
    end

    local counter = 0

    for _,_ pairs(neurons) do 
        counter = counter + 1
    end 

    local randomNumber = math.random(1,counter)

    for position,value pairs(neurons) do
        randomNumber = randomNumber - 1
        if randomNumber == 0 then
            return position
        end
    end
end

local function nodeMutate(genome)

    if #genome.links == 0
        return
    end

    genome.maxNeuron = genome.maxNeuron + 1

    local randomLink = genome.links[math.random(1, #genome.links)]
    
    if randomLink.enable == false then                                  -- Testa sen du vet
        return
    end

    randomLink.enable = false

    local newLink1 = LinkHandler.copyLink(randomLink)
    local newLink2 = LinkHandler.copyLink(randomLink)

    newLink1.out            = genome.maxNeuron
    newLink1.wieght         = 1
    newLink1.innovation     = PoolHandler.generateInnovationNumber()
    newLink1.enable         = true

    newLink2.into           = genome.maxNeuron
    newLink2.innovation     = PoolHandler.generateInnovationNumber()
    newLink2.enable         = true

    table.insert(genome.links, newLink1)
    table.insert(genome.links, newLink2)

end

local function linkAllreadyExists(links, newLink) 
    for i=1, #genome.links 
        if links[i].into == newLink.into and links[i].out == newLink.out then
            return true
        end
    end
    return false
end

local function printClass(link) 
    print("            ---- Link ----")
    print("            Into: " .. link.into)
    print("            Out: " .. link.out)
    print("            Weight: " .. link.weight)
    print("            Innovation number: " .. link.innovation)
    print("            Enabled: " .. link.enalbed)
end

-- binda functioner
LinkHandler.newLink = newLink
LinkHandler.copyLink = copyLink
LinkHandler.getRandomNeuron = getRandomNeuron
LinkHandler.linkAllreadyExists =  linkAllreadyExists
LinkHandler.nodeMutate = nodeMutate
LinkHandler.printClass = printClass

return LinkHandler