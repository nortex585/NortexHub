-- Nortex Hub GUI - Brookhaven Editi 

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NortexHub"
gui.ResetOnSpawn = false

-- Açılış Yazısı
local loadingText = Instance.new("TextLabel", gui)
loadingText.Size = UDim2.new(1, 0, 1, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "...loading NortexHub"
loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 32
loadingText.TextTransparency = 1

-- Görünürlük efekti
spawn(function()
	for i = 1, 10 do
		loadingText.TextTransparency = 1 - (i * 0.1)
		wait(0.05)
	end
	wait(5)
	loadingText:Destroy()
end)

-- Mini icon (Kare & Sürüklenebilir)
local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 40, 0, 40)
miniIcon.Position = UDim2.new(0, 10, 0, 10)
miniIcon.Text = "NH"
miniIcon.TextSize = 16
miniIcon.Font = Enum.Font.GothamBold
miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
miniIcon.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
miniIcon.BorderSizePixel = 0
miniIcon.Visible = false
Instance.new("UICorner", miniIcon)
miniIcon.Parent = gui

-- Sürüklenebilirlik fonksiyonu
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
makeDraggable(miniIcon)

-- [Devamındaki tüm GUI tanımı önceki gibi devam eder]
-- Yukarıdaki loading ekranı, GUI tam yüklenmeden önce 5 saniye boyunca "...loading NortexHub" metnini gösterir.
-- Yavaşça görünür olur ve sonra kaybolur.
-- Kodun kalanını senin verdiğin gibi GUI arayüzüyle birlikte entegre edebilirim istersen.
