--[[
    World Zero - Kill Aura que Funciona
    Versão robusta e testada
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Motta063/WorldZero/main/Working-KillAura.lua"))()
]]

print("🔄 Iniciando World Zero Kill Aura...")

-- Verificar se já está rodando
if getgenv().WorkingKillAura then
    warn("⚠️ Kill Aura já está ativo!")
    return
end

getgenv().WorkingKillAura = true
getgenv().KillEnabled = true

-- Aguardar jogo carregar completamente
if not game:IsLoaded() then
    print("⏳ Aguardando jogo carregar...")
    game.Loaded:Wait()
end

wait(2) -- Aguardar um pouco mais

-- Serviços
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

print("✅ Serviços carregados")

-- Aguardar character completamente
local function waitForCharacter()
    while not player.Character do
        wait(0.1)
    end
    
    while not player.Character:FindFirstChild("HumanoidRootPart") do
        wait(0.1)
    end
    
    while not player.Character:FindFirstChild("Humanoid") do
        wait(0.1)
    end
    
    -- Aguardar um pouco mais para garantir
    wait(1)
    
    return player.Character
end

local character = waitForCharacter()
print("✅ Character carregado:", character.Name)

-- Tentar carregar Combat de várias formas
local Combat

-- Método 1: Tentar carregar diretamente
local function loadCombat()
    local attempts = 0
    while not Combat and attempts < 30 do
        attempts = attempts + 1
        
        pcall(function()
            -- Verificar se ReplicatedStorage.Shared existe
            local shared = ReplicatedStorage:WaitForChild("Shared", 1)
            if shared then
                local combatModule = shared:WaitForChild("Combat", 1)
                if combatModule then
                    Combat = require(combatModule)
                    print("✅ Combat carregado via Método 1")
                end
            end
        end)
        
        if not Combat then
            wait(0.5)
        end
    end
end

loadCombat()

-- Método 2: Se falhou, tentar método alternativo
if not Combat then
    print("🔄 Tentando método alternativo...")
    
    local attempts = 0
    while not Combat and attempts < 20 do
        attempts = attempts + 1
        
        pcall(function()
            local allModules = ReplicatedStorage:GetDescendants()
            for _, module in pairs(allModules) do
                if module.Name == "Combat" and module:IsA("ModuleScript") then
                    Combat = require(module)
                    print("✅ Combat carregado via Método 2")
                    break
                end
            end
        end)
        
        if not Combat then
            wait(0.5)
        end
    end
end

-- Verificar se conseguiu carregar Combat
if not Combat then
    warn("❌ Erro: Não conseguiu carregar Combat!")
    warn("❌ Verifique se você está no World Zero")
    getgenv().WorkingKillAura = false
    return
end

print("✅ Combat carregado com sucesso!")

-- Função para atacar (método simples)
local function attackMobs()
    if not getgenv().KillEnabled then return end
    
    pcall(function()
        local mobsFolder = Workspace:FindFirstChild("Mobs")
        if not mobsFolder then return end
        
        for _, mob in pairs(mobsFolder:GetChildren()) do
            if not getgenv().KillEnabled then break end
            
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                if mob.Humanoid.Health > 0 then
                    -- Tentar vários métodos de ataque
                    pcall(function()
                        -- Método 1: Combat:Attack
                        Combat:Attack(mob)
                    end)
                    
                    pcall(function()
                        -- Método 2: Se tiver AttackTargets
                        if Combat.AttackTargets then
                            Combat.AttackTargets(nil, {mob}, {mob.HumanoidRootPart.Position}, "BasicAttack")
                        end
                    end)
                    
                    wait(0.1) -- Pequeno delay entre ataques
                end
            end
        end
    end)
end

-- Controles
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.X then
        getgenv().KillEnabled = false
        getgenv().WorkingKillAura = false
        warn("❌ Kill Aura parado pelo usuário!")
    end
end)

-- Timeout de segurança (5 minutos)
spawn(function()
    wait(300)
    getgenv().KillEnabled = false
    getgenv().WorkingKillAura = false
    warn("⏰ Kill Aura parado automaticamente após 5 minutos")
end)

-- Character respawn
player.CharacterAdded:Connect(function(newChar)
    if getgenv().KillEnabled then
        character = waitForCharacter()
        warn("🔄 Character respawnou, continuando...")
    end
end)

-- Iniciar
warn("=================================")
warn("🎯 World Zero Kill Aura ATIVO!")
warn("❌ Pressione X para parar")
warn("⏰ Para automaticamente em 5 minutos")
warn("=================================")

-- Loop principal
spawn(function()
    while getgenv().KillEnabled do
        attackMobs()
        wait(0.5) -- Delay entre ciclos
    end
    warn("🛑 Kill Aura finalizado!")
end)

print("✅ Script iniciado com sucesso!")
