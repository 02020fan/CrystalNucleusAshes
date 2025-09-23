---@class UMG_Lobby_MainUI_C:UUserWidget
---@field Amored UMG_Lobby_Equipment_C
---@field Begin UMG_Lobby_StartGame_C
---@field CancleMatch UMG_Lobby_StartGame_C
---@field CancleReady UMG_Lobby_StartGame_C
---@field CanvasPanel_0 UCanvasPanel
---@field Equipment UMG_Lobby_Equipment_C
---@field IfAddOtherPlayers UMG_Lobby_IfAddOtherPlayers_C
---@field Image_1 UImage
---@field PlayerInfo UMG_Lobby_PlayerInfo_C
---@field Players UVerticalBox
---@field Quit UMG_Lobby_Quit_C
---@field Ready UMG_Lobby_StartGame_C
---@field RoomState UMG_Lobby_RoomState_C
---@field Shop UMG_Lobby_Equipment_C
---@field Single UMG_Lobby_StartGame_C
---@field Weapon UMG_Lobby_Equipment_C
---@field WidgetSwitcher_0 UWidgetSwitcher
---@field WidgetSwitcher_1 UWidgetSwitcher
--Edit Below--
local UMG_Lobby_MainUI = {} 
UMG_Lobby_MainUI.PlayersWidget={}
function UMG_Lobby_MainUI:Construct()
    UICommonFunctionLibrary.SetAdaptation(self.CanvasPanel_0, self);
	self.Equipment.FightShop.OnClicked:Add(self.EquipmentFightShop,self)
    self.Weapon.FightShop.OnClicked:Add(self.WeaponFightShop,self)
    -- self.Amored.FightShop.OnClicked:Add(self.AmoredFightShop,self)
    self.Shop.FightShop.OnClicked:Add(self.ShopFightShop,self)
    self.PlayerNum:SetText(tostring(UGCGameSystem.GetPlayerNum(true)))
    self:OnPlayerEnter()
    
end

function UMG_Lobby_MainUI:ShopFightShop()
    print("Clicked ShopFightShop")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Shop)
end

function UMG_Lobby_MainUI:EquipmentFightShop()
    print("Clicked EquipmentFightShop")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Equipment)
end

function UMG_Lobby_MainUI:AmoredFightShop()
    print("Clicked AmoredFightShop")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Amored)
end

function UMG_Lobby_MainUI:WeaponFightShop()
    print("Clicked WeaponFightShop")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Weapon)
end


-- function UMG_Lobby_MainUI:Tick(MyGeometry, InDeltaTime)
-- end
-- function UMG_Lobby_MainUI:Destruct()
-- end
return UMG_Lobby_MainUI