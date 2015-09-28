-- POOL FILE --
-- huvudhållakollare, håller koll på generationspoolen --

local PoolHandler = {}

local function newPool() 
    local pool = {}
    pool.species = {}           -- alla species för denna generation --
    pool.generation = 0         -- vilken generation vi är på för nuvarande --
    pool.innovation = 0         -- vilket innvoationstal som vi är på, om de skapas en ny länk används detta tal --
    pool.currentSpecies = 1     -- nuvarande ras som testas --
    pool.currentGenome = 1      -- nuvarande genom som testas --
    pool.currentFrame = 0       -- vilken frame vi är på i emulationen --
    pool.maxFitness = 0         -- bästa värdet vi nånsin uppnåt -- 

    return pool
end

local function printClass() 
    print("Pool & ")
    --SpeciesHandler.printClass()
end

PoolHandler.newPool = newPool
PoolHandler.printClass = printClass

return PoolHandler;
