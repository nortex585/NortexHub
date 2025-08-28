-- LocalScript (StarterGui içine koy)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI örneği
local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "CopyGui"

local button = Instance.new("TextButton", screenGui)
button.Size = UDim2.new(0, 200, 0, 50)
button.Position = UDim2.new(0.5, -100, 0.5, -25)
button.Text = "Oyuncudan Kopyala"

-- Fonksiyon: oyuncu karakterini kopyala
local function CopyAppearance(targetName)
	local targetPlayer = Players:FindFirstChild(targetName)
	if not targetPlayer then return end

	local targetChar = targetPlayer.Character
	local myChar = player.Character

	if targetChar and myChar then
		-- HumanoidDescription ile komple görünüş kopyala
		local humanoid = myChar:FindFirstChildOfClass("Humanoid")
		local targetHumanoid = targetChar:FindFirstChildOfClass("Humanoid")

		if humanoid and targetHumanoid then
			local desc = targetHumanoid:GetAppliedDescription()
			humanoid:ApplyDescription(desc)
		end
	end
end

-- Butona basınca çalışsın
button.MouseButton1Click:Connect(function()
	local targetName = "benbirdehayallerim" -- Buraya kopyalamak istediğin oyuncunun adını yaz
	CopyAppearance(targetName)
end)
