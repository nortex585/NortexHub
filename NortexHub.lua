-- Nortex Hub - Brookhaven GUI v2
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NortexHub"
gui.ResetOnSpawn = false

-- Helper: UICorner
local function applyCorner(obj, radius)
	local corner = Instance.new("UICorner")
	if radius then corner.CornerRadius = UDim.new(0, radius) end
	corner.Parent = obj
end

-- Sürüklenebilirlik Fonksiyonu
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

-- YÜKLEME PANELİ
local loadingPanel = Instance.new("Frame", gui)
loadingPanel.Size = UDim2.new(0, 400, 0, 200)
loadingPanel.Position = UDim2.new(0.5, -200, 0.5, -100)
loadingPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
loadingPanel.ZIndex = 10
applyCorner(loadingPanel, 12)

-- Hoşgeldin yazısı
local welcomeText = Instance.new("TextLabel", loadingPanel)
welcomeText.Size = UDim2.new(1, 0, 0, 50)
welcomeText.Position = UDim2.new(0, 0, 0, 20)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "Nortex Hub'a Hoşgeldiniz"
welcomeText.Font = Enum.Font.GothamBold
welcomeText.TextSize = 20
welcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Loading bar background
local loadingBG = Instance.new("Frame", loadingPanel)
loadingBG.Size = UDim2.new(0.8, 0, 0, 20)
loadingBG.Position = UDim2.new(0.1, 0, 0.55, 0)
loadingBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
loadingBG.BorderSizePixel = 0
applyCorner(loadingBG, 6)

-- Loading bar fill
local loadingBar = Instance.new("Frame", loadingBG)
loadingBar.Size = UDim2.new(0, 0, 1, 0)
loadingBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
loadingBar.BorderSizePixel = 0
applyCorner(loadingBar, 6)

-- Yüzde gösterge
local percentLabel = Instance.new("TextLabel", loadingPanel)
percentLabel.Size = UDim2.new(1, 0, 0, 30)
percentLabel.Position = UDim2.new(0, 0, 0.7, 0)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "Yükleniyor... %0"
percentLabel.Font = Enum.Font.Gotham
percentLabel.TextSize = 16
percentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

-- Powered By
local powered = Instance.new("TextLabel", loadingPanel)
powered.Size = UDim2.new(1, -10, 0, 20)
powered.Position = UDim2.new(0, 5, 1, -25)
powered.BackgroundTransparency = 1
powered.Text = "Powered By: Nortex585"
powered.Font = Enum.Font.Gotham
powered.TextSize = 12
powered.TextColor3 = Color3.fromRGB(150, 150, 150)
powered.TextXAlignment = Enum.TextXAlignment.Left

-- Ana GUI Panel (başta gizli)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0.1, 0, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Visible = false
applyCorner(main, 10)

-- Başlık
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Text = "Nortex Hub [BETA] : Brookhaven"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BorderSizePixel = 0
applyCorner(title)
makeDraggable(main)

-- Kapat ve Küçült
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
applyCorner(closeBtn)

local miniBtn = Instance.new("TextButton", main)
miniBtn.Size = UDim2.new(0, 30, 0, 30)
miniBtn.Position = UDim2.new(1, -70, 0, 5)
miniBtn.Text = "-"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 14
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
applyCorner(miniBtn)

-- Mini İkon
local miniIcon = Instance.new("TextButton", gui)
miniIcon.Size = UDim2.new(0, 60, 0, 60)
miniIcon.Position = UDim2.new(0, 20, 0, 20)
miniIcon.Text = "NH"
miniIcon.Font = Enum.Font.GothamBold
miniIcon.TextSize = 18
miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
miniIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
applyCorner(miniIcon)
miniIcon.Visible = false
makeDraggable(miniIcon)

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

-- Discord Sekmesi (Örnek)
local tabBtn = Instance.new("TextButton", main)
tabBtn.Size = UDim2.new(0, 120, 0, 30)
tabBtn.Position = UDim2.new(0, 0, 0, 50)
tabBtn.Text = "Discord"
tabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tabBtn.Font = Enum.Font.Gotham
tabBtn.TextSize = 14
applyCorner(tabBtn)

local contentHolder = Instance.new("Frame", main)
contentHolder.Size = UDim2.new(1, -120, 1, -50)
contentHolder.Position = UDim2.new(0, 120, 0, 50)
contentHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
applyCorner(contentHolder)

tabBtn.MouseButton1Click:Connect(function()
	contentHolder:ClearAllChildren()
	local btn = Instance.new("TextButton", contentHolder)
	btn.Size = UDim2.new(0, 200, 0, 40)
	btn.Position = UDim2.new(0, 20, 0, 20)
	btn.Text = "Join Discord Group"
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
	applyCorner(btn)
	btn.MouseButton1Click:Connect(function()
		setclipboard("https://discord.gg/qVbjNkfs")
		game.StarterGui:SetCore("SendNotification", {
			Title = "Discord",
			Text = "Link kopyalandı!",
			Duration = 5
		})
	end)
end)

-- Harf harf yazı efekti
task.spawn(function()
	local message = "Nortex Hub'a Hoşgeldiniz"
	welcomeText.Text = ""
	for i = 1, #message do
		welcomeText.Text = string.sub(message, 1, i)
		wait(0.05)
	end
end)


