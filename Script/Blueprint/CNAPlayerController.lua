local CNAPlayerController = {}
 

function CNAPlayerController:ReceiveBeginPlay()
    CNAPlayerController.SuperClass.ReceiveBeginPlay(self)

    -- local path=UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/MainWidget.MainWidget_C');
    -- UGCWidgetManager.SetWidgetLayout(path);



    if self:HasAuthority()==false then
        local MainControlPanel = UGCWidgetManagerSystem.GetMainUI()

        UGCWidgetManagerSystem.HideWidget(MainControlPanel.MainControlBaseUI)
        UGCWidgetManagerSystem.HideWidget(MainControlPanel.ShootingUIPanel)
        UGCWidgetManagerSystem.SetVirtualJoystickVisibility(false);   --隐藏摇杆
        
        UGCWidgetManagerSystem.SetCrosshairVisibility(true)
    
    end

    
    local Cameras=UGCActorComponentUtility.GetAllActorsOfClass(UGCGameSystem.GameState,UGCObjectUtility.LoadClass(UGCGameSystem.GetUGCResourcesFullPath('Asset/Blueprint/Lobby/BP_LobbyCamera.BP_LobbyCamera_C')));
    for _, Camera in pairs(Cameras) do
        if Camera  then
            self.IsCurrentUsePersistStateView = false
            self:SetViewTargetWithBlend(Camera);
            self.IsCurrentUsePersistStateView = true
            break;
        end
    end

    local MainUIPath=UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/UMG_Lobby_MainUI.UMG_Lobby_MainUI_C');

    if MainUIPath then

    UGCWidgetManagerSystem.CreateWidgetAsync(MainUIPath,
    function (widget)
        if widget then
            widget:AddToViewport();
        end
        
    end);
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