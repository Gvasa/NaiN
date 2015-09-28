-- link file --
-- detta är koppling mellan neuronerna --
local LinkHandler = {}


local function newLink()
    local link = {}
    
    link.into = 0           -- till vilken neuron ska den in i --
    link.out = 0            -- från vilken neuron den kommer ifrån --
    link.weight = 0.0       -- vikten för out-värdet --
    link.enabled = true     -- om länken skall va aktiverad eller ej --
    link.innovation = 0     -- unikt generationtal, specifik för varje länk, en länk har samma generationstal i flera generationer -- 
                            -- får bara nytt generationstal ifall en helt ny länk skapas --
    return link
end

local function printClass(link) 
    print("            ---- Link ----")
    print("            Into: " .. link.into)
    print("            Out: " .. link.out)
    print("            Weight: " .. link.weight)
    print("            Innovation number: " .. link.innovation)
    print("            Enabled: " .. link.enalbed)
end

-- binda functioner
LinkHandler.newLink = newLink
LinkHandler.printClass = printClass

return LinkHandler