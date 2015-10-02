-- MAIN FILE --- 

---------- include files --------------
PoolHandler 	= require("PoolHandler")
SpeciesHandler 	= require("SpeciesHandler")
GenomeHandler 	= require("GenomeHandler")
LinkHandler 	= require("LinkHandler")
NeuronHandler 	= require("NeuronHandler")
NetworkHandler 	= require("NetworkHandler")
UtilHandler		= require("UtilHandler")
ConstantValues 	= require("ConstantValues")
---------------------------------------
local main = {}								-- För att kunna skriva funktioner där vi vill ha dom
local outputs 	= {}
local lastPosition = 0
local rightMost = 0
local timeout 	= 0
---------------------------------------




------------ Funktioner ---------------

-- Sätter startvärden är simulationen
local function startRun(pool)
	rightMost 			= 0
	pool.currentFrame 	= 0
	timeout 			= 0

	main.clearController()																	-- Clear controller
	local currentGenome = pool.species[pool.currentSpecies].genomes[pool.currentGenome] 	-- Hämta nuvarande genome
	GenomeHandler.generateNetwork(currentGenome)			
	main.setControllerInput(currentGenome)
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

local function setControllerInput(genome)

	--local currentGenome = pool.species[pool.currentSpecies].genomes[pool.currentGenome]
	local outputs = evaluateNetworkForOutput(genome.network)
		
	if outputs["P1 Up"] and outputs["P1 Down"] then
		outputs["P1 Up"] = false
		outputs["P1 Down"] = false
	end

	if outputs["P1 Right"] and outputs["P1 Left"] then
		outputs["P1 Right"] = false
		outputs["P1 Left"] = false
	end

	joypad.set(outputs) 								-- set the joypads(simulated controller) ´with the output values.
	return outputs
end

local function findNextGenome(pool)

end

main.startRun = startRun
main.clearController = clearController
main.setControllerInput = setControllerInput
main.findNextGenome = findNextGenome

--------------------PROGRAM ----------------------------

-- Skapa en ny genpool
local pool = PoolHandler.newPool()


--inputs = UtilHandler.getWorldInputs()

-- Generera populationen med arter --
PoolHandler.generateStartPool(pool.species);
main.startRun(pool)
main.setControllerInput(pool.species[pool.currentSpecies].genomes[pool.currentGenome])

PoolHandler.printClass(pool)

while true do
	-- måla gui
	-- 
	local currentGenome = pool.species[pool.currentSpecies].genomes[pool.currentGenome]		-- gets the current genome

	if pool.currentFrame % 5 then
		outputs = main.setControllerInput(currentGenome) 									-- calculate new output values every 5th frame			
	end

	joypad.set(outputs)																		-- even if we dont calculate new values, set the joypad to the previous calculated outputs

	local marioPositions = UtilHandler.getPositions()

	if lastPosition ~= marioPositions.marioX then											-- check if mario is standing still or not
		timeout = TIMEOUT_CONSTANT 															-- if he moves reset the timeout timer
	end

	if marioPositions.marioX > rightMost then 												-- if mario is further to the right than before then update rightmost
		rightMost = marioPositions.marioX
	end

	timeout = timeout - 1 																	-- tick down the timeout timer
 	
	if timeout <= 0 then 																	-- if mario has been standing still for to long
		local fitness = rightMost + pool.currentFrame / 3.0 								-- calculate the fitnesss
		if rightMost > 3186 then  															-- if mario finish the level give him a fuckingMILLION FITNESS POINTS
			fitness = fitness + 1000000
		end

		if fitness == 0 then 																-- if fitness zero set it to -1 
			fitness = -1
		end																						-- should remove this 

		currentGenome.fitness = fitness 													-- set the genomes fitness to the current fitness

		if fitness > pool.maxFitness then 													-- update the pools maxfitness if needed
			pool.maxFitness = fitness 												
		end


		main.findNextGenome() 																-- search for the next genome to simulate, will change the current species and current genome of the pool.

		startRun() 																			-- start a run with the next genome

	end



end



