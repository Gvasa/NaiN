local UtilHandler = {}

-- hämta världsinfo INTE VÅR SKIT FÖR TILLFÄLLET!

local function getWorldInputs()
    local positions = UtilHandler.getPositions()
    
    local sprites = UtilHandler.getSprites()                -- hämta positioner för fiendesprites och lägg i array


    local inputs = {}                      -- 
    
    for dy=-BOX_RADIUS*16,BOX_RADIUS*16,16 do        -- loopa från -BOX_RADIUS*16 till BOX_RADIUS*16, med 16hopp
        for dx=-BOX_RADIUS*16,BOX_RADIUS*16,16 do     -- loopa från -boxradius till boxradies*16 med 16steg
            inputs[#inputs+1] = 0                   -- LUA RÄKNAR FRÅN 1!!!!!!! skapa nytt element och sätt de till 0
            
            local tile = UtilHandler.getTile(dx, dy, positions)                    --  kolla om current tile går att interagera med om det är 1 så går det
            if tile == 1 and positions.marioY+dy < 0x1B0 then   -- om tilen är 1 dvs går interagera emd 
                inputs[#inputs] = 1                  -- sätt input till 1
            end
            
            for i = 1,#sprites do
                distx = math.abs(sprites[i]["x"] - (positions.marioX+dx))
                disty = math.abs(sprites[i]["y"] - (positions.marioY+dy))
                if distx <= 8 and disty <= 8 then
                    inputs[#inputs] = -1                        -- sätt input till -1 ifall det ä en fiende
                end
            end
        end
    end
    
    --mariovx = memory.read_s8(0x7B)
    --mariovy = memory.read_s8(0x7D)
    
    return inputs

end

local function getPositions()
    local positions = {}

    positions.marioX = memory.readbyte(0x6D) * 0x100 + memory.readbyte(0x86)
    positions.marioY = memory.readbyte(0x03B8)+16

    --positions.screenX = memory.readbyte(0x03AD)
    --positions.screenY = memory.readbyte(0x03B8)

    return positions
end
-- kan vi interagera med tilen eller ej? 1 för ja 0 för nej
local function getTile(dx, dy, positions)

    local x = positions.marioX + dx + 8                         -- vi får position där mario är 
    local y = positions.marioY + dy - 16                        -- vi position 
    local page = math.floor(x/256)%2

    local subx = math.floor((x%256)/16)
    local suby = math.floor((y - 32)/16)
    local addr = 0x500 + page*13*16+suby*16+subx
    
    if suby >= 13 or suby < 0 then
        return 0
    end
    
    if memory.readbyte(addr) ~= 0 then
        return 1
    else
        return 0
    end

end

local function getSprites()

    local sprites = {}
    for slot=0,4 do
        local enemy = memory.readbyte(0xF+slot)
        if enemy ~= 0 then
            local ex = memory.readbyte(0x6E + slot)*0x100 + memory.readbyte(0x87+slot) -- 
            local ey = memory.readbyte(0xCF + slot)+24
            sprites[#sprites+1] = {["x"]=ex,["y"]=ey}
        end
    end
    
    return sprites

end

UtilHandler.getWorldInputs = getWorldInputs
UtilHandler.getPositions = getPositions
UtilHandler.getTile = getTile
UtilHandler.getSprites = getSprites

return UtilHandler