local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lp = Players.LocalPlayer

local ATTACK_DELAY = 0.06
local ATTACK_RANGE = 60

local CombatFramework = require(lp.PlayerScripts:WaitForChild("CombatFramework"))
local CameraShaker = require(ReplicatedStorage.Util.CameraShaker)
CameraShaker:Stop()

local RigControllerEvent = ReplicatedStorage.Remotes.RigControllerEvent
local Validator = ReplicatedStorage.Remotes.Validator

local function getController()
    local cf = CombatFramework
    if not cf.activeController then
        cf.activeController = cf.controllers[1]
    end
    return cf.activeController
end

task.spawn(function()
    while task.wait(ATTACK_DELAY) do
        pcall(function()
            local char = lp.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local controller = getController()
            if not controller or not controller.equipped then return end

            controller.hitboxMagnitude = ATTACK_RANGE
            controller.timeToNextAttack = 0

            local hits = {}
            for _,v in pairs(workspace.Enemies:GetChildren()) do
                local ehrp = v:FindFirstChild("HumanoidRootPart")
                local hum = v:FindFirstChild("Humanoid")
                if ehrp and hum and hum.Health > 0 then
                    if (ehrp.Position - hrp.Position).Magnitude <= ATTACK_RANGE then
                        hits[#hits+1] = ehrp
                    end
                end
            end

            if #hits > 0 then
                Validator:FireServer(math.random(100000,999999), math.random())
                RigControllerEvent:FireServer("weaponChange", tostring(controller.currentWeapon))
                RigControllerEvent:FireServer("hit", hits, 1, "")
                controller:attack()
            end
        end)
    end
end)
