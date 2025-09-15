---@class UMG_Lobby_MainUI_C:UUserWidget
---@field Amored UMG_Lobby_Equipment_C
---@field BeginGame UMG_Lobby_StartGame_C
---@field CancleMatch UMG_Lobby_StartGame_C
---@field CancleReady UMG_Lobby_StartGame_C
---@field Equipment UMG_Lobby_Equipment_C
---@field Image_1 UImage
---@field Image_2 UImage
---@field Invite UMG_Lobby_InviteJoin_C
---@field Join UMG_Lobby_InviteJoin_C
---@field ModeSelect UMG_Lobby_ModeSelect_C
---@field Player01 UMG_GamePlayer_C
---@field Player02 UMG_GamePlayer_C
---@field Player03 UMG_GamePlayer_C
---@field Player04 UMG_GamePlayer_C
---@field ReadyGame UMG_Lobby_StartGame_C
---@field Shop UMG_Lobby_Equipment_C
---@field UMG_Lobby_IfAddOtherPlayers UMG_Lobby_IfAddOtherPlayers_C
---@field UMG_Lobby_PlayerInfo UMG_Lobby_PlayerInfo_C
---@field UMG_Lobby_Quit UMG_Lobby_Quit_C
---@field Weapon UMG_Lobby_Equipment_C
---@field WidgetSwitcher_0 UWidgetSwitcher
--Edit Below--
local UMG_Lobby_MainUI = {} 
function UMG_Lobby_MainUI:Construct()
	self.Equipment.FightShop.OnClicked:Add(self.EquipmentFightShop,self)
    self.Weapon.FightShop.OnClicked:Add(self.WeaponFightShop,self)
    self.Amored.FightShop.OnClicked:Add(self.AmoredFightShop,self)
end
function UMG_Lobby_MainUI:EquipmentFightShop()
    print("Clicked FightShop")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Equipment)
end
function UMG_Lobby_MainUI:AmoredFightShop()
    print("Clicked FightShop")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Amored)
end
function UMG_Lobby_MainUI:WeaponFightShop()
    print("Clicked FightShop")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Weapon)
end
-- function UMG_Lobby_MainUI:Tick(MyGeometry, InDeltaTime)
-- end
-- function UMG_Lobby_MainUI:Destruct()
-- end
return UMG_Lobby_MainUI