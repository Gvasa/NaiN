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

local function addGenomeToSpecies(species, genomeToAdd)
    local foundSpecies = false

    for i=1, #species do
        local spiecesGenome = species[i].genomes[1] 
        if(foundSpecies == false and GenomeHandler.compareGenomeSameSpecies(speciesGenome, genomeToAdd) == true then
            table.insert(species[i].genomes, genomeToAdd)
            foundSpecies = true;
        end
    end

    if foundSpecies == false then
        local newSpecies = SpeciesHandler.newSpecies;
        table.insert(newSpecies.genomes, genomeToAdd)
        table.insert(species, newSpecies)
    end

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
SpeciesHandler.addGenomeToSpecies = addGenomeToSpecies
SpeciesHandler.printClass = printClass

return SpeciesHandler