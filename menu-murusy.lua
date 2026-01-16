-- Murusy Hub - Blox Fruit (UI ONLY | Banana Style)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- ===== COLOR =====
local CYAN = Color3.fromRGB(0,191,255)
local DARK = Color3.fromRGB(18,18,18)
local DARK2 = Color3.fromRGB(25,25,25)

-- ===== GUI =====
local gui = Instance.new("ScreenGui", lp.PlayerGui)
gui.Name = "MurusyHub"
gui.ResetOnSpawn = false

-- ===== DRAG FUNCTION =====
local function Drag(frame)
    local drag, dragInput, startPos, startInput
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            startInput = i.Position
            startPos = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    drag = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = i
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if i == dragInput and drag then
            local delta = i.Position - startInput
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ===== TOGGLE BUTTON =====
local Toggle = Instance.new("Frame", gui)
Toggle.Size = UDim2.fromOffset(120,38)
Toggle.Position = UDim2.fromScale(0.03,0.35)
Toggle.BackgroundColor3 = DARK2
Toggle.BorderSizePixel = 0
Drag(Toggle)

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,10)
local ts = Instance.new("UIStroke", Toggle)
ts.Color = CYAN
ts.Thickness = 1

local ToggleText = Instance.new("TextLabel", Toggle)
ToggleText.Size = UDim2.new(1,0,1,0)
ToggleText.BackgroundTransparency = 1
ToggleText.Text = "Murusy Hub"
ToggleText.TextColor3 = CYAN
ToggleText.Font = Enum.Font.GothamBold
ToggleText.TextSize = 14

-- ===== MAIN =====
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.fromOffset(760,440)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = DARK
Main.BorderSizePixel = 0
Drag(Main)

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)
local stroke = Instance.new("UIStroke", Main)
stroke.Color = CYAN
stroke.Thickness = 1.2

-- ===== HEADER =====
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1,0,0,44)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(1,0,1,0)
Title.BackgroundTransparency = 1
Title.Text = "Murusy Hub - Blox Fruit"
Title.TextColor3 = CYAN
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- ===== LEFT PANEL =====
local Left = Instance.new("Frame", Main)
Left.Position = UDim2.fromOffset(12,54)
Left.Size = UDim2.fromOffset(220,370)
Left.BackgroundColor3 = DARK2
Left.BorderSizePixel = 0
Instance.new("UICorner", Left).CornerRadius = UDim.new(0,12)

local LeftScroll = Instance.new("ScrollingFrame", Left)
LeftScroll.Size = UDim2.new(1,-10,1,-10)
LeftScroll.Position = UDim2.fromOffset(5,5)
LeftScroll.CanvasSize = UDim2.new(0,0,0,0)
LeftScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
LeftScroll.ScrollBarImageColor3 = CYAN
LeftScroll.BorderSizePixel = 0
LeftScroll.BackgroundTransparency = 1

local LL = Instance.new("UIListLayout", LeftScroll)
LL.Padding = UDim.new(0,8)

-- ===== RIGHT PANEL =====
local Right = Instance.new("Frame", Main)
Right.Position = UDim2.fromOffset(248,54)
Right.Size = UDim2.fromOffset(500,370)
Right.BackgroundColor3 = DARK2
Right.BorderSizePixel = 0
Instance.new("UICorner", Right).CornerRadius = UDim.new(0,12)

local RightScroll = Instance.new("ScrollingFrame", Right)
RightScroll.Size = UDim2.new(1,-10,1,-10)
RightScroll.Position = UDim2.fromOffset(5,5)
RightScroll.CanvasSize = UDim2.new(0,0,0,0)
RightScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
RightScroll.ScrollBarImageColor3 = CYAN
RightScroll.BorderSizePixel = 0
RightScroll.BackgroundTransparency = 1

local RL = Instance.new("UIListLayout", RightScroll)
RL.Padding = UDim.new(0,10)

-- ===== TAB =====
local function Tab(name)
    local b = Instance.new("TextButton", LeftScroll)
    b.Size = UDim2.new(1,0,0,40)
    b.Text = name
    b.BackgroundColor3 = DARK
    b.TextColor3 = CYAN
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
end

-- ===== OPTION =====
local function Option(text)
    local f = Instance.new("Frame", RightScroll)
    f.Size = UDim2.new(1,0,0,46)
    f.BackgroundColor3 = DARK
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,12)

    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(0.7,0,1,0)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = Color3.fromRGB(235,235,235)
    l.Font = Enum.Font.Gotham
    l.TextSize = 14

    local c = Instance.new("TextButton", f)
    c.Size = UDim2.new(0.25,0,0.65,0)
    c.Position = UDim2.fromScale(0.72,0.18)
    c.Text = "Click"
    c.BackgroundColor3 = CYAN
    c.TextColor3 = Color3.new(0,0,0)
    c.Font = Enum.Font.GothamBold
    c.TextSize = 13
    c.BorderSizePixel = 0
    Instance.new("UICorner", c).CornerRadius = UDim.new(0,10)
end

-- ===== DEMO =====
local tabs = {
    "Shop","Status & Server","LocalPlayer","Setting Farm",
    "Hold & Select Skill","Farming","Stack Farming",
    "Farming Other","Fruit / Raid / Dungeon","Sea Event"
}
for _,v in pairs(tabs) do Tab(v) end

Option("Auto Farm Level")
Option("Auto Farm Boss")
Option("Fast Attack")
Option("Auto Skill")
Option("Auto Haki")

-- ===== TOGGLE =====
Toggle.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        Main.Visible = not Main.Visible
    end
end)
