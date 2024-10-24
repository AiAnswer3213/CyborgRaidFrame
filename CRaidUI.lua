-- CRaidUI.lua

local NUM_TEST_RAID_MEMBERS = 10

-- Function to generate dummy data for testing
function GenerateDummyData()
    local dummyData = {}
    for i = 1, NUM_TEST_RAID_MEMBERS do
        table.insert(dummyData, {
            name = "Player" .. i,
            health = math.random(1, 100),
            mana = math.random(1, 100),
            class = "Warrior",
            debuffs = {
                {name = "Debuff1", icon = "Interface\\Icons\\Spell_Nature_Polymorph"},
                {name = "Debuff2", icon = "Interface\\Icons\\Spell_Nature_Polymorph"},
                {name = "Debuff3", icon = "Interface\\Icons\\Spell_Nature_Polymorph"},
                {name = "Debuff4", icon = "Interface\\Icons\\Spell_Nature_Polymorph"}
            }
        })
    end
    return dummyData
end

-- Function to get class color
function GetClassColor(class)
    local classColors = {
        ["Warrior"] = {r = 0.78, g = 0.61, b = 0.43},
        ["Mage"] = {r = 0.41, g = 0.8, b = 0.94},
        ["Rogue"] = {r = 1.0, g = 0.96, b = 0.41},
        ["Druid"] = {r = 1.0, g = 0.49, b = 0.04},
        ["Hunter"] = {r = 0.67, g = 0.83, b = 0.45},
        ["Shaman"] = {r = 0.0, g = 0.44, b = 0.87},
        ["Priest"] = {r = 1.0, g = 1.0, b = 1.0},
        ["Warlock"] = {r = 0.58, g = 0.51, b = 0.79},
        ["Paladin"] = {r = 0.96, g = 0.55, b = 0.73}
    }
    return classColors[class] or {r = 1.0, g = 1.0, b = 1.0}
end

-- Function to handle dummy data and update the raid frames
function UpdateRaidFrames(dummyData)
    for i = 1, NUM_TEST_RAID_MEMBERS do
        local raidFrame = _G["RaidFrame" .. i]
        if raidFrame then
            if i <= #dummyData then
                local player = dummyData[i]
                raidFrame:Show()
                raidFrame.name:SetText(player.name)
                raidFrame.health:SetValue(player.health)
                raidFrame.mana:SetValue(player.mana)
                raidFrame.class:SetText(player.class)

                -- Set class color
                local classColor = GetClassColor(player.class)
                raidFrame.health:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
                raidFrame.mana:SetStatusBarColor(classColor.r, classColor.g, classColor.b)

                -- Update debuffs
                for j = 1, 4 do
                    local debuffFrame = raidFrame["debuff" .. j]
                    if player.debuffs[j] then
                        debuffFrame:Show()
                        debuffFrame.icon:SetTexture(player.debuffs[j].icon)
                    else
                        debuffFrame:Hide()
                    end
                end
            else
                raidFrame:Hide()
            end
        end
    end
end

-- Initialize the raid frames with dummy data for testing
local dummyData = GenerateDummyData()
UpdateRaidFrames(dummyData)
