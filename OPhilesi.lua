-- Oyuncu ve GUI oluşturma
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local button = Instance.new("TextButton")
local textBox = Instance.new("TextBox")

-- ScreenGui'yi ekliyoruz
screenGui.Parent = player.PlayerGui
screenGui.Name = "OnurPuanı"

-- Frame ayarları
frame.Parent = screenGui
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- TextBox ayarları (OnurPuanı miktarını yazacağız)
textBox.Parent = frame
textBox.Size = UDim2.new(0, 200, 0, 50)
textBox.Position = UDim2.new(0.5, -100, 0.2, -25)
textBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
textBox.PlaceholderText = "OnurPuanı miktarını girin"
textBox.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Button ayarları
button.Parent = frame
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
button.Text = "Çalıştır"
button.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Button tıklama fonksiyonu
button.MouseButton1Click:Connect(function()
    local onurPuanıAmount = tonumber(textBox.Text) -- TextBox'tan girilen değeri alıyoruz
    if onurPuanıAmount then
        -- OnurPuanı miktarını oyuncuya ekliyoruz (örneğin, oyuncunun leaderstats kısmına ekliyoruz)
        if player:FindFirstChild("leaderstats") then
            local onurPuanıCurrency = player.leaderstats:FindFirstChild("OnurPuanı")
            if onurPuanıCurrency then
                onurPuanıCurrency.Value = onurPuanıCurrency.Value + onurPuanıAmount
                print("OnurPuanı eklendi: " .. onurPuanıAmount)
            else
                -- Eğer OnurPuanı para birimi yoksa, yeni bir tane oluşturuyoruz
                local newOnurPuanıCurrency = Instance.new("IntValue")
                newOnurPuanıCurrency.Name = "OnurPuanı"
                newOnurPuanıCurrency.Parent = player.leaderstats
                newOnurPuanıCurrency.Value = onurPuanıAmount
                print("Yeni OnurPuanı eklendi: " .. onurPuanıAmount)
            end
        else
            print("leaderstats bulunamadı!")
        end
    else
        print("Geçerli bir OnurPuanı miktarı girin.")
    end
end)
