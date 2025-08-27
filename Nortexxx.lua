-- LocalScript (StarterGui içine koy)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Teleport sistemi değişkenleri
local active = false
local targetNames = {
	"053d059b00b8471abe331339c0ef91",
	"06831f59464b4f77b607fba6a3f2d97a6032d35c6c39487",
	"0684a25f519c48f3959e487cd83f2fea8757ab66aa8f4",
	"08b5bb10f1ad413aad05df78a36e0d8359",
	"0e9b2bb7994349a0bcdae011b7cf877303",
	"11665ff9b88b475fbd3d10655fabd113ab7",
	"1d59be42bc5f4389a6b3e7f368eb65",
	"252cd6bf11ba488dab5f04ee79284a72c288806cc5d",
	"418e9b2314444f3a88fcb09b43df975f0e8",
	"463fce05de8e43ddb0cf9ce1e8d60a7284f928b04a03463cb4",
	"4b6fdd34d9954d3eb348f0e3cc1a38820f",
	"4f55cc9371284704b1a7e54ffdc1e35d542bad4ae5284",
	"536f28bf9fca41ffad06f071e5f5a7bf0577ec",
	"6a2b0e583bc841aeaa58e6916163f067387e3f029a",
	"6d905677560e4260bdaeeade739683900dbb2523cbba4",
	"7360bcc48b7f4bdda15c1a0434616070bbebd0c9",
	"74c6c68e347444adb389c19100f5a329105185d3",
	"78c40717eeac4140828bbd20dc8406abd0e399ed5ad74af08",
	"7c03cba239154a31bc62fcd3ed8792f3845d3b48",
	"7e490be647124e728daf5cc13a37243acd269f70d9",
	"8436e8a271ea4dad96b72cdc6f5da7b2be8",
	"90f8068e7f7f474b8e40db4136db0684ce39cd2d60f",
	"9635fe8d6e594831a84b009c217ab0d3e0bceb3850f143",
	"9b75ebd786774f72898fb26bbbd55aa4032666d2a",
	"9c81667a145548c5a098b15e042a32b0e63aee260db04c",
}
local folder
for _, obj in pairs(workspace:GetChildren()) do
	if obj:IsA("Folder") and obj:FindFirstChild("ParkourMoney") then
		folder = obj
		break
	end
end
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local function teleportLoop()
	spawn(function()
		local currentIndex = 1
		while active do
			local targetName = targetNames[currentIndex]
			local targetPart
			for _, obj in pairs(folder:GetChildren()) do
				if obj.Name == targetName then
					targetPart = obj
					break
				end
			end
			if targetPart and targetPart:IsA("BasePart") then
				hrp.CFrame = targetPart.CFrame + Vector3.new(0,3,0)
			end
			currentIndex = currentIndex +1
			if currentIndex>#targetNames then currentIndex=1 end
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

-- Kapat ve Minimize
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,25,0,25)
closeBtn.Position = UDim2.new(1,-30,0,2)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.Parent = topBar
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,6)



-- Ana İçerik Frame (Ortada)
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1,-20,0,100)
contentFrame.Position = UDim2.new(0,10,0,50)
contentFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
contentFrame.Parent = mainFrame
local contentCorner = Instance.new("UICorner", contentFrame)
contentCorner.CornerRadius = UDim.new(0,12)

-- Euro Farm Label
-- Minimize butonu kaldırıldı, önceki minBtn kısmını silebilirsin

-- Euro Farm Label
-- Euro Farm Label
local euroLabel = Instance.new("TextLabel")
euroLabel.Size = UDim2.new(1, -80, 1, 0) -- Toggle buton için sağdan boşluk bırakıyoruz
euroLabel.Position = UDim2.new(0, 10, 0, 0)
euroLabel.Text = "Euro Farm"
euroLabel.Font = Enum.Font.FredokaOne
euroLabel.TextColor3 = Color3.fromRGB(255,255,255)
euroLabel.BackgroundTransparency = 1
euroLabel.TextScaled = true -- Tam alana sığdır
euroLabel.TextXAlignment = Enum.TextXAlignment.Left -- Solda hizala
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

-- Kapat ve Minimize Fonksiyonları
closeBtn.MouseButton1Click:Connect(function()
	local tween = TweenService:Create(mainFrame,TweenInfo.new(0.5),{Size=UDim2.new(0,0,0,0)})
	tween:Play()
	tween.Completed:Wait()
	gui:Destroy()
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
