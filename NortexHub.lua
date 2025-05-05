-- Nortex Hub GUI - Brookhaven Edition (GÜncellenmiş ve teleport + avatar destekli)

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NortexHub"
gui.ResetOnSpawn = false

-- Mini icon (Kare NH)
local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 40, 0, 40)
miniIcon.Position = UDim2.new(0, 10, 0, 10)
miniIcon.Text = "NH"
miniIcon.Visible = false
miniIcon.Parent = gui
miniIcon.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
miniIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
miniIcon.BorderSizePixel = 0
Instance.new("UICorner", miniIcon)

local function makeDraggable(frame)
	local UIS = game:GetService("UserInputService")
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
	end)
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end
makeDraggable(miniIcon)

-- Main GUI
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0.1, 0, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Name = "MainFrame"
main.BorderSizePixel = 0
Instance.new("UICorner", main)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Text = "Nortex Hub [BETA] : Brookhaven"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BorderSizePixel = 0
Instance.new("UICorner", title)
makeDraggable(main)

local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Instance.new("UICorner", closeBtn)

local miniBtn = Instance.new("TextButton", main)
miniBtn.Size = UDim2.new(0, 30, 0, 30)
miniBtn.Position = UDim2.new(1, -70, 0, 5)
miniBtn.Text = "-"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 14
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
Instance.new("UICorner", miniBtn)

closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)
miniBtn.MouseButton1Click:Connect(function() main.Visible = false miniIcon.Visible = true end)
miniIcon.MouseButton1Click:Connect(function() main.Visible = true miniIcon.Visible = false end)

local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(0, 120, 1, -40)
tabHolder.Position = UDim2.new(0, 0, 0, 40)
tabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", tabHolder)

local contentHolder = Instance.new("Frame", main)
contentHolder.Size = UDim2.new(1, -120, 1, -40)
contentHolder.Position = UDim2.new(0, 120, 0, 40)
contentHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", contentHolder)

local tabNames = {"Discord", "Avatar", "Teleports"}

for i, name in ipairs(tabNames) do
	local btn = Instance.new("TextButton", tabHolder)
	btn.Size = UDim2.new(1, 0, 0, 30)
	btn.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.Font = Enum.Font.Gotham
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 14
	Instance.new("UICorner", btn)

	btn.MouseButton1Click:Connect(function()
		contentHolder:ClearAllChildren()
		if name == "Discord" then
			local discordBtn = Instance.new("TextButton", contentHolder)
			discordBtn.Size = UDim2.new(0, 200, 0, 40)
			discordBtn.Position = UDim2.new(0, 20, 0, 20)
			discordBtn.Text = "Join Discord"
			discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			discordBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
			Instance.new("UICorner", discordBtn)
			discordBtn.MouseButton1Click:Connect(function()
				setclipboard("https://discord.gg/YOUR_CODE")
				game.StarterGui:SetCore("SendNotification", {Title="Discord", Text="Kopyalandı!", Duration=5})
			end)
		elseif name == "Avatar" then
			local items = {
				{"Right Korblox", function()
					player.Character.RightLeg.Transparency = 1
				end},
				{"Left Korblox", function()
					player.Character.LeftLeg.Transparency = 1
				end},
				{"Headless", function()
					player.Character.Head.Transparency = 1
					player.Character.Head.face:Destroy()
				end}
			}
			for i, info in ipairs(items) do
				local btn = Instance.new("TextButton", contentHolder)
				btn.Size = UDim2.new(0, 200, 0, 30)
				btn.Position = UDim2.new(0, 20, 0, i * 40)
				btn.Text = info[1]
				btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				btn.TextColor3 = Color3.fromRGB(255, 255, 255)
				Instance.new("UICorner", btn)
				btn.MouseButton1Click:Connect(info[2])
			end
		elseif name == "Teleports" then
			local label = Instance.new("TextLabel", contentHolder)
			label.Text = "Oyuncu Adı:"
			label.Position = UDim2.new(0, 20, 0, 20)
			label.Size = UDim2.new(0, 150, 0, 25)
			label.BackgroundTransparency = 1
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
			label.Font = Enum.Font.Gotham
			label.TextSize = 16

			local nameBox = Instance.new("TextBox", contentHolder)
			nameBox.Size = UDim2.new(0, 200, 0, 30)
			nameBox.Position = UDim2.new(0, 20, 0, 60)
			nameBox.PlaceholderText = "OyuncuAdı"
			nameBox.TextColor3 = Color3.fromRGB(0, 0, 0)
			nameBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Instance.new("UICorner", nameBox)

			local tpBtn = Instance.new("TextButton", contentHolder)
			tpBtn.Size = UDim2.new(0, 100, 0, 30)
			tpBtn.Position = UDim2.new(0, 20, 0, 100)
			tpBtn.Text = "Teleport"
			tpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
			tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			Instance.new("UICorner", tpBtn)

			tpBtn.MouseButton1Click:Connect(function()
				local target = game.Players:FindFirstChild(nameBox.Text)
				if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
					player.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0))
				else
					game.StarterGui:SetCore("SendNotification", {Title="Hata", Text="Oyuncu bulunamadı", Duration=3})
				end
			end)
		end
	end)
end
