-- RaidUI.lua

-- Function to generate dummy data for testing
function GenerateDummyData()
    local dummyData = {}
    for i = 1, 25 do
        table.insert(dummyData, {
            name = "Player" .. i,
            health = math.random(1, 100),
            mana = math.random(1, 100),
            class = "Warrior"
        })
    end
    return dummyData
end

-- Function to handle dummy data and update the raid frames
function UpdateRaidFrames(dummyData)
    for i, player in ipairs(dummyData) do
        -- Update the raid frame for each player with the dummy data
        local raidFrame = _G["RaidFrame" .. i]
        if raidFrame then
            raidFrame.name:SetText(player.name)
            raidFrame.health:SetValue(player.health)
            raidFrame.mana:SetValue(player.mana)
            raidFrame.class:SetText(player.class)
        end
    end
end

-- Initialize the raid frames with dummy data for testing
local dummyData = GenerateDummyData()
UpdateRaidFrames(dummyData)
