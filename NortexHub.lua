-- GUI ve Buton Oluştur
local screenGui = Instance.new("ScreenGui")
local button = Instance.new("TextButton")
local uiCorner = Instance.new("UICorner")

screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
button.Parent = screenGui

button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Düşmanları Yok Et!"
button.BackgroundColor3 = Color3.new(0, 0, 0)
button.TextColor3 = Color3.new(1, 1, 1)

uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = button

-- Sürüklenebilir Buton
local dragging = false
local dragInput, mousePos, framePos

local function updateInput(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - mousePos
		button.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
end

button.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		mousePos = input.Position
		framePos = button.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

button.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(updateInput)

-- Düşmanları öldür
local function destroyEnemies()
	for _, enemy in pairs(workspace:GetDescendants()) do
		if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
			local isEnemy = enemy.Name ~= game.Players.LocalPlayer.Name and not game.Players:FindFirstChild(enemy.Name)
			if isEnemy then
				enemy:MoveTo(Vector3.new(0, -500, 0))
				wait(0.2) -- Biraz zaman tanı
				enemy.Humanoid.Health = 0 -- Öldür
				-- Alternatif: enemy:BreakJoints() -- parçala
			end
		end
	end
end

-- Butona tıklanınca çalıştır
button.MouseButton1Click:Connect(destroyEnemies)
