-- Murusy Hub - Blox Fruit (UI ONLY | Fixed)

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- ===== COLOR =====
local CYAN = Color3.fromRGB(0,191,255)
local BG = Color3.fromRGB(20,20,20)
local PANEL = Color3.fromRGB(30,30,30)
local ITEM = Color3.fromRGB(25,25,25)

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "MurusyHub"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

-- ===== TOGGLE BUTTON (FIXED) =====
local Toggle = Instance.new("TextButton", gui)
Toggle.Size = UDim2.fromOffset(120,36)
Toggle.Position = UDim2.fromScale(0.02,0.32)
Toggle.Text = "Murusy Hub"
Toggle.BackgroundColor3 = PANEL
Toggle.TextColor3 = CYAN
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 13
Toggle.BorderSizePixel = 0
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,8)

-- ===== MAIN MENU (FIXED) =====
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.fromOffset(650,370)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

-- ===== HEADER =====
local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1,0,0,36)
Header.BackgroundColor3 = PANEL
Header.Text = "Murusy Hub - Blox Fruit"
Header.TextColor3 = CYAN
Header.Font = Enum.Font.GothamBold
Header.TextSize = 15
Header.BorderSizePixel = 0
Instance.new("UICorner", Header).CornerRadius = UDim.new(0,10)

-- ===== LEFT PANEL =====
local Left = Instance.new("Frame", Main)
Left.Position = UDim2.fromOffset(10,46)
Left.Size = UDim2.fromOffset(220,310)
Left.BackgroundColor3 = PANEL
Left.BorderSizePixel = 0
Instance.new("UICorner", Left).CornerRadius = UDim.new(0,8)

local LeftScroll = Instance.new("ScrollingFrame", Left)
LeftScroll.Size = UDim2.new(1,-8,1,-8)
LeftScroll.Position = UDim2.fromOffset(4,4)
LeftScroll.CanvasSize = UDim2.new(0,0,0,0)
LeftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
LeftScroll.ScrollBarImageColor3 = CYAN
LeftScroll.ScrollBarThickness = 4
LeftScroll.BackgroundTransparency = 1
LeftScroll.BorderSizePixel = 0

local LL = Instance.new("UIListLayout", LeftScroll)
LL.Padding = UDim.new(0,6)

-- ===== RIGHT PANEL =====
local Right = Instance.new("Frame", Main)
Right.Position = UDim2.fromOffset(240,46)
Right.Size = UDim2.fromOffset(400,310)
Right.BackgroundColor3 = PANEL
Right.BorderSizePixel = 0
Instance.new("UICorner", Right).CornerRadius = UDim.new(0,8)

local RightScroll = Instance.new("ScrollingFrame", Right)
RightScroll.Size = UDim2.new(1,-8,1,-8)
RightScroll.Position = UDim2.fromOffset(4,4)
RightScroll.CanvasSize = UDim2.new(0,0,0,0)
RightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
RightScroll.ScrollBarImageColor3 = CYAN
RightScroll.ScrollBarThickness = 4
RightScroll.BackgroundTransparency = 1
RightScroll.BorderSizePixel = 0

local RL = Instance.new("UIListLayout", RightScroll)
RL.Padding = UDim.new(0,8)

-- ===== TAB BUTTON =====
local function CreateTab(name)
    local b = Instance.new("TextButton", LeftScroll)
    b.Size = UDim2.new(1,0,0,34)
    b.Text = name
    b.BackgroundColor3 = ITEM
    b.TextColor3 = CYAN
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
end

-- ===== DEMO OPTION (RIGHT) =====
local function CreateOption(text)
    local f = Instance.new("Frame", RightScroll)
    f.Size = UDim2.new(1,0,0,38)
    f.BackgroundColor3 = ITEM
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,6)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.7,0,1,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(230,230,230)
    l.Font = Enum.Font.Gotham
    l.TextSize = 13

    local c = Instance.new("TextButton", f)
    c.Size = UDim2.new(0.25,0,0.6,0)
    c.Position = UDim2.fromScale(0.72,0.2)
    c.Text = "Click"
    c.BackgroundColor3 = CYAN
    c.TextColor3 = Color3.new(0,0,0)
    c.Font = Enum.Font.GothamBold
    c.TextSize = 12
    c.BorderSizePixel = 0
    Instance.new("UICorner", c).CornerRadius = UDim.new(0,6)
end

-- ===== TAB LIST (THEO YÊU CẦU) =====
local Tabs = {
    "Shop",
    "Status And Server",
    "LocalPlayer",
    "Setting Farm",
    "Hold and Select Skill",
    "Farming",
    "Stack Farming",
    "Farming Other",
    "Fruit and Raid, Dungeon",
    "Sea Event",
    "Upgrade Race",
    "Get and Upgrade Items",
    "PVP",
    "Esp",
    "Tab Webhook",
    "Setting"
}

for _,v in ipairs(Tabs) do
    CreateTab(v)
end

-- ===== DEMO CONTENT =====
CreateOption("Option Example 1")
CreateOption("Option Example 2")

-- ===== TOGGLE MENU =====
Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)
