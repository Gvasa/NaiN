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

local function basicGenome()      
    local genome = newGenome()
    local innovation = 1

    genome.maxNeuron = NUM_OF_INPUTS

    mutateGenome(genome)

    return genome

end

local function compareGenomeSameSpecies(genome1, genome2)
    local deltaDisjointLinks = DELTA_DISJOINT*findDisjoints(genome1, genome2)
    local deltaWeight = DELTA_WEIGHTS*weightDifference(genome1, genome2)

    return deltaDisjointLinks + deltaWeight < DELTA_THRESHOLD
end

local function findDisjoints(genome1, genome2)
    local links1 = {}
    local links2 = {}
    local disjoints = 0

    for i=1, #genome1.links do
        links1[genome1.links[i].innovation] = true
    end

    for i=1, #genome2.links do
        links2[genome2.links[i].innovation] = true
    end

    for i=1, #genome1.links do
        if links2[genome1.links[i].innovation] ~= true then
            disjoints = disjoints + 1
        end 
    end

    for i=1, #genome2.links do
        if link1[genome2.links[i].innovation] ~= true then
            disjoints = disjoints + 1
        end
    end

    return disjoints / max(#genome1.links, #genome2.links) 
end

local function weightDifference(genome1, genome2)
    local links2 = {}
    local weightDifference = 0.0
    local counter = 0

    for i=1, #genome2.links do
        links2[genom2.links[i].innovation] = genome2.link[i]
    end

    for i=1, #genome1.links do
        local link1 = genome1.links[i]

        if links2[link1.innovation] ~= nil then
            weightDifference = weightDifference + math.abs(link1.weight - links2[link1.innovation].weight)
            counter = counter + 1 
        end
    end

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