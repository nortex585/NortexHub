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
frame.Size = UDim2.new(0, 250, 0, 90)
frame.Position = UDim2.new(0.5, -125, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Sürükleme başlığı
local dragBar = Instance.new("TextLabel")
dragBar.Size = UDim2.new(1, 0, 0, 20)
dragBar.Position = UDim2.new(0, 0, 0, 0)
dragBar.Text = "Tüm Çarkları Sıfırla"
dragBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
dragBar.TextColor3 = Color3.fromRGB(255, 255, 255)
dragBar.Font = Enum.Font.Gotham
dragBar.TextSize = 14
dragBar.TextXAlignment = Enum.TextXAlignment.Left
dragBar.PaddingLeft = UDim.new(0, 5)
dragBar.Parent = frame

-- Kapatma butonu (X)
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 20, 0, 20)
closeButton.Position = UDim2.new(1, -20, 0, 0)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- Buton
local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -20, 0, 35)
button.Position = UDim2.new(0, 10, 0, 35)
button.Text = "Süreleri Sıfırla"
button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 14
button.Parent = frame

-- Yumuşak köşe (UICorner)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = button

-- Tıklama işlemi
button.MouseButton1Click:Connect(function()
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local specialWheel = leaderstats:FindFirstChild("SpecialWheelTime")
		local normalWheel = leaderstats:FindFirstChild("Çark")

		if specialWheel and specialWheel:IsA("IntValue") then
			specialWheel.Value = 0
			print("✅ SpecialWheelTime sıfırlandı.")
		else
			warn("⚠️ SpecialWheelTime bulunamadı veya IntValue değil.")
		end

		if normalWheel and normalWheel:IsA("IntValue") then
			normalWheel.Value = 0
			print("✅ Çark süresi sıfırlandı.")
		else
			warn("⚠️ Çark değeri bulunamadı veya IntValue değil.")
		end
	else
		warn("⚠️ leaderstats bulunamadı.")
	end
end)
