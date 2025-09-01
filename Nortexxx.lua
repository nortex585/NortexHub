--// Rael Hub GUI - LocalScript (Siyah Tema)
--// StarterGui içine koyabilirsin

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RaelHub"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Ana Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 350)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- siyah
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Başlık
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Nortex Hub | Türk Sohbet V.0.3"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

-- Kapatma butonu
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundTransparency = 1
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- Minimize butonu
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -70, 0, 5)
minimizeBtn.Text = "-"
minimizeBtn.TextSize = 28
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Parent = mainFrame

-- İçerik frame
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -20, 1, -50)
contentFrame.Position = UDim2.new(0,10,0,50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Minimize sistemi
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		contentFrame.Visible = false
		mainFrame.Size = UDim2.new(0, 600, 0, 40)
		minimizeBtn.Text = "+"
	else
		contentFrame.Visible = true
		mainFrame.Size = UDim2.new(0, 600, 0, 350)
		minimizeBtn.Text = "-"
	end
end)

-- Sol Menü
local menuFrame = Instance.new("ScrollingFrame")
menuFrame.Size = UDim2.new(0, 160, 1, 0)
menuFrame.Position = UDim2.new(0, 0, 0, 0)
menuFrame.BackgroundTransparency = 1
menuFrame.Parent = contentFrame
menuFrame.ScrollBarThickness = 6
menuFrame.CanvasSize = UDim2.new(0,0,2,0)

local UIListLayout = Instance.new("UIListLayout", menuFrame)
UIListLayout.Padding = UDim.new(0, 5)

local pages = {}
local menuButtons = {"Home","Main","Teleport","Player","Ayar"}
local rightFrame = Instance.new("Frame")
rightFrame.Size = UDim2.new(1, -170, 1, 0)
rightFrame.Position = UDim2.new(0, 170, 0, 0)
rightFrame.BackgroundTransparency = 1
rightFrame.Parent = contentFrame

local function createPage(name)
	local page = Instance.new("Frame")
	page.Size = UDim2.new(1,0,1,0)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Name = name
	page.Parent = rightFrame
	return page
end

for _,name in ipairs(menuButtons) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.9, 0, 0, 30)
	btn.BackgroundColor3 = Color3.fromRGB(35,35,35) -- koyu gri
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.Parent = menuFrame
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	local page = createPage(name)
	pages[name] = page

	btn.MouseButton1Click:Connect(function()
		for _,p in pairs(pages) do p.Visible = false end
		page.Visible = true
	end)
end

-- Home Page
local homeScroll = Instance.new("ScrollingFrame")
homeScroll.Size = UDim2.new(1,0,1,0)
homeScroll.ScrollBarThickness = 6
homeScroll.BackgroundTransparency = 1
homeScroll.Parent = pages["Home"]

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0,20)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = homeScroll

local homeFrame = Instance.new("Frame")
homeFrame.Size = UDim2.new(0.8,0,0,180)
homeFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
homeFrame.Parent = homeScroll
Instance.new("UICorner", homeFrame).CornerRadius = UDim.new(0,15)

local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,100,0,100)
logo.Position = UDim2.new(0.5,0,0,-10)
logo.AnchorPoint = Vector2.new(0.5,0)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://16584754883"
logo.Parent = homeFrame

local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(0.6,0,0,40)
discordButton.Position = UDim2.new(0.5,0,1,-30)
discordButton.AnchorPoint = Vector2.new(0.5,1)
discordButton.Text = "Discord Link"
discordButton.Font = Enum.Font.GothamBold
discordButton.TextSize = 18
discordButton.TextColor3 = Color3.fromRGB(255,255,255)
discordButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
discordButton.Parent = homeFrame
Instance.new("UICorner", discordButton).CornerRadius = UDim.new(0,12)

discordButton.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/YOURDISCORDLINK")
	print("Discord linki kopyalandı! ✅")
end)

-- Main Page
local TweenService = game:GetService("TweenService")

-- FARM SYSTEM DEĞİŞKENLERİ
local euroFarmActive = false
local parkourFarmActive = false

-- EuroFarm için hedef bulma
local euroFolder
for _, obj in pairs(workspace:GetChildren()) do
	if obj:IsA("Folder") and obj:FindFirstChild("ParkourMoney") then
		euroFolder = obj
		break
	end
end

local function getTargetParts(folder)
	local parts = {}
	if folder then
		for _, obj in pairs(folder:GetChildren()) do
			if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.CanCollide then
				table.insert(parts, obj)
			end
		end
	end
	return parts
end

-- EuroFarm loop
local function euroFarmLoop()
	spawn(function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local hrp = character:WaitForChild("HumanoidRootPart")
		local currentIndex = 1

		while euroFarmActive do
			local targets = getTargetParts(euroFolder)
			if #targets > 0 then
				local targetPart = targets[currentIndex]
				if targetPart then
					hrp.CFrame = targetPart.CFrame + Vector3.new(0,10,0)
					local tween = TweenService:Create(
						hrp,
						TweenInfo.new(1, Enum.EasingStyle.Linear),
						{CFrame = targetPart.CFrame + Vector3.new(0,3,0)}
					)
					tween:Play()
					tween.Completed:Wait()
				end
				currentIndex += 1
				if currentIndex > #targets then
					currentIndex = 1
				end
			end
			task.wait(3)
		end
	end)
end

-- ParkourMoney Farm loop (benzer)
local function parkourFarmLoop()
	spawn(function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local hrp = character:WaitForChild("HumanoidRootPart")

		while parkourFarmActive do
			-- Buraya ParkourMoney farm için teleport / hareket kodunu yaz
			print("ParkourMoney Farm Çalışıyor ✅")
			task.wait(2)
		end
	end)
end


-- SWITCH CARD SİSTEMİ
local nextY = 30
local cardSpacing = 80

local function createSwitchCard(parent, titleText, descText, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0.9,0,0,45)
	frame.Position = UDim2.new(0,15,0,nextY)
	frame.BackgroundColor3 = Color3.fromRGB(20,100,60)
	frame.Parent = parent
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

	nextY = nextY + cardSpacing

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1,0,0,20)
	title.Position = UDim2.new(0,5,0,-22)
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Parent = frame

	local desc = Instance.new("TextLabel")
	desc.Size = UDim2.new(0.6,0,0,20)
	desc.AnchorPoint = Vector2.new(0,0.5)
	desc.Position = UDim2.new(0,10,0.5,0)
	desc.Text = descText
	desc.TextColor3 = Color3.fromRGB(200,200,200)
	desc.Font = Enum.Font.Gotham
	desc.TextSize = 13
	desc.TextXAlignment = Enum.TextXAlignment.Left
	desc.BackgroundTransparency = 1
	desc.Parent = frame

	local switchBack = Instance.new("Frame")
	switchBack.Size = UDim2.new(0,55,0,22)
	switchBack.AnchorPoint = Vector2.new(1,0.5)
	switchBack.Position = UDim2.new(1,-15,0.5,0)
	switchBack.BackgroundColor3 = Color3.fromRGB(80,80,80)
	switchBack.Parent = frame
	Instance.new("UICorner", switchBack).CornerRadius = UDim.new(0,12)

	local knob = Instance.new("Frame")
	knob.Size = UDim2.new(0,20,0,20)
	knob.Position = UDim2.new(0,1,0,1)
	knob.BackgroundColor3 = Color3.fromRGB(220,220,220)
	knob.Parent = switchBack
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

	local switchOn = false
	switchBack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			switchOn = not switchOn
			if switchOn then
				knob:TweenPosition(UDim2.new(1,-21,0,1),"Out","Quad",0.2,true)
				switchBack.BackgroundColor3 = Color3.fromRGB(0,200,100)
				print(titleText.." AÇILDI ✅")
				if callback then callback(true) end
			else
				knob:TweenPosition(UDim2.new(0,1,0,1),"Out","Quad",0.2,true)
				switchBack.BackgroundColor3 = Color3.fromRGB(80,80,80)
				print(titleText.." KAPANDI ❌")
				if callback then callback(false) end
			end
		end
	end)
end


-- MAIN SAYFASINA EKLE
nextY = 30
createSwitchCard(pages["Main"], "Euro Farm", "Otomatik Euro toplama", function(state)
	euroFarmActive = state
	if state then
		euroFarmLoop()
	end
end)

createSwitchCard(pages["Main"], "ParkourMoney Farm", "Otomatik para farm", function(state)
	parkourFarmActive = state
	if state then
		parkourFarmLoop()
	end
end)


-- Teleport Page
-- TELEPORT PAGE SCROLLINGFRAME
local teleportScroll = Instance.new("ScrollingFrame")
teleportScroll.Size = UDim2.new(1,0,1,0)
teleportScroll.CanvasSize = UDim2.new(0,0,2,0)
teleportScroll.ScrollBarThickness = 6
teleportScroll.BackgroundTransparency = 1
teleportScroll.Parent = pages["Teleport"]

local nextY = 20
local cardSpacing = 70

local function createTeleportCard(parent, titleText, onClick)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0.9,0,0,45)
	frame.Position = UDim2.new(0,15,0,nextY)
	frame.BackgroundColor3 = Color3.fromRGB(20,100,60)
	frame.Parent = parent
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)

	nextY = nextY + cardSpacing

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(0.7,0,1,0)
	title.Position = UDim2.new(0,10,0,0)
	title.Text = titleText
	title.TextColor3 = Color3.fromRGB(255,255,255)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 18
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Parent = frame

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0,40,0,40)
	button.AnchorPoint = Vector2.new(1,0.5)
	button.Position = UDim2.new(1,-10,0.5,0)
	button.Text = ">"
	button.TextColor3 = Color3.fromRGB(255,255,255)
	button.Font = Enum.Font.FredokaOne
	button.TextSize = 20
	button.BackgroundColor3 = Color3.fromRGB(20,100,60)
	button.Parent = frame
	Instance.new("UICorner", button).CornerRadius = UDim.new(1,0)

	button.MouseButton1Click:Connect(function()
		if onClick then onClick() end
	end)
end


-- TELEPORT KARTLARI
createTeleportCard(teleportScroll, "HalıSaha", function()
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	local target = workspace:FindFirstChild("FutbolGerekli")
	if target and target:FindFirstChild("TopSpawner") then
		hrp.CFrame = target.TopSpawner.CFrame + Vector3.new(0,3,0)
	end
end)

createTeleportCard(teleportScroll, "Market", function()
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	local target = workspace:FindFirstChild("Shopblock2")
	if target then
		hrp.CFrame = target.CFrame + Vector3.new(0,3,0)
	end
end)

createTeleportCard(teleportScroll, "Spawn", function()
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	local target = workspace:FindFirstChild("Spawn")
	if target and target:FindFirstChild("SpawnLocation") then
		hrp.CFrame = target.SpawnLocation.CFrame + Vector3.new(0,3,0)
	end
end)


-- Ayar Page
local ayarText = Instance.new("TextLabel")
ayarText.Size = UDim2.new(1,0,1,0)
ayarText.Text = "Ayar Page"
ayarText.TextColor3 = Color3.fromRGB(255,255,255)
ayarText.Font = Enum.Font.GothamBold
ayarText.TextSize = 24
ayarText.BackgroundTransparency = 1
ayarText.Parent = pages["Ayar"]

-- Player Page
local humanoid = player.Character:WaitForChild("Humanoid")
local speedValue = 25
local enableSpeed = false
local dragging = false
local jumpPower = 50

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1,0,0,30)
speedLabel.Text = "Player speed"
speedLabel.TextColor3 = Color3.fromRGB(255,255,255)
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 18
speedLabel.BackgroundTransparency = 1
speedLabel.Parent = pages["Player"]

local sliderBack = Instance.new("Frame")
sliderBack.Size = UDim2.new(0.8,0,0,20)
sliderBack.Position = UDim2.new(0,10,0,40)
sliderBack.BackgroundColor3 = Color3.fromRGB(20,100,60)
sliderBack.Parent = pages["Player"]
Instance.new("UICorner", sliderBack).CornerRadius = UDim.new(0,10)

local sliderBtn = Instance.new("TextButton")
sliderBtn.Size = UDim2.new(0,15,1,0)
sliderBtn.Position = UDim2.new(speedValue/100, -5, 0, 0)
sliderBtn.BackgroundColor3 = Color3.fromRGB(0,255,120)
sliderBtn.Text = ""
sliderBtn.Parent = sliderBack
Instance.new("UICorner", sliderBtn).CornerRadius = UDim.new(1,0)

local valueText = Instance.new("TextLabel")
valueText.Size = UDim2.new(0,50,0,20)
valueText.Position = UDim2.new(1,5,0,0)
valueText.Text = tostring(speedValue)
valueText.TextColor3 = Color3.fromRGB(255,255,255)
valueText.Font = Enum.Font.Gotham
valueText.TextSize = 14
valueText.BackgroundTransparency = 1
valueText.Parent = sliderBack

sliderBtn.MouseButton1Down:Connect(function() dragging = "speed" end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
	if dragging == "speed" and input.UserInputType == Enum.UserInputType.MouseMovement then
		local relX = math.clamp((input.Position.X - sliderBack.AbsolutePosition.X) / sliderBack.AbsoluteSize.X, 0, 1)
		sliderBtn.Position = UDim2.new(relX, -5, 0, 0)
		speedValue = math.floor(relX*100)
		valueText.Text = tostring(speedValue)
		if enableSpeed then humanoid.WalkSpeed = speedValue end
	end
end)

local switchBack = Instance.new("Frame")
switchBack.Size = UDim2.new(0,60,0,25)
switchBack.Position = UDim2.new(0,10,0,80)
switchBack.BackgroundColor3 = Color3.fromRGB(80,80,80)
switchBack.Parent = pages["Player"]
Instance.new("UICorner", switchBack).CornerRadius = UDim.new(0,15)

local knob = Instance.new("Frame")
knob.Size = UDim2.new(0,23,0,23)
knob.Position = UDim2.new(0,1,0,1)
knob.BackgroundColor3 = Color3.fromRGB(200,200,200)
knob.Parent = switchBack
Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

local switchOn = false
switchBack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		switchOn = not switchOn
		if switchOn then
			knob:TweenPosition(UDim2.new(1,-24,0,1),"Out","Quad",0.2,true)
			switchBack.BackgroundColor3 = Color3.fromRGB(0,200,100)
			enableSpeed = true
			humanoid.WalkSpeed = speedValue
		else
			knob:TweenPosition(UDim2.new(0,1,0,1),"Out","Quad",0.2,true)
			switchBack.BackgroundColor3 = Color3.fromRGB(80,80,80)
			enableSpeed = false
			humanoid.WalkSpeed = 16
		end
	end
end)

local jumpLabel = Instance.new("TextLabel")
jumpLabel.Size = UDim2.new(1,0,0,30)
jumpLabel.Position = UDim2.new(0,0,0,120)
jumpLabel.Text = "Player jump power"
jumpLabel.TextColor3 = Color3.fromRGB(255,255,255)
jumpLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpLabel.Font = Enum.Font.GothamBold
jumpLabel.TextSize = 18
jumpLabel.BackgroundTransparency = 1
jumpLabel.Parent = pages["Player"]

local jumpBack = sliderBack:Clone()
jumpBack.Position = UDim2.new(0,10,0,160)
jumpBack.Parent = pages["Player"]
local jumpBtn = jumpBack:FindFirstChildWhichIsA("TextButton")
local jumpValueText = jumpBack:FindFirstChildWhichIsA("TextLabel")
jumpValueText.Text = tostring(jumpPower)

jumpBtn.MouseButton1Down:Connect(function() dragging = "jump" end)
UserInputService.InputChanged:Connect(function(input)
	if dragging == "jump" and input.UserInputType == Enum.UserInputType.MouseMovement then
		local relX = math.clamp((input.Position.X - jumpBack.AbsolutePosition.X) / jumpBack.AbsoluteSize.X, 0, 1)
		jumpBtn.Position = UDim2.new(relX, -5, 0, 0)
		jumpPower = math.floor(relX*200)
		jumpValueText.Text = tostring(jumpPower)
		humanoid.JumpPower = jumpPower
	end
end)
UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging=="jump" then dragging = false end
end)


-- Başlangıç sayfası
pages["Home"].Visible = true

-- Ana Frame'i biraz sola kaydır
mainFrame.Position = UDim2.new(0.4, -300, 0.5, -175) -- eskisine göre sola alındı

-- Ana Frame Toggle Butonu
local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0,40,0,40)
toggleButton.Position = UDim2.new(0,20,0.5,-20) -- ekranın soluna yakın
toggleButton.BackgroundColor3 = Color3.fromRGB(30,30,30) -- koyu gri arka plan
toggleButton.Image = "rbxassetid://92268113133841" -- kendi icon ID'ni gir
toggleButton.Parent = screenGui

-- Köşeleri yuvarlatma (cornerui)
local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(1, 0) -- tam yuvarlak köşe (dairesel buton gibi)

-- Toggle sistemi
toggleButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Toggle butonu sürüklenebilir
local draggingToggle = false
local dragInputToggle, dragStartToggle, startPosToggle

toggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingToggle = true
		dragStartToggle = input.Position
		startPosToggle = toggleButton.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				draggingToggle = false
			end
		end)
	end
end)

toggleButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInputToggle = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInputToggle and draggingToggle then
		local delta = input.Position - dragStartToggle
		toggleButton.Position = UDim2.new(
			startPosToggle.X.Scale,
			startPosToggle.X.Offset + delta.X,
			startPosToggle.Y.Scale,
			startPosToggle.Y.Offset + delta.Y
		)
	end
end)
