-- Combat System for Battlegrounds-style game

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuration
local COMBAT_RANGE = 10
local DAMAGE_AMOUNT = 10
local ATTACK_COOLDOWN = 1

-- Remote Events
local attackEvent = Instance.new("RemoteEvent")
attackEvent.Name = "AttackEvent"
attackEvent.Parent = ReplicatedStorage

-- Player Data
local playerData = {}

-- Initialize player data
Players.PlayerAdded:Connect(function(player)
    playerData[player] = {
        lastAttackTime = 0,
        isAttacking = false
    }

    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            playerData[player].isAttacking = false
        end)
    end)
end)

-- Attack function
local function attack(player)
    local currentTime = os.time()
    if currentTime - playerData[player].lastAttackTime < ATTACK_COOLDOWN then
        return
    end

    playerData[player].lastAttackTime = currentTime
    playerData[player].isAttacking = true

    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    -- Check for enemies in range
    local enemies = {}
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter then
                local otherHumanoid = otherCharacter:FindFirstChildOfClass("Humanoid")
                local otherRootPart = otherCharacter:FindFirstChild("HumanoidRootPart")
                
                if otherHumanoid and otherRootPart and otherHumanoid.Health > 0 then
                    local distance = (rootPart.Position - otherRootPart.Position).Magnitude
                    if distance <= COMBAT_RANGE then
                        table.insert(enemies, otherHumanoid)
                    end
                end
            end
        end
    end

    -- Deal damage to enemies
    for _, enemy in ipairs(enemies) do
        enemy:TakeDamage(DAMAGE_AMOUNT)
    end

    -- Animation
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if animator then
        local animationTrack = animator:LoadAnimation(script:WaitForChild("AttackAnimation"))
        animationTrack:Play()
    end

    -- Reset attack state
    task.wait(0.5) -- Animation duration
    playerData[player].isAttacking = false
end

-- Event handler
attackEvent.OnServerEvent:Connect(function(player)
    attack(player)
end)

-- Animation
local attackAnimation = Instance.new("Animation")
attackAnimation.Name = "AttackAnimation"
attackAnimation.AnimationId = "rbxassetid://123456789" -- Replace with actual animation ID
attackAnimation.Parent = script

return CombatSystem