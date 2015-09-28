-- POOL FILE --
local PoolHandler = {}

local function newPool() 
    local pool = {}
    pool.species = {}
    pool.generation = 0
    pool.innovation = 0
    pool.currentSpecies = 1
    pool.currentGenome = 1
    pool.currentFrame = 0
    pool.maxFitness = 0

    return pool
end

local function printClass() 
    print("Pool & ")
    --SpeciesHandler.printClass()
end

PoolHandler.newPool = newPool
PoolHandler.printClass = printClass

return PoolHandler;
