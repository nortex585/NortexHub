-- LocalScript (StarterGui içine koy)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Leaderstats = player:WaitForChild("leaderstats")
local EuroStat = Leaderstats:WaitForChild("EURO") -- Leaderstats içindeki EURO

-- Teleport sistemi
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
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
mainFrame.Parent = gui

local mainUICorner = Instance.new("UICorner", mainFrame)
mainUICorner.CornerRadius = UDim.new(0,12)

-- TopBar
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1,0,0,40)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
topBar.Parent = mainFrame

local topUICorner = Instance.new("UICorner", topBar)
topUICorner.CornerRadius = UDim.new(0,12)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0,120,1,0)
titleLabel.Position = UDim2.new(0,10,0,0)
titleLabel.Text = "Nortex Hub"
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.BackgroundTransparency = 1
titleLabel.TextScaled = true
titleLabel.Parent = topBar

-- EURO Leaderstats
local euroLabel = Instance.new("TextLabel")
euroLabel.Size = UDim2.new(0,120,1,0)
euroLabel.Position = UDim2.new(0.5,-60,0,0)
euroLabel.BackgroundTransparency = 1
euroLabel.Font = Enum.Font.FredokaOne
euroLabel.TextColor3 = Color3.fromRGB(255,255,255)
euroLabel.TextScaled = true
euroLabel.Text = "EURO: "..EuroStat.Value
euroLabel.Parent = topBar

-- Leaderstats güncellemesi
EuroStat.Changed:Connect(function(val)
	euroLabel.Text = "EURO: "..val
end)

-- Kapat ve Minimize butonları
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
closeBtn.Parent = topBar
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,6)

local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0,30,0,30)
minBtn.Position = UDim2.new(1,-70,0,5)
minBtn.Text = "_"
minBtn.Font = Enum.Font.FredokaOne
minBtn.TextColor3 = Color3.fromRGB(255,255,255)
minBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
minBtn.Parent = topBar
local minCorner = Instance.new("UICorner", minBtn)
minCorner.CornerRadius = UDim.new(0,6)

-- Ana içerik frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20,1,-60)
contentFrame.Position = UDim2.new(0,10,0,50)
contentFrame.BackgroundColor3 = Color3.fromRGB(35,35,35)
contentFrame.Parent = mainFrame
local contentCorner = Instance.new("UICorner", contentFrame)
contentCorner.CornerRadius = UDim.new(0,12)

-- Profil üst frame
local profileFrame = Instance.new("Frame")
profileFrame.Size = UDim2.new(1, -20,0,150)
profileFrame.Position = UDim2.new(0,10,0,10)
profileFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
profileFrame.Parent = contentFrame
local profCorner = Instance.new("UICorner", profileFrame)
profCorner.CornerRadius = UDim.new(0,12)

-- Profil Image
local profileImage = Instance.new("ImageLabel")
profileImage.Size = UDim2.new(0,100,0,100)
profileImage.Position = UDim2.new(0.5,-50,0,20)
profileImage.Image = player.UserId and "rbxthumb://type=AvatarHeadShot&id="..player.UserId.."&w=420&h=420"
profileImage.BackgroundTransparency = 1
profileImage.Parent = profileFrame

-- Alt Label (Oyuncu ismi)
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1,0,0,30)
nameLabel.Position = UDim2.new(0,0,0,125)
nameLabel.Text = player.Name
nameLabel.Font = Enum.Font.FredokaOne
nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
nameLabel.BackgroundTransparency = 1
nameLabel.Parent = profileFrame

-- Euro Farm Frame
local euroFrame = Instance.new("Frame")
euroFrame.Size = UDim2.new(1,-20,0,60)
euroFrame.Position = UDim2.new(0,10,0,170)
euroFrame.BackgroundColor3 = Color3.fromRGB(60,60,60)
euroFrame.Parent = contentFrame
local euroCorner = Instance.new("UICorner", euroFrame)
euroCorner.CornerRadius = UDim.new(0,12)

-- Sol Label
local euroText = Instance.new("TextLabel")
euroText.Size = UDim2.new(0,150,1,0)
euroText.Position = UDim2.new(0,0,0,0)
euroText.Text = "Euro Farm"
euroText.Font = Enum.Font.FredokaOne
euroText.TextColor3 = Color3.fromRGB(255,255,255)
euroText.BackgroundTransparency = 1
euroText.Parent = euroFrame

-- Sağ Toggle Buton
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0,50,0,50)
toggleBtn.Position = UDim2.new(1,-60,0,5)
toggleBtn.Text = ""
toggleBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
toggleBtn.Parent = euroFrame
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

-- Kapat ve Minimize Animasyonları
closeBtn.MouseButton1Click:Connect(function()
	local tween = TweenService:Create(mainFrame, TweenInfo.new(0.5), {Size=UDim2.new(0,0,0,0)})
	tween:Play()
	tween.Completed:Wait()
	gui:Destroy()
end)

minBtn.MouseButton1Click:Connect(function()
	local tween = TweenService:Create(contentFrame, TweenInfo.new(0.5), {Size=UDim2.new(1,-20,0,0)})
	tween:Play()
end)
