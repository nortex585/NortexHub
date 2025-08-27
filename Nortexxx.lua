-- LocalScript (StarterGui içine koy)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Teleport sistemi değişkenleri
local active = false
local folder
for _, obj in pairs(workspace:GetChildren()) do
	if obj:IsA("Folder") and obj:FindFirstChild("ParkourMoney") then
		folder = obj
		break
	end
end

-- Folder içindeki tüm BasePart/MeshPart'ları al
local function getTargetParts()
	local parts = {}
	if folder then
		for _, obj in pairs(folder:GetChildren()) do
			if obj:IsA("BasePart") or obj:IsA("MeshPart") then
				table.insert(parts, obj)
			end
		end
	end
	return parts
end

local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Teleport loop fonksiyonu
local function teleportLoop()
	spawn(function()
		local targetParts = getTargetParts()
		local currentIndex = 1
		while active do
			local targetPart = targetParts[currentIndex]
			if targetPart and targetPart:IsA("BasePart") then
				hrp.CFrame = targetPart.CFrame + Vector3.new(0,3,0)
			end
			currentIndex = currentIndex + 1
			if currentIndex > #targetParts then
				currentIndex = 1
			end
			wait(1)
		end
	end)
end

-- GUI Başlangıcı
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NortexHubGUI"
gui.ResetOnSpawn = false

-- Ana Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,300,0,200)
mainFrame.Position = UDim2.new(0.5,-150,0.5,-100)
mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0,12)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(150,150,150)
mainStroke.Thickness = 2

-- TopBar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,30)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(35,35,35)
topBar.Parent = mainFrame
local topCorner = Instance.new("UICorner", topBar)
topCorner.CornerRadius = UDim.new(0,12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0,150,1,0)
titleLabel.Position = UDim2.new(0,10,0,0)
titleLabel.Text = "Nortex Hub v.001"
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextScaled = true
titleLabel.Parent = topBar

-- Kapat Butonu
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,25,0,25)
closeBtn.Position = UDim2.new(1,-30,0,2)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Parent = topBar
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,6)

closeBtn.MouseButton1Click:Connect(function()
	local tween = TweenService:Create(mainFrame,TweenInfo.new(0.5),{Size=UDim2.new(0,0,0,0)})
	tween:Play()
	tween.Completed:Wait()
	gui:Destroy()
end)

-- Ana İçerik Frame (Ortada)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1,-20,0,100)
contentFrame.Position = UDim2.new(0,10,0,50)
contentFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
contentFrame.Parent = mainFrame
local contentCorner = Instance.new("UICorner", contentFrame)
contentCorner.CornerRadius = UDim.new(0,12)

-- Euro Farm Label
local euroLabel = Instance.new("TextLabel")
euroLabel.Size = UDim2.new(1, -80, 1, 0) -- Toggle buton için sağdan boşluk bırak
euroLabel.Position = UDim2.new(0, 10, 0, 0)
euroLabel.Text = "Euro Farm"
euroLabel.Font = Enum.Font.FredokaOne
euroLabel.TextColor3 = Color3.fromRGB(255,255,255)
euroLabel.BackgroundTransparency = 1
euroLabel.TextScaled = true
euroLabel.TextXAlignment = Enum.TextXAlignment.Left
euroLabel.Parent = contentFrame

-- Toggle Buton
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0,50,0,50)
toggleBtn.Position = UDim2.new(1,-60,0,25)
toggleBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
toggleBtn.Text = ""
toggleBtn.Parent = contentFrame
local toggleCorner = Instance.new("UICorner", toggleBtn)
toggleCorner.CornerRadius = UDim.new(0,12)

local isOn = false
toggleBtn.MouseButton1Click:Connect(function()
	isOn = not isOn
	if isOn then
		toggleBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
		active = true
		teleportLoop()
	else
		toggleBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
		active = false
	end
end)

-- Topbar Sürükleme
local dragging = false
local dragInput, dragStart, startPos

topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

RunService.RenderStepped:Connect(function()
	if dragging and dragInput then
		local delta = dragInput.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
