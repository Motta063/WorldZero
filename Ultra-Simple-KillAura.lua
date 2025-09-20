--[[
    World Zero - Ultra Simple Kill Aura
    Só mata mobs - nada mais
    
    loadstring(game:HttpGet("SEU-LINK-AQUI"))()
]]

-- Aguardar jogo carregar
repeat wait() until game:IsLoaded()

-- Verificar se já está rodando
if _G.UltraKillRunning then
    warn("Script já rodando!")
    return
end

_G.UltraKillRunning = true
_G.UltraKillEnabled = true

local player = game.Players.LocalPlayer

-- Aguardar character
repeat wait() until player.Character
repeat wait() until player.Character:FindFirstChild("HumanoidRootPart")

-- Aguardar Combat
local Combat
repeat 
    wait()
    local success = pcall(function()
        Combat = require(game.ReplicatedStorage.Shared.Combat)
    end)
until success and Combat

print("✅ Kill Aura Carregado!")

-- Função principal
spawn(function()
    while _G.UltraKillEnabled do
        pcall(function()
            -- Pegar todos os mobs
            local mobs = game.Workspace:FindFirstChild("Mobs")
            if mobs then
                for _, mob in pairs(mobs:GetChildren()) do
                    if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                        -- Atacar o mob
                        Combat:Attack(mob)
                    end
                end
            end
        end)
        wait(0.5) -- Delay entre ataques
    end
end)

-- Parar com X
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.X then
        _G.UltraKillEnabled = false
        _G.UltraKillRunning = false
        warn("❌ Kill Aura PARADO!")
    end
end)

-- Timeout 15 minutos
spawn(function()
    wait(900) -- 15 minutos
    _G.UltraKillEnabled = false
    _G.UltraKillRunning = false
    warn("⏰ Script parado automaticamente")
end)

warn("🎯 KILL AURA ATIVO! Pressione X para parar")

-- Reconectar quando morrer
player.CharacterAdded:Connect(function()
    repeat wait() until player.Character:FindFirstChild("HumanoidRootPart")
    warn("🔄 Character respawnou, continuando...")
end)
