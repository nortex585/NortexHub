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

-- Yükleme % Barı animasyonu
task.spawn(function()
	for i = 0, 100, 1 do
		loadingBar:TweenSize(UDim2.new(i / 100, 0, 1, 0), "Out", "Linear", 0.1, true)
		percentLabel.Text = "Yükleniyor... %" .. tostring(i)
		wait(0.1)
	end
	loadingPanel:Destroy()
	main.Visible = true
end)
