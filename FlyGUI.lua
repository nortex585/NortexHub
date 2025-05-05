-- Made for Roblox, works as a local script

-- GUI Oluştur
local gui = Instance.new("ScreenGui")
gui.Name = "FlyGui"
gui.ResetOnSpawn = false
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Ana çerçeve
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- UICorner: Yumuşak köşeler
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 10)
frameCorner.Parent = frame

-- Başlık
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "Fly GUI"
title.TextColor3 = Color3.new(1, 1, 1)
title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = title

-- Kapatma Butonu
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.new(1, 0.3, 0.3)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame

local closeUICorner = Instance.new("UICorner")
closeUICorner.CornerRadius = UDim.new(0, 8)
closeUICorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Hız kutusu
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(1, -20, 0, 30)
speedBox.Position = UDim2.new(0, 10, 0, 40)
speedBox.PlaceholderText = "Hız gir (sayı)"
speedBox.Text = ""
speedBox.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
speedBox.TextColor3 = Color3.new(1,1,1)
speedBox.Parent = frame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 10)
boxCorner.Parent = speedBox

-- Uç Butonu
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0.4, 0, 0, 30)
flyBtn.Position = UDim2.new(0.05, 0, 0, 80)
flyBtn.Text = "Uç"
flyBtn.BackgroundColor3 = Color3.new(0, 1, 0)
flyBtn.TextColor3 = Color3.new(0,0,0)
flyBtn.Parent = frame

local flyBtnCorner = Instance.new("UICorner")
flyBtnCorner.CornerRadius = UDim.new(0, 10)
flyBtnCorner.Parent = flyBtn

-- Bırak Butonu
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(0.4, 0, 0, 30)
stopBtn.Position = UDim2.new(0.55, 0, 0, 80)
stopBtn.Text = "Bırak"
stopBtn.BackgroundColor3 = Color3.new(1, 0, 0)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Parent = frame

local stopBtnCorner = Instance.new("UICorner")
stopBtnCorner.CornerRadius = UDim.new(0, 10)
stopBtnCorner.Parent = stopBtn

-- Uçma Scripti
local flying = false
local flySpeed = 50
local uis = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local velocity = Instance.new("BodyVelocity")
velocity.Velocity = Vector3.zero
velocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
velocity.P = 1250

local function startFlying()
	if not flying then
		flying = true
		velocity = Instance.new("BodyVelocity")
		velocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
		velocity.P = 1250
		velocity.Velocity = Vector3.zero
		velocity.Parent = rootPart
	end
end

local function stopFlying()
	flying = false
	if velocity and velocity.Parent then
		velocity:Destroy()
	end
end

-- Input ile uçma yönü
game:GetService("RunService").RenderStepped:Connect(function()
	if flying and velocity and velocity.Parent then
		local dir = Vector3.zero
		if uis:IsKeyDown(Enum.KeyCode.W) then dir = dir + workspace.CurrentCamera.CFrame.LookVector end
		if uis:IsKeyDown(Enum.KeyCode.S) then dir = dir - workspace.CurrentCamera.CFrame.LookVector end
		if uis:IsKeyDown(Enum.KeyCode.A) then dir = dir - workspace.CurrentCamera.CFrame.RightVector end
		if uis:IsKeyDown(Enum.KeyCode.D) then dir = dir + workspace.CurrentCamera.CFrame.RightVector end
		if uis:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0,1,0) end
		if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir = dir - Vector3.new(0,1,0) end

		if dir.Magnitude > 0 then
			velocity.Velocity = dir.Unit * flySpeed
		else
			velocity.Velocity = Vector3.zero
		end
	end
end)

-- Butonlar
flyBtn.MouseButton1Click:Connect(function()
	local num = tonumber(speedBox.Text)
	if num then
		flySpeed = num
	end
	startFlying()
end)

stopBtn.MouseButton1Click:Connect(function()
	stopFlying()
end)
