-- CAKE PRINCE FARM (FINAL - SAFE HITBOX)
-- Fast Attack INSTANT | Melee only | Bring 8 | Hover Y=12 | Tween Speed=370

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local lp = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- ===== CONFIG =====
local MOB_NAMES = {["Cake Guard"]=true, ["Baking Staff"]=true}
local BOSS_NAME = "Cake Prince"
local NEED_KILL = 500
local MAX_MOB = 8
local HOVER_Y = 12
local LOOP_DELAY = 0.15
local HITBOX_SIZE = Vector3.new(45,45,45) -- SAFE SIZE
local TWEEN_SPEED = 370

local FARM_POS = CFrame.new(-2077, 50, -12290)
local NPC_CAKE = CFrame.new(-2150, 70, -12380)

local KillCount = 0
local Farming = true
local MeleeTool

-- ===== ANTI AFK =====
lp.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.zero)
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

-- ===== FAST ATTACK INSTANT =====
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
    local dist = (hrp.Position - cf.Position).Magnitude
    local time = dist / TWEEN_SPEED
    TweenService:Create(
        hrp,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        {CFrame = cf}
    ):Play()
end

-- SAFE HITBOX (KHÔNG KÉO DÍNH NGƯỜI)
local function enlargeHitbox(m)
    local hr = m:FindFirstChild("HumanoidRootPart")
    local hm = m:FindFirstChild("Humanoid")
    if hr and hm and hm.Health > 0 then
        hr.Size = HITBOX_SIZE
        hr.Transparency = 1
        hr.CanCollide = false
        hr.Massless = true
        hr.AssemblyLinearVelocity = Vector3.zero
    end
end

-- ===== GET MOBS / BOSS =====
local function getMobs()
    local t = {}
    if not Workspace:FindFirstChild("Enemies") then return t end
    for _,v in ipairs(Workspace.Enemies:GetChildren()) do
        if MOB_NAMES[v.Name]
        and v:FindFirstChild("Humanoid")
        and v:FindFirstChild("HumanoidRootPart")
        and v.Humanoid.Health > 0 then
            table.insert(t, v)
            if #t >= MAX_MOB then break end
        end
    end
    return t
end

local function getBoss()
    if not Workspace:FindFirstChild("Enemies") then return end
    for _,v in ipairs(Workspace.Enemies:GetChildren()) do
        if v.Name == BOSS_NAME
        and v:FindFirstChild("Humanoid")
        and v:FindFirstChild("HumanoidRootPart")
        and v.Humanoid.Health > 0 then
            return v
        end
    end
end

-- ===== FARM MOB =====
task.spawn(function()
    while task.wait(LOOP_DELAY) do
        if not Farming then continue end
        equipMelee()

        local mobs = getMobs()
        if #mobs > 0 then
            tween(mobs[1].HumanoidRootPart.CFrame * CFrame.new(0, HOVER_Y, 0))
            for _,m in ipairs(mobs) do
                enlargeHitbox(m)
            end
        else
            tween(FARM_POS)
        end
    end
end)

-- ===== COUNT KILL =====
if Workspace:FindFirstChild("Enemies") then
    Workspace.Enemies.ChildRemoved:Connect(function(m)
        if MOB_NAMES[m.Name] then
            KillCount += 1
        end
    end)
end

-- ===== SPAWN CAKE PRINCE =====
task.spawn(function()
    while task.wait(1) do
        if KillCount >= NEED_KILL then
            Farming = false
            tween(NPC_CAKE)
            task.wait(2)
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            end)
            task.wait(3)
            KillCount = 0
            Farming = true
        end
    end
end)

-- ===== FARM BOSS =====
task.spawn(function()
    while task.wait(0.1) do
        local boss = getBoss()
        if boss then
            equipMelee()
            enlargeHitbox(boss)
            tween(boss.HumanoidRootPart.CFrame * CFrame.new(0, HOVER_Y, 0))
        end
    end
end)
