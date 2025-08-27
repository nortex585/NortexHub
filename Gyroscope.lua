-- [[ TEK SCRIPT: Notez Hub for Zyper v.00.1 ]] --

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- RemoteEvent oluştur (varsa kullan)
local event = ReplicatedStorage:FindFirstChild("GiveEuro")
if not event then
    event = Instance.new("RemoteEvent")
    event.Name = "GiveEuro"
    event.Parent = ReplicatedStorage
end

-- Oyuncu oyuna girince leaderstats + GUI kur
Players.PlayerAdded:Connect(function(player)
    -- Leaderstats
    local stats = Instance.new("Folder")
    stats.Name = "leaderstats"
    stats.Parent = player

    local euro = Instance.new("IntValue")
    euro.Name = "Euro"
    euro.Value = 0
    euro.Parent = stats

    -- GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "NotezHub"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 30)
    title.Position = UDim2.new(0,10,0,0)
    title.BackgroundTransparency = 1
    title.Text = "Notez Hub for Zyper"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = frame

    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(0,80,0,20)
    version.Position = UDim2.new(0,5,1,-25)
    version.BackgroundTransparency = 1
    version.Text = "v.00.1"
    version.TextColor3 = Color3.fromRGB(200,200,200)
    version.TextScaled = true
    version.Font = Enum.Font.SourceSans
    version.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0,30,0,30)
    closeBtn.Position = UDim2.new(1,-35,0,5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,0,0)
    closeBtn.Font = Enum.Font.SourceSansBold
    closeBtn.TextScaled = true
    closeBtn.Parent = frame

    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0,8)
    corner2.Parent = closeBtn

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.8,0,0,40)
    box.Position = UDim2.new(0.1,0,0.4,0)
    box.BackgroundColor3 = Color3.fromRGB(40,40,40)
    box.PlaceholderText = "Miktar gir..."
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.Font = Enum.Font.SourceSans
    box.TextScaled = true
    box.Parent = frame

    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0,8)
    corner3.Parent = box

    local addBtn = Instance.new("TextButton")
    addBtn.Size = UDim2.new(0.6,0,0,40)
    addBtn.Position = UDim2.new(0.2,0,0.7,0)
    addBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    addBtn.Text = "Ekle"
    addBtn.TextColor3 = Color3.fromRGB(255,255,255)
    addBtn.Font = Enum.Font.SourceSansBold
    addBtn.TextScaled = true
    addBtn.Parent = frame

    local corner4 = Instance.new("UICorner")
    corner4.CornerRadius = UDim.new(0,8)
    corner4.Parent = addBtn

    -- Local kısım (GUI eventleri için)
    gui.Parent = player:WaitForChild("PlayerGui")

    closeBtn.MouseButton1Click:Connect(function()
        frame.Visible = false
    end)

    addBtn.MouseButton1Click:Connect(function()
        local amount = tonumber(box.Text)
        if amount and amount > 0 then
            event:FireServer(amount)
        end
    end)
end)

-- Server tarafında Euro ekleme
event.OnServerEvent:Connect(function(player, amount)
    if type(amount) == "number" and amount > 0 then
        local stats = player:FindFirstChild("leaderstats")
        if stats then
            local euro = stats:FindFirstChild("Euro")
            if euro then
                euro.Value = euro.Value + amount
            end
        end
    end
end)
