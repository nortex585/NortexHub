-- LocalScript içinde kullanılmalı
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Ana GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ResetWheelGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Çerçeve
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 70)
frame.Position = UDim2.new(0.5, -110, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Sürükleme başlığı
local dragBar = Instance.new("TextLabel")
dragBar.Size = UDim2.new(1, 0, 0, 20)
dragBar.Position = UDim2.new(0, 0, 0, 0)
dragBar.Text = "Özel Çark Sıfırla"
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.TextColor3 = Color3.fromRGB(255, 255, 255)
dragBar.Font = Enum.Font.Gotham
dragBar.TextSize = 14
dragBar.Parent = frame

-- Buton
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 30)
button.Position = UDim2.new(0, 10, 0, 30)
button.Text = "Süreyi Sıfırla"
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 14
button.Parent = frame

-- Yumuşak köşe (UICorner)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = button

-- Buton tıklama olayı
button.MouseButton1Click:Connect(function()
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local value = leaderstats:FindFirstChild("SpecialWheelTime")
		if value and value:IsA("IntValue") then
			value.Value = 0
			print("✅ Özel çark süresi sıfırlandı.")
		else
			warn("⚠️ 'SpecialWheelTime' bulunamadı veya türü yanlış (IntValue olmalı).")
		end
	else
		warn("⚠️ 'leaderstats' bulunamadı.")
	end
end)
