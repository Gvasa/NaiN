-- genome file --
-- en genome är ett helt nätverk med neuroner, länkar och nätverkshanterare --

local GenomeHandler = {}

local function newGenome()
    local genome = {}
    
    genome.links = {}           -- alla länkar mellan neuronerna
    genome.fitness = 0          -- värde på hur bra genomen är
    genome.adjustedFitness = 0  -- värde efter 
    genome.network = {}         -- nätverkHanterare för alla kopplingar mellan neuroner
    genome.maxNeuron = 0        -- max antal neuroner
    genome.globalRank = 0       -- en global rank över alla genomer för en generation

    return genome
end

local function printClass(genome) 
    print("Number of Genes: " .. #genome)
end


-- bind functions
GenomeHandler.newGenome = newGenome
GenomeHandler.printClass = printClass

return GenomeHandler