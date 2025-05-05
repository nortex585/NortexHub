-- Nortex Hub - Brookhaven GUI

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NortexHub"
gui.ResetOnSpawn = false

-- UICorner Helper
local function applyCorner(obj, radius)
    local corner = Instance.new("UICorner")
    if radius then corner.CornerRadius = UDim.new(0, radius) end
    corner.Parent = obj
end

-- Sürüklenebilirlik
local function makeDraggable(frame)
	local UIS = game:GetService("UserInputService")
	local dragging, dragInput, dragStart, startPos

	frame.InputBegan:Connect(function(input)
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

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- Yükleme ekranı
local loadingFrame = Instance.new("Frame", gui)
loadingFrame.Size = UDim2.new(1, 0, 1, 0)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
loadingFrame.ZIndex = 10

local welcomeLabel = Instance.new("TextLabel", loadingFrame)
welcomeLabel.Size = UDim2.new(1, 0, 0, 100)
welcomeLabel.Position = UDim2.new(0, 0, 0.4, 0)
welcomeLabel.Text = "Nortex Hub'a Hoşgeldiniz"
welcomeLabel.Font = Enum.Font.GothamBold
welcomeLabel.TextSize = 24
welcomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeLabel.BackgroundTransparency = 1

local loadingBarBG = Instance.new("Frame", loadingFrame)
loadingBarBG.Size = UDim2.new(0.6, 0, 0, 20)
loadingBarBG.Position = UDim2.new(0.2, 0, 0.55, 0)
loadingBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadingBarBG.BorderSizePixel = 0
applyCorner(loadingBarBG)

local loadingBar = Instance.new("Frame", loadingBarBG)
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
loadingBar.BorderSizePixel = 0
applyCorner(loadingBar)

-- Mini icon (başta görünmez)
local miniIcon = Instance.new("TextButton", gui)
miniIcon.Size = UDim2.new(0, 60, 0, 60)
miniIcon.Position = UDim2.new(0, 20, 0, 20)
miniIcon.Text = "NH"
miniIcon.Font = Enum.Font.GothamBold
miniIcon.TextSize = 18
miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
miniIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
miniIcon.BorderSizePixel = 0
miniIcon.Visible = false
applyCorner(miniIcon)
makeDraggable(miniIcon)

-- Ana GUI (başta gizli)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0.1, 0, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Name = "MainFrame"
main.BorderSizePixel = 0
main.Visible = false
applyCorner(main)

-- Title Bar
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Text = "Nortex Hub [BETA] : Brookhaven"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BorderSizePixel = 0
title.Name = "TitleBar"
applyCorner(title)
makeDraggable(main)

-- Close Button
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.BorderSizePixel = 0
applyCorner(closeBtn)

-- Minimize Button
local miniBtn = Instance.new("TextButton", main)
miniBtn.Size = UDim2.new(0, 30, 0, 30)
miniBtn.Position = UDim2.new(1, -70, 0, 5)
miniBtn.Text = "-"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 14
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
miniBtn.BorderSizePixel = 0
applyCorner(miniBtn)

-- Sekmeler
local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(0, 120, 1, -40)
tabHolder.Position = UDim2.new(0, 0, 0, 40)
tabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabHolder.BorderSizePixel = 0
applyCorner(tabHolder)

local contentHolder = Instance.new("Frame", main)
contentHolder.Size = UDim2.new(1, -120, 1, -40)
contentHolder.Position = UDim2.new(0, 120, 0, 40)
contentHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
contentHolder.BorderSizePixel = 0
applyCorner(contentHolder)

-- Buton Fonksiyonları
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

miniBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	miniIcon.Visible = true
end)

miniIcon.MouseButton1Click:Connect(function()
	main.Visible = true
	miniIcon.Visible = false
end)

-- Tablar
local tabNames = {"Discord", "Farm", "Shop", "Mini Games", "Player", "Teleports", "Misc"}

for i, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton", tabHolder)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.BorderSizePixel = 0
	btn.Font = Enum.Font.Gotham
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 14
	applyCorner(btn)

	btn.MouseButton1Click:Connect(function()
		contentHolder:ClearAllChildren()
		if name == "Discord" then
			local discordBtn = Instance.new("TextButton", contentHolder)
			discordBtn.Size = UDim2.new(0, 200, 0, 40)
			discordBtn.Position = UDim2.new(0, 20, 0, 20)
			discordBtn.Text = "Join Discord Group"
			discordBtn.Font = Enum.Font.GothamBold
			discordBtn.TextSize = 14
			discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			discordBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
			discordBtn.BorderSizePixel = 0
			applyCorner(discordBtn)

			discordBtn.MouseButton1Click:Connect(function()
				setclipboard("https://discord.gg/qVbjNkfs")
				game.StarterGui:SetCore("SendNotification", {
					Title = "Discord",
					Text = "Link kopyalandı!",
					Duration = 5
				})
			end)
		else
			local label = Instance.new("TextLabel", contentHolder)
			label.Size = UDim2.new(1, 0, 0, 30)
			label.Text = name .. " sekmesi hazırlanıyor..."
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.Font = Enum.Font.Gotham
			label.TextSize = 16
			label.BackgroundTransparency = 1
		end
	end)
end
