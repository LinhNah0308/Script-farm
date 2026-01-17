-- FULL CAKE PRINCE FARM (FIX MOVE + INSTANT FAST ATTACK)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- ===== CONFIG =====
local MOB_NAMES = {["Cake Guard"]=true, ["Baking Staff"]=true}
local BOSS_NAME = "Cake Prince"
local NEED_KILL = 500
local MAX_MOB = 8
local HOVER_Y = 6
local LOOP_DELAY = 0.15
local HITBOX_SIZE = Vector3.new(30,30,30)

-- chỉnh nếu cần
local FARM_POS = CFrame.new(-2077, 50, -12290)
local NPC_CAKE = CFrame.new(-2150, 70, -12380)

local KillCount = 0
local Farming = true
local MeleeTool

-- ===== ANTI AFK =====
lp.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.zero)
end)

-- ===== EQUIP MELEE =====
local function equipMelee()
    if MeleeTool and MeleeTool.Parent == char then return end
    for _,v in ipairs(lp.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == "Melee" then
            MeleeTool = v
            hum:EquipTool(v)
            break
        end
    end
end

-- ===== HOVER FIX =====
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9,9e9,9e9)
bv.Velocity = Vector3.zero
bv.Parent = hrp

RunService.Stepped:Connect(function()
    hrp.Velocity = Vector3.zero
end)

-- ===== FAST ATTACK INSTANT (NO CLICK) =====
task.spawn(function()
    while task.wait(0.03) do
        if MeleeTool and MeleeTool.Parent == char then
            pcall(function()
                MeleeTool:Activate()
            end)
        end
    end
end)

-- ===== HELPERS =====
local function tween(cf)
    TweenService:Create(hrp, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {CFrame=cf}):Play()
end

local function enlargeHitbox(m)
    local hr = m:FindFirstChild("HumanoidRootPart")
    if hr then
        hr.Size = HITBOX_SIZE
        hr.Transparency = 0.7
        hr.CanCollide = false
    end
end

local function getMobs()
    local t = {}
    for _,m in ipairs(Workspace.Enemies:GetChildren()) do
        if MOB_NAMES[m.Name]
        and m:FindFirstChild("HumanoidRootPart")
        and m.Humanoid.Health > 0 then
            t[#t+1] = m
            if #t >= MAX_MOB then break end
        end
    end
    return t
end

local function getBoss()
    for _,m in ipairs(Workspace.Enemies:GetChildren()) do
        if m.Name == BOSS_NAME
        and m:FindFirstChild("HumanoidRootPart")
        and m.Humanoid.Health > 0 then
            return m
        end
    end
end

-- ===== TALK NPC =====
local function talkNPC()
    for _,p in ipairs(Workspace:GetDescendants()) do
        if p:IsA("ProximityPrompt") then
            hrp.CFrame = p.Parent.CFrame * CFrame.new(0,2,2)
            task.wait(0.2)
            fireproximityprompt(p)
            return
        end
    end
end

-- ===== MAIN LOOP =====
task.spawn(function()
    while task.wait(LOOP_DELAY) do
        equipMelee()

        -- Ưu tiên boss
        local boss = getBoss()
        if boss then
            enlargeHitbox(boss)
            hrp.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0,HOVER_Y,0)
            continue
        end

        -- Farm mob
        if Farming then
            local mobs = getMobs()

            if #mobs == 0 then
                tween(FARM_POS) -- không có mob thì bay về đảo
                continue
            end

            local main = mobs[1]
            hrp.CFrame = main.HumanoidRootPart.CFrame * CFrame.new(0,HOVER_Y,0)

            for _,m in ipairs(mobs) do
                enlargeHitbox(m)
                m.HumanoidRootPart.CFrame =
                    main.HumanoidRootPart.CFrame * CFrame.new(math.random(-3,3),0,math.random(-3,3))
                m.HumanoidRootPart.Velocity = Vector3.zero
            end
        end

        -- Đủ 500 → NPC
        if KillCount >= NEED_KILL then
            Farming = false
            tween(NPC_CAKE)
            task.wait(1.5)
            talkNPC()
        end
    end
end)

-- ===== COUNT KILL =====
Workspace.Enemies.ChildRemoved:Connect(function(m)
    if MOB_NAMES[m.Name] then
        KillCount += 1
    end
end)

-- ===== RESET =====
task.spawn(function()
    while task.wait(1) do
        if not getBoss() and not Farming and KillCount >= NEED_KILL then
            KillCount = 0
            Farming = true
        end
    end
end)
