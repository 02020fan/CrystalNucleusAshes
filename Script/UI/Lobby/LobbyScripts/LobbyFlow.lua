--- @class LobbyFlow
LobbyFlow = {}

local PromiseFuture = require("common.PromiseFuture")

LobbyFlow.CurrentState="None"  --默认状态

LobbyFlow.WidgetType={
    Lobby_MainLobby={
        Name="MainLobby",
        Path=UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/MainLobby/UMG_Lobby_MainUI.UMG_Lobby_MainUI_C'),
        Widget=nil,
    },
    Lobby_MapSelect={
        Name="MapSelect",
        Path='Asset/UI/Lobby/MapSelect/UMG_Lobby_MapSelect.UMG_Lobby_MapSelect_C',
        Widget=nil,
    },
    Lobby_Equipment={
        Name="Equipment",
        Path=UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/FightEquip/Equipment/UMG_Lobby_MainEquipment.UMG_Lobby_MainEquipment_C'),
        Widget=nil,
    },
    Lobby_Weapon={
        Name="Weapon",
        Path=UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/FightEquip/Weapon/UMG_Lobby_MainWeapon.UMG_Lobby_MainWeapon_C'),
        Widget=nil,
    },
    Lobby_Amored={
        Name="Amored",
        Path=UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/FightEquip/Amored/UMG_Lobby_MainAmored.UMG_Lobby_MainAmored_C'),
        Widget=nil,
    },
    Lobby_Quit={
        Name="Quit",
        Path=UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/MainLobby/UMG_Lobby_Quit.UMG_Lobby_Quit_C'),
        Widget=nil,
    },
    Lobby_Shop={
        Name="Shop",
        Path=UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/Shop/Mainshop/UMG_Lobby_MainShop.UMG_Lobby_MainShop_C'),
        Widget=nil,
    },
}
function LobbyFlow:Go(WidgetType)
    print("LobbyFlow CurrentState"..LobbyFlow.CurrentState)
    if  WidgetType.Name==LobbyFlow.CurrentState  then
        print("Already in "..WidgetType.Name)
        return
    else
        print("Switch to "..WidgetType.Name)
         --隐藏当前界面
        for _, type in pairs(LobbyFlow.WidgetType) do
            if  type.Name==LobbyFlow.CurrentState then
                if type.Widget then
                    UGCWidgetManagerSystem.HideWidget(type.Widget)
                    print("LobbyHide "..type.Name)
                end
            end
        end
        if WidgetType.Widget then
            UGCWidgetManagerSystem.ShowWidget(WidgetType.Widget)
            LobbyFlow.CurrentState=WidgetType.Name
            print("AlreadyShow "..WidgetType.Name)
        else
            if WidgetType.Path then
            UGCWidgetManagerSystem.CreateWidgetAsync(WidgetType.Path,
            function(Widget) 
            if Widget then
                WidgetType.Widget=Widget
                Widget:AddToViewport();
                LobbyFlow.CurrentState=WidgetType.Name
                print("Create and Show "..WidgetType.Name)
                print("Create and Show"..LobbyFlow.CurrentState)
                end
            end)
            else
                print("Widget Path is nil"..WidgetType.Name)
            end
        end
    end
end

function LobbyFlow:SwitchToLobbyCamera(PlayerController)
    local Cameras=UGCActorComponentUtility.GetAllActorsOfClass(UGCGameSystem.GameState,UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Lobby/BP_LobbyCamera.BP_LobbyCamera_C')));
    for _, Camera in pairs(Cameras) do
        if Camera  then
            PlayerController:SetViewTargetWithBlend(Camera);
            break;
        end
    end
end

function LobbyFlow:HideBeginUI()
    local MainControlPanel = UGCWidgetManagerSystem.GetMainUI()
    UGCWidgetManagerSystem.HideWidget(MainControlPanel.MainControlBaseUI)
    UGCWidgetManagerSystem.HideWidget(MainControlPanel.ShootingUIPanel)
    UGCWidgetManagerSystem.SetVirtualJoystickVisibility(false);   --隐藏摇杆
    UGCWidgetManagerSystem.SetCrosshairVisibility(false)
end

function LobbyFlow:OnPlayerEnterInLobby(Num)

    if LobbyFlow.WidgetType.Lobby_MainLobby.Widget then

        LobbyFlow.WidgetType.Lobby_MainLobby.Widget.RoomState.PlayerNum:SetText(Num);

    else
        PromiseFuture.New():Set(
                function (PromiseFuture)
                    while true do
                        if LobbyFlow.WidgetType.Lobby_MainLobby.Widget then
                           LobbyFlow.WidgetType.Lobby_MainLobby.Widget.RoomState.PlayerNum:SetText(#UGCGameSystem.GetLocalPlayerController().LobbyTeammatePlayerKeys);
                          return
                        else
                        PromiseFuture:Yield()
                        end
                    end
                end):AutoResume(self,0.2,10)
    end
end

function LobbyFlow:UpdateLobbyTeammates()

    if LobbyFlow.WidgetType.Lobby_MainLobby.Widget then

        LobbyFlow.WidgetType.Lobby_MainLobby.Widget.Players:ClearChildren();

        LobbyFlow.WidgetType.Lobby_MainLobby.Widget:AddLobbyTeammate(UGCGameSystem.GetLocalPlayerState());
        local PC=UGCGameSystem.GetLocalPlayerController()
        if PC then
            for _, PlayerKey in pairs(PC.LobbyTeammatePlayerKeys) do
    
                if PlayerKey~=UGCGameSystem.GetPlayerKeyByPlayerController(UGCGameSystem.GetLocalPlayerController()) then
                    LobbyFlow.WidgetType.Lobby_MainLobby.Widget:AddLobbyTeammate(UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey));
                end
            end
        end
    else
        PromiseFuture.New():Set(
                function (PromiseFuture)
                    while true do
                        print("Waiting for Lobby_MainLobby.Widget to be available...")

                        if LobbyFlow.WidgetType.Lobby_MainLobby.Widget then
                           LobbyFlow.WidgetType.Lobby_MainLobby.Widget.Players:ClearChildren();
                           print("Cleared existing teammate widgets.")
                           LobbyFlow.WidgetType.Lobby_MainLobby.Widget:AddLobbyTeammate(UGCGameSystem.GetLocalPlayerState());
                           print("Added local player widget.")
                           local PC=UGCGameSystem.GetLocalPlayerController()
                           if PC then
                               for _, PlayerKey in pairs(PC.LobbyTeammatePlayerKeys) do
                                   if PlayerKey~=UGCGameSystem.GetPlayerKeyByPlayerController(UGCGameSystem.GetLocalPlayerController()) then
                                       LobbyFlow.WidgetType.Lobby_MainLobby.Widget:AddLobbyTeammate(UGCGameSystem.GetPlayerStateByPlayerKey(PlayerKey));
                                   end
                               end
                           end
                          return
                        else
                        PromiseFuture:Yield()
                        print("Waiting for Lobby_MainLobby.Widget to be available...")
                        end
                    end
                end):AutoResume(self,0.2,10)
    end
end

function LobbyFlow:IsTeamLeader()

    local PlayerController=UGCGameSystem.GetLocalPlayerController()
    if LobbyFlow.WidgetType.Lobby_MainLobby.Widget then
        LobbyFlow.WidgetType.Lobby_MainLobby.Widget:InitMatchUI(PlayerController.bIsTeamLeader)
    else
        PromiseFuture.New():Set(
                function (PromiseFuture)
                    while true do
                        if LobbyFlow.WidgetType.Lobby_MainLobby.Widget then
                           LobbyFlow.WidgetType.Lobby_MainLobby.Widget:InitMatchUI(PlayerController.bIsTeamLeader)
                          return
                        else
                        PromiseFuture:Yield()
                        end
                    end
                end):AutoResume(self,0.2,10)
    end
end

function LobbyFlow:SetReadyState(IsLobbyReady)
    if IsLobbyReady then
        LobbyFlow.WidgetType.Lobby_MainLobby.Widget.Match:SetActiveWidget(LobbyFlow.WidgetType.Lobby_MainLobby.Widget.CancleReady)
    else
        LobbyFlow.WidgetType.Lobby_MainLobby.Widget.Match:SetActiveWidget(LobbyFlow.WidgetType.Lobby_MainLobby.Widget.Ready)
    end
end

return LobbyFlow