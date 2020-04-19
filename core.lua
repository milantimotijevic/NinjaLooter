local recipient = "Ghadisha";
local trackedItems = {
    "Zulian Coin",
    "Razzashi Coin",
    "Hakkari Coin",
    "Sandfury Coin",
    "Skullsplitter Coin",
    "Bloodscalp Coin",
    "Gurubashi Coin",
    "Vilebranch Coin",
    "Witherbark Coin",
    "Red Hakkari Bijou",
    "Green Hakkari Bijou",
    "Blue Hakkari Bijou",
    "Purple Hakkari Bijou",
    "Bronze Hakkari Bijou",
    "Silver Hakkari Bijou",
    "Gold Hakkari Bijou",
    "Orange Hakkari Bijou",
    "Yellow Hakkari Bijou"
};

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
    f:SetScript("OnEvent", function()
        local groupType;

        if IsInGroup("LE_PARTY_CATEGORY_HOME") then groupType = "PARTY" end

        if IsInRaid("LE_PARTY_CATEGORY_HOME") then groupType = "RAID" end

        if groupType == nil then return end

        local lootInfo = GetLootInfo();
        
        for lootIndex, lootWrapper in ipairs(lootInfo) do
            if tableIncludes(trackedItems, lootWrapper.item) then
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
        end
    end)

print("<NinjaLooter> Successfully loaded. Recipient set to " .. recipient);

-- Declare slash command
SLASH_NINJALOOTER1 = "/ninjalooter"
-- Declare slash handler
SlashCmdList["NINJALOOTER"] = function(inp)
    recipient = inp;
    print("<NinjaLooter> Recipient set to " .. recipient);
end
