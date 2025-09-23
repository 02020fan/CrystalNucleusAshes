local CNAPlayerController = {}
UGCGameSystem.UGCRequire("Script.UI.Lobby.LobbyScripts.LobbyFlow")
local GameState=UGCGameSystem.UGCRequire("Script.Blueprint.CNAGameState");
local PromiseFuture = require("common.PromiseFuture")
local Delegate = require("common.Delegate")


CNAPlayerController.LobbyInfo=
{
    SelectedModeID=1002,  --默认选择模式

    bFillTeammate=true, --默认自动填充队友

    bTeamComplete = true, --默认队伍已满

    bIsMatching = false, --默认不在匹配中
}

CNAPlayerController.bIsTeamLeader=false; --默认是队长

CNAPlayerController.LobbyTeammatePlayerKeys={}; --队友的PlayerKey列表

CNAPlayerController.OnLobbyTeammatePlayerKeysUpdate = Delegate.New()

function CNAPlayerController:ReceiveBeginPlay()
    CNAPlayerController.SuperClass.ReceiveBeginPlay(self)
    if UGCGameSystem.IsServer() then
        if GameState.IsInLobby then
           self:InitInServerofLobby();
        else
           self:InitInServerofBattle();
        end
    else
        if GameState.IsInLobby then
            self:InitInClientofLobby();  
        else
            self:InitInClientofBattle();
        end
    end
end

function CNAPlayerController:ReceiveEndPlay()
    if UGCGameSystem.IsServer() then
        UGCGenericMessageSystem.UnListenMessage(self, UGCGenericMessageSystem.Messages.UGC.Player.PlayerEnter) 
        UGCGenericMessageSystem.UnListenMessage(self, UGCGenericMessageSystem.Messages.UGC.Player.PlayerExit) 
    end
end

function CNAPlayerController:InitInServerofLobby()
    self:LobbyUIInit();
    UGCGenericMessageSystem.ListenGlobalMessage(self, UGCGenericMessageSystem.Messages.UGC.Player.PlayerEnter, self, self.OnPlayerEnter);
    UGCGenericMessageSystem.ListenGlobalMessage(self, UGCGenericMessageSystem.Messages.UGC.Player.PlayerExit, self, self.OnPlayerExit);
end

function CNAPlayerController:OnPlayerEnter(PlayerKey)

    local bIsUGCPIE = UGCBlueprintFunctionLibrary.IsUGCPIE(self)
    print("CNAPlayerController:OnPlayerEnter PlayerKey="..tostring(PlayerKey).." bIsUGCPIE="..tostring(bIsUGCPIE))
    if PlayerKey == UGCGameSystem.GetPlayerKeyByPlayerController(self) then
        self.bIsTeamLeader= bIsUGCPIE and PlayerKey==10001 or UGCTeamSystem.GetIsLeaderOrNotByPlayerKey(PlayerKey)
        print("CNAPlayerController:OnPlayerEnter bIsTeamLeader="..tostring(self.bIsTeamLeader))

        UnrealNetwork.RepLazyProperty(self,"bIsTeamLeader")
        UGCGameSystem.GetPlayerStateByPlayerController(self):SetIsLobbyTeamLeader(self.bIsTeamLeader)
        self:RPC_Server_SetLobbyReadyStatus(self.bIsTeamLeader)
    end

    if bIsUGCPIE then
        self.LobbyTeammatePlayerKeys = UGCTeamSystem.GetPlayerKeysByTeamID(UGCTeamSystem.GetTeamIDByPlayerKey(UGCGameSystem.GetPlayerKeyByPlayerController(self)), true)
        -- self.LobbyTeammatePlayerKeys = {self.PlayerKey}
        print("CNAPlayerController:OnPlayerEnter PIE LobbyTeammatePlayerKeys "..#self.LobbyTeammatePlayerKeys)
    else
        self.LobbyTeammatePlayerKeys = UGCTeamSystem.GetLobbyTeamKeysByPlayerKey(UGCGameSystem.GetPlayerKeyByPlayerController(self))
    end
    
    -- UnrealNetwork.RepLazyProperty(self, "LobbyTeammatePlayerKeys")

    ---给加入游戏的队友同步大厅信息
    if self.bIsTeamLeader then
        if not bIsUGCPIE then
            self.LobbyInfo.bTeamComplete = #UGCTeamSystem.GetLobbyTeamKeysByPlayerKey(self.PlayerKey) == #UGCTeamSystem.GetLobbyTeammateUIDsByUID(UGCGameSystem.GetUIDByPlayerController(self))
            UnrealNetwork.RepLazyProperty(self, "LobbyInfo.bTeamComplete")
        end

        for _, TeammatePlayerKey in ipairs(self.LobbyTeammatePlayerKeys) do
            if TeammatePlayerKey == PlayerKey then
                local PC = UGCGameSystem.GetPlayerControllerByPlayerKey(PlayerKey)
                PC:SetLobbyInfo(self.LobbyInfo)
                break     
            end
        end
    end
end

function CNAPlayerController:OnPlayerExit(PlayerKey)
    local bIsUGCPIE = UGCBlueprintFunctionLibrary.IsUGCPIE(self)
    
    for Index, TeammatePlayerKey in ipairs(self.LobbyTeammatePlayerKeys) do
        if TeammatePlayerKey == PlayerKey then
            self.LobbyInfo.bTeamComplete = false
            UnrealNetwork.RepLazyProperty(self, "LobbyInfo.bTeamComplete")
        end
    end
end

function CNAPlayerController:InitInServerofBattle()
    
end

function CNAPlayerController:InitInClientofLobby()
    self:LobbyUIInit();
end

function CNAPlayerController:InitInClientofBattle()
    
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

function CNAPlayerController:SetLobbyInfo(LobbyInfo)

    if UGCActorComponentUtility.HasAuthority(self) == false then
        return
    end

    print(string.format("UGCPlayerController:SetLobbyInfo ModeID=%d, bFillTeammate=%s", LobbyInfo.SelectedModeID, tostring(LobbyInfo.bFillTeammate)))

    self.LobbyInfo = LobbyInfo
    UnrealNetwork.RepLazyProperty(self, "LobbyInfo")

end

function CNAPlayerController:GetReplicatedProperties()
    return {"bIsTeamLeader","Lazy"},"LobbyTeammatePlayerKeys",{"LobbyInfo","Lazy"}
end

function CNAPlayerController:OnRep_LobbyInfo()
    
end

function CNAPlayerController:OnRep_LobbyTeammatePlayerKeys()

    ugcprint("UGCPlayerController:OnRep_LobbyTeammatePlayerKeys")

    -- self.OnLobbyTeammatePlayerKeysUpdate()
    print("CNAPlayerController:OnRep_LobbyTeammatePlayerKeys "..#self.LobbyTeammatePlayerKeys)

    LobbyFlow:OnPlayerEnterInLobby();
end

function CNAPlayerController:GetAvailableServerRPCs()
    return "RPC_Server_SetLobbyReadyStatus";
end

function CNAPlayerController:RPC_Server_SetLobbyReadyStatus(bIsReady)

    if UGCGameSystem.IsServer() then
        local PS=UGCGameSystem.GetPlayerStateByPlayerController(self);
        if PS then
            PS:SetLobbyReady(bIsReady);
        end
    end
    
end

return CNAPlayerController