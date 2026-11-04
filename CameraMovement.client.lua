-- Camera Movement for Battlegrounds-style game

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Configuration
local CAMERA_DISTANCE = 15
local CAMERA_HEIGHT = 5
local CAMERA_SMOOTHNESS = 0.1
local MOUSE_SENSITIVITY = 0.5

-- Player and Camera
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Camera variables
local cameraOffset = Vector3.new(0, CAMERA_HEIGHT, -CAMERA_DISTANCE)
local cameraRotation = Vector2.new(0, 0)

-- Initialize camera
local function initializeCamera(character)
    if not character then return end
    
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    
    -- Set up camera
    camera.CameraType = Enum.CameraType.Scriptable
    camera.CameraSubject = humanoid
    
    -- Update camera position
    local function updateCamera()
        local targetPosition = rootPart.Position + cameraOffset
        local currentPosition = camera.CFrame.Position
        
        -- Smooth camera movement
        camera.CFrame = CFrame.new(
            currentPosition:Lerp(targetPosition, CAMERA_SMOOTHNESS),
            rootPart.Position
        )
    end
    
    -- Connect to RenderStepped for smooth updates
    game:GetService("RunService").RenderStepped:Connect(updateCamera)

    -- Mouse input for camera rotation
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Delta
            cameraRotation = cameraRotation + Vector2.new(delta.X, delta.Y) * MOUSE_SENSITIVITY
            
            -- Apply rotation to camera
            camera.CFrame = CFrame.new(camera.CFrame.Position) * CFrame.Angles(0, math.rad(cameraRotation.X), 0)
        end
    end)
end

-- Character added handler
player.CharacterAdded:Connect(initializeCamera)

-- Initialize if character already exists
if player.Character then
    initializeCamera(player.Character)
end

return CameraMovement