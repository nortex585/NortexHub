-- GUI oluşturma
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local button = Instance.new("TextButton")

-- ScreenGui'yi ekliyoruz
screenGui.Parent = player.PlayerGui
screenGui.Name = "ÇarkSüresiSıfırlama"

-- Frame ayarları
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- Button ayarları
button.Parent = frame
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.Text = "Çark Süresini Sıfırla"
button.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Button tıklama fonksiyonu
button.MouseButton1Click:Connect(function()
    -- Çarkın bekleme süresi sıfırlanacak
    local çark = game.Workspace:WaitForChild("Çark") -- Çark objesi
    local sonÇevrilmeZamanı = çark:FindFirstChild("SonÇevrilmeZamanı") -- Çarkın son çevrilme zamanı

    if sonÇevrilmeZamanı then
        sonÇevrilmeZamanı.Value = 0 -- Zamanı sıfırlıyoruz
        print("Çarkın bekleme süresi sıfırlandı!")
    else
        print("Çarkın son çevrilme zamanı bulunamadı.")
    end
end)
