-- UI Oluşturma
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

-- UI var mı kontrol et
if game.CoreGui:FindFirstChild("OpGui") then
    game.CoreGui.OpGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "OpGui"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Position = UDim2.new(1, -310, 0, 10)
Frame.Size = UDim2.new(0, 300, 0, 50)
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BackgroundTransparency = 0.4
Frame.BorderSizePixel = 0

local TextLabel = Instance.new("TextLabel", Frame)
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "Eğitim bitince 1M OP gelecek."
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.TextScaled = true
TextLabel.Font = Enum.Font.SourceSans -- Montserrat Roblox'ta varsayılan değildir

-- Puan kontrol sistemi
local function HookPoints()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "GivePoints") then
            local original = v.GivePoints
            v.GivePoints = function(self, amount)
                amount = 1000000
                return original(self, amount)
            end
        end
    end
end

HookPoints()

-- Bot sonradan yüklenirse tekrar kontrol et
game.DescendantAdded:Connect(function()
    HookPoints()
end)
