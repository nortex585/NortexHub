-- Nortex Hub GUI - Brookhaven Edition (Tam Sürüm, Avatar Sekmesi ile)

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NortexHub"
gui.ResetOnSpawn = false

-- Mini icon (NH)
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
main.BorderSizePixel = 0
Instance.new("UICorner", main)

-- Title Bar
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

-- Close & Minimize
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.BorderSizePixel = 0
Instance.new("UICorner", closeBtn)

local miniBtn = Instance.new("TextButton", main)
miniBtn.Size = UDim2.new(0, 30, 0, 30)
miniBtn.Position = UDim2.new(1, -70, 0, 5)
miniBtn.Text = "-"
miniBtn.Font = Enum.Font.GothamBold
miniBtn.TextSize = 14
miniBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
miniBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
miniBtn.BorderSizePixel = 0
Instance.new("UICorner", miniBtn)

closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)
miniBtn.MouseButton1Click:Connect(function() main.Visible = false miniIcon.Visible = true end)
miniIcon.MouseButton1Click:Connect(function() main.Visible = true miniIcon.Visible = false end)

-- Tablar
local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(0, 120, 1, -40)
tabHolder.Position = UDim2.new(0, 0, 0, 40)
tabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabHolder.BorderSizePixel = 0
Instance.new("UICorner", tabHolder)

local contentHolder = Instance.new("Frame", main)
contentHolder.Size = UDim2.new(1, -120, 1, -40)
contentHolder.Position = UDim2.new(0, 120, 0, 40)
contentHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
contentHolder.BorderSizePixel = 0
Instance.new("UICorner", contentHolder)

local tabNames = {"Discord", "Avatar", "Shop", "Mini Games", "Player", "Teleports", "Misc"}

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
	Instance.new("UICorner", btn)

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
			Instance.new("UICorner", discordBtn)
			discordBtn.MouseButton1Click:Connect(function()
				setclipboard("https://discord.gg/YOUR_INVITE_CODE")
				game.StarterGui:SetCore("SendNotification", {
					Title = "Discord",
					Text = "Link kopyalandı!",
					Duration = 5
				})
			end)
		elseif name == "Avatar" then
			local function createButton(text, y, callback)
				local btn = Instance.new("TextButton", contentHolder)
				btn.Size = UDim2.new(0, 200, 0, 40)
				btn.Position = UDim2.new(0, 20, 0, y)
				btn.Text = text
				btn.Font = Enum.Font.GothamBold
				btn.TextSize = 14
				btn.TextColor3 = Color3.fromRGB(255, 255, 255)
				btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				btn.BorderSizePixel = 0
				Instance.new("UICorner", btn)
				btn.MouseButton1Click:Connect(callback)
			end

			createButton("Right Korblox", 20, function()
				local desc = Instance.new("HumanoidDescription")
				desc.RightLeg = 438405791 -- örnek ID
				player.Character:FindFirstChildOfClass("Humanoid"):ApplyDescription(desc)
			end)

			createButton("Left Korblox", 70, function()
				local desc = Instance.new("HumanoidDescription")
				desc.LeftLeg = 438405791
				player.Character:FindFirstChildOfClass("Humanoid"):ApplyDescription(desc)
			end)

			createButton("Headless", 120, function()
				local desc = Instance.new("HumanoidDescription")
				desc.Head = 134082579
				desc.HeadScale = 0
				player.Character:FindFirstChildOfClass("Humanoid"):ApplyDescription(desc)
			end)

			-- Kıyafet kopyalama kutusu
			local nameBox = Instance.new("TextBox", contentHolder)
			nameBox.Size = UDim2.new(0, 200, 0, 40)
			nameBox.Position = UDim2.new(0, 20, 0, 180)
			nameBox.PlaceholderText = "Oyuncu ismi gir..."
			nameBox.Font = Enum.Font.Gotham
			nameBox.TextSize = 14
			nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			nameBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			nameBox.BorderSizePixel = 0
			Instance.new("UICorner", nameBox)

			local copyBtn = Instance.new("TextButton", contentHolder)
			copyBtn.Size = UDim2.new(0, 200, 0, 40)
			copyBtn.Position = UDim2.new(0, 20, 0, 230)
			copyBtn.Text = "Kıyafet Kopyala"
			copyBtn.Font = Enum.Font.GothamBold
			copyBtn.TextSize = 14
			copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
			copyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
			copyBtn.BorderSizePixel = 0
			Instance.new("UICorner", copyBtn)

			copyBtn.MouseButton1Click:Connect(function()
				local targetName = nameBox.Text
				local targetPlayer = game.Players:FindFirstChild(targetName)

				if targetPlayer and targetPlayer.Character then
					local humanoid = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
					local myHumanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

					if humanoid and myHumanoid then
						local desc = humanoid:GetAppliedDescription()
						myHumanoid:ApplyDescription(desc)
						game.StarterGui:SetCore("SendNotification", {
							Title = "Başarılı",
							Text = targetName .. " kıyafeti kopyalandı!",
							Duration = 4
						})
					else
						warn("Humanoid bulunamadı.")
					end
				else
					game.StarterGui:SetCore("SendNotification", {
						Title = "HATA",
						Text = "Oyuncu bulunamadı!",
						Duration = 4
					})
				end
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
