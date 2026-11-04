# Smoothest Battlegrounds

This project provides a combat system and camera movement for a Battlegrounds-style game in Roblox. The combat system handles player attacks, damage, and cooldowns, while the camera movement script ensures smooth and responsive camera controls for an immersive gameplay experience.

## Install

1. **CombatSystem.server.lua**
   - Place this script in the ServerScriptService.
   - It will automatically create a RemoteEvent for handling attacks.

2. **CameraMovement.client.lua**
   - Place this script in StarterPlayerScripts.
   - It will handle camera movement for each player.

## Use

1. **CombatSystem.server.lua**
   - Configure the combat settings at the top of the script:
     - `COMBAT_RANGE`: Set the attack range.
     - `DAMAGE_AMOUNT`: Set the damage per attack.
     - `ATTACK_COOLDOWN`: Set the time between attacks.
   - Replace the placeholder animation ID with an actual animation ID from Roblox.

2. **CameraMovement.client.lua**
   - Adjust the camera settings at the top of the script:
     - `CAMERA_DISTANCE`: Set the distance of the camera from the player.
     - `CAMERA_HEIGHT`: Set the height of the camera above the player.
     - `CAMERA_SMOOTHNESS`: Set the smoothness of camera movement.
     - `MOUSE_SENSITIVITY`: Set the sensitivity of mouse movement for camera rotation.

---

More Roblox script projects by EnderDevelopment: https://github.com/EnderDevelopment

Project page: https://dash.enderdevelopment.com/community/fcacd610-99e0-48b5-9ead-b66766c55a29?utm_source=github&utm_medium=readme&utm_campaign=auto_publish&utm_content=fcacd610-99e0-48b5-9ead-b66766c55a29
