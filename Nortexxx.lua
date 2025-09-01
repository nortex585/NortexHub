-- LocalScript (StarterGui içine)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MessageGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Ana Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,300,0,150)
frame.Position = UDim2.new(0.5,-150,0.5,-75)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- TextBox
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8,0,0,40)
textBox.Position = UDim2.new(0.1,0,0.2,0)
textBox.PlaceholderText = "Mesaj yaz"
textBox.ClearTextOnFocus = false
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
textBox.Parent = frame
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,8)

-- Buton
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.6,0,0,40)
button.Position = UDim2.new(0.2,0,0.6,0)
button.Text = "Mesaj Gönder"
button.Font = Enum.Font.GothamBold
button.TextColor3 = Color3.fromRGB(255,255,255)
button.TextSize = 18
button.BackgroundColor3 = Color3.fromRGB(50,150,50)
button.Parent = frame
Instance.new("UICorner", button).CornerRadius = UDim.new(0,10)

-- Butona tıklandığında System_Message tetiklenir
button.MouseButton1Click:Connect(function()
	local remote = ReplicatedStorage:FindFirstChild("System_Message")
	if remote and remote:IsA("RemoteEvent") then
		remote:FireServer(textBox.Text)
	end
end)
