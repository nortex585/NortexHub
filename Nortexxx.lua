-- LocalScript (StarterGui içine koy)
local player = game.Players.LocalPlayer

--== GUI OLUŞTURMA ==--
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "MusicPlayer"
gui.ResetOnSpawn = false

-- Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0.5, -125, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0

-- Corner
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- TextBox
local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(0.9, 0, 0, 40)
textbox.Position = UDim2.new(0.05, 0, 0.15, 0)
textbox.PlaceholderText = "Müzik ID girin"
textbox.Text = ""
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
textbox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local tCorner = Instance.new("UICorner", textbox)
tCorner.CornerRadius = UDim.new(0, 8)

-- Button
local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(0.9, 0, 0, 35)
button.Position = UDim2.new(0.05, 0, 0.65, 0)
button.Text = "Müziği Çal"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local bCorner = Instance.new("UICorner", button)
bCorner.CornerRadius = UDim.new(0, 8)

--== BUTON FONKSİYONU ==--
button.MouseButton1Click:Connect(function()
	local musicId = textbox.Text

	if musicId and musicId ~= "" then
		-- Workspace'te Sound arıyoruz
		local sound = workspace:FindFirstChildWhichIsA("Sound", true)
		if sound then
			-- SoundId formatı
			if not string.find(musicId, "rbxassetid://") then
				musicId = "rbxassetid://" .. musicId
			end
			sound.SoundId = musicId
			sound.Volume = 10 -- Roblox'ta max 10, "100" mümkün değil
			sound:Play()
			print("Müzik çalıyor: " .. musicId)
		else
			warn("Workspace'te Sound nesnesi bulunamadı!")
		end
	else
		warn("Geçerli bir ID giriniz!")
	end
end)
