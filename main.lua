-- MAIN FILE --- 

---------- include files --------------
PoolHandler = require("PoolHandler")
SpeciesHandler = require("SpeciesHandler")
GenomeHandler = require("GenomeHandler")
LinkHandler = require("LinkHandler")
NeuronHandler = require("NeuronHandler")
NetworkHandler = require("NetworkHandler")
ConstantValues = require("ConstantValues")
---------------------------------------

local pool = PoolHandler.newPool()

PoolHandler.generateStartPool(pool);
PoolHandler.printClass(pool);

