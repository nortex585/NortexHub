-- LocalScript (StarterPlayerScripts veya StarterGui içine)
-- Space Hub | Brookhaven (Sekmeler: Home, Farm, Teleport, Player, Ayar)

--==[ SERVISLER ]==--
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

--==[ KONUM AYARLARI ]==--
local LOCATIONS: {[string]: CFrame | Vector3 | string} = {
	["Spawn"] = "Spawn",
	["HalıSaha"] = "TopSpawner", -- artık HalıSaha seçilince TopSpawner'a ışınlanacak
	["Market"] = "Shopblock2",
}

-- findCFrame fonksiyonunu güncellemek gerekirse:
local function findCFrame(target:any): CFrame?
	if typeof(target) == "CFrame" then return target end
	if typeof(target) == "Vector3" then return CFrame.new(target) end
	if typeof(target) == "string" then
		if target == "TopSpawner" then
			local inst = workspace:FindFirstChild("FutbolGerekli") and workspace.FutbolGerekli:FindFirstChild("TopSpawner")
			if inst then return inst.CFrame + Vector3.new(0,5,0) end
		else
			local inst = workspace:FindFirstChild(target, true)
			if inst and inst:IsA("BasePart") then
				return inst.CFrame + Vector3.new(0, 5, 0)
			elseif inst and inst.PrimaryPart then
				return inst.PrimaryPart.CFrame + Vector3.new(0, 5, 0)
			end
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("BasePart") and string.find(string.lower(obj.Name), string.lower(target)) then
					return obj.CFrame + Vector3.new(0, 5, 0)
				end
			end
		end
	end
	return nil
end


local function getHRP(char: Model?): BasePart?
	char = char or player.Character
	if not char then return nil end
	return char:FindFirstChild("HumanoidRootPart") :: BasePart
end

local function safeTeleport(toCFrame: CFrame)
	local hrp = getHRP(player.Character or player.CharacterAdded:Wait())
	if not hrp then return end
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

	if hum then hum.Sit = false end
	local oldAnchored = hrp.Anchored
	hrp.Anchored = true
	hrp.CFrame = toCFrame
	task.wait(0.05)
	hrp.Anchored = oldAnchored
end

--==[ UI OLUSTURMA ]==--
local pg = player:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui")
gui.Name = "SpaceHubUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = pg

-- Ana pencere
local window = Instance.new("Frame")
window.Size = UDim2.fromOffset(520, 330)
window.Position = UDim2.fromScale(0.5, 0.5)
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
window.Parent = gui


local stroke = Instance.new("UIStroke")
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Thickness = 1.5
stroke.Transparency = 0.35
stroke.Color = Color3.fromRGB(60, 60, 66)
stroke.Parent = window

-- Üst Bar
local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 34)
topbar.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
topbar.Parent = window

-- Solundaki ImageLabel
local topImage = Instance.new("ImageLabel", topbar)
topImage.Size = UDim2.fromOffset(24, 24)
topImage.Position = UDim2.fromOffset(8, 5)
topImage.BackgroundTransparency = 1
topImage.Image = "rbxassetid://88106479644374"

-- Başlık yazısı
local title = Instance.new("TextLabel")
title.Text = "Nortex Hub | Türk Sohbet V.0.2"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(230, 230, 235)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.fromOffset(40, 0)
title.Size = UDim2.new(1, -52, 1, 0)
title.BackgroundTransparency = 1
title.Parent = topbar


-- Sağ üst butonlar
local btnContainer = Instance.new("Frame")
btnContainer.BackgroundTransparency = 1
btnContainer.Size = UDim2.fromOffset(80, 34)
btnContainer.Position = UDim2.new(1, -84, 0, 0)
btnContainer.Parent = topbar

local function makeTopButton(txt)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(36, 24)
	b.BackgroundColor3 = Color3.fromRGB(38,38,44)
	b.Text = txt
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.fromRGB(220,220,225)
	b.Parent = btnContainer
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	return b
end

local minimizeBtn = makeTopButton("–")
minimizeBtn.Position = UDim2.fromOffset(4,5)
local closeBtn = makeTopButton("×")
closeBtn.Position = UDim2.fromOffset(44,5)

-- Gövde
local body = Instance.new("Frame")
body.Size = UDim2.new(1,0,1,-34)
body.Position = UDim2.fromOffset(0,34)
body.BackgroundTransparency = 1
body.Parent = window

-- Sol menü (Sekmeler)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(28,28,32)
sidebar.Parent = body

local menuLayout = Instance.new("UIListLayout", sidebar)
menuLayout.Padding = UDim.new(0,5)
menuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
menuLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Sağ içerik (Sayfalar)
local content = Instance.new("Frame")
content.Size = UDim2.new(1,-148,1,-16)
content.Position = UDim2.fromOffset(148,8)
content.BackgroundColor3 = Color3.fromRGB(32,32,36)
content.Parent = body
Instance.new("UICorner", content).CornerRadius = UDim.new(0,10)

local pages = {}
local currentPage = nil

local function switchPage(name)
	if currentPage then pages[currentPage].Visible = false end
	if pages[name] then
		pages[name].Visible = true
		currentPage = name
	end
end

--== SAYFA OLUSTURMA FONKSIYONU ==--
local function createPage(name)
	local page = Instance.new("Frame", content)
	page.Name = name
	page.Size = UDim2.fromScale(1,1)
	page.BackgroundTransparency = 1
	page.Visible = false
	pages[name] = page
	return page
end

-- Menü butonları
local function makeMenuButton(name)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,-20,0,30)
	btn.BackgroundColor3 = Color3.fromRGB(38,38,44)
	btn.Text = name
	btn.Font = Enum.Font.GothamMedium
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(230,230,235)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
	btn.Parent = sidebar
	btn.MouseButton1Click:Connect(function()
		switchPage(name)
	end)
end

--== HOME SAYFASI ==--
makeMenuButton("Home")
local homePage = createPage("Home")

-- Ana başlık frame (karakter çerçevesi tarzında)
local homeProfile = Instance.new("Frame", homePage)
homeProfile.Size = UDim2.new(0, 350, 0, 70)
homeProfile.Position = UDim2.fromOffset(12, 20)
homeProfile.BackgroundColor3 = Color3.fromRGB(24,24,28)
Instance.new("UICorner", homeProfile).CornerRadius = UDim.new(0,8)
local homeStroke = Instance.new("UIStroke", homeProfile)
homeStroke.Thickness = 1
homeStroke.Transparency = 0.5
homeStroke.Color = Color3.fromRGB(55,55,62)

-- ImageLabel
local homeImage = Instance.new("ImageLabel", homeProfile)
homeImage.Size = UDim2.fromOffset(60,60)
homeImage.Position = UDim2.fromOffset(10,5)
homeImage.BackgroundTransparency = 1
homeImage.Image = "rbxassetid://88106479644374"

-- Başlık yazısı
local homeTitle = Instance.new("TextLabel", homeProfile)
homeTitle.Size = UDim2.new(1,-80,1,0)
homeTitle.Position = UDim2.fromOffset(80,0)
homeTitle.Font = Enum.Font.GothamBold
homeTitle.Text = "Türk Sohbet Oyunu Hub"
homeTitle.TextSize = 16
homeTitle.TextXAlignment = Enum.TextXAlignment.Left
homeTitle.TextColor3 = Color3.fromRGB(230,230,235)
homeTitle.BackgroundTransparency = 1

-- Alt küçük frameler
local smallFrames = {}
local texts = {"Euro Farm Eklendi", "Parkur Money Farm Eklendi", "Teleport Eklendi", "Hız Ayarlama Eklendi"}
for i, txt in ipairs(texts) do
	local frame = Instance.new("Frame", homePage)
	frame.Size = UDim2.new(0, 160, 0, 40)
	frame.Position = UDim2.fromOffset(12 + ((i-1)%2)*170, 100 + math.floor((i-1)/2)*50)
	frame.BackgroundColor3 = Color3.fromRGB(24,24,28)
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0,6)
	local stroke = Instance.new("UIStroke", frame)
	stroke.Thickness = 1
	stroke.Transparency = 0.5
	stroke.Color = Color3.fromRGB(55,55,62)

	local label = Instance.new("TextLabel", frame)
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextColor3 = Color3.fromRGB(230,230,235)
	label.Text = txt
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextYAlignment = Enum.TextYAlignment.Center

	table.insert(smallFrames, frame)
end


--== FARM SAYFASI ==--
makeMenuButton("Farm")
local farmPage = createPage("Farm")
--== FARM SAYFASI BUTONLARI ==--
local farmList = Instance.new("ScrollingFrame", farmPage)
farmList.Size = UDim2.fromScale(1,1)
farmList.BackgroundTransparency = 1
farmList.ScrollBarThickness = 6
farmList.CanvasSize = UDim2.new(0,0,0,0)

local farmLayout = Instance.new("UIListLayout", farmList)
farmLayout.Padding = UDim.new(0,8)
farmLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function updateFarmCanvas()
	farmList.CanvasSize = UDim2.fromOffset(0, farmLayout.AbsoluteContentSize.Y + 12)
end
farmLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateFarmCanvas)

local active = false
local folder
for _, obj in pairs(workspace:GetChildren()) do
	if obj:IsA("Folder") and obj:FindFirstChild("ParkourMoney") then
		folder = obj
		break
	end
end

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

local function safeTeleportLoop()
	spawn(function()
		local player = game.Players.LocalPlayer
		local character = player.Character or player.CharacterAdded:Wait()
		local hrp = character:WaitForChild("HumanoidRootPart")
		local currentIndex = 1

		while active do
			-- Sadece CanCollide = true olan parçaları al
			local targetParts = {}
			if folder then
				for _, obj in pairs(folder:GetChildren()) do
					if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.CanCollide then
						table.insert(targetParts, obj)
					end
				end
			end

			if #targetParts > 0 then
				local targetPart = targetParts[currentIndex]
				if targetPart then
					-- LocalPlayer'ı yukarıdan yumuşak geçişle ışınla
					hrp.CFrame = targetPart.CFrame + Vector3.new(0,10,0)
					local tween = TweenService:Create(
						hrp,
						TweenInfo.new(1, Enum.EasingStyle.Linear),
						{CFrame = targetPart.CFrame + Vector3.new(0,3,0)}
					)
					tween:Play()
					tween.Completed:Wait()
				end

				currentIndex = currentIndex + 1
				if currentIndex > #targetParts then
					currentIndex = 1
				end
			end

			task.wait(3)
		end
	end)
end


local function makeFarmRow(name, callback)
	local row = Instance.new("TextButton", farmList)
	row.Size = UDim2.new(1,-20,0,40)
	row.BackgroundColor3 = Color3.fromRGB(38,38,44)
	row.Text = ""
	Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)

	local lbl = Instance.new("TextLabel", row)
	lbl.Text = name
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 15
	lbl.TextColor3 = Color3.fromRGB(230,230,235)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Position = UDim2.fromOffset(12,0)
	lbl.Size = UDim2.new(1,-60,1,0)
	lbl.BackgroundTransparency = 1

	local dot = Instance.new("Frame", row)
	dot.Size = UDim2.fromOffset(12,12)
	dot.Position = UDim2.new(1,-22,0.5,-6)
	dot.BackgroundColor3 = Color3.fromRGB(54,54,62)
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

	row.MouseButton1Click:Connect(function()
		active = not active -- toggle mantığı
		if active then
			safeTeleportLoop()
			TweenService:Create(dot, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(90,180,120)}):Play()
		else
			TweenService:Create(dot, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(54,54,62)}):Play()
		end
		callback()
	end)
end

-- Butonları ekle
makeFarmRow("Euro Farm", function()
	print("Euro Farm başlatıldı/durduruldu!")
end)


updateFarmCanvas()

--== TELEPORT SAYFASI ==--
makeMenuButton("Teleport")
local teleportPage = createPage("Teleport")

local listHolder = Instance.new("ScrollingFrame", teleportPage)
listHolder.Size = UDim2.fromScale(1,1)
listHolder.BackgroundTransparency = 1
listHolder.CanvasSize = UDim2.new(0,0,0,0)
listHolder.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", listHolder)
layout.Padding = UDim.new(0,8)
layout.SortOrder = Enum.SortOrder.LayoutOrder

local function updateCanvas()
	listHolder.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 12)
end
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

local function makeRow(textLabel: string, callback: ()->())
	local row = Instance.new("TextButton", listHolder)
	row.Size = UDim2.new(1,-20,0,40)
	row.BackgroundColor3 = Color3.fromRGB(38,38,44)
	row.Text = ""
	Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)

	local lbl = Instance.new("TextLabel", row)
	lbl.Text = textLabel
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextSize = 15
	lbl.TextColor3 = Color3.fromRGB(230,230,235)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Position = UDim2.fromOffset(12,0)
	lbl.Size = UDim2.new(1,-60,1,0)
	lbl.BackgroundTransparency = 1

	local dot = Instance.new("Frame", row)
	dot.Size = UDim2.fromOffset(12,12)
	dot.Position = UDim2.new(1,-22,0.5,-6)
	dot.BackgroundColor3 = Color3.fromRGB(54,54,62)
	Instance.new("UICorner", dot).CornerRadius = UDim.new(1,0)

	row.MouseButton1Click:Connect(function()
		callback()
		TweenService:Create(dot, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(90,180,120)}):Play()
		task.delay(0.25, function()
			TweenService:Create(dot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(54,54,62)}):Play()
		end)
	end)
end

for name, target in pairs(LOCATIONS) do
	makeRow(name, function()
		local cf = findCFrame(target)
		if cf then safeTeleport(cf) end
	end)
end
updateCanvas()

--== PLAYER SAYFASI ==--
makeMenuButton("Player")
local playerPage = createPage("Player")

-- Player Page başlığı
local profile = Instance.new("Frame", playerPage)
profile.Size = UDim2.new(0, 350, 0, 70)
profile.Position = UDim2.fromOffset(12, 20)
profile.BackgroundColor3 = Color3.fromRGB(24,24,28)
local pCorner = Instance.new("UICorner"); pCorner.CornerRadius = UDim.new(0,8); pCorner.Parent = profile
local pStroke = Instance.new("UIStroke"); pStroke.Thickness = 1; pStroke.Transparency = 0.5; pStroke.Color = Color3.fromRGB(55,55,62); pStroke.Parent = profile

-- Karakter resmi
local headshot = Instance.new("ImageLabel", profile)
headshot.Size = UDim2.fromOffset(60,60)
headshot.Position = UDim2.fromOffset(10,5)
headshot.BackgroundTransparency = 1
headshot.Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", player.UserId)

-- Karakter adı
local uname = Instance.new("TextLabel", profile)
uname.Size = UDim2.new(1,-80,1,0)
uname.Position = UDim2.fromOffset(80,0)
uname.Font = Enum.Font.GothamBold
uname.Text = player.DisplayName
uname.TextSize = 16
uname.TextXAlignment = Enum.TextXAlignment.Left
uname.TextColor3 = Color3.fromRGB(230,230,235)
uname.BackgroundTransparency = 1

-- Hız frame'i
local speedFrame = Instance.new("Frame", playerPage)
speedFrame.Size = UDim2.new(0, 350, 0, 70)
speedFrame.Position = UDim2.fromOffset(12, 100) -- profile'ın altına
speedFrame.BackgroundColor3 = Color3.fromRGB(24,24,28)
local sCorner = Instance.new("UICorner"); sCorner.CornerRadius = UDim.new(0,8); sCorner.Parent = speedFrame
local sStroke = Instance.new("UIStroke"); sStroke.Thickness = 1; sStroke.Transparency = 0.5; sStroke.Color = Color3.fromRGB(55,55,62); sStroke.Parent = speedFrame

-- Sol tarafta "Hız" yazısı
local speedLabel = Instance.new("TextLabel", speedFrame)
speedLabel.Size = UDim2.new(0, 50, 1, 0)
speedLabel.Position = UDim2.fromOffset(10,0)
speedLabel.Text = "Hız"
speedLabel.Font = Enum.Font.GothamBold
speedLabel.TextSize = 16
speedLabel.TextColor3 = Color3.fromRGB(230,230,235)
speedLabel.BackgroundTransparency = 1
speedLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Ortada TextBox
local speedBox = Instance.new("TextBox", speedFrame)
speedBox.Size = UDim2.new(0, 150, 0, 36)
speedBox.Position = UDim2.fromOffset(70, 17)
speedBox.PlaceholderText = "Hız değeri"
speedBox.Text = ""
speedBox.ClearTextOnFocus = false
speedBox.Font = Enum.Font.Gotham
speedBox.TextSize = 14
speedBox.TextColor3 = Color3.fromRGB(230,230,235)
speedBox.BackgroundColor3 = Color3.fromRGB(54,54,62)
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0,6)

-- Sağ tarafta buton
local speedBtn = Instance.new("TextButton", speedFrame)
speedBtn.Size = UDim2.new(0, 60, 0, 36)
speedBtn.Position = UDim2.fromOffset(240,17)
speedBtn.Text = "Ayarla"
speedBtn.Font = Enum.Font.GothamBold
speedBtn.TextSize = 14
speedBtn.TextColor3 = Color3.fromRGB(220,220,225)
speedBtn.BackgroundColor3 = Color3.fromRGB(38,38,44)
Instance.new("UICorner", speedBtn).CornerRadius = UDim.new(0,6)

-- Buton click olayı: oyuncunun yürüyüş hızını ayarlıyor
speedBtn.MouseButton1Click:Connect(function()
	local value = tonumber(speedBox.Text)
	if value and player.Character and player.Character:FindFirstChildOfClass("Humanoid") then
		player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
	end
end)

-- JumpPower frame'i -> artık Işınlan frame'i
local tpFrame = Instance.new("Frame", playerPage)
tpFrame.Size = UDim2.new(0, 350, 0, 70)
tpFrame.Position = UDim2.fromOffset(12, 190) -- speedFrame'ın altına
tpFrame.BackgroundColor3 = Color3.fromRGB(24,24,28)
local tpCorner = Instance.new("UICorner"); tpCorner.CornerRadius = UDim.new(0,8); tpCorner.Parent = tpFrame
local tpStroke = Instance.new("UIStroke"); tpStroke.Thickness = 1; tpStroke.Transparency = 0.5; tpStroke.Color = Color3.fromRGB(55,55,62); tpStroke.Parent = tpFrame

-- Sol tarafta "Işınlan" yazısı
local tpLabel = Instance.new("TextLabel", tpFrame)
tpLabel.Size = UDim2.new(0, 70, 1, 0)
tpLabel.Position = UDim2.fromOffset(10,0)
tpLabel.Text = "Işınlan"
tpLabel.Font = Enum.Font.GothamBold
tpLabel.TextSize = 16
tpLabel.TextColor3 = Color3.fromRGB(230,230,235)
tpLabel.BackgroundTransparency = 1
tpLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Ortada TextBox
local tpBox = Instance.new("TextBox", tpFrame)
tpBox.Size = UDim2.new(0, 150, 0, 36)
tpBox.Position = UDim2.fromOffset(90,17)
tpBox.PlaceholderText = "Oyuncu adı"
tpBox.Text = ""
tpBox.ClearTextOnFocus = false
tpBox.Font = Enum.Font.Gotham
tpBox.TextSize = 14
tpBox.TextColor3 = Color3.fromRGB(230,230,235)
tpBox.BackgroundColor3 = Color3.fromRGB(54,54,62)
Instance.new("UICorner", tpBox).CornerRadius = UDim.new(0,6)

-- Sağ tarafta buton
local tpBtn = Instance.new("TextButton", tpFrame)
tpBtn.Size = UDim2.new(0, 60, 0, 36)
tpBtn.Position = UDim2.fromOffset(250,17)
tpBtn.Text = "Işınlan"
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 14
tpBtn.TextColor3 = Color3.fromRGB(220,220,225)
tpBtn.BackgroundColor3 = Color3.fromRGB(38,38,44)
Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0,6)

-- Buton click olayı: oyuncuyu ışınlar
tpBtn.MouseButton1Click:Connect(function()
	local input = tpBox.Text:lower()
	for _, p in pairs(game.Players:GetPlayers()) do
		if string.find(p.Name:lower(), input) or string.find(p.DisplayName:lower(), input) then
			local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
			if hrp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0,5,0)
			end
			break
		end
	end
end)


-- Başlangıç sayfası
switchPage("Home")

--== MINIMIZE & CLOSE ==--
--== MINIMIZE & CLOSE ==--
-- Minimize & Close (yeni mantık)
local minimized = false

-- 40x40 geri açma butonu (başlangıçta gizli)
local restoreBtn = Instance.new("ImageButton")
restoreBtn.Size = UDim2.fromOffset(40, 40)
restoreBtn.Position = UDim2.fromScale(0, 0)
restoreBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 44)
restoreBtn.Image = "rbxassetid://7072724987" -- ikon ID'sini değiştirebilirsin
restoreBtn.Visible = false
restoreBtn.Parent = pg
Instance.new("UICorner", restoreBtn).CornerRadius = UDim.new(0, 6)

local minimized = false

local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized

	-- AnaFrame görünürlüğünü toggle et
	body.Visible = not minimized

	-- AnaFrame'in arka plan transparanlığını toggle et
	if minimized then
		window.BackgroundTransparency = 1
	else
		window.BackgroundTransparency = 0
	end

	-- Stroke kalınlığını toggle et
	if minimized then
		stroke.Thickness = 0
	else
		stroke.Thickness = 1.5
	end
end)



closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy() -- tüm GUI'yi kapat
end)

-- Topbar'ı sürüklenebilir yap
local dragging = false
local dragStart = Vector2.new(0,0)
local startPos = UDim2.new(0,0,0,0)

topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = window.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

topbar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		local dragInput
		dragInput = input
		dragInput.Changed:Connect(function()
			if dragInput.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		window.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)


