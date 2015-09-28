-- POOL FILE --
-- huvudhållakollare, håller koll på generationspoolen --

local PoolHandler = {}
lastInnovation = 0         -- vilket innvoationstal som vi är på, om de skapas en ny länk används detta tal --

local function newPool() 
    local pool = {}
    pool.species = {}           -- alla species för denna generation --
    pool.generation = 0         -- vilken generation vi är på för nuvarande --
    pool.currentSpecies = 1     -- nuvarande ras som testas --
    pool.currentGenome = 1      -- nuvarande genom som testas --
    pool.currentFrame = 0       -- vilken frame vi är på i emulationen --
    pool.maxFitness = 0         -- bästa värdet vi nånsin uppnåt -- 

    return pool
end

    -- Lägger massa startgenomer till raser som sedan läggs till i poolen --
local function generateStartPool(species)

    for i=1, POPULATION do
        local newGenome = GenomeHandler.basicGenome()
        SpeciesHandler.addGenomeToSpecies(species, newGenome)
    end

    -- Starta igång hela simulation
end

local function generateInnovationNumber()
    lastInnovation = lastInnovation + 1
    return lastInnovation
end


local function printClass(pool) 
    print("")
    print("--- POOL ---- ")
    print("number of species: " .. #pool.species)
    print("current generation: " .. pool.generation)
    print("current species: " .. pool.currentSpecies)
    print("current genome: " .. pool.currentGenome)
    print("max fitness: " .. pool.maxFitness)
    print("innovation: " .. lastInnovation)
end

PoolHandler.newPool = newPool
PoolHandler.generateStartPool = generateStartPool
PoolHandler.generateInnovationNumber = generateInnovationNumber
PoolHandler.printClass = printClass

return PoolHandler;
