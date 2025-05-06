-- LocalScript içinde kullanılmalı
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Ana GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CarkSifirlaGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Ana çerçeve
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 90)
frame.Position = UDim2.new(0.5, -125, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Başlık (Sürükleme alanı)
local dragBar = Instance.new("TextLabel")
dragBar.Size = UDim2.new(1, 0, 0, 20)
dragBar.Position = UDim2.new(0, 0, 0, 0)
dragBar.Text = "Çark Süresi Sıfırlayıcı"
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

-- Sıfırlama butonu
local resetButton = Instance.new("TextButton")
resetButton.Size = UDim2.new(1, -20, 0, 35)
resetButton.Position = UDim2.new(0, 10, 0, 35)
resetButton.Text = "Çark Süresini Sıfırla"
resetButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
resetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
resetButton.Font = Enum.Font.Gotham
resetButton.TextSize = 14
resetButton.Parent = frame

local resetCorner = Instance.new("UICorner")
resetCorner.CornerRadius = UDim.new(0, 10)
resetCorner.Parent = resetButton

-- Tıklama işlevi
resetButton.MouseButton1Click:Connect(function()
	local leaderstats = player:FindFirstChild("leaderstats")
	if leaderstats then
		local cark = leaderstats:FindFirstChild("Çark")
		if cark and cark:IsA("IntValue") then
			cark.Value = 0
			print("✅ Çark süresi sıfırlandı.")
		else
			warn("⚠️ 'Çark' bulunamadı veya IntValue değil.")
		end
	else
		warn("⚠️ 'leaderstats' bulunamadı.")
	end
end)
