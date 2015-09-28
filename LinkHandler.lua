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

-- kopierar en redan existerande link --
local function copyLink(link)
    local newLink = LinkHanlder.newLink()
    newLink.into        = link.into
    newlink.out         = link.out
    newlink.wieght      = link.weight
    newlink.enable      = link.enable
    newLink.innovation  = link.innovation

    return newLink
end

-- returnerar position för en random neuron som finns i genomen.
local function getRandomNeuron(links, mayBeInput)   -- mayBeInput används för att tillåta om den random neuronen man får ut får vara en världs-input node.
    local neurons = {}

    if mayBeInput then                              -- om vi får ta en inputnode sätt alla dessa positioner till true
        for i=1, NUM_OF_INPUTS do                   -- de sätts till true för att vi senare skall kunna plocka en av dessa positioner
            neurons[i] = true
        end
    end

    for i=1, NUM_OF_OUTPUTS do                      -- sätter alla output positioner till true för att de skall kunna plockas senare
        neurons[i+MAX_NODES] = true                 -- sätter i+max_nodes då de är output noder,   |......| |......|  |.......|
    end                                             --                                        start^inputs^ ^hidden^  ^Maxnodes+ = output

    for i=1, #links do 
        if mayBeInput or links[i].into > NUM_OF_INPUTS then     -- alla positioner i hidden layer för into där vi har noder sätts till true
            neurons[links[i].into] = true
        end 
        if mayBeInput or links[i].out > NUM_OF_INPUTS then      -- alla positioner i hidden layer för outo där vi har noder sätts till true
            neurons[links[i].out] = true
        end
    end

    local counter = 0                               -- används för att räkna hur många neuroner vi har aktiva

    for _,_ pairs(neurons) do                       -- loopa igenom alla neuroner, vi slutar med counter = #neuroner
        counter = counter + 1
    end 

    local randomNumber = math.random(1,counter)     -- ta fram ett randomtal mellan 1 och counter

    for position,value pairs(neurons) do            -- loopa igenom neuroner till randomnumber = 0
        randomNumber = randomNumber - 1             -- retunera den position´som neruonen finns på.
        if randomNumber == 0 then
            return position
        end
    end
end

-- ta en randomlänk ur samling och skapa två länkar utav denna med olika vikter.
local function nodeMutate(genome)

    if #genome.links == 0   -- kolla att vi har länkar
        return
    end

    genome.maxNeuron = genome.maxNeuron + 1                            -- inkrementerar maxneuroner med 1

    local randomLink = genome.links[math.random(1, #genome.links)]      -- plocka en randomlänk ur de´länkar vi har
    
    if randomLink.enable == false then                                  -- kolla att länken i fråga är aktiv
        return                                                          -- om ej aktiv returnera
    end

    randomLink.enable = false                                           -- sätt randomlänk till inaktiv

    local newLink1 = LinkHandler.copyLink(randomLink)                   -- kopiera över länken till två nya länkar
    local newLink2 = LinkHandler.copyLink(randomLink)

    newLink1.out            = genome.maxNeuron                          -- sätter länk1 utneuron till maxneuroner
    newLink1.wieght         = 1                                         -- länk1 vikt sätts till 1
    newLink1.innovation     = PoolHandler.generateInnovationNumber()    -- generera ett innovationsnummer för vår nya länk
    newLink1.enable         = true                                      -- sätt den till aktiv

    newLink2.into           = genome.maxNeuron                          -- sätt länk2 into till maxneuroner (nu är länk1 och länk2 kopplade)
    newLink2.innovation     = PoolHandler.generateInnovationNumber()    -- generera ett nytt innovationsnummer för vår nya länk
    newLink2.enable         = true                                      -- sätt den till aktiv

    table.insert(genome.links, newLink1)                                -- lägg in våra nyskapade länkar till vår linktable
    table.insert(genome.links, newLink2)

end

-- jämför två länkar och kolla om de är lika -- 
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