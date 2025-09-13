local CNAPlayerController = {}
 
UGCGameSystem.UGCRequire("Script.UI.Lobby.LobbyScripts.LobbyFlow")

function CNAPlayerController:ReceiveBeginPlay()
    CNAPlayerController.SuperClass.ReceiveBeginPlay(self)
    self:Init();
    
end

function CNAPlayerController:Init()

    self:LobbyUIInit();

end

function CNAPlayerController:LobbyUIInit()
    
    LobbyFlow:SwitchToLobbyCamera(self);

    if self:HasAuthority()==false then
        LobbyFlow:HideBeginUI();
        LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_MainLobby);
    end
    
end

--[[
function CNAPlayerController:ReceiveTick(DeltaTime)
    CNAPlayerController.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function CNAPlayerController:ReceiveEndPlay()
    CNAPlayerController.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function CNAPlayerController:GetReplicatedProperties()
    return
end
--]]

--[[
function CNAPlayerController:GetAvailableServerRPCs()
    return
end
--]]

return CNAPlayerController