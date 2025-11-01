_Hawk = "ohhahtuhthttouttpwuttuaunbotwo"
local Hawk = loadstring(game:HttpGet("https://raw.githubusercontent.com/xwerta/HawkHUB/refs/heads/main/Roblox/UILibs/HawkLib.lua", true))()

local TweenService = game:GetService("TweenService")
local Players      = game:GetService("Players")
local Workspace    = game:GetService("Workspace")

-- ==================== UI ====================
local Window = Hawk:Window({
    ScriptName      = "Nortex Hub",
    DestroyIfExists = true,
    Theme           = "Dark"
})

Window:Close({ visibility = true, Callback = function() Window:Destroy() end })
Window:Minimize({ visibility = true, OpenButton = true, Callback = function() end })

local Notifications = Hawk:AddNotifications()
local HomeTab       = Window:Tab("Home")
local MainTab       = Window:Tab("Main")
local TeleportsTab  = Window:Tab("Teleports")
local PlayerTab     = Window:Tab("Player")

-- ==================== HOME TAB - EN ÜSTTE SPYRO VİDEOSU (TEST KODUNDAN ALINDI) ====================
local homeSec = HomeTab:Section("Nortex Hub")

--Creating Image (Test Kodundan Birebir)
homeSec:Image("Türk Sohbet Oyunu", "Hawk", {
    Name = "Türk Sohbet Oyunu",
    FileName = "Spyro.webm",
    CheckFile = false,
    ImageLink = "rbxassetid://76022680841782",
    ImageColor = Color3.fromRGB(255, 255, 255),
    Stroke = Color3.fromRGB(255, 255, 255),
    Volume = 1,
    Description = {"Euro Farm", "ParkourMoney Farm"}
})

-- Diğer Home Etiketleri
homeSec:Label("Euro Farm (Fix)")
homeSec:Label("ParkourMoney Farm (Artık çalışıyor)")
homeSec:Label("Hız, Işınlanma, Yeni UI")

-- ==================== DEĞİŞKENLER ====================
local euroFarmActive    = false
local parkourFarmActive = false
local selectedPlayer    = nil
local euroConn          = nil
local parkourConn       = nil

-- ==================== YARDIMCI FONKSİYONLAR ====================
local function getCurrentEuroParts()
    local parts = {}
    local targetFolder = nil
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Folder") and obj:FindFirstChild("ParkourMoney") then
            targetFolder = obj
            break
        end
    end
    if targetFolder then
        for _, obj in pairs(targetFolder:GetChildren()) do
            if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.CanCollide and obj.Name ~= "ParkourMoney" then
                if obj.Parent then
                    table.insert(parts, obj)
                end
            end
        end
    end
    return parts
end

local function getParkourModels()
    local models = {}
    local targetFolder = nil
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("Folder") and obj:FindFirstChild("ParkourMoney") then
            targetFolder = obj
            break
        end
    end
    if targetFolder then
        for _, model in pairs(targetFolder:GetChildren()) do
            if model.Name == "ParkourMoney" and model:IsA("Model") and model.Parent then
                table.insert(models, model)
            end
        end
    end
    return models
end

local function getPlayerNames()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then table.insert(list, p.Name) end
    end
    return list
end

-- ==================== EURO FARM ====================
local function startEuroFarm()
    if euroConn then return end
    euroConn = task.spawn(function()
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local currentIndex = 1
        while euroFarmActive do
            local targets = getCurrentEuroParts()
            if #targets == 0 then task.wait(1); continue end
            if currentIndex > #targets then currentIndex = 1 end
            local targetPart = targets[currentIndex]
            if targetPart and targetPart.Parent and hrp and hrp.Parent then
                hrp.CFrame = targetPart.CFrame + Vector3.new(0, 10, 0)
                local tween = TweenService:Create(
                    hrp,
                    TweenInfo.new(0.8, Enum.EasingStyle.Linear),
                    {CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)}
                )
                tween:Play()
                pcall(function() tween.Completed:Wait() end)
            end
            currentIndex = currentIndex + 1
            task.wait(3)
        end
    end)
end

local function stopEuroFarm()
    euroFarmActive = false
    if euroConn then task.cancel(euroConn); euroConn = nil end
end

-- ==================== PARKOURMONEY FARM ====================
local function startParkourFarm()
    if parkourConn then return end
    parkourConn = task.spawn(function()
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local currentIndex = 1
        while parkourFarmActive do
            local models = getParkourModels()
            if #models == 0 then task.wait(1); continue end
            if currentIndex > #models then currentIndex = 1 end
            local targetModel = models[currentIndex]
            if targetModel and targetModel.Parent then
                local targetCFrame = targetModel.PrimaryPart and targetModel.PrimaryPart.CFrame
                                 or targetModel:FindFirstChildWhichIsA("BasePart") and targetModel:FindFirstChildWhichIsA("BasePart").CFrame
                                 or targetModel:GetPivot()
                if hrp and hrp.Parent then
                    hrp.CFrame = targetCFrame + Vector3.new(0, 10, 0)
                    local tween = TweenService:Create(
                        hrp,
                        TweenInfo.new(0.8, Enum.EasingStyle.Linear),
                        {CFrame = targetCFrame + Vector3.new(0, 3, 0)}
                    )
                    tween:Play()
                    pcall(function() tween.Completed:Wait() end)
                end
            end
            currentIndex = currentIndex + 1
            task.wait(3)
        end
    end)
end

local function stopParkourFarm()
    parkourFarmActive = false
    if parkourConn then task.cancel(parkourConn); parkourConn = nil end
end

-- ==================== MAIN TAB ====================
local mainSec = MainTab:Section("Farm Sistemleri")

mainSec:Toggle("Euro Farm (Dinamik)", false, function(state)
    euroFarmActive = state
    if state then
        startEuroFarm()
        Notifications:Notification("Başarılı", "Euro Farm başladı! (Sürekli tarar)", "Done", 2)
    else
        stopEuroFarm()
        Notifications:Notification("Kapatıldı", "Euro Farm durduruldu.", "Warn", 2)
    end
end)

mainSec:Toggle("ParkourMoney Farm (Model)", false, function(state)
    parkourFarmActive = state
    if state then
        startParkourFarm()
        Notifications:Notification("Başarılı", "ParkourMoney Farm başladı! (5x Model)", "Done", 2)
    else
        stopParkourFarm()
        Notifications:Notification("Kapatıldı", "ParkourMoney Farm durduruldu.", "Warn", 2)
    end
end)

-- ==== TOPLANABİLİR EURO SAYACI (ANLIK GÜNCELLENİR) ====
local euroCountLabel = mainSec:Label("Toplanabilir Euro: 0")

task.spawn(function()
    while task.wait(1) do
        local count = #getCurrentEuroParts()
        pcall(function()
            euroCountLabel:SetText("Toplanabilir Euro: " .. count)
        end)
    end
end)

-- ==================== TELEPORTS TAB ====================
local tpSec = TeleportsTab:Section("Hazır Işınlanmalar")

tpSec:Button("Spawn", function()
    local m = Workspace:FindFirstChild("SpawnLocationModel")
    if m and m:FindFirstChild("SpawnLocation") then
        local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = m.SpawnLocation.CFrame + Vector3.new(0, 5, 0)
            Notifications:Notification("Işınlandın", "Spawn'a ışınlandın!", "Done", 2)
        end
    else
        Notifications:Notification("Hata", "Spawn bulunamadı!", "Error", 2)
    end
end)

tpSec:Button("Market", function()
    local shop = Workspace:FindFirstChild("Shopblock2")
    if shop then
        local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = shop.CFrame + Vector3.new(0, 5, 0)
            Notifications:Notification("Işınlandın", "Markete ışınlandın!", "Done", 2)
        end
    else
        Notifications:Notification("Hata", "Market bulunamadı!", "Error", 2)
    end
end)

tpSec:Button("Halısaha", function()
    local f = Workspace:FindFirstChild("FutbolGerekli")
    if f and f:FindFirstChild("TopSpawner") then
        local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = f.TopSpawner.CFrame + Vector3.new(0, 5, 0)
            Notifications:Notification("Işınlandın", "Halısahaya ışınlandın!", "Done", 2)
        end
    else
        Notifications:Notification("Hata", "Halısaha bulunamadı!", "Error", 2)
    end
end)

-- ==================== OYUNCU IŞINLANMA ====================
local playerSec = TeleportsTab:Section("Oyuncuya Işınlan")
local playerDropdown = playerSec:Dropdown("Oyuncu Seç", getPlayerNames(), function(name)
    selectedPlayer = Players:FindFirstChild(name)
end)

playerSec:Button("Refresh", function()
    playerDropdown:Refresh(getPlayerNames(), false)
    Notifications:Notification("Güncellendi", "Liste yenilendi!", "Done", 1)
end)

playerSec:Button("Işınla", function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = selectedPlayer.Character.HumanoidRootPart
        local hrp = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = target.CFrame + Vector3.new(0, 5, 0)
            Notifications:Notification("Işınlandın", selectedPlayer.Name .. " yanına!", "Done", 2)
        end
    else
        Notifications:Notification("Hata", "Oyuncu seçin!", "Error", 2)
    end
end)

-- ==================== PLAYER TAB ====================
local playerSecTab = PlayerTab:Section("Karakter Ayarları")
playerSecTab:TextBox("Hız Ayarla", "16", function(txt)
    local speed = tonumber(txt)
    local char = Players.LocalPlayer.Character
    if speed and char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
        Notifications:Notification("Hız", "Yeni hız: " .. speed, "Done", 1)
    end
end)

-- ==================== BAŞLANGIÇ BİLDİRİMİ ====================
Notifications:Notification("Nortex Hub", "Spyro videosu yüklendi + Dinamik Euro Farm aktif!", "Done", 4)
