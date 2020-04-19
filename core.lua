local recipient = "Ghadisha";
local trackedItems = {"Battlesmasher of the Monkey"};

local function tableIncludes (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

-- Declare frame
local f = CreateFrame("Frame");

f:RegisterEvent("LOOT_OPENED");
    f:SetScript("OnEvent", function(self, event, msg, author, language, lineId, senderGUID)
        local groupType;

        if IsInGroup("LE_PARTY_CATEGORY_HOME") then groupType = "PARTY" end

        if IsInRaid("LE_PARTY_CATEGORY_HOME") then groupType = "RAID" end

        if groupType == nil then return end

        local lootInfo = GetLootInfo();
        
        for lootIndex, lootWrapper in ipairs(lootInfo) do

            for raidIndex=1, 40 do 
                local candidate = GetMasterLootCandidate(lootIndex, raidIndex);
                
                if candidate then
                    if candidate == recipient then
                        SendChatMessage("<NinjaLooter> Automatically assigning " .. lootWrapper.item .. " to " .. candidate, groupType);
                        GiveMasterLoot(lootIndex, raidIndex);
                    end
                end
            end
        end
    end)

print("<NinjaLooter> Successfully loaded. Recipient set to " .. recipient);
