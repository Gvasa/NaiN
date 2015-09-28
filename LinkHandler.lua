-- link file --
-- 
local LinkHandler = {}


local function newLink()
    local link = {}
    
    link.into = 0
    link.out = 0
    link.weight = 0.0
    link.enabled = true
    link.innovation = 0

    return link
end

local function printClass(link) 
    if link.into ~= nil then
        print("into: " .. link.into .. " out: " .. link.out)
    end
end

LinkHandler.newLink = newLink
LinkHandler.printClass = printClass

return LinkHandler