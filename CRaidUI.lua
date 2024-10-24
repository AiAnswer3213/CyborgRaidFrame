-- CRaidUI.lua

local NUM_TEST_RAID_MEMBERS = 10

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

-- Function to handle real data and update the raid frames
function UpdateRaidFrames()
    local numRaidMembers = GetNumGroupMembers()
    for i = 1, NUM_TEST_RAID_MEMBERS do
        local raidFrame = _G["RaidFrame" .. i]
        if raidFrame then
            if i <= numRaidMembers then
                local unit = "raid" .. i
                local name = UnitName(unit)
                local health = UnitHealth(unit)
                local mana = UnitPower(unit)
                local class = UnitClass(unit)

                raidFrame:Show()
                raidFrame.name:SetText(name)
                raidFrame.health:SetValue(health)
                raidFrame.mana:SetValue(mana)
                raidFrame.class:SetText(class)

                -- Set class color
                local classColor = GetClassColor(class)
                raidFrame.health:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
                raidFrame.mana:SetStatusBarColor(classColor.r, classColor.g, classColor.b)

                -- Update debuffs
                for j = 1, 4 do
                    local debuffFrame = raidFrame["debuff" .. j]
                    local debuffName, _, debuffIcon = UnitDebuff(unit, j)
                    if debuffName then
                        debuffFrame:Show()
                        debuffFrame.icon:SetTexture(debuffIcon)
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

-- Event handler function
local function OnEvent(self, event, arg1)
    if event == "RAID_ROSTER_UPDATE" or (event == "UNIT_HEALTH" and arg1:find("raid")) or (event == "UNIT_MANA" and arg1:find("raid")) then
        UpdateRaidFrames()
    end
end

-- Register event handlers
local frame = CreateFrame("Frame")
frame:RegisterEvent("RAID_ROSTER_UPDATE")
frame:RegisterEvent("UNIT_HEALTH")
frame:RegisterEvent("UNIT_MANA")
frame:SetScript("OnEvent", OnEvent)
