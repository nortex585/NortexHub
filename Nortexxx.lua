-- LocalScript (StarterGui içine koy)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "NortexHub"
gui.ResetOnSpawn = false

-- Ana Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 600, 0, 360)
frame.Position = UDim2.new(0.5, -300, 0.5, -180)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 1.2
stroke.Color = Color3.fromRGB(50, 50, 50)

-- Üst Bar
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.BorderSizePixel = 0
local strokeTop = Instance.new("UIStroke", topBar)
strokeTop.Thickness = 1
strokeTop.Color = Color3.fromRGB(50, 50, 50)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Nortex Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.Font = Enum.Font.FredokaOne
title.TextXAlignment = Enum.TextXAlignment.Left

-- Butonlar Altında Arka Plan Frame
local btnBackground = Instance.new("Frame", topBar)
btnBackground.Size = UDim2.new(0, 70, 0, 35)
btnBackground.Position = UDim2.new(1, -75, 0, 0)
btnBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
btnBackground.BorderSizePixel = 0

local cornerBG = Instance.new("UICorner", btnBackground)
cornerBG.CornerRadius = UDim.new(0, 6)

local strokeBG = Instance.new("UIStroke", btnBackground)
strokeBG.Thickness = 1
strokeBG.Color = Color3.fromRGB(50, 50, 50)

-- Ortadan Çizgi
local midLine = Instance.new("Frame", btnBackground)
midLine.Size = UDim2.new(0, 1, 1, 0)
midLine.Position = UDim2.new(0.5, -0.5, 0, 0)
midLine.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
midLine.BorderSizePixel = 0

-- Kapatma & Minimize Butonları Frame içine
local closeBtn = Instance.new("TextButton", btnBackground)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(0.5, 3, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.FredokaOne
closeBtn.TextScaled = true

local miniBtn = Instance.new("TextButton", btnBackground)
miniBtn.Size = UDim2.new(0, 25, 0, 25)
miniBtn.Position = UDim2.new(0.5, -33, 0, 5)
miniBtn.Text = "-"
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.BackgroundTransparency = 1
miniBtn.Font = Enum.Font.FredokaOne
miniBtn.TextScaled = true

-- Sol Menü
local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 150, 1, -35)
sidebar.Position = UDim2.new(0, 0, 0, 35)
sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
sidebar.BorderSizePixel = 0
local strokeSidebar = Instance.new("UIStroke", sidebar)
strokeSidebar.Thickness = 1
strokeSidebar.Color = Color3.fromRGB(50, 50, 50)

-- İçerik Frame
local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -150, 1, -35)
content.Position = UDim2.new(0, 150, 0, 35)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
content.BorderSizePixel = 0
local strokeContent = Instance.new("UIStroke", content)
strokeContent.Thickness = 1
strokeContent.Color = Color3.fromRGB(76, 76, 76)

-- Menü Butonları ve sayfalar
local menuButtons = {"Home", "Main","Eğlnc","Troll","Ayar"}
local pages = {}
local buttonHolder = Instance.new("Frame", sidebar)
buttonHolder.Size = UDim2.new(1, 0, 0, #menuButtons * 40)
buttonHolder.Position = UDim2.new(0, 0, 0, 5)
buttonHolder.BackgroundTransparency = 1

for i, name in ipairs(menuButtons) do
	local btn = Instance.new("TextButton", buttonHolder)
	btn.Size = UDim2.new(1, -10, 0, 35)
	btn.Position = UDim2.new(0, 5, 0, (i - 1) * 40)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.BorderSizePixel = 0
	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0,6)
	local strokeBtn = Instance.new("UIStroke", btn)
	strokeBtn.Thickness = 1
	strokeBtn.Color = Color3.fromRGB(60, 60, 60)

	-- Icon ekleme
	local icon = Instance.new("ImageLabel", btn)
	icon.Size = UDim2.new(0, 50, 0, 50)
	icon.Position = UDim2.new(0, 15,0.5, -25)
	icon.Image = "rbxassetid://13591510704"
	icon.BackgroundTransparency = 1
	icon.Rotation = 90
	icon.ScaleType = Enum.ScaleType.Fit

	local page = Instance.new("Frame", content)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.Visible = (i == 1)
	pages[name] = page

	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(pages) do
			p.Visible = false
		end
		page.Visible = true
	end)
end

-- Profil kısmı
local profileFrame = Instance.new("Frame", sidebar)
profileFrame.Size = UDim2.new(1, 0, 0, 50)
profileFrame.Position = UDim2.new(0, 0, 1, -50)
profileFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
profileFrame.BorderSizePixel = 0
local strokeProfile = Instance.new("UIStroke", profileFrame)
strokeProfile.Thickness = 1
strokeProfile.Color = Color3.fromRGB(60, 60, 60)

local thumb = Instance.new("ImageLabel", profileFrame)
thumb.Size = UDim2.new(0, 40, 0, 40)
thumb.Position = UDim2.new(0, 5, 0.5, -20)
thumb.BackgroundTransparency = 1
local function updateThumb()
	local userId = player.UserId
	local headshot = Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	thumb.Image = headshot
end
updateThumb()

local nameLabel = Instance.new("TextLabel", profileFrame)
nameLabel.Size = UDim2.new(1, -55, 1, 0)
nameLabel.Position = UDim2.new(0, 50, 0, 0)
nameLabel.BackgroundTransparency = 1
nameLabel.Text = player.Name
nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
nameLabel.TextScaled = true
nameLabel.Font = Enum.Font.SourceSansBold
nameLabel.TextXAlignment = Enum.TextXAlignment.Left

local mainPage = pages["Main"]

-- Fonksiyon Butonları
local function createFunctionButton(parent, text, order, isFarm)
	local btnFrame = Instance.new("Frame", parent)
	btnFrame.Size = UDim2.new(1, -20, 0, 40)
	btnFrame.Position = UDim2.new(0, 10, 0, (order - 1) * 45 + 10)
	btnFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btnFrame.BorderSizePixel = 0
	local corner = Instance.new("UICorner", btnFrame)
	corner.CornerRadius = UDim.new(0, 6)
	local strokeFrame = Instance.new("UIStroke", btnFrame)
	strokeFrame.Thickness = 1
	strokeFrame.Color = Color3.fromRGB(76, 76, 76)
	strokeFrame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	local btn = Instance.new("TextButton", btnFrame)
	btn.Size = UDim2.new(1, 0, 1, 0)
	btn.Position = UDim2.new(0, 0, 0, 0)
	btn.BackgroundTransparency = 1
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16

	-- Toggle Button (en sağ)
	local toggleFrame = Instance.new("Frame", btnFrame)
	toggleFrame.Size = UDim2.new(0, 50, 1, 0)
	toggleFrame.Position = UDim2.new(1, -55, 0, 0)
	toggleFrame.BackgroundTransparency = 1

	local toggleBtn = Instance.new("TextButton", toggleFrame)
	toggleBtn.Size = UDim2.new(1,0,1,0)
	toggleBtn.Position = UDim2.new(0,0,0,0)
	toggleBtn.BackgroundColor3 = Color3.fromRGB(76,76,76)
	toggleBtn.BorderSizePixel = 0
	toggleBtn.Text = ""
	local cornerBtn = Instance.new("UICorner", toggleBtn)
	cornerBtn.CornerRadius = UDim.new(0,6)

	-- Farming işlemi için toggle
	if isFarm then
		local player = game.Players.LocalPlayer
		local farming = false
		local speed = 0.2

		toggleBtn.MouseButton1Click:Connect(function()
			farming = not farming
			if farming then
				toggleBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)

				-- Money toplama işlemi
				spawn(function()
					local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
					if not hrp then return end
					while farming and hrp do
						for _, moneyPart in pairs(workspace:GetChildren()) do
							if moneyPart.Name == "Money" and moneyPart:IsA("BasePart") then
								local mesh = moneyPart:FindFirstChildWhichIsA("MeshPart") or moneyPart
								local targetPos = mesh.Position + Vector3.new(0,2,0)
								hrp.CFrame = CFrame.new(targetPos)
								wait(speed)
								hrp.CFrame = CFrame.new(targetPos + Vector3.new(0,0.5,0))
								wait(speed)
							end
						end
						wait(0.1)
					end
				end)

			else
				toggleBtn.BackgroundColor3 = Color3.fromRGB(76,76,76)
			end
		end)
	end
end

-- Butonları oluştur
createFunctionButton(mainPage, "Farm Euro", 1, true) -- toggle basınca Money ışınlaması
createFunctionButton(mainPage, "BTools", 2, false)
createFunctionButton(mainPage, "Teleport (Q)", 3, false)
createFunctionButton(mainPage, "Infinite Jump", 4, false)
createFunctionButton(mainPage, "FreeCam (Shift + P)", 5, false)
createFunctionButton(mainPage, "Spam Chat", 6, false)
createFunctionButton(mainPage, "Baseplate", 7, false)

createFunctionButton(mainPage, "BTools", 2, false)

-- BTools toggle
do
	local player = game.Players.LocalPlayer
	local backpack = player:WaitForChild("Backpack")
	local btnFrame
	-- Butonu bul
	for _, f in pairs(mainPage:GetChildren()) do
		if f:IsA("Frame") then
			local tb = f:FindFirstChildOfClass("TextButton")
			if tb and tb.Text == "BTools" then
				btnFrame = f
				break
			end
		end
	end

	if btnFrame then
		local toggleFrame = btnFrame:FindFirstChildWhichIsA("Frame")
		local toggleBtn = toggleFrame and toggleFrame:FindFirstChildOfClass("TextButton")
		if toggleBtn then
			local active = false
			toggleBtn.MouseButton1Click:Connect(function()
				active = not active
				if active then
					toggleBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
					-- BTools Tool oluştur veya ver
					local tool = Instance.new("Tool")
					tool.Name = "BTools"
					tool.RequiresHandle = false
					tool.Parent = backpack
				else
					toggleBtn.BackgroundColor3 = Color3.fromRGB(76,76,76)
					-- BTools Tool’u kaldır
					local tool = backpack:FindFirstChild("BTools")
					if tool then
						tool:Destroy()
					end
					-- Karakterde varsa sil
					local charTool = player.Character:FindFirstChild("BTools")
					if charTool then
						charTool:Destroy()
					end
				end
			end)
		end
	end
end


-- Kapatma ve Minimize İşlevleri


local minimized = false
miniBtn.MouseButton1Click:Connect(function()
	if minimized then
		minimized = false
		sidebar.Visible = true
		content.Visible = true
		TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 360)}):Play()
	else
		minimized = true
		sidebar.Visible = false
		content.Visible = false
		TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 35)}):Play()
	end
end)

-- Sürüklenebilirlik
local dragging, dragInput, dragStart, startPos
topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
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

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Kapatma Onay Frame
local confirmFrame = Instance.new("Frame", gui)
confirmFrame.Size = UDim2.new(0, 300, 0, 150)
confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
confirmFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
confirmFrame.BorderSizePixel = 0
confirmFrame.Visible = false

local strokeConfirm = Instance.new("UIStroke", confirmFrame)
strokeConfirm.Thickness = 1
strokeConfirm.Color = Color3.fromRGB(50, 50, 50)

local confirmText = Instance.new("TextLabel", confirmFrame)
confirmText.Size = UDim2.new(1, -20, 0, 60)
confirmText.Position = UDim2.new(0, 10, 0, 20)
confirmText.BackgroundTransparency = 1
confirmText.Text = "Gerçekten kapatmak istiyor musun?"
confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmText.TextScaled = true
confirmText.Font = Enum.Font.SourceSansBold
confirmText.TextWrapped = true
confirmText.TextXAlignment = Enum.TextXAlignment.Center
confirmText.TextYAlignment = Enum.TextYAlignment.Center

-- Kapat Butonu
local confirmClose = Instance.new("TextButton", confirmFrame)
confirmClose.Size = UDim2.new(0.4, 0, 0, 40)
confirmClose.Position = UDim2.new(0.05, 0, 1, -50)
confirmClose.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
confirmClose.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmClose.Text = "Kapat"
confirmClose.Font = Enum.Font.SourceSansBold
confirmClose.TextScaled = true
confirmClose.BorderSizePixel = 0
local cornerClose = Instance.new("UICorner", confirmClose)
cornerClose.CornerRadius = UDim.new(0, 6)

-- İptal Butonu
local confirmCancel = Instance.new("TextButton", confirmFrame)
confirmCancel.Size = UDim2.new(0.4, 0, 0, 40)
confirmCancel.Position = UDim2.new(0.55, 0, 1, -50)
confirmCancel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
confirmCancel.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmCancel.Text = "İptal"
confirmCancel.Font = Enum.Font.SourceSansBold
confirmCancel.TextScaled = true
confirmCancel.BorderSizePixel = 0
local cornerCancel = Instance.new("UICorner", confirmCancel)
cornerCancel.CornerRadius = UDim.new(0, 6)

-- Buton işlevleri
-- Kapatma Onay Frame
local confirmFrame = Instance.new("Frame", gui)
confirmFrame.Size = UDim2.new(0, 300, 0, 150)
confirmFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
confirmFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
confirmFrame.BorderSizePixel = 0
confirmFrame.Visible = false

local strokeConfirm = Instance.new("UIStroke", confirmFrame)
strokeConfirm.Thickness = 1
strokeConfirm.Color = Color3.fromRGB(50, 50, 50)

local confirmText = Instance.new("TextLabel", confirmFrame)
confirmText.Size = UDim2.new(1, -20, 0, 60)
confirmText.Position = UDim2.new(0, 10, 0, 20)
confirmText.BackgroundTransparency = 1
confirmText.Text = "Gerçekten kapatmak istiyor musun?"
confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmText.TextScaled = true
confirmText.Font = Enum.Font.SourceSansBold
confirmText.TextWrapped = true
confirmText.TextXAlignment = Enum.TextXAlignment.Center
confirmText.TextYAlignment = Enum.TextYAlignment.Center

-- Kapat Butonu
local confirmClose = Instance.new("TextButton", confirmFrame)
confirmClose.Size = UDim2.new(0.4, 0, 0, 40)
confirmClose.Position = UDim2.new(0.05, 0, 1, -50)
confirmClose.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
confirmClose.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmClose.Text = "Kapat"
confirmClose.Font = Enum.Font.SourceSansBold
confirmClose.TextScaled = true
confirmClose.BorderSizePixel = 0
local cornerClose = Instance.new("UICorner", confirmClose)
cornerClose.CornerRadius = UDim.new(0, 6)

-- İptal Butonu
local confirmCancel = Instance.new("TextButton", confirmFrame)
confirmCancel.Size = UDim2.new(0.4, 0, 0, 40)
confirmCancel.Position = UDim2.new(0.55, 0, 1, -50)
confirmCancel.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
confirmCancel.TextColor3 = Color3.fromRGB(255, 255, 255)
confirmCancel.Text = "İptal"
confirmCancel.Font = Enum.Font.SourceSansBold
confirmCancel.TextScaled = true
confirmCancel.BorderSizePixel = 0
local cornerCancel = Instance.new("UICorner", confirmCancel)
cornerCancel.CornerRadius = UDim.new(0, 6)

-- closeBtn işlevini onay ile değiştir
closeBtn.MouseButton1Click:Connect(function()
	confirmFrame.Visible = true
end)

confirmCancel.MouseButton1Click:Connect(function()
	confirmFrame.Visible = false
end)

confirmClose.MouseButton1Click:Connect(function()
	gui:Destroy() -- GUI tamamen kapanacak
end)

-- Home sayfası
local homePage = pages["Home"]

-- Discord butonu
local function createDiscordButton(parent, text, order)
	local btnFrame = Instance.new("Frame", parent)
	btnFrame.Size = UDim2.new(1, -20, 0, 40)
	btnFrame.Position = UDim2.new(0, 10, 0, (order - 1) * 45 + 10)
	btnFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btnFrame.BorderSizePixel = 0
	local corner = Instance.new("UICorner", btnFrame)
	corner.CornerRadius = UDim.new(0, 6)
	local strokeFrame = Instance.new("UIStroke", btnFrame)
	strokeFrame.Thickness = 1
	strokeFrame.Color = Color3.fromRGB(76, 76, 76)
	strokeFrame.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

	local btn = Instance.new("TextButton", btnFrame)
	btn.Size = UDim2.new(1, 0, 1, 0)
	btn.Position = UDim2.new(0, 0, 0, 0)
	btn.BackgroundTransparency = 1
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 16

	btn.MouseButton1Click:Connect(function()
		-- Discord sunucu URL'sini kopyalama
		local url = "https://discord.gg/YourServerCode"
		setclipboard(url)
	end)
end

createDiscordButton(homePage, "Discord", 1)

local eglncPage = pages["Eğlnc"]

-- Hız Frame
local function createSpeedFrame(parent, text, order)
	local frame = Instance.new("Frame", parent)
	frame.Size = UDim2.new(1, -20, 0, 40)
	frame.Position = UDim2.new(0, 10, 0, (order - 1) * 45 + 10)
	frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	frame.BorderSizePixel = 0
	local corner = Instance.new("UICorner", frame)
	corner.CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", frame)
	stroke.Thickness = 1
	stroke.Color = Color3.fromRGB(76, 76, 76)

	-- Sol TextLabel
	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(0.4, 0, 1, 0)
	label.Position = UDim2.new(0, 5, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.Font = Enum.Font.SourceSansBold
	label.TextScaled = true
	label.TextXAlignment = Enum.TextXAlignment.Left

	-- Sağ TextBox
	local textBox = Instance.new("TextBox", frame)
	textBox.Size = UDim2.new(0.5, -10, 1, 0)
	textBox.Position = UDim2.new(0.5, 5, 0, 0)
	textBox.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textBox.Text = "16"
	textBox.Font = Enum.Font.SourceSans
	textBox.TextScaled = true
	textBox.ClearTextOnFocus = false
	textBox.TextStrokeTransparency = 0.8
	textBox.PlaceholderText = "0"

	-- Hız değerini değiştir
	textBox.FocusLost:Connect(function(enterPressed)
		local val = tonumber(textBox.Text)
		if val then
			local character = player.Character
			if character and character:FindFirstChild("Humanoid") then
				if text == "Hız" then
					character.Humanoid.WalkSpeed = val-- Main sayfasındaki Anticheat Bypass butonunu bul ve adını değiştir
for _, btnFrame in pairs(mainPage:GetChildren()) do
	if btnFrame:IsA("Frame") then
		local btn = btnFrame:FindFirstChildOfClass("TextButton")
		if btn and btn.Text == "Anticheat Bypass (For WS/JP)" then
			btn.Text = "Farm Euro"
			
			-- Toggle için değişken
			local farming = false
			local speed = 0.2 -- Işınlanma hızı

			btn.MouseButton1Click:Connect(function()
				farming = not farming
				if farming then
					btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Açık yeşil
					
					-- Farming işlemini başlat
					spawn(function()
						local playerChar = player.Character
						local humanoidRootPart = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
						if not humanoidRootPart then return end

						while farming and humanoidRootPart do
							for _, moneyPart in pairs(workspace:GetChildren()) do
								if moneyPart.Name == "Money" and moneyPart:IsA("BasePart") then
									local mesh = moneyPart:FindFirstChildWhichIsA("MeshPart") or moneyPart
									local targetPos = mesh.Position + Vector3.new(0, 2, 0) -- üstüne ışınlan
									-- İleri-geri hareket
									humanoidRootPart.CFrame = CFrame.new(targetPos)
									wait(speed)
									humanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0,0.5,0))
									wait(speed)
								end
							end
							wait(0.1)
						end
					end)
				else
					btn.BackgroundColor3 = Color3.fromRGB(30,30,30) -- Kapalı gri
				end
			end)
		end
	end
end

				end
			end
		end
	end)
end

-- Eğlnc sayfasına ekle
createSpeedFrame(eglncPage, "Hız", 1)


-- Main sayfasındaki Anticheat Bypass butonunu Farm Euro yap ve toggle ekle
for _, btnFrame in pairs(mainPage:GetChildren()) do
	if btnFrame:IsA("Frame") then
		local btn = btnFrame:FindFirstChildOfClass("TextButton")
		if btn and btn.Text == "Anticheat Bypass (For WS/JP)" then
			btn.Text = "Farm Euro"
			btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Başlangıç kapalı gri

			local farming = false
			local speed = 0.2 -- ışınlanma hızı

			btn.MouseButton1Click:Connect(function()
				farming = not farming
				if farming then
					btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Açık yeşil

					-- Farming işlemi
					spawn(function()
						local playerChar = player.Character
						local hrp = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
						if not hrp then return end

						while farming and hrp do
							for _, moneyPart in pairs(workspace:GetChildren()) do
								if moneyPart.Name == "Euro","Para","Money","spara" and moneyPart:IsA("BasePart") then
									local mesh = moneyPart:FindFirstChildWhichIsA("MeshPart") or moneyPart
									local targetPos = mesh.Position + Vector3.new(0, 2, 0)

									-- Işınlan ve ileri-geri hareket
									hrp.CFrame = CFrame.new(targetPos)
									wait(speed)
									hrp.CFrame = CFrame.new(targetPos + Vector3.new(0,0.5,0))
									wait(speed)
								end
							end
							wait(0.1)
						end
					end)
				else
					btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Kapalı gri
				end
			end)
		end
	end
end

local trollPage = pages["Troll"]

-- Frame oluştur
local frame = Instance.new("Frame", trollPage)
frame.Size = UDim2.new(1, -20, 0, 40) -- yüksekliği küçültüldü
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
frame.BorderSizePixel = 0
local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 1
stroke.Color = Color3.fromRGB(76, 76, 76)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 6)

-- Sol TextLabel
local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(0.3, 0, 1, 0)
label.Position = UDim2.new(0, 5, 0, 0)
label.BackgroundTransparency = 1
label.Text = "Işınlanma"
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Font = Enum.Font.SourceSansBold
label.TextScaled = true
label.TextXAlignment = Enum.TextXAlignment.Left

-- Ortada TextBox
local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.5, -10, 1, 0)
textBox.Position = UDim2.new(0.3, 5, 0, 0)
textBox.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
textBox.Text = ""
textBox.Font = Enum.Font.SourceSans
textBox.TextScaled = true
textBox.ClearTextOnFocus = false
textBox.PlaceholderText = "Oyuncu ismi"
local textBoxCorner = Instance.new("UICorner", textBox)
textBoxCorner.CornerRadius = UDim.new(0, 6)

-- Sağda TextButton
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0, 50, 1, 0)
btn.Position = UDim2.new(0.85, 0, 0, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 128, 255) -- mavi
btn.Text = "Işınlan"
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.Font = Enum.Font.SourceSansBold
btn.TextScaled = true
btn.BorderSizePixel = 0
local btnCorner = Instance.new("UICorner", btn)
btnCorner.CornerRadius = UDim.new(0, 6)

local player = game.Players.LocalPlayer

btn.MouseButton1Click:Connect(function()
	local targetName = textBox.Text:lower()
	if targetName == "" then return end
	local targetPlayer
	for _, p in pairs(game.Players:GetPlayers()) do
		if p.Name:lower():find(targetName) then
			targetPlayer = p
			break
		end
	end
	if targetPlayer and targetPlayer.Character and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character.HumanoidRootPart
		local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
		if targetHRP then
			hrp.CFrame = CFrame.new(targetHRP.Position + Vector3.new(0,3,0))
		end
	end
end)

-- Altına Bring ekleme
local bringFrame = Instance.new("Frame", trollPage)
bringFrame.Size = UDim2.new(1, -20, 0, 40)
bringFrame.Position = UDim2.new(0, 10, 0, 60) -- Işınlanmanın altına
bringFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
bringFrame.BorderSizePixel = 0
local strokeBring = Instance.new("UIStroke", bringFrame)
strokeBring.Thickness = 1
strokeBring.Color = Color3.fromRGB(76, 76, 76)
strokeBring.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
local cornerBring = Instance.new("UICorner", bringFrame)
cornerBring.CornerRadius = UDim.new(0, 6)

-- Sol TextLabel
local bringLabel = Instance.new("TextLabel", bringFrame)
bringLabel.Size = UDim2.new(0.3, 0, 1, 0)
bringLabel.Position = UDim2.new(0, 5, 0, 0)
bringLabel.BackgroundTransparency = 1
bringLabel.Text = "Bring"
bringLabel.TextColor3 = Color3.fromRGB(255,255,255)
bringLabel.Font = Enum.Font.SourceSansBold
bringLabel.TextScaled = true
bringLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Ortada TextBox
local bringTextBox = Instance.new("TextBox", bringFrame)
bringTextBox.Size = UDim2.new(0.5, -10, 1, 0)
bringTextBox.Position = UDim2.new(0.3, 5, 0, 0)
bringTextBox.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
bringTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
bringTextBox.Text = ""
bringTextBox.Font = Enum.Font.SourceSans
bringTextBox.TextScaled = true
bringTextBox.ClearTextOnFocus = false
bringTextBox.PlaceholderText = "Oyuncu ismi"
local bringTextBoxCorner = Instance.new("UICorner", bringTextBox)
bringTextBoxCorner.CornerRadius = UDim.new(0, 6)

-- Sağda TextButton
local bringBtn = Instance.new("TextButton", bringFrame)
bringBtn.Size = UDim2.new(0, 50, 1, 0)
bringBtn.Position = UDim2.new(0.85, 0, 0, 0)
bringBtn.BackgroundColor3 = Color3.fromRGB(0, 128, 255) -- mavi
bringBtn.Text = "Bring"
bringBtn.TextColor3 = Color3.fromRGB(255,255,255)
bringBtn.Font = Enum.Font.SourceSansBold
bringBtn.TextScaled = true
bringBtn.BorderSizePixel = 0
local bringBtnCorner = Instance.new("UICorner", bringBtn)
bringBtnCorner.CornerRadius = UDim.new(0, 6)

bringBtn.MouseButton1Click:Connect(function()
	local targetName = bringTextBox.Text:lower()
	if targetName == "" then return end
	local targetPlayer
	for _, p in pairs(game.Players:GetPlayers()) do
		if p.Name:lower():find(targetName) then
			targetPlayer = p
			break
		end
	end
	if targetPlayer and targetPlayer.Character and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = player.Character.HumanoidRootPart
		local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
		if targetHRP then
			targetHRP.CFrame = CFrame.new(hrp.Position + Vector3.new(0,3,0))
		end
	end
end)


