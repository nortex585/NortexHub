local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
 
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "SydearGui"
gui.ResetOnSpawn = false
 
-- Ana Panel
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 400)
frame.Position = UDim2.new(0.5, -130, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", frame).Color = Color3.fromRGB(80, 80, 80)
 
-- Başlık
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Sydear Ta Hile - Team Sydear"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Center
 
-- EN İYİ SYDEAR Yazısı
local footer = Instance.new("TextLabel", frame)
footer.Size = UDim2.new(1, 0, 0, 25)
footer.Position = UDim2.new(0, 0, 1, -25)
footer.BackgroundTransparency = 1
footer.Text = "EN İYİ SYDEAR"
footer.TextColor3 = Color3.fromRGB(200, 200, 200)
footer.Font = Enum.Font.GothamBold
footer.TextSize = 16
footer.TextXAlignment = Enum.TextXAlignment.Center
 
-- Yardımcı Fonksiyon
local function createButton(parent, name, posY, callback)
	local button = Instance.new("TextButton", parent)
	button.Size = UDim2.new(0, 220, 0, 30)
	button.Position = UDim2.new(0.5, -110, 0, posY)
	button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	button.Text = name
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)
	button.MouseButton1Click:Connect(callback)
	return button
end
 
-- TEAM MENU
local teamMenu = Instance.new("Frame", frame)
teamMenu.Size = UDim2.new(1, -20, 0, 130)
teamMenu.Position = UDim2.new(0, 10, 0, 70)
teamMenu.Visible = false
teamMenu.BackgroundTransparency = 1
 
createButton(teamMenu, "ASİZ", 0, function()
	player.Team = Teams["Askeri İnzibat"]
end)
 
createButton(teamMenu, "JANDARMA", 35, function()
	player.Team = Teams.Jandarma
end)
 
createButton(teamMenu, "SM", 70, function()
	player.Team = Teams["Sınır Müfettişleri"]
end)
 
-- TOOL MENU
local toolMenu = Instance.new("Frame", frame)
toolMenu.Size = UDim2.new(1, -20, 0, 240)
toolMenu.Position = UDim2.new(0, 10, 0, 210)
toolMenu.Visible = false
toolMenu.BackgroundTransparency = 1
 
local function give(tool)
	local backpack = player:WaitForChild("Backpack")
	if tool then
		tool:Clone().Parent = backpack
	end
end
 
createButton(toolMenu, "DET", 0, function()
	give(Teams["Askeri İnzibat"].Detain)
end)
 
createButton(toolMenu, "M4A4", 35, function()
	give(Teams["Askeri İnzibat"].M4A4)
end)
 
createButton(toolMenu, "KALKAN", 70, function()
	give(Teams["Askeri İnzibat"]["Medikal Kalkan"])
end)
 
createButton(toolMenu, "PARAŞÜT", 105, function()
	give(Teams["Hava Kuvvetleri"]["Paraşüt"])
end)
 
createButton(toolMenu, "MP7", 140, function()
	give(Teams["Hava Kuvvetleri"].MP7)
end)
 
createButton(toolMenu, "HK416", 175, function()
	give(Teams.Jandarma.HK416)
end)
 
createButton(toolMenu, "EAGLE", 210, function()
	give(Teams["Ordu Subayları"]["Desert Eagle"])
end)
 
-- Ana Menü Butonları
createButton(frame, "TEAM CHANGER", 35, function()
	teamMenu.Visible = not teamMenu.Visible
	toolMenu.Visible = false
end)
 
createButton(frame, "TOOL CHANGER", 170, function()
	toolMenu.Visible = not toolMenu.Visible
	teamMenu.Visible = false
end)
 
-- Sürükleme Sistemi
local dragging, dragInput, dragStart, startPos = false
 
local function update(input)
	local delta = input.Position - dragStart
	frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
 
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
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
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)
 
UIS.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)
