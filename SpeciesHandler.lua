-- species file -- 
-- en specifik ras, har hand om genomer som tillhör samma ras --
local SpeciesHandler = {}

local function newSpecies()
    local species = {}
    
    species.topFitness = 0          -- bästa fitness för denna ras --
    species.staleness = 0           -- ett värde på om rasen inte har förbättrats från tidigare generationer 0 = bra--
    species.genomes = {}             -- alla genomer för denna ras, alla olika sorts "hjärnor" i rasen --
    species.averageFitness = 0      -- average fitness för rasen --

    return species
end


local function printClass(species) 
    print("    ---- Species ---- ")
    print("    number of genomes: " .. #species.genomes)
    print("    top fitness: " .. species.topFitness)
    print("    average fitness: " .. species.averageFitness)
    print("    staleness: " .. species.staleness)
   -- GenomeHandler.printClass(genome)
end

-- binda functioner
SpeciesHandler.newSpecies = newSpecies
SpeciesHandler.printClass = printClass

return SpeciesHandler