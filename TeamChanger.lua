-- GUI Oluştur
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Button = Instance.new("TextButton")

-- Parent ayarla
ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Frame ayarları
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0

-- TextBox ayarları
TextBox.Parent = Frame
TextBox.PlaceholderText = "Takım ismini gir"
TextBox.Size = UDim2.new(0, 200, 0, 40)
TextBox.Position = UDim2.new(0.5, -100, 0, 20)
TextBox.Text = ""

-- Button ayarları
Button.Parent = Frame
Button.Text = "Takıma Katıl"
Button.Size = UDim2.new(0, 200, 0, 40)
Button.Position = UDim2.new(0.5, -100, 0, 80)

-- Butona tıklanınca
Button.MouseButton1Click:Connect(function()
    local teamName = TextBox.Text
    local team = game:GetService("Teams"):FindFirstChild(teamName)
    if team then
        local player = game:GetService("Players").LocalPlayer
        player.Team = team
        player:LoadCharacter()
    else
        warn("Takım bulunamadı: " .. teamName)
    end
end)
