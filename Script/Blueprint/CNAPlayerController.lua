local CNAPlayerController = {}
 
UGCGameSystem.UGCRequire("Script.UI.Lobby.LobbyScripts.LobbyFlow")

CNAPlayerController.PlayerNums=0;

function CNAPlayerController:ReceiveBeginPlay()
    CNAPlayerController.SuperClass.ReceiveBeginPlay(self)
    self:Init();

    UGCGenericMessageSystem.ListenGlobalMessage(self, UGCGenericMessageSystem.Messages.UGC.Player.PlayerEnter, self, self.InitOnPlayerEnter);
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

function CNAPlayerController:InitOnPlayerEnter(PlayerKeys)

    self.PlayerNums=UGCGameSystem.GetPlayerNum(true)

    if self:HasAuthority()==false then
        
        LobbyFlow:UpdatePlayers();
        
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


function CNAPlayerController:GetReplicatedProperties()
    return"PlayerNums";
end

function CNAPlayerController:OnRep_PlayerNums()

    LobbyFlow:UpdateRoomNums(self.PlayerNums);

end

--[[
function CNAPlayerController:GetAvailableServerRPCs()
    return
end
--]]

return CNAPlayerController