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

-- Ska lägga till en genom till en ras
local function addGenomeToSpecies(species, genomeToAdd)
    local foundSpecies = false                          -- En boolean som kollar om vi lagt till den till en ras eller ej

    -- Loopa igenom alla raser för att finna om den nya genomen passar till någon
    for i=1, #species do

        local spiecesGenome = species[i].genomes[1] -- Hämtar hem första genomen i rasen, för jämnförelse

        -- Om vi inte har hittat en ras och om genomen passar till denna rasen så lägg till den
        if(foundSpecies == false and GenomeHandler.compareGenomeSameSpecies(speciesGenome, genomeToAdd) == true then
            table.insert(species[i].genomes, genomeToAdd)
            foundSpecies = true;
        end
    end

    -- Om genomen inte passade till någon ras, skapa ny ras och lägga till genomen.
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