local button = script.Parent

button.Text = "Titreşim Gönder"

button.MouseButton1Click:Connect(function()
	local gamepad = Enum.UserInputType.Gamepad1
	local userInputService = game:GetService("UserInputService")

	if userInputService:GetLastInputType() == gamepad then
		userInputService:SetGamepadVibration(gamepad, Enum.VibrationMotor.Large, 1)
		task.wait(5)
		userInputService:SetGamepadVibration(gamepad, Enum.VibrationMotor.Large, 0)
	else
		warn("Gamepad bağlı değil veya kullanılmıyor.")
	end
end)
