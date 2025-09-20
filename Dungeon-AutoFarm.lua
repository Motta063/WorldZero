--[[
    World Zero - Dungeon AutoFarm
    Versão: Segura e Otimizada
    Autor: MOTTA063
    
    Para usar:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/GitHub-Ready/Dungeon-AutoFarm.lua"))()
]]

-- Verificação de compatibilidade
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Verificar se já está rodando
if getgenv().WorldZeroDungeonRunning then
    warn("Dungeon AutoFarm já está rodando!")
    return
end

getgenv().WorldZeroDungeonRunning = true
_G.run = false

-- Aguardar carregamento completo
repeat wait() until game:IsLoaded()

-- Verificações de segurança
if not require then
    game.Players.LocalPlayer:Kick('Executor não suportado')
    wait(5)
    return game:Shutdown()
end

function getPlayer()
    local load
    player, cha, plr, col = nil, nil, nil, nil
    repeat 
        load = pcall(function()
            local player = game.Players.LocalPlayer
            local cha = player.Character
            local plr = cha.HumanoidRootPart
            local col = cha.Collider
            local hum = cha.Humanoid
        end)
        wait()
    until load
	local player = game.Players.LocalPlayer
	local cha = player.Character
	local plr = cha.HumanoidRootPart
	local col = cha.Collider
    local hum = cha.Humanoid
    return player, cha, plr, hum, col
end

local player, cha, plr, hum, col = getPlayer()

-- IDs dos mundos e dungeons
local dungeonId = {
	-- world 1
	[2978696440] = 'Crabby Crusade (1-1)', 
	[4310476380] = 'Scarecrow Defense (1-2)', 
	[4310464656] = 'Dire Problem (1-3)',
	[4310478830] = 'Kingslayer (1-4)',
	[3383444582] = 'Gravetower Dungeon (1-5)',
	
	[3885726701] = 'Temple of Ruin (2-1)',
	[3994953548] = 'Mama Trauma (2-2)',
	[4050468028] = "Volcano's Shadow (2-3)",
	[3165900886] = 'Volcano Dungeon (2-4)',
	
	[4465988196] = 'Mountain Pass (3-1)',
	[4465989351] = 'Winter Cavern (3-2)',
	[4465989998] = 'Winter Dungeon (3-3)',

	[4646473427] = 'Scrap Canyon (4-1)',
	[4646475342] = 'Deserted Burrowmine (4-2)',
	[4646475570] = 'Pyramid Dungeon (4-3)',
	
	[6386112652] = 'Konoh Heartlands (5-1)',
	[6510862058] = 'Atlantic Atoll (6-1)',
	[6847034886] = 'Mezuvia Skylands (7-1)'
}

local towerId = {
	[5703353651] = 'Prison Tower',
	[6075085184] = 'Atlantis Tower'
}

local lobbyId = {
	[2727067538] = 'Main menu',
	[4310463616] = 'World 1',
	[4310463940] = 'World 2',
	[4465987684] = 'World 3',
	[4646472003] = 'World 4',
	[5703355191] = 'World 5',
	[6075083204] = 'World 6',
	[6847035264] = 'World 7'
}

function lobbyCheck()
    for i,v in pairs(lobbyId) do
        if game.PlaceId == i then
			warn('Checking Lobby')
			warn("Lobby:", v)
           return true
        end
    end
    return false
end

function dungeonCheck()
	warn('Verificando local...')
    for i,v in pairs(dungeonId) do
        if game.PlaceId == i then
			warn("Dungeon:", v)
           return true
        end
    end
	for i,v in pairs(towerId) do
		if game.PlaceId == i then
			warn("Tower:", v)
           return true
        end
	end
	warn('Local não suportado')
    getgenv().WorldZeroDungeonRunning = false
    return player:Kick('Local não suportado')
end 

local inLobby = lobbyCheck()
local inDungeon = dungeonCheck()

if inLobby then
	warn('Aguardando entrar em dungeon...')
	return
elseif inDungeon then

function credit()
    warn("=================================")
    warn("World Zero - Dungeon AutoFarm")
    warn("Versão: Segura e Otimizada")
    warn("Autor: MOTTA063")
    warn("=================================")
end

function killAura()
    pcall(function()
        for i, v in pairs(game:GetService("Workspace").Mobs:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                local Combat = require(game:GetService("ReplicatedStorage").Shared.Combat)
                Combat:Attack(v)
            end
        end
    end)
end

function noClip()
    local player, cha, plr, hum, col = getPlayer()
    if not col:FindFirstChild('BodyVelocity') then
        local BodyVelocity = Instance.new("BodyVelocity", col)
    end
    wait(0.1)
    plr.CanCollide = false
    col.CanCollide = false
end

function invisibleModel()
    -- Otimizada para evitar lag excessivo
    pcall(function()
        for i,v in pairs(game.Workspace:GetChildren()) do
            if v:IsA('Model') and v.Name ~= 'Gate' and v.Name ~= 'Camera' then
                -- Apenas torna invisível em vez de destruir
                for _,part in pairs(v:GetDescendants()) do
                    if part:IsA('BasePart') then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            elseif v:IsA('Part') and v.Name ~= 'Baseplate' then
                v.Transparency = 1
                v.CanCollide = false
            end
        end
    end)
end

function main()
    local player, cha, plr, hum, col = getPlayer()
    _G.run = true
    noClip()
    credit()
    invisibleModel()
    
    -- Sistema de parada segura
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.X then
            _G.run = false
            getgenv().WorldZeroDungeonRunning = false
            warn("Script parado pelo usuário! (Pressione X para parar)")
        end
    end)
    
    -- Timeout de segurança (para em 25 minutos para evitar detecção)
    spawn(function()
        wait(1500) -- 25 minutos
        _G.run = false
        getgenv().WorldZeroDungeonRunning = false
        warn("Script parado automaticamente após 25 minutos para segurança")
    end)
    
    warn("Script Dungeon iniciado! Pressione X para parar a qualquer momento.")
    
    while _G.run and wait(0.1) do
        pcall(function()
            killAura()
        end)
    end
end

main()

end
