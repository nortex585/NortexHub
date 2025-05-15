local UserInputService = game:GetService("UserInputService")

-- GUI Oluşturma --
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GyroscopeGUI"
screenGui.Parent = playerGui

-- Ana Frame --
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.BackgroundColor3 = Color3.new(0,0,0)
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Parent = screenGui

local uiCornerMain = Instance.new("UICorner", mainFrame)
uiCornerMain.CornerRadius = UDim.new(0, 10)

-- Üst Başlık Çubuğu (Sürüklenebilir) --
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.BackgroundColor3 = Color3.new(0, 0, 0)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Parent = mainFrame

local uiCornerTitle = Instance.new("UICorner", titleBar)
uiCornerTitle.CornerRadius = UDim.new(0, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(0.6, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.Text = "Gyroscope v1.0"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Kapat Butonu --
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
closeButton.Size = UDim2.new(0, 40, 1, 0)
closeButton.Position = UDim2.new(0.8, 0, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.Parent = titleBar

local uiCornerClose = Instance.new("UICorner", closeButton)
uiCornerClose.CornerRadius = UDim.new(0, 5)

-- Sekme Butonu (Küçült/Göster) --
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
toggleButton.Size = UDim2.new(0, 40, 1, 0)
toggleButton.Position = UDim2.new(0.65, 0, 0, 0)
toggleButton.Text = "-"
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 24
toggleButton.Parent = titleBar

local uiCornerToggle = Instance.new("UICorner", toggleButton)
uiCornerToggle.CornerRadius = UDim.new(0, 5)

-- Ana İçerik --
local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.BackgroundTransparency = 1
contentFrame.Size = UDim2.new(1, 0, 1, -30)
contentFrame.Position = UDim2.new(0, 0, 0, 30)
contentFrame.Parent = mainFrame

-- Gyroscope Aç/Kapat Butonu --
local gyroButton = Instance.new("TextButton")
gyroButton.Name = "GyroButton"
gyroButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
gyroButton.Size = UDim2.new(0, 120, 0, 40)
gyroButton.Position = UDim2.new(0.5, -60, 0.5, -20)
gyroButton.Text = "Gyroscope Aç"
gyroButton.TextColor3 = Color3.new(1,1,1)
gyroButton.Font = Enum.Font.SourceSansBold
gyroButton.TextSize = 20
gyroButton.Parent = contentFrame

local uiCornerGyro = Instance.new("UICorner", gyroButton)
uiCornerGyro.CornerRadius = UDim.new(0, 8)

-- Sekme Boyutuna Küçültülmüş Kare --
local miniFrame = Instance.new("Frame")
miniFrame.Name = "MiniFrame"
miniFrame.BackgroundColor3 = Color3.new(0,0,0)
miniFrame.Size = UDim2.new(0, 80, 0, 30)
miniFrame.Position = UDim2.new(0.5, -40, 0.5, -15)
miniFrame.AnchorPoint = Vector2.new(0.5,0.5)
miniFrame.Visible = false
miniFrame.Parent = screenGui

local uiCornerMini = Instance.new("UICorner", miniFrame)
uiCornerMini.CornerRadius = UDim.new(0, 10)

local miniLabel = Instance.new("TextLabel")
miniLabel.Name = "MiniLabel"
miniLabel.BackgroundTransparency = 1
miniLabel.Size = UDim2.new(1, 0, 1, 0)
miniLabel.Text = "GR"
miniLabel.TextColor3 = Color3.new(1,1,1)
miniLabel.Font = Enum.Font.SourceSansBold
miniLabel.TextSize = 20
miniLabel.Parent = miniFrame

-- Sürükleme Fonksiyonu --
local function makeDraggable(frame, dragArea)
    local dragging = false
    local dragInput
    local dragStart
    local startPos

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                math.clamp(startPos.X.Scale, 0, 1),
                math.clamp(startPos.X.Offset + delta.X, 0, workspace.CurrentCamera.ViewportSize.X - frame.AbsoluteSize.X),
                math.clamp(startPos.Y.Scale, 0, 1),
                math.clamp(startPos.Y.Offset + delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - frame.AbsoluteSize.Y)
            )
        end
    end)
end

makeDraggable(mainFrame, titleBar)
makeDraggable(miniFrame, miniFrame)

-- Gyroscope Kontrol --
local gyroEnabled = false

local function updateGyroButton()
    if gyroEnabled then
        gyroButton.Text = "Gyroscope Kapat"
    else
        gyroButton.Text = "Gyroscope Aç"
    end
end

gyroButton.MouseButton1Click:Connect(function()
    gyroEnabled = not gyroEnabled
    updateGyroButton()
end)

updateGyroButton()

-- Kapat Butonu --
closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniFrame.Visible = true
end)

-- Sekme Butonu (küçültme) --
toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    miniFrame.Visible = true
end)

-- Mini Frame tıklayınca ana GUI gösterilsin --
miniFrame.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    miniFrame.Visible = false
end)

-- Mini Frame için tıklama ve sürükleme --
local draggingMini = false
local dragInputMini
local dragStartMini
local startPosMini

miniFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingMini = true
        dragStartMini = input.Position
        startPosMini = miniFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingMini = false
            end
        end)
    end
end)

miniFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputMini = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInputMini and draggingMini then
        local delta = input.Position - dragStartMini
        miniFrame.Position = UDim2.new(
            math.clamp(startPosMini.X.Scale, 0, 1),
            math.clamp(startPosMini.X.Offset + delta.X, 0, workspace.CurrentCamera.ViewportSize.X - miniFrame.AbsoluteSize.X),
            math.clamp(startPosMini.Y.Scale, 0, 1),
            math.clamp(startPosMini.Y.Offset + delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - miniFrame.AbsoluteSize.Y)
        )
    end
end)

-- Gyroscope Etkinleştirme Scripti --
local function onRenderStep()
    if gyroEnabled then
        local rotation = UserInputService:GetDeviceRotation()
        -- Örnek: Karakteri döndür (isteğe göre düzenleyebilirsin)
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart then
            humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * rotation
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(onRenderStep)
