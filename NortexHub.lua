-- GUI Oluştur
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "HKGui"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- Ana Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.05, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame)

-- Üst Bar
local topBar = Instance.new("TextLabel")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.Text = "HK MOD PANEL"
topBar.TextColor3 = Color3.new(1, 1, 1)
topBar.Font = Enum.Font.SourceSansBold
topBar.TextSize = 14
topBar.Parent = frame
Instance.new("UICorner", topBar)

-- Kapat Butonu
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -60, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn)

-- Küçültme Butonu
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Text = "_"
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -30, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minimizeBtn.Parent = frame
Instance.new("UICorner", minimizeBtn)

-- Anahtar Butonu
local toggleBtn = Instance.new("TextButton")
toggleBtn.Text = "OFF"
toggleBtn.Size = UDim2.new(0, 100, 0, 40)
toggleBtn.Position = UDim2.new(0.5, -50, 0.5, -20)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
toggleBtn.Parent = frame
Instance.new("UICorner", toggleBtn)

-- Türk Bayrağı
local flag = Instance.new("ImageLabel")
flag.Size = UDim2.new(0, 40, 0, 25)
flag.Position = UDim2.new(0, 5, 1, -30)
flag.Image = "rbxassetid://7229874622"
flag.BackgroundTransparency = 1
flag.Parent = frame

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

-- Anahtar ON/OFF
local toggle = false
local aimbotThread

local function startBehavior()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V3/main/src/Aimbot.lua"))()
	while toggle do
		if humanoid then
			humanoid.Jump = true
			humanoid.WalkSpeed = math.random(30, 70)
		end
		wait(0.4)
	end
end

toggleBtn.MouseButton1Click:Connect(function()
	toggle = not toggle
	toggleBtn.Text = toggle and "ON" or "OFF"
	if toggle then
		aimbotThread = task.spawn(startBehavior)
	else
		if aimbotThread then
			coroutine.close(aimbotThread)
			aimbotThread = nil
		end
		local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local humanoid = char:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = 16
		end
	end
end)
