-- LocalScript içinde kullanılacak

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Ana ekran GUI'si
local screenGui = Instance.new("ScreenGui", playerGui)
screenGui.Name = "ResetWheelGUI"
screenGui.ResetOnSpawn = false

-- Ana çerçeve
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 50)
frame.Position = UDim2.new(0.5, -100, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Draggable = true
frame.Active = true
frame.Parent = screenGui

-- Sürükleme çubuğu
local dragBar = Instance.new("TextLabel")
dragBar.Size = UDim2.new(1, 0, 0, 20)
dragBar.Position = UDim2.new(0, 0, 0, 0)
dragBar.Text = "Özel Çark Sıfırla"
dragBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dragBar.TextColor3 = Color3.fromRGB(255, 255, 255)
dragBar.Parent = frame

-- Buton
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -10, 0, 25)
button.Position = UDim2.new(0, 5, 0, 22)
button.Text = "Süreyi Sıfırla"
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 14
button.Parent = frame

-- UICorner (butona yumuşak köşe)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = button

-- Butona basınca çalışacak kod
button.MouseButton1Click:Connect(function()
	local value = player:FindFirstChild("SpecialWheelTime")
	if value and value:IsA("IntValue") then
		value.Value = 0
		print("Özel çark süresi sıfırlandı.")
	else
		warn("SpecialWheelTime değeri bulunamadı.")
	end
end)
