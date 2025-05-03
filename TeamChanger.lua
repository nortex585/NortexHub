local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer

-- GUI öğeleri
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = screenGui
frame.Size = UDim2.new(0.3, 0, 0.3, 0)
frame.Position = UDim2.new(0.35, 0, 0.35, 0)

local textBox = Instance.new("TextBox")
textBox.Parent = frame
textBox.Size = UDim2.new(0.8, 0, 0.3, 0)
textBox.Position = UDim2.new(0.1, 0, 0.1, 0)
textBox.PlaceholderText = "Takım adını girin"
textBox.TextChanged:Connect(function()
    -- TextBox'daki metin değiştiğinde yapılacak işlem
end)

local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(0.8, 0, 0.3, 0)
button.Position = UDim2.new(0.1, 0, 0.6, 0)
button.Text = "Takıma Gir"
button.MouseButton1Click:Connect(function()
    local teamName = textBox.Text
    -- Takım adını kullanarak GitHub'dan scripti yükle
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nortex585/TeamChanger/main/TeamChanger.lua"))()
end)
