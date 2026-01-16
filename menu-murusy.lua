-- Murusy Hub - Blox Fruit (UI ONLY | Small Banana Style | Fixed)

local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- ===== COLOR =====
local CYAN = Color3.fromRGB(0,191,255)
local DARK = Color3.fromRGB(20,20,20)
local DARK2 = Color3.fromRGB(28,28,28)

-- ===== GUI =====
local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.Name = "MurusyHub"
gui.ResetOnSpawn = false

-- ===== TOGGLE BUTTON (FIXED) =====
local Toggle = Instance.new("Frame", gui)
Toggle.Size = UDim2.fromOffset(110,34)
Toggle.Position = UDim2.fromScale(0.02,0.32)
Toggle.BackgroundColor3 = DARK2
Toggle.BackgroundTransparency = 0.25
Toggle.BorderSizePixel = 0

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,10)
local tStroke = Instance.new("UIStroke", Toggle)
tStroke.Color = CYAN
tStroke.Thickness = 1

local ToggleText = Instance.new("TextLabel", Toggle)
ToggleText.Size = UDim2.new(1,0,1,0)
ToggleText.BackgroundTransparency = 1
ToggleText.Text = "Murusy Hub"
ToggleText.TextColor3 = CYAN
ToggleText.Font = Enum.Font.GothamBold
ToggleText.TextSize = 13

-- ===== MAIN MENU (FIXED + SMALL) =====
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.fromOffset(640,360) -- nhỏ như Banana
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = DARK
Main.BackgroundTransparency = 0.18
Main.BorderSizePixel = 0
Main.Visible = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)
local stroke = Instance.new("UIStroke", Main)
stroke.Color = CYAN
stroke.Thickness = 1

-- ===== HEADER =====
local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1,0,0,38)
Header.BackgroundTransparency = 1
Header.Text = "Murusy Hub - Blox Fruit"
Header.TextColor3 = CYAN
Header.Font = Enum.Font.GothamBold
Header.TextSize = 16

-- ===== LEFT PANEL =====
local Left = Instance.new("Frame", Main)
Left.Position = UDim2.fromOffset(10,44)
Left.Size = UDim2.fromOffset(200,300)
Left.BackgroundColor3 = DARK2
Left.BackgroundTransparency = 0.2
Left.BorderSizePixel = 0
Instance.new("UICorner", Left).CornerRadius = UDim.new(0,12)

local LeftScroll = Instance.new("ScrollingFrame", Left)
LeftScroll.Size = UDim2.new(1,-8,1,-8)
LeftScroll.Position = UDim2.fromOffset(4,4)
LeftScroll.CanvasSize = UDim2.new(0,0,0,0)
LeftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
LeftScroll.ScrollBarImageColor3 = CYAN
LeftScroll.BorderSizePixel = 0
LeftScroll.BackgroundTransparency = 1

local LL = Instance.new("UIListLayout", LeftScroll)
LL.Padding = UDim.new(0,7)

-- ===== RIGHT PANEL =====
local Right = Instance.new("Frame", Main)
Right.Position = UDim2.fromOffset(220,44)
Right.Size = UDim2.fromOffset(410,300)
Right.BackgroundColor3 = DARK2
Right.BackgroundTransparency = 0.2
Right.BorderSizePixel = 0
Instance.new("UICorner", Right).CornerRadius = UDim.new(0,12)

local RightScroll = Instance.new("ScrollingFrame", Right)
RightScroll.Size = UDim2.new(1,-8,1,-8)
RightScroll.Position = UDim2.fromOffset(4,4)
RightScroll.CanvasSize = UDim2.new(0,0,0,0)
RightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
RightScroll.ScrollBarImageColor3 = CYAN
RightScroll.BorderSizePixel = 0
RightScroll.BackgroundTransparency = 1

local RL = Instance.new("UIListLayout", RightScroll)
RL.Padding = UDim.new(0,8)

-- ===== TAB BUTTON =====
local function Tab(name)
    local b = Instance.new("TextButton", LeftScroll)
    b.Size = UDim2.new(1,0,0,36)
    b.Text = name
    b.BackgroundColor3 = DARK
    b.BackgroundTransparency = 0.15
    b.TextColor3 = CYAN
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
end

-- ===== OPTION =====
local function Option(text)
    local f = Instance.new("Frame", RightScroll)
    f.Size = UDim2.new(1,0,0,40)
    f.BackgroundColor3 = DARK
    f.BackgroundTransparency = 0.15
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.7,0,1,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(235,235,235)
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
    Instance.new("UICorner", c).CornerRadius = UDim.new(0,10)
end

-- ===== DEMO CONTENT =====
local tabs = {
    "Shop","Status & Server","LocalPlayer",
    "Setting Farm","Farming","Fruit / Raid"
}
for _,v in pairs(tabs) do Tab(v) end

Option("Auto Farm Level")
Option("Auto Farm Boss")
Option("Fast Attack")
Option("Auto Skill")

-- ===== TOGGLE CLICK =====
Toggle.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        Main.Visible = not Main.Visible
    end
end)
