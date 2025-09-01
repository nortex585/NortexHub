local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "GoalSoundGui"
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 120)
frame.Position = UDim2.new(0.5, -150, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- TextBox
local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0, 260, 0, 40)
textBox.Position = UDim2.new(0, 20, 0, 10)
textBox.PlaceholderText = "Müzik ID'si gir..."
textBox.ClearTextOnFocus = false
textBox.TextColor3 = Color3.fromRGB(255,255,255)
textBox.BackgroundColor3 = Color3.fromRGB(30,30,30)
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,8)
textBox.TextSize = 18
textBox.Font = Enum.Font.GothamBold

-- Buton
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0, 260, 0, 50)
button.Position = UDim2.new(0, 20, 0, 60)
button.Text = "Çal"
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.TextColor3 = Color3.fromRGB(255,255,255)
button.BackgroundColor3 = Color3.fromRGB(0,150,255)
Instance.new("UICorner", button).CornerRadius = UDim.new(0,10)

-- Buton işlevi
button.MouseButton1Click:Connect(function()
	local id = textBox.Text
	if id ~= "" then
		local folder = workspace:FindFirstChild("FutbolGerekli")
		if folder then
			local manager = folder:FindFirstChild("FutbolManager")
			if manager then
				local goalSound = manager:FindFirstChild("Goal")
				if goalSound and goalSound:IsA("Sound") then
					goalSound.SoundId = "rbxassetid://"..id
					goalSound.Volume = 100
					goalSound:Play()
				else
					warn("Goal adlı Sound bulunamadı!")
				end
			else
				warn("FutbolManager bulunamadı!")
			end
		else
			warn("FutbolGerekli folder bulunamadı!")
		end
	end
end)
