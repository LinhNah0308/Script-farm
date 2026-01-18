-- FAST ATTACK M1 - NO ANIMATION / NO CLICK / NO HITBOX ENEMY

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer

-- CONFIG
local ATTACK_DELAY = 0.06      -- an toàn
local ATTACK_RANGE = 60        -- xa ~3x

-- LOAD MODULE
local CombatFramework = require(lp.PlayerScripts:WaitForChild("CombatFramework"))
local CameraShaker = require(ReplicatedStorage.Util.CameraShaker)
CameraShaker:Stop()

-- GET CONTROLLER (CF v2)
local function getController()
    local cf = CombatFramework
    if not cf.activeController then
        cf.activeController = cf.controllers[1]
    end
    return cf.activeController
end

-- CORE FAST ATTACK
task.spawn(function()
    while task.wait(ATTACK_DELAY) do
        pcall(function()
            local controller = getController()
            if not controller or not controller.equipped then return end

            controller.hitboxMagnitude = ATTACK_RANGE
            controller.timeToNextAttack = 0
            controller.increment = 3

            -- BUILD HIT
            local hits = {}
            for _,v in pairs(workspace.Enemies:GetChildren()) do
                local hrp = v:FindFirstChild("HumanoidRootPart")
                local hum = v:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    if (hrp.Position - lp.Character.HumanoidRootPart.Position).Magnitude <= ATTACK_RANGE then
                        table.insert(hits, hrp)
                    end
                end
            end

            -- APPLY DAMAGE (SERVER ACCEPT)
            if #hits > 0 then
                controller:attack()
                controller:hit(hits, 1)
            end
        end)
    end
end)
