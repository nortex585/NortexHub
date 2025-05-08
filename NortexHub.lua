-- StarterGui içine bir ScreenGui yerleştir, içine TextButton ve bu scripti ekle
local button = script.Parent

button.Text = "Titreşim Gönder"

button.MouseButton1Click:Connect(function()
	local gamepad = Enum.UserInputType.Gamepad1
	local vibrationIntensity = 1 -- 0 ile 1 arasında
	local vibrationDuration = 5 -- saniye

	local userInputService = game:GetService("UserInputService")

	if userInputService:GetLastInputType() == gamepad then
		-- Titreşimi başlat
		userInputService:SetGamepadVibration(gamepad, Enum.VibrationMotor.Large, vibrationIntensity)
		
		-- 5 saniye bekle
		task.wait(vibrationDuration)
		
		-- Titreşimi durdur
		userInputService:SetGamepadVibration(gamepad, Enum.VibrationMotor.Large, 0)
	else
		warn("Gamepad bağlı değil veya kullanılmıyor.")
	end
end)
