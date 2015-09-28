-- genome file --
-- en genome är ett helt nätverk med neuroner, länkar och nätverkshanterare --

local GenomeHandler = {}

local function newGenome()
    local genome = {}
    
    genome.links = {}           -- alla länkar mellan neuronerna
    genome.fitness = 0          -- värde på hur bra genomen är 
    genome.network = {}         -- nätverkHanterare för alla kopplingar mellan neuroner
    genome.maxNeuron = 0        -- max antal neuroner
    genome.globalRank = 0       -- en global rank över alla genomer för en generation

    return genome
end

-- Skapar en basic ganom och muterar den. Anropas bara när vi skapar den nya poolen.
local function basicGenome()      
    local genome = newGenome()
    local innovation = 1

    genome.maxNeuron = NUM_OF_INPUTS

    mutateGenome(genome) -- Muterar vår genome; ändrar länkar, vikter, om den är aktiv ..

    return genome

end

-- Kollar om genom1 och genom2 kan klassas som samma ras
local function compareGenomeSameSpecies(genome1, genome2)
    local deltaDisjointLinks = DELTA_DISJOINT*GenomeHandler.findDisjoints(genome1, genome2)
    local deltaWeight = DELTA_WEIGHTS*GenomeHandler.weightDifference(genome1, genome2)

    return deltaDisjointLinks + deltaWeight < DELTA_THRESHOLD
end

-- Hittar disjoints mellan de olika genomernas länkar
local function findDisjoints(genome1, genome2)
    local links1 = {}           -- Länkarna för genome1
    local links2 = {}           -- Länkarna för genome2
    local disjoints = 0         -- Antalet disjoints

    -- Loppa igenom genomes 1 länkar och sätter att det finns en länk med indexet - innovationsnumret
    for i=1, #genome1.links do
        links1[genome1.links[i].innovation] = true
    end

    -- Loppa igenom genomes 2 länkar och sätter att det finns en länk med indexet - innovationsnumret
    for i=1, #genome2.links do
        links2[genome2.links[i].innovation] = true
    end

    -- Loopa igenom genomes1 länkar och kollar om det finns en med samma innovationsnummer bland genomes 2 länkar, om inte inkrementera disjoints
    for i=1, #genome1.links do
        if links2[genome1.links[i].innovation] ~= true then
            disjoints = disjoints + 1
        end 
    end

    -- Loopa igenom genomes1 länkar och kollar om det finns en med samma innovationsnummer bland genomes 2 länkar, om inte inkrementera disjoints
    for i=1, #genome2.links do
        if link1[genome2.links[i].innovation] ~= true then
            disjoints = disjoints + 1
        end
    end

    -- Retunera en procentuell likhet bland genomernas länkar.
    return disjoints / math.max(#genome1.links, #genome2.links) 
end

-- Jämnför genome1 och genome2s länkars vikter
local function weightDifference(genome1, genome2)
    local links2 = {}
    local weightDifference = 0.0
    local counter = 0

    -- Loopa igenom genomes2s länkar och kopiera in länken med index innovation
    for i=1, #genome2.links do
        links2[genom2.links[i].innovation] = genome2.link[i]
    end

    -- Loopa igenom genome1:s länkar och kolla om samma innovationstal finns bland genomes2:s länkar
    for i=1, #genome1.links do
        local link1 = genome1.links[i]

        -- Om det finns motsvarande så ta ut skillanden i vikter och addera weightDifference samt inkremetera countern
        if links2[link1.innovation] ~= nil then 
            weightDifference = weightDifference + math.abs(link1.weight - links2[link1.innovation].weight)
            counter = counter + 1 
        end
    end

    -- Skicka tillbaka någonslags skillnad mellan viktskillanden och antal fall så det finns samma innovationstal.
    return weightDifference / counter

end


local function printClass(genome) 
    print("        ---- Genome ---- ")
    print("        Number of links: " .. #genome.links)
    print("        Fitness: " .. genome.fitness)
    print("        Global Rank: " .. genome.globalRank)
    print("        Max neurons: " .. genome.maxNeuron)
    print("        Network: " .. "exists")
end


-- bind functions
GenomeHandler.newGenome = newGenome
GenomeHandler.basicGenome = basicGenome
GenomeHandler.compareGenomeSameSpecies = compareGenomeSameSpecies
GenomeHandler.findDisjoints = findDisjoints
GenomeHandler.weightDifference = weightDifference
GenomeHandler.printClass = printClass

return GenomeHandler