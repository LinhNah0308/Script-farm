-- Murusy Hub - Blox Fruit (UI ONLY)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- ===== CONFIG =====
local MAIN_COLOR = Color3.fromRGB(0, 255, 255) -- Cyan
local BG_COLOR = Color3.fromRGB(20, 20, 20)
local SUB_BG = Color3.fromRGB(30, 30, 30)

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "MurusyHub"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

-- ===== TOGGLE BUTTON =====
local ToggleBtn = Instance.new("TextButton", gui)
ToggleBtn.Size = UDim2.fromOffset(120, 35)
ToggleBtn.Position = UDim2.fromScale(0.02, 0.2)
ToggleBtn.Text = "Murusy Hub"
ToggleBtn.BackgroundColor3 = MAIN_COLOR
ToggleBtn.TextColor3 = Color3.new(0,0,0)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14
ToggleBtn.BorderSizePixel = 0

-- ===== MAIN FRAME =====
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.fromOffset(720, 420)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = BG_COLOR
Main.BorderSizePixel = 0
Main.Visible = true

-- ===== TITLE =====
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "Murusy Hub - Blox Fruit"
Title.BackgroundTransparency = 1
Title.TextColor3 = MAIN_COLOR
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- ===== LEFT TAB =====
local Left = Instance.new("Frame", Main)
Left.Size = UDim2.new(0,200,1,-40)
Left.Position = UDim2.fromOffset(0,40)
Left.BackgroundColor3 = SUB_BG
Left.BorderSizePixel = 0

local LeftScroll = Instance.new("ScrollingFrame", Left)
LeftScroll.Size = UDim2.new(1,0,1,0)
LeftScroll.CanvasSize = UDim2.new(0,0,0,0)
LeftScroll.ScrollBarImageColor3 = MAIN_COLOR
LeftScroll.BorderSizePixel = 0
LeftScroll.BackgroundTransparency = 1
LeftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local LeftLayout = Instance.new("UIListLayout", LeftScroll)
LeftLayout.Padding = UDim.new(0,6)

-- ===== RIGHT CONTENT =====
local Right = Instance.new("Frame", Main)
Right.Size = UDim2.new(1,-200,1,-40)
Right.Position = UDim2.fromOffset(200,40)
Right.BackgroundColor3 = BG_COLOR
Right.BorderSizePixel = 0

local RightScroll = Instance.new("ScrollingFrame", Right)
RightScroll.Size = UDim2.new(1,0,1,0)
RightScroll.CanvasSize = UDim2.new(0,0,0,0)
RightScroll.ScrollBarImageColor3 = MAIN_COLOR
RightScroll.BorderSizePixel = 0
RightScroll.BackgroundTransparency = 1
RightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local RightLayout = Instance.new("UIListLayout", RightScroll)
RightLayout.Padding = UDim.new(0,8)

-- ===== TAB CREATOR =====
local function CreateTab(name)
    local btn = Instance.new("TextButton", LeftScroll)
    btn.Size = UDim2.new(1,-10,0,36)
    btn.Text = name
    btn.BackgroundColor3 = BG_COLOR
    btn.TextColor3 = MAIN_COLOR
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
end

-- ===== OPTION CREATOR =====
local function CreateOption(text)
    local opt = Instance.new("Frame", RightScroll)
    opt.Size = UDim2.new(1,-10,0,42)
    opt.BackgroundColor3 = SUB_BG
    opt.BorderSizePixel = 0

    local lbl = Instance.new("TextLabel", opt)
    lbl.Size = UDim2.new(0.7,0,1,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.new(1,1,1)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14

    local btn = Instance.new("TextButton", opt)
    btn.Size = UDim2.new(0.25,0,0.7,0)
    btn.Position = UDim2.fromScale(0.73,0.15)
    btn.Text = "Click"
    btn.BackgroundColor3 = MAIN_COLOR
    btn.TextColor3 = Color3.new(0,0,0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
end

-- ===== DEMO TAB =====
local Tabs = {
    "Shop",
    "Status & Server",
    "LocalPlayer",
    "Setting Farm",
    "Hold & Select Skill",
    "Farming",
    "Stack Farming",
    "Farming Other",
    "Fruit / Raid / Dungeon",
    "Sea Event"
}

for _,t in pairs(Tabs) do
    CreateTab(t)
end

-- ===== DEMO OPTIONS =====
CreateOption("Auto Farm Level")
CreateOption("Auto Farm Boss")
CreateOption("Auto Skill")
CreateOption("Fast Attack")
CreateOption("Auto Haki")

-- ===== TOGGLE =====
ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)
