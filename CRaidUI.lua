-- CRaidUI.lua

local NUM_TEST_RAID_MEMBERS = 10

-- Require CDebuff.lua
local CDebuff = require("CDebuff")

-- Global test mode switch
local TEST_MODE = false

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
                {name = "Debuff1", icon = "Interface\\Icons\\Spell_Nature_Polymorph", spellSchool = 0},
                {name = "Debuff2", icon = "Interface\\Icons\\Spell_Nature_Polymorph", spellSchool = 1},
                {name = "Debuff3", icon = "Interface\\Icons\\Spell_Nature_Polymorph", spellSchool = 2},
                {name = "Debuff4", icon = "Interface\\Icons\\Spell_Nature_Polymorph", spellSchool = 3}
            }
        })
    end
    return dummyData
end

-- Function to fetch real data from the game
function FetchRealData()
    local realData = {}
    for i = 1, NUM_TEST_RAID_MEMBERS do
        local unit = "raid" .. i
        if UnitExists(unit) then
            table.insert(realData, {
                name = UnitName(unit),
                health = UnitHealth(unit),
                mana = UnitMana(unit),
                class = UnitClass(unit),
                debuffs = GetUnitDebuffs(unit)
            })
        end
    end
    return realData
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

-- Function to handle data and update the raid frames
function UpdateRaidFrames(data)
    for i = 1, NUM_TEST_RAID_MEMBERS do
        local raidFrame = _G["RaidFrame" .. i]
        if raidFrame then
            if i <= #data then
                local player = data[i]
                raidFrame:Show()
                raidFrame.name:SetText(player.name)
                raidFrame.health:SetValue(player.health)
                raidFrame.mana:SetValue(player.mana)
                raidFrame.class:SetText(player.class)

                -- Set class color
                local classColor = GetClassColor(player.class)
                raidFrame.health:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
                raidFrame.mana:SetStatusBarColor(classColor.r, classColor.g, classColor.b)

                -- Get important debuffs
                local importantDebuffs = CDebuff.GetImportantDebuffs(player.debuffs)

                -- Update debuffs
                for j = 1, 4 do
                    local debuffFrame = raidFrame["debuff" .. j]
                    if importantDebuffs[j] then
                        debuffFrame:Show()
                        debuffFrame.icon:SetTexture(importantDebuffs[j].icon)
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

-- Initialize the raid frames with data
local data
if TEST_MODE then
    data = GenerateDummyData()
else
    data = FetchRealData()
end
UpdateRaidFrames(data)
