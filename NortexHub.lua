-- GUI Oluştur
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "HKTurkishHile"
gui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 250, 0, 250)
mainFrame.Position = UDim2.new(0, 50, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Active = true
mainFrame.Draggable = true

Instance.new("UICorner", mainFrame)

-- Başlık Çubuğu
local titleBar = Instance.new("TextLabel", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 25)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.Text = "HK Turkish Hile 1.0"
titleBar.TextColor3 = Color3.new(1, 1, 1)
titleBar.TextSize = 14
titleBar.Font = Enum.Font.SourceSansBold

-- Kapat Butonu
local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -50, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", closeBtn)

-- Küçültme Butonu
local minimizeBtn = Instance.new("TextButton", mainFrame)
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -25, 0, 0)
minimizeBtn.Text = "_"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
Instance.new("UICorner", minimizeBtn)

-- Mini Kare Buton (HK)
local hkMiniBtn = Instance.new("TextButton", gui)
hkMiniBtn.Size = UDim2.new(0, 60, 0, 30)
hkMiniBtn.Position = UDim2.new(0, 10, 0, 10)
hkMiniBtn.Text = "HK"
hkMiniBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Instance.new("UICorner", hkMiniBtn)
hkMiniBtn.Visible = false

-- TextBox & JumpPower Button
local jumpBox = Instance.new("TextBox", mainFrame)
jumpBox.PlaceholderText = "JumpPower"
jumpBox.Position = UDim2.new(0, 25, 0, 40)
jumpBox.Size = UDim2.new(0, 200, 0, 30)
jumpBox.BackgroundColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", jumpBox)

local jumpBtn = Instance.new("TextButton", mainFrame)
jumpBtn.Text = "Set JumpPower"
jumpBtn.Position = UDim2.new(0, 25, 0, 75)
jumpBtn.Size = UDim2.new(0, 200, 0, 30)
jumpBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Instance.new("UICorner", jumpBtn)

-- TextBox & Speed Button
local speedBox = Instance.new("TextBox", mainFrame)
speedBox.PlaceholderText = "WalkSpeed"
speedBox.Position = UDim2.new(0, 25, 0, 115)
speedBox.Size = UDim2.new(0, 200, 0, 30)
speedBox.BackgroundColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", speedBox)

local speedBtn = Instance.new("TextButton", mainFrame)
speedBtn.Text = "Set Speed"
speedBtn.Position = UDim2.new(0, 25, 0, 150)
speedBtn.Size = UDim2.new(0, 200, 0, 30)
speedBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Instance.new("UICorner", speedBtn)

-- Aimbot Button
local aimbotBtn = Instance.new("TextButton", mainFrame)
aimbotBtn.Text = "Activate Aimbot"
aimbotBtn.Position = UDim2.new(0, 25, 0, 190)
aimbotBtn.Size = UDim2.new(0, 200, 0, 30)
aimbotBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
Instance.new("UICorner", aimbotBtn)

-- Fonksiyonlar
jumpBtn.MouseButton1Click:Connect(function()
	local val = tonumber(jumpBox.Text)
	if val then
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower = val
		end
	end
end)

speedBtn.MouseButton1Click:Connect(function()
	local val = tonumber(speedBox.Text)
	if val then
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = val
		end
	end
end)

aimbotBtn.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
end)

-- GUI Kapatma
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	hkMiniBtn.Visible = false
end)

-- Küçültme / Açma
minimizeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
	hkMiniBtn.Visible = true
end)

hkMiniBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = true
	hkMiniBtn.Visible = false
end)
