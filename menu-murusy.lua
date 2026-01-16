-- Murusy Hub - Blox Fruit | UI + Tabs + Drag (FIXED)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- ===== DRAG =====
local function Drag(frame)
    local dragging, dragInput, startPos, startFrame
    frame.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = i.Position
            startFrame = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then
                    dragging = false
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
        if i == dragInput and dragging then
            local d = i.Position - startPos
            frame.Position = UDim2.new(
                startFrame.X.Scale, startFrame.X.Offset + d.X,
                startFrame.Y.Scale, startFrame.Y.Offset + d.Y
            )
        end
    end)
end

-- ===== COLORS =====
local CYAN = Color3.fromRGB(0,191,255)
local BG = Color3.fromRGB(20,20,20)
local PANEL = Color3.fromRGB(30,30,30)
local ITEM = Color3.fromRGB(25,25,25)

-- ===== GUI =====
local gui = Instance.new("ScreenGui")
gui.Name = "MurusyHub"
gui.ResetOnSpawn = false
gui.Parent = lp:WaitForChild("PlayerGui")

-- ===== TOGGLE =====
local Toggle = Instance.new("TextButton", gui)
Toggle.Size = UDim2.fromOffset(120,36)
Toggle.Position = UDim2.fromScale(0.02,0.3)
Toggle.Text = "Murusy Hub"
Toggle.BackgroundColor3 = PANEL
Toggle.TextColor3 = CYAN
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 13
Toggle.BorderSizePixel = 0
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,8)
Drag(Toggle)

-- ===== MAIN =====
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.fromOffset(650,370)
Main.Position = UDim2.fromScale(0.5,0.5)
Main.AnchorPoint = Vector2.new(0.5,0.5)
Main.BackgroundColor3 = BG
Main.BorderSizePixel = 0
Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)
Drag(Main)

Toggle.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- ===== HEADER =====
local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1,0,0,36)
Header.BackgroundColor3 = PANEL
Header.Text = "Murusy Hub - Blox Fruit"
Header.TextColor3 = CYAN
Header.Font = Enum.Font.GothamBold
Header.TextSize = 15
Header.BorderSizePixel = 0

-- ===== LEFT TABS =====
local Left = Instance.new("ScrollingFrame", Main)
Left.Position = UDim2.fromOffset(10,46)
Left.Size = UDim2.fromOffset(220,310)
Left.AutomaticCanvasSize = Enum.AutomaticSize.Y
Left.CanvasSize = UDim2.new(0,0,0,0)
Left.ScrollBarThickness = 4
Left.ScrollBarImageColor3 = CYAN
Left.BackgroundColor3 = PANEL
Left.BorderSizePixel = 0
Instance.new("UICorner", Left).CornerRadius = UDim.new(0,8)

local LL = Instance.new("UIListLayout", Left)
LL.Padding = UDim.new(0,6)

-- ===== PAGES =====
local Pages = Instance.new("Folder", Main)

local function NewPage(name)
    local p = Instance.new("ScrollingFrame", Pages)
    p.Name = name
    p.Position = UDim2.fromOffset(240,46)
    p.Size = UDim2.fromOffset(400,310)
    p.AutomaticCanvasSize = Enum.AutomaticSize.Y
    p.CanvasSize = UDim2.new(0,0,0,0)
    p.ScrollBarThickness = 4
    p.ScrollBarImageColor3 = CYAN
    p.BackgroundColor3 = PANEL
    p.BorderSizePixel = 0
    p.Visible = false
    Instance.new("UICorner", p).CornerRadius = UDim.new(0,8)

    local L = Instance.new("UIListLayout", p)
    L.Padding = UDim.new(0,8)
    return p
end

local function Option(parent, text)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,0,0,38)
    f.BackgroundColor3 = ITEM
    f.BorderSizePixel = 0
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,6)

    local t = Instance.new("TextLabel", f)
    t.Size = UDim2.new(1,-20,1,0)
    t.Position = UDim2.fromOffset(10,0)
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextColor3 = Color3.fromRGB(230,230,230)
    t.Font = Enum.Font.Gotham
    t.TextSize = 13
    t.TextXAlignment = Enum.TextXAlignment.Left
end

-- ===== TAB LIST =====
local Tabs = {
    "Shop","Status And Server","LocalPlayer","Setting Farm",
    "Hold and Select Skill","Farming","Stack Farming",
    "Farming Other","Fruit and Raid, Dungeon","Sea Event",
    "Upgrade Race","Get and Upgrade Items","PVP",
    "Esp","Tab Webhook","Setting"
}

local PageList = {}

for _,name in ipairs(Tabs) do
    PageList[name] = NewPage(name)
    Option(PageList[name], name.." Option 1")
    Option(PageList[name], name.." Option 2")

    local b = Instance.new("TextButton", Left)
    b.Size = UDim2.new(1,0,0,34)
    b.Text = name
    b.BackgroundColor3 = ITEM
    b.TextColor3 = CYAN
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

    b.MouseButton1Click:Connect(function()
        for _,p in pairs(PageList) do
            p.Visible = false
        end
        PageList[name].Visible = true
    end)
end

PageList["Shop"].Visible = true
