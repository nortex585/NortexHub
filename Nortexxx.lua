local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Orion/main/source"))()
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Window = OrionLib:MakeWindow({
    Name = "Nortex Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "NortexHubConfig",
    IntroEnabled = true,
    IntroText = "Nortex Hub'a Hoşgeldiniz!",
    IntroIcon = "rbxassetid://4483345998"
})

-- Home Tab
local HomeTab = Window:MakeTab({Name = "Home", Icon = "rbxassetid://4483345998", PremiumOnly = false})
HomeTab:AddLabel("Euro Farm Eklendi!")
HomeTab:AddLabel("Hız Eklendi!")
HomeTab:AddLabel("Işınlanma Eklendi")
HomeTab:AddLabel("Yeni UI")
HomeTab:AddLabel("NOT : Parkour Money çalışmayabilir!")

-- Main Tab
local MainTab = Window:MakeTab({Name = "Main", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local euroFarmActive = false
local parkourFarmActive = false

-- EuroFarm helper
local function getTargetParts(folder)
    local parts = {}
    if folder then
        for _, obj in pairs(folder:GetChildren()) do
            if (obj:IsA("BasePart") or obj:IsA("MeshPart")) and obj.CanCollide then
                table.insert(parts, obj)
            end
        end
    end
    return parts
end

local function euroFarmLoop()
    spawn(function()
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        local euroFolder
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("Folder") and obj:FindFirstChild("ParkourMoney") then
                euroFolder = obj
                break
            end
        end
        local currentIndex = 1
        while euroFarmActive do
            local targets = getTargetParts(euroFolder)
            if #targets > 0 then
                local targetPart = targets[currentIndex]
                if targetPart then
                    hrp.CFrame = targetPart.CFrame + Vector3.new(0,10,0)
                    local tween = TweenService:Create(
                        hrp,
                        TweenInfo.new(1, Enum.EasingStyle.Linear),
                        {CFrame = targetPart.CFrame + Vector3.new(0,3,0)}
                    )
                    tween:Play()
                    tween.Completed:Wait()
                end
                currentIndex += 1
                if currentIndex > #targets then currentIndex = 1 end
            end
            task.wait(3)
        end
    end)
end

-- ParkourMoney helper
local function getAllTouchParts(parent)
    local parts = {}
    for _, obj in pairs(parent:GetChildren()) do
        if obj:IsA("BasePart") and obj.Name == "Touch" then
            table.insert(parts, obj)
        end
        if obj:IsA("Model") or obj:IsA("Folder") then
            local childParts = getAllTouchParts(obj)
            for _, p in pairs(childParts) do
                table.insert(parts, p)
            end
        end
    end
    return parts
end

local function parkourFarmLoop()
    spawn(function()
        local player = Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local hrp = character:WaitForChild("HumanoidRootPart")
        while parkourFarmActive do
            local targets = getAllTouchParts(workspace)
            for _, targetPart in ipairs(targets) do
                if not parkourFarmActive then break end
                hrp.CFrame = targetPart.CFrame + Vector3.new(0,10,0)
                local tween = TweenService:Create(
                    hrp,
                    TweenInfo.new(1, Enum.EasingStyle.Linear),
                    {CFrame = targetPart.CFrame + Vector3.new(0,3,0)}
                )
                tween:Play()
                tween.Completed:Wait()
                task.wait(3)
            end
            task.wait(1)
        end
    end)
end

-- Main Tab toggle’ları
MainTab:AddToggle({
    Name = "Euro Farm",
    Default = false,
    Callback = function(Value)
        euroFarmActive = Value
        if euroFarmActive then euroFarmLoop() end
    end
})

MainTab:AddToggle({
    Name = "ParkourMoney Farm",
    Default = false,
    Callback = function(Value)
        parkourFarmActive = Value
        if parkourFarmActive then parkourFarmLoop() end
    end
})

-- Teleports Tab
local TeleportsTab = Window:MakeTab({Name = "Teleports", Icon = "rbxassetid://4483345998", PremiumOnly = false})

-- Mevcut 3 buton
TeleportsTab:AddButton({Name = "Spawn", Callback = function() print("Spawn") end})
TeleportsTab:AddButton({Name = "Market", Callback = function() print("Market") end})
TeleportsTab:AddButton({Name = "Halısaha", Callback = function() print("Halısaha") end})

-- Dropdown ve ışınlama
local selectedPlayer = nil
local function getPlayerNames()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Players.LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    return list
end

local playerDropdown = TeleportsTab:AddDropdown({
    Name = "Player",
    Default = "Seç",
    Options = getPlayerNames(),
    Callback = function(Value)
        selectedPlayer = Players:FindFirstChild(Value)
    end
})

-- Işınlama butonu
TeleportsTab:AddButton({
    Name = "Işınla",
    Callback = function()
        if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetHRP = selectedPlayer.Character.HumanoidRootPart
            local playerHRP = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if playerHRP then
                playerHRP.CFrame = targetHRP.CFrame + Vector3.new(0,5,0)
            end
        end
    end
})

-- Dropdown refresh butonu
TeleportsTab:AddButton({
    Name = "Refresh",
    Callback = function()
        playerDropdown:Refresh(getPlayerNames(), true)
        print("Oyuncu listesi güncellendi!")
    end
})

-- Player Tab
local PlayerTab = Window:MakeTab({Name = "Player", Icon = "rbxassetid://4483345998", PremiumOnly = false})
PlayerTab:AddTextbox({
    Name = "Hız",
    Default = "16",
    TextDisappear = false,
    Callback = function(Value)
        local speed = tonumber(Value)
        if speed and Players.LocalPlayer.Character then
            Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
})
PlayerTab:AddToggle({Name = "Enable", Default = false, Callback = function(Value) end})

-- Init UI
OrionLib:Init()
