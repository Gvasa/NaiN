-- MAIN FILE --- 

---------- include files --------------
PoolHandler = require("PoolHandler")
SpeciesHandler = require("SpeciesHandler")
GenomeHandler = require("GenomeHandler")
LinkHandler = require("LinkHandler")
NeuronHandler = require("NeuronHandler")
NetworkHandler = require("NetworkHandler")
---------------------------------------

local genome = GenomeHandler.newGenome()

table.insert(genome.links, LinkHandler.newLink())

GenomeHandler.printClass(genome)