local teamName = "Red"

local team = game.Teams:FindFirstChild(teamName)
if team then
    game.Players.LocalPlayer.Team = team
    game.Players.LocalPlayer:LoadCharacter()
else
    warn("Takım bulunamadı: " .. teamName)
end
