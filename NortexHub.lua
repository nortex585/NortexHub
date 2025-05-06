-- Nortex Hub GUI - Brookhaven Editi 

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "NortexHub"
gui.ResetOnSpawn = false

-- Açılış Yazısı
local loadingText = Instance.new("TextLabel", gui)
loadingText.Size = UDim2.new(1, 0, 1, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "NortexHub"
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
	wait(5) -- 5 saniye gösterme süresi
	loadingText:Destroy() -- Yazıyı yok et

	-- GUI'yi göster
	gui.Enabled = true
end)

-- Mini icon (Kare & Sürüklenebilir)
local miniIcon = Instance.new("TextButton")
miniIcon.Size = UDim2.new(0, 40, 0, 40) -- Kare boyut
miniIcon.Position = UDim2.new(0, 10, 0, 10)
miniIcon.Text = "NH" -- Kısaltılmış metin
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

-- Ana GUI
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 400)
main.Position = UDim2.new(0.1, 0, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Name = "MainFrame"
main.BorderSizePixel = 0
Instance.new("UICorner", main)

-- Başlık
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Text = "Nortex Hub [BETA] : Brookhaven"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BorderSizePixel = 0
title.Name = "TitleBar"
Instance.new("UICorner", title)

makeDraggable(main)

-- Kapat (X)
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

-- Küçült (-)
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

-- Buton işlevleri
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

-- Sol menü
local tabHolder = Instance.new("Frame", main)
tabHolder.Size = UDim2.new(0, 120, 1, -40)
tabHolder.Position = UDim2.new(0, 0, 0, 40)
tabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabHolder.BorderSizePixel = 0
Instance.new("UICorner", tabHolder)

-- İçerik alanı
local contentHolder = Instance.new("Frame", main)
contentHolder.Size = UDim2.new(1, -120, 1, -40)
contentHolder.Position = UDim2.new(0, 120, 0, 40)
contentHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
contentHolder.BorderSizePixel = 0
Instance.new("UICorner", contentHolder)

-- Sekme butonları
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
                setclipboard("https://discord.gg/YOUR_INVITE_CODE") -- Linki buraya ekle
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Discord",
                    Text = "Link kopyalandı! Tarayıcıya yapıştır.",
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
