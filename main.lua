-- MAIN FILE --- 

---------- include files --------------
PoolHandler 	= require("PoolHandler")
SpeciesHandler 	= require("SpeciesHandler")
GenomeHandler 	= require("GenomeHandler")
LinkHandler 	= require("LinkHandler")
NeuronHandler 	= require("NeuronHandler")
NetworkHandler 	= require("NetworkHandler")
ConstantValues 	= require("ConstantValues")
---------------------------------------
local main = {}								-- För att kunna skriva funktioner där vi vill ha dom
local rightMost = 0
local timeout 	= 0
local joypad 	= {}
---------------------------------------




------------ Funktioner ---------------

-- Sätter startvärden är simulationen
local function startRun(pool)
	rightMost 			= 0
	pool.currentFrame 	= 0
	timeout 			= 0

	main.clearController()																	-- Clear controller
	local currentGenome = pool.species[pool.currentSpecies].genomes[pool.currentGenome] 	-- Hämta nuvarande genome
	GenomeHandler.GenerateNetwork(currentGenome)											-- Genererar ett nytt nätverk
end

-- Sätter kontrollern så vi inte klickar på någon knapp
local function clearController()
	local emptyController = {} 								-- Skapar en tom controller
	for i=1, NUM_OF_OUTPUTS do 								-- Loopa igenom alla knappar
		emptyController["P1 " .. BUTTON_NAMES[i]] = false 	-- Sätter knapparna till false(Att vi inte klickar på dom)
	end

	--joypad.set(emptyController) 							-- Sätter vår joypad
	joypad = emptyController

end

main.startRun = startRun
main.clearController = clearController

-- Skapa en ny genpool
local pool = PoolHandler.newPool()

-- Generera populationen med arter --
PoolHandler.generateStartPool(pool.species);
main.startRun(pool)

PoolHandler.printClass(pool);

