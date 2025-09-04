---@class BP_LobbyCamera_C:Pawn
---@field Camera UCameraComponent
---@field DefaultSceneRoot USceneComponent
--Edit Below--
local BP_LobbyCamera = {}
 
--[[
function BP_LobbyCamera:ReceiveBeginPlay()
    BP_LobbyCamera.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function BP_LobbyCamera:ReceiveTick(DeltaTime)
    BP_LobbyCamera.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function BP_LobbyCamera:ReceiveEndPlay()
    BP_LobbyCamera.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function BP_LobbyCamera:GetReplicatedProperties()
    return
end
--]]

--[[
function BP_LobbyCamera:GetAvailableServerRPCs()
    return
end
--]]

return BP_LobbyCamera