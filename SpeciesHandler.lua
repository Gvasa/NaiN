-- species file -- 
local SpeciesHandler = {}

local function newSpecies()
    local species = {}
    
    species.topFitness = 0
    species.staleness = 0
    species.genome = {}
    species.averageFitness = 0

    return species
end


local function printClass() 
    print("Species & ")  
   -- GenomeHandler.printClass(genome)
end

SpeciesHandler.newSpecies = newSpecies
SpeciesHandler.printClass = printClass

return SpeciesHandler