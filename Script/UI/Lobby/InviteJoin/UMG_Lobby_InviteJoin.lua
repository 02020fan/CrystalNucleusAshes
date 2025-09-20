---@class UMG_Lobby_InviteJoin_C:UUserWidget
---@field Button_0 UButton
---@field Image_0 UImage
--Edit Below--
local UMG_Lobby_InviteJoin = { bInitDoOnce = false } 


function UMG_Lobby_InviteJoin:Construct()
    self.Button_0.OnClicked:Add(self.OnClickInviteJoin,self)
end

function UMG_Lobby_InviteJoin:OnClickInviteJoin()

    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_InviteJoin);
    
end
-- function UMG_Lobby_InviteJoin:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_InviteJoin:Destruct()

-- end

return UMG_Lobby_InviteJoin