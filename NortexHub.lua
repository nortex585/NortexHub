-- GUI Oluştur
local screenGui = Instance.new("ScreenGui")
local button = Instance.new("TextButton")

screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
button.Parent = screenGui

button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Düşmanları Aşağı At!"
button.BackgroundColor3 = Color3.new(1, 0, 0)

-- Fonksiyon: Düşmanları aşağı atar
local function pushEnemiesDown()
    for _, enemy in pairs(workspace:GetDescendants()) do
        if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
            if enemy ~= game.Players.LocalPlayer.Character then
                enemy.HumanoidRootPart.Velocity = Vector3.new(0, -500, 0) -- Aşağı doğru hızlı bir itme
            end
        end
    end
end

-- Buton tıklanınca fonksiyon çalışır
button.MouseButton1Click:Connect(pushEnemiesDown)
