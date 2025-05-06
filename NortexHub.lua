local Players = game:GetService("Players")
local player = Players.LocalPlayer
 
-- GUI oluştur
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "Ta sydearr hub team fake op"
 
-- Hoşgeldin yazısı
local welcomeText = Instance.new("TextLabel", gui)
welcomeText.Size = UDim2.new(0.6, 0, 0, 50)
welcomeText.Position = UDim2.new(0.2, 0, 0.1, 0)
welcomeText.BackgroundTransparency = 1
welcomeText.Text = "Sydearr Hub Team Fake OP"
welcomeText.TextScaled = true
welcomeText.Font = Enum.Font.GothamBold
welcomeText.TextColor3 = Color3.fromRGB(255, 255, 255)
 
-- Fade out ile yazıyı kaldır
task.delay(3, function()
	for i = 1, 20 do
		welcomeText.TextTransparency = i / 20
		task.wait(0.05)
	end
	welcomeText:Destroy()
end)
 
-- Ana Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
 
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)
 
-- TextBox
local textBox = Instance.new("TextBox", frame)
textBox.Size = UDim2.new(0.9, 0, 0, 40)
textBox.Position = UDim2.new(0.05, 0, 0.2, 0)
textBox.PlaceholderText = "Yaz..."
textBox.Text = ""
textBox.TextScaled = true
textBox.Font = Enum.Font.Gotham
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
 
local tbCorner = Instance.new("UICorner", textBox)
tbCorner.CornerRadius = UDim.new(0, 8)
 
-- Buton
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0, 40)
button.Position = UDim2.new(0.05, 0, 0.6, 0)
button.Text = "op ver"
button.TextScaled = true
button.Font = Enum.Font.GothamBold
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
 
local btnCorner = Instance.new("UICorner", button)
btnCorner.CornerRadius = UDim.new(0, 8)
 
-- Butona tıklanınca yazıyı değiştir
button.MouseButton1Click:Connect(function()
	local yazilan = textBox.Text
	local hedef = player:FindFirstChild("PlayerGui") and player.PlayerGui:FindFirstChild("Frames")
	if hedef and hedef:FindFirstChild("Market") and hedef.Market:FindFirstChild("Onur") then
		hedef.Market.Onur.Text = yazilan
	end
end)
