local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI oluşturma
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

-- Ana GUI Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.Parent = screenGui

-- Köşe yuvarlatma için UICorner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Sol taraf için kaydırılabilir frame
local leftFrame = Instance.new("Frame")
leftFrame.Size = UDim2.new(0, 200, 1, 0)
leftFrame.Position = UDim2.new(0, 0, 0, 0)
leftFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
leftFrame.Parent = mainFrame

-- Sağ tarafta açılabilir panel
local rightFrame = Instance.new("Frame")
rightFrame.Size = UDim2.new(0, 0, 1, 0)
rightFrame.Position = UDim2.new(0, 200, 0, 0)
rightFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
rightFrame.Parent = mainFrame
rightFrame.Visible = false

-- Kaydırılabilir alan için uçuş butonu
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(1, 0, 0, 50)
flyButton.Position = UDim2.new(0, 0, 0, 50)
flyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Parent = leftFrame

-- Fly açma/kapatma tuşu
local flyToggleButton = Instance.new("TextButton")
flyToggleButton.Size = UDim2.new(1, 0, 0, 50)
flyToggleButton.Position = UDim2.new(0, 0, 0, 100)
flyToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
flyToggleButton.Text = "Fly'ı Aç/Kapat"
flyToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyToggleButton.Parent = leftFrame

-- Uçuş hızını ayarlama kısmı
local speedSlider = Instance.new("Slider")
speedSlider.Size = UDim2.new(0, 200, 0, 30)
speedSlider.Position = UDim2.new(0, 10, 0, 150)
speedSlider.Min = 0
speedSlider.Max = 100
speedSlider.Parent = rightFrame

-- Kapatma butonu
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = mainFrame

-- Küçültme butonu
local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -70, 0, 5)
minimizeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
minimizeButton.Text = "_"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.Parent = mainFrame

-- Fly'ı açma işlevi
local flyEnabled = false
local flyingSpeed = 50

local function toggleFly()
    flyEnabled = not flyEnabled
    if flyEnabled then
        rightFrame.Visible = true
        flyToggleButton.Text = "Fly'ı Kapat"
    else
        rightFrame.Visible = false
        flyToggleButton.Text = "Fly'ı Aç"
    end
end

-- Uçuş hızını ayarlama işlevi
speedSlider.Changed:Connect(function()
    flyingSpeed = speedSlider.Value
end)

-- Kapatma butonuna işlev ekle
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Küçültme butonuna işlev ekle
minimizeButton.MouseButton1Click:Connect(function()
    if mainFrame.Size == UDim2.new(0, 300, 0, 400) then
        mainFrame.Size = UDim2.new(0, 300, 0, 50)
    else
        mainFrame.Size = UDim2.new(0, 300, 0, 400)
    end
end)

-- Sürüklenebilir yapma
local dragging = false
local dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging then
        updateInput(input)
    end
end)

-- Butonlara tıklama işlevi ekleyelim
flyButton.MouseButton1Click:Connect(function()
    rightFrame.Visible = not rightFrame.Visible
end)

flyToggleButton.MouseButton1Click:Connect(toggleFly)
