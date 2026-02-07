local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- ==================== SERVISLER & DEGISKENLER ====================
local TweenService = game:GetService("TweenService")
local Players      = game:GetService("Players")
local Workspace    = game:GetService("Workspace")
local LocalPlayer  = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")

local tlFarmActive      = false
local tlConn            = nil
local autoRejoinEnabled = false
local antiAfkEnabled      = true
local selectedPlayerName = ""

-- ==================== YARDIMCI FONKSIYONLAR ====================
local function getCurrentTLParts()
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
                if obj.Parent then table.insert(parts, obj) end
            end
        end
    end
    return parts
end

local function getPlayerNames()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(list, p.Name) end
    end
    return list
end

-- ==================== PENCERE OLUŞTURMA ====================
local Window = Rayfield:CreateWindow({
   Name = "Nortex Hub | Turk Sohbet",
   LoadingTitle = "Nortex Hub",
   LoadingSubtitle = "by Zypersl",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   ConfigurationSaving = {
      Enabled = true,
      FileName = "NortexHubConfig",
      Folder = "NortexHubConfigs"
   },
   KeySystem = false
})

-- ==================== TABLAR ====================
local HomeTab = Window:CreateTab("Home", nil)
local MainTab = Window:CreateTab("Farm", nil)
local TeleportsTab = Window:CreateTab("Isinlanma", nil)
local SettingsTab = Window:CreateTab("Ayarlar", nil)

-- ==================== HOME TAB ====================
HomeTab:CreateSection("Sosyal Medya")

HomeTab:CreateButton({
   Name = "Discord Sunucusuna Katil (Kopyala)",
   Callback = function()
      setclipboard("https://discord.gg/bS6uMXuT85")
      Rayfield:Notify({
          Title = "Nortex Hub",
          Content = "Discord linki başarıyla kopyalandı!",
          Duration = 3,
          Image = 4483362458,
      })
   end,
})

HomeTab:CreateSection("Nortex Hub Ozellikleri")
HomeTab:CreateLabel("TL Farm")
HomeTab:CreateLabel("Hub Acilip Kapansa Bile Secimleri Hatirlar Ve otomatik calistirir")
HomeTab:CreateLabel("Anti AFK")
HomeTab:CreateLabel("Auto Rejoin")
HomeTab:CreateLabel("Hub Henuz Betadadir Sorunlari Discordan bildirin!")

-- ==================== MAIN (FARM) TAB ====================
MainTab:CreateSection("Para Farm Sistemleri")

MainTab:CreateToggle({
   Name = "TL Farm (Güvenli Mod)",
   CurrentValue = false,
   Flag = "TLFarmToggle",
   Callback = function(Value)
      tlFarmActive = Value
      if Value then
         tlConn = task.spawn(function()
            while tlFarmActive do
               local targets = getCurrentTLParts()
               
               if #targets == 0 then
                  task.wait(1.5) 
                  continue
               end

               local targetPart = targets[1]
               local character = LocalPlayer.Character
               local hrp = character and character:FindFirstChild("HumanoidRootPart")
               
               if targetPart and targetPart.Parent and hrp then
                  -- Kick yememek için önce biraz uzağına ışınlanıp sonra Tween yapıyoruz
                  hrp.CFrame = targetPart.CFrame + Vector3.new(0, 12, 0)
                  task.wait(0.1)
                  
                  -- Tween hızı 0.8 saniyeye çekildi (Daha yavaş ve güvenli)
                  local tween = TweenService:Create(hrp, TweenInfo.new(0.8, Enum.EasingStyle.Quad), {CFrame = targetPart.CFrame + Vector3.new(0, 2, 0)})
                  tween:Play()
                  
                  local start = tick()
                  -- Parçanın alınmasını bekle
                  repeat task.wait() until not targetPart.Parent or (tick() - start > 1.2)
               end
               -- Her toplama sonrası kısa bir "mola" (Anti-Cheat için)
               task.wait(0.5)
            end
         end)
      else
         if tlConn then task.cancel(tlConn); tlConn = nil end
      end
   end,
})

MainTab:CreateSection("Istatistikler")
local TLCounterLabel = MainTab:CreateLabel("Toplanabilir TL: Taraniyor...")
local CurrentTLLabel = MainTab:CreateLabel("Mevcut TL: Yukleniyor...")

task.spawn(function()
    while true do
        local partsCount = #getCurrentTLParts()
        TLCounterLabel:Set("Toplanabilir TL: " .. partsCount)
        local stats = LocalPlayer:FindFirstChild("leaderstats")
        if stats and stats:FindFirstChild("TL") then
            CurrentTLLabel:Set("Mevcut TL: " .. tostring(stats.TL.Value))
        end
        task.wait(1)
    end
end)

-- ==================== TELEPORTS TAB ====================
TeleportsTab:CreateSection("Harita Isinlanmalari")

TeleportsTab:CreateButton({
   Name = "Spawn'a Git",
   Callback = function()
      pcall(function()
          local target = Workspace.Folder.MapMainFolder.Builds.lobi.Model.SpawnLocation
          local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
          if target and hrp then hrp.CFrame = target.CFrame + Vector3.new(0, 5, 0) end
      end)
   end,
})

local PlayerDropdown = TeleportsTab:CreateDropdown({
   Name = "Oyuncu Sec",
   Options = getPlayerNames(),
   CurrentOption = "",
   Flag = "PlayerTargetDropdown", 
   Callback = function(Option)
      if type(Option) == "table" then selectedPlayerName = Option[1] else selectedPlayerName = Option end
   end,
})

TeleportsTab:CreateButton({
   Name = "Listeyi Yenile",
   Callback = function() PlayerDropdown:Refresh(getPlayerNames(), true) end,
})

TeleportsTab:CreateButton({
   Name = "Oyuncuya Isinla",
   Callback = function()
      if selectedPlayerName ~= "" then
          local targetPlayer = Players:FindFirstChild(selectedPlayerName)
          if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
             local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
             if myHrp then
                myHrp.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
             end
          end
      end
   end,
})

-- ==================== SETTINGS TAB ====================
SettingsTab:CreateSection("Sistem Ayarlari")

SettingsTab:CreateToggle({
   Name = "Anti AFK",
   CurrentValue = true,
   Flag = "AntiAFK_AlwaysOn",
   Callback = function(Value) antiAfkEnabled = Value end,
})

SettingsTab:CreateToggle({
   Name = "Auto Rejoin",
   CurrentValue = false,
   Flag = "AutoRejoinToggle",
   Callback = function(Value) autoRejoinEnabled = Value end,
})

SettingsTab:CreateSlider({
   Name = "Yurume Hizi",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Flag = "WS_Slider",
   Callback = function(Value)
      if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
          LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

-- ==================== ARKA PLAN MANTIGI ====================

-- Anti AFK
task.spawn(function()
    while true do
        if antiAfkEnabled then
            pcall(function()
                local char = LocalPlayer.Character
                local backpack = LocalPlayer:FindFirstChild("Backpack")
                if char and backpack then
                    local tool = backpack:FindFirstChildOfClass("Tool")
                    if tool then
                        char.Humanoid:EquipTool(tool)
                        task.wait(0.2)
                        char.Humanoid:UnequipTools()
                    end
                end
            end)
        end
        task.wait(10)
    end
end)

-- Auto Rejoin
game:GetService("GuiService").ErrorMessageChanged:Connect(function()
    if autoRejoinEnabled then
        task.wait(5)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
end)

Rayfield:LoadConfiguration()
Rayfield:Notify({Title = "Nortex Hub", Content = "Güvenli Farm Modu Aktif!", Duration = 3})
