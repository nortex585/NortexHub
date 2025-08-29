-- LocalScript (StarterGui içine koy)
local InsertService = game:GetService("InsertService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local assetId = 132786323178755 -- modelin ID'si
local allowedPlaceId = 5673965 -- izin verilen oyun PlaceId
local player = Players.LocalPlayer

--== LOADING GUI OLUŞTUR ==--
local gui = Instance.new("ScreenGui")
gui.Name = "NortexLoader"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 150)
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 19)
frameCorner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "NORTEX HUB"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 30
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 30)
status.Position = UDim2.new(0, 0, 0, 50)
status.BackgroundTransparency = 1
status.Text = "Checking Executor"
status.TextColor3 = Color3.fromRGB(0, 255, 0)
status.Font = Enum.Font.SourceSans
status.TextSize = 24
status.Parent = frame

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0.9, 0, 0, 15)
barBg.Position = UDim2.new(0.05, 0, 1, -30)
barBg.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
barBg.BorderSizePixel = 0
barBg.Parent = frame

local barBgCorner = Instance.new("UICorner")
barBgCorner.CornerRadius = UDim.new(0, 19)
barBgCorner.Parent = barBg

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
bar.BorderSizePixel = 0
bar.Parent = barBg

local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 19)
barCorner.Parent = bar

-- Asset yükleme fonksiyonu (sonradan çağırılabilir)
local function loadAsset()
    local success, asset = pcall(function()
        return InsertService:LoadAsset(assetId)
    end)
    if success and asset then
        local localScript = asset:FindFirstChildOfClass("LocalScript")
        if localScript then
            local clone = localScript:Clone()
            clone.Parent = player:WaitForChild("PlayerGui")
            print("LocalScript başarıyla yüklendi!")
        else
            warn("Modelin içinde LocalScript bulunamadı!")
        end
    else
        warn("Asset yüklenemedi!")
    end
end

--== ANİMASYON ==--
task.spawn(function()
    local tween = TweenService:Create(bar, TweenInfo.new(9, Enum.EasingStyle.Linear), {Size = UDim2.new(1,0,1,0)})
    tween:Play()

    -- 0-3 saniye
    status.Text = "Hoşgeldiniz"
    task.wait(3)

    -- 3-6 saniye
    status.Text = "Oyun Kontrol Ediliyor"
    task.wait(3)

    -- Oyun kontrolü
    if game.PlaceId == allowedPlaceId then
        status.Text = "Başarılı"
        status.TextColor3 = Color3.fromRGB(0, 255, 0)
        -- Burada LocalScript'i henüz yüklemiyoruz
        -- Daha sonra bir buton veya süre ile loadAsset() çağrılabilir
    else
        status.Text = "Başarısız"
        status.TextColor3 = Color3.fromRGB(255, 0, 0)
    end

    task.wait(2)
    gui:Destroy()
end)

-- Örnek kullanım: 5 saniye sonra otomatik yükle
if game.PlaceId == allowedPlaceId then
    task.delay(5, loadAsset)
end
