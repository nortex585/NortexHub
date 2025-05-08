local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "HKGui"
gui.ResetOnSpawn = false

-- Ana Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame)

-- Üst Bar
local topBar = Instance.new("TextLabel", frame)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.Text = "HK MOD PANEL"
topBar.TextColor3 = Color3.new(1, 1, 1)
topBar.Font = Enum.Font.SourceSansBold
topBar.TextSize = 14
topBar.Name = "TopBar"
Instance.new("UICorner", topBar)

-- Kapat Butonu
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -60, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", closeBtn)

-- Küçültme Butonu
local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Text = "_"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -30, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", minimizeBtn)

-- Anahtar Butonu
local toggle = false
local toggleBtn = Instance.new("TextButton", frame)
toggleBtn.Text = "OFF"
toggleBtn.Size = UDim2.new(0, 100, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -50, 0.5, -20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Instance.new("UICorner", toggleBtn)

-- Türk Bayrağı
local flag = Instance.new("ImageLabel", frame)
flag.Size = UDim2.new(0, 40, 0, 25)
flag.Position = UDim2.new(0, 5, 1, -30)
flag.Image = "rbxassetid://7229874622" -- Türk bayrağı asset ID (güncel)
flag.BackgroundTransparency = 1

-- Sekme Gizleme Fonksiyonu
local isMinimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	if not isMinimized then
		for _, obj in pairs(frame:GetChildren()) do
			if obj ~= topBar and obj ~= closeBtn and obj ~= minimizeBtn then
				obj.Visible = false
			end
		end
		frame.Size = UDim2.new(0, 300, 0, 30)
		minimizeBtn.Text = "+"
		isMinimized = true
	else
		for _, obj in pairs(frame:GetChildren()) do
			obj.Visible = true
		end
		frame.Size = UDim2.new(0, 300, 0, 200)
		minimizeBtn.Text = "_"
		isMinimized = false
	end
end)

-- GUI'yi Kapatma
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ON/OFF Fonksiyonu
local function randomJumpAndShoot()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	while toggle do
		if humanoid then
			humanoid.Jump = true
			humanoid.WalkSpeed = math.random(25, 60)
		end
		wait(0.5)
	end
end

-- Aimbot (örnek sistem)
local function simpleAimbot()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			-- Niye hedef alır gibi örnek sistem
			print("Aiming at", plr.Name)
		end
	end
end

toggleBtn.MouseButton1Click:Connect(function()
	toggle = not toggle
	toggleBtn.Text = toggle and "ON" or "OFF"
	if toggle then
		task.spawn(randomJumpAndShoot)
		task.spawn(simpleAimbot)
	end
end)
