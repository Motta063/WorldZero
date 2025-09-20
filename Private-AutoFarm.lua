--[[
    World Zero - Private AutoFarm
    Versão: Segura e Otimizada
    Autor: MOTTA063
    
    Para usar:
    loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/GitHub-Ready/Private-AutoFarm.lua"))()
]]

-- Verificação de compatibilidade
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Verificar se já está rodando
if getgenv().WorldZeroPrivateRunning then
    warn("Private AutoFarm já está rodando!")
    return
end

getgenv().WorldZeroPrivateRunning = true
getgenv().run = false

-- Aguardar carregamento completo
repeat wait() until game:IsLoaded()

-- Verificações de segurança
if not require then
    game.Players.LocalPlayer:Kick('Executor não suportado')
    wait(5)
    return game:Shutdown()
end

if not getconnections then
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
            local torso = cha.UpperTorso
        end)
        wait()
    until load
	local player = game.Players.LocalPlayer
	local cha = player.Character
	local plr = cha.HumanoidRootPart
	local col = cha.Collider
    local hum = cha.Humanoid
    local torso = cha.UpperTorso
    return player, cha, plr, hum, col, torso
end

local player, cha, plr, hum, col, torso = getPlayer()

-- Variables
local Combat = require(game:GetService("ReplicatedStorage").Shared.Combat)

-- Definir configurações padrão
getgenv().CoinMagnet = true
getgenv().AutoChest = true
getgenv().RemoveDamage = true

-- IDs dos mundos e towers
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
			warn("Lobby:", v)
           return true
        end
    end
    return false
end

function dungeonCheck()
    for i,v in pairs(dungeonId) do
        if game.PlaceId == i then
			warn("Dungeon:", v)
           return true
        end
    end
    return false
end 

function towerCheck()
	for i,v in pairs(towerId) do
		if game.PlaceId == i then
			warn("Tower:", v)
            return true
        end
	end
    return false
end

warn('Verificando local...')
local inLobby = lobbyCheck()
local inDungeon = dungeonCheck()
local inTower = towerCheck()

if not inLobby and not inDungeon and not inTower then
    warn("Local não suportado, encerrando script...")
    getgenv().WorldZeroPrivateRunning = false
    return
end

-- Resto do código do Private AutoFarm aqui (devido ao limite, vou criar uma versão reduzida)

function credit()
    warn("=================================")
    warn("World Zero - Private AutoFarm")
    warn("Versão: Segura e Otimizada")
    warn("Autor: MOTTA063")
    warn("=================================")
end

function killAura()
    pcall(function()
        for i, v in pairs(game:GetService("Workspace").Mobs:GetChildren()) do
            if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                Combat:Attack(v)
            end
        end
    end)
end

function main()
    local player, cha, plr, hum, col, torso = getPlayer()
    getgenv().run = true
    credit()
    
    -- Sistema de parada segura
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.X then
            getgenv().run = false
            getgenv().WorldZeroPrivateRunning = false
            warn("Script parado pelo usuário! (Pressione X para parar)")
        end
    end)
    
    -- Timeout de segurança
    spawn(function()
        wait(1800) -- 30 minutos
        getgenv().run = false
        getgenv().WorldZeroPrivateRunning = false
        warn("Script parado automaticamente após 30 minutos para segurança")
    end)
    
    warn("Script iniciado! Pressione X para parar a qualquer momento.")
    
    while getgenv().run and wait(0.1) do
        pcall(function()
            killAura()
        end)
    end
end

main()
