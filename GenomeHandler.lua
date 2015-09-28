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

local function printClass(genome) 
    print("        ---- Genome ---- ")
    print("        Number of links: " .. #genome.links)
    print("        Fitness: " .. genome.fitness)
    print("        Global Rank: " .. #genome.globalRank)
    print("        Max neurons: " .. #genome.neuron)
    print("        Network: " .. "exists")
end


-- bind functions
GenomeHandler.newGenome = newGenome
GenomeHandler.printClass = printClass

return GenomeHandler