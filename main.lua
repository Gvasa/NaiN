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
	
	savestate.load(SAVE_STATE)
	rightMost 			= 0
	pool.currentFrame 	= 0
	lastPosition 		= 0
	timeout 			= TIMEOUT_CONSTANT

	main.clearController()		
																-- Clear controller
	local currentSpecies = pool.species[pool.currentSpecies]
	local currentGenome = currentSpecies.genomes[pool.currentGenome] 	-- Hämta nuvarande genome
	GenomeHandler.generateNetwork(currentGenome)	
	main.setControllerInput(currentGenome)
end

-- Sätter kontrollern så vi inte klickar på någon knapp
local function clearController()
	outputs = {}							-- Skapar en tom controller
	for i=1, NUM_OF_OUTPUTS do 								-- Loopa igenom alla knappar
		outputs["P1 " .. BUTTON_NAMES[i]] = false 	-- Sätter knapparna till false(Att vi inte klickar på dom)
	end

	joypad.set(outputs) 							-- Sätter vår joypad
	--joypad = emptyController
end

local function setControllerInput(genome)

	--local currentGenome = pool.species[pool.currentSpecies].genomes[pool.currentGenome]
	outputs = NetworkHandler.evaluateNetworkForOutput(genome.network)

	if outputs["P1 Up"] and outputs["P1 Down"] then
		outputs["P1 Up"] = false
		outputs["P1 Down"] = false
	end

	if outputs["P1 Right"] and outputs["P1 Left"] then
		outputs["P1 Right"] = false
		outputs["P1 Left"] = false
	end

	joypad.set(outputs) 								-- set the joypads(simulated controller) ´with the output values.
	--joypad = outputs

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
print("Före while, har initiliazat en start pool")
--PoolHandler.printClass(pool)

while true do
--for k = 1, 10 do
	-- måla gui
	-- 
	--print(k)
	local currentGenome = pool.species[pool.currentSpecies].genomes[pool.currentGenome]		-- gets the current genome

	if pool.currentFrame % 5 then
		main.setControllerInput(currentGenome) 									-- calculate new output values every 5th frame			
		--print(string.format("Outputs -  A: %t, B: %t, Up: %t, Down: %t, Left: %t, Right: %t",	outputs["A"], outputs["B"], outputs["Up"], outputs["Down"], outputs["Left"], outputs["Right"]))
	end

	joypad.set(outputs)																		-- even if we dont calculate new values, set the joypad to the previous calculated outputs
	--joypad = outputs
	local marioPositions = UtilHandler.getPositions()

	if lastPosition ~= marioPositions.marioX then											-- check if mario is standing still or not
																	-- if he moves reset the timeout timer
		lastPosition = marioPositions.marioX
	end

	if marioPositions.marioX > rightMost then 	
		timeout = TIMEOUT_CONSTANT 											-- if mario is further to the right than before then update rightmost
		rightMost = marioPositions.marioX
	end

	timeout = timeout - 1 																	-- tick down the timeout timer
 	
	if timeout <= 0 then 	

																							-- if mario has been standing still for to long
		local fitness = math.floor(rightMost + pool.currentFrame / 4.0) 								-- calculate the fitnesss
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
		print("Gen: " ..  pool.generation .. " - Species - " .. pool.currentSpecies .. " - Genome: " .. pool.currentGenome .. " - fitness: " .. currentGenome.fitness .. " - maxF: " .. pool.maxFitness)
	
		PoolHandler.findNextGenome(pool) 																-- search for the next genome to simulate, will change the current species and current genome of the pool.
		--PoolHandler.printClass(pool)
		
		main.startRun(pool) 																			-- start a run with the next genome
		
	end

	pool.currentFrame = pool.currentFrame + 1
	emu.frameadvance();
end



