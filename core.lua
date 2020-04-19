local recipient = "Oglock";
local trackedItems = {"Battlesmasher of the Monkey"};

local function tableIncludes (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- Util methods
local splitStr = function (inputstr, sep)
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

-- Declare frame
local f = CreateFrame("Frame");

f:RegisterEvent("LOOT_OPENED");
    f:SetScript("OnEvent", function(self, event, msg, author, language, lineId, senderGUID)
        local lootInfo = GetLootInfo();
        
        for lootIndex, lootWrapper in ipairs(lootInfo) do

            for raidIndex=1, 40 do 
                local candidate = GetMasterLootCandidate(lootIndex, raidIndex);
                
                if candidate then
                    if candidate == recipient then
                        SendChatMessage("<NinjaLooter> Automatically assigning " .. lootWrapper.item .. " to " .. candidate);
                    end
                end
            end
        end
    end)


