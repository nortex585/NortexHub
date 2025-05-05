-- Nortex Hub GUI - Brookhaven Edition

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TabHolder = Instance.new("Frame")
local ButtonsHolder = Instance.new("Frame")
local Tabs = {}

-- Setup
ScreenGui.Name = "NortexHub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 600, 0, 400)

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "Nortex Hub [BETA] : Brookhaven"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

TabHolder.Name = "TabHolder"
TabHolder.Parent = MainFrame
TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabHolder.Position = UDim2.new(0, 0, 0, 40)
TabHolder.Size = UDim2.new(0, 120, 1, -40)

ButtonsHolder.Name = "ButtonsHolder"
ButtonsHolder.Parent = MainFrame
ButtonsHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ButtonsHolder.Position = UDim2.new(0, 120, 0, 40)
ButtonsHolder.Size = UDim2.new(1, -120, 1, -40)

-- Example Tabs
local tabNames = {"Discord", "Farm", "Shop", "Mini Games", "Player", "Teleports", "Misc"}

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Parent = TabHolder
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14

    -- placeholder functionality
    btn.MouseButton1Click:Connect(function()
        ButtonsHolder:ClearAllChildren()
        local label = Instance.new("TextLabel")
        label.Parent = ButtonsHolder
        label.Size = UDim2.new(1, 0, 0, 30)
        label.Text = name .. " section coming soon..."
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 16
        label.BackgroundTransparency = 1
    end)
end
