-- CRaidUI.lua

local NUM_TEST_RAID_MEMBERS = 25

-- Function to generate dummy data for testing
function GenerateDummyData()
    local dummyData = {}
    for i = 1, NUM_TEST_RAID_MEMBERS do
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
    for i = 1, NUM_TEST_RAID_MEMBERS do
        local raidFrame = _G["CRaidFrame" .. i]
        if not raidFrame then
            raidFrame = CreateFrame("Frame", "CRaidFrame" .. i, CyborgRaidFrame, "RaidFrameTemplate")
            if i == 1 then
                raidFrame:SetPoint("TOPLEFT", CyborgRaidFrame, "TOPLEFT", 10, -10)
            else
                raidFrame:SetPoint("TOPLEFT", _G["CRaidFrame" .. (i - 1)], "BOTTOMLEFT", 0, -5)
            end
        end
        if i <= #dummyData then
            local player = dummyData[i]
            raidFrame:Show()
            raidFrame.name:SetText(player.name)
            raidFrame.health:SetValue(player.health)
            raidFrame.mana:SetValue(player.mana)
            raidFrame.class:SetText(player.class)
        else
            raidFrame:Hide()
        end
    end
end

-- Initialize the raid frames with dummy data for testing
local dummyData = GenerateDummyData()
UpdateRaidFrames(dummyData)
