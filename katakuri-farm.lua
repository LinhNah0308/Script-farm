-- FULL CAKE PRINCE FARM (OPTIMIZED + ANTI KICK/LAG)
-- Melee | Fast Attack | Bring 8 | Hover | Large Hitbox | Anti AFK/Lag

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
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
local FAST_DELAY = 0.05
local LOOP_DELAY = 0.2
local HITBOX_SIZE = Vector3.new(30,30,30)

-- chỉnh nếu cần
local NPC_CAKE = CFrame.new(-2150, 70, -12380)
local BACK_FARM = CFrame.new(-2077, 50, -12290)

local KillCount = 0
local Farming = true

-- ===== ANTI AFK =====
lp.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
end)

-- ===== ANTI LAG / NETWORK =====
pcall(function()
    sethiddenproperty(lp, "MaximumSimulationRadius", math.huge)
    sethiddenproperty(lp, "SimulationRadius", math.huge)
end)
settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
workspace.StreamingEnabled = true

-- ===== FIX GIẬT / RƠI =====
RunService.Stepped:Connect(function()
    hrp.Velocity = Vector3.zero
    hrp.RotVelocity = Vector3.zero
end)

-- ===== EQUIP MELEE =====
local function equipMelee()
    for _,v in ipairs(lp.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.ToolTip == "Melee" then
            hum:EquipTool(v); break
        end
    end
end
equipMelee()

-- ===== HOVER FIX =====
local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9,9e9,9e9)
bv.Velocity = Vector3.zero
bv.Parent = hrp

-- ===== FAST ATTACK =====
task.spawn(function()
    while task.wait(FAST_DELAY) do
        VirtualUser:Button1Down(Vector2.zero, workspace.CurrentCamera.CFrame)
        VirtualUser:Button1Up(Vector2.zero, workspace.CurrentCamera.CFrame)
    end
end)

-- ===== HELPERS =====
local function tween(cf)
    TweenService:Create(hrp, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {CFrame=cf}):Play()
end

local function enlargeHitbox(m)
    if m and m:FindFirstChild("HumanoidRootPart") then
        local hr = m.HumanoidRootPart
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

-- ===== TALK NPC (PROXIMITYPROMPT) =====
local function talkNPC()
    for _,p in ipairs(Workspace:GetDescendants()) do
        if p:IsA("ProximityPrompt") then
            hrp.CFrame = p.Parent.CFrame * CFrame.new(0,2,2)
            task.wait(0.3)
            fireproximityprompt(p)
            return true
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
            if #mobs > 0 then
                local main = mobs[1]
                hrp.CFrame = main.HumanoidRootPart.CFrame * CFrame.new(0,HOVER_Y,0)
                for _,m in ipairs(mobs) do
                    enlargeHitbox(m)
                    m.HumanoidRootPart.CFrame =
                        main.HumanoidRootPart.CFrame * CFrame.new(math.random(-3,3),0,math.random(-3,3))
                    m.HumanoidRootPart.Velocity = Vector3.zero
                end
            end
        end

        -- Đủ 500 → nói NPC
        if KillCount >= NEED_KILL then
            Farming = false
            tween(NPC_CAKE)
            task.wait(2)
            talkNPC()
        end
    end
end)

-- ===== COUNT KILL =====
Workspace.Enemies.ChildRemoved:Connect(function(m)
    if MOB_NAMES[m.Name] then
        KillCount += 1
        if KillCount >= NEED_KILL then
            Farming = false
        end
    end
end)

-- ===== RESET SAU KHI GIẾT BOSS =====
task.spawn(function()
    while task.wait(1) do
        if not getBoss() and not Farming and KillCount >= NEED_KILL then
            KillCount = 0
            Farming = true
            tween(BACK_FARM)
        end
    end
end)
