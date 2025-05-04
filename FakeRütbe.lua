ocal Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local function updateNameTag(character)
    local head = character:FindFirstChild("Head") or character:WaitForChild("Head", 5)
    if not head then
        warn("Head bulunamadı.")
        return
    end

    local nametag
    for , gui in pairs(head:GetChildren()) do
        if gui:IsA("BillboardGui") then
            nametag = gui
            break
        end
    end

    if not nametag then
        warn("BillboardGui bulunamadı.")
        return
    end

    local label
    for , child in pairs(nametag:GetChildren()) do
        if child:IsA("TextLabel") then
            label = child
            break
        end
    end

    if not label then
        warn("TextLabel bulunamadı.")
        return
    end

 
    label.Text = "İstediğiniz Rütbe"
    label.TextColor3 = Color3.fromRGB(255, 0, 0)
    label.TextSize = 20
end


if player.Character then
    updateNameTag(player.Character)
end

player.CharacterAdded:Connect(function(character)
    updateNameTag(character)
end) 
