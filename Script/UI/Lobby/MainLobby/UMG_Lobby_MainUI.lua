---@class UMG_Lobby_MainUI_C:UUserWidget
---@field Amored UMG_Lobby_Equipment_C
---@field BeginGame UMG_Lobby_StartGame_C
---@field CancleMatch UMG_Lobby_StartGame_C
---@field CancleReady UMG_Lobby_StartGame_C
---@field Equipment UMG_Lobby_Equipment_C
---@field IfAddOtherPlayers UMG_Lobby_IfAddOtherPlayers_C
---@field Image_1 UImage
---@field Image_2 UImage
---@field InviteJoin UMG_Lobby_InviteJoin_C
---@field ModeSelect UMG_Lobby_ModeSelect_C
---@field PlayerInfo UMG_Lobby_PlayerInfo_C
---@field PlayerNum UTextBlock
---@field Players UVerticalBox
---@field Quit UMG_Lobby_Quit_C
---@field ReadyGame UMG_Lobby_StartGame_C
---@field Shop UMG_Lobby_Equipment_C
---@field Weapon UMG_Lobby_Equipment_C
---@field WidgetSwitcher_0 UWidgetSwitcher
--Edit Below--
local UMG_Lobby_MainUI = {} 

UMG_Lobby_MainUI.PlayersWidget={}

function UMG_Lobby_MainUI:Construct()

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

function UMG_Lobby_MainUI:UpdatePlayerNum(Nums)
    self.PlayerNum:SetText(tostring(Nums))
end

function UMG_Lobby_MainUI:OnPlayerEnter()

    local PSS=UGCGameSystem.GetAllPlayerState(false)

    for _, ps in pairs(PSS) do

        self.IfAddPlayer=true

        for _, Widget in pairs(self.PlayersWidget) do

            if  ps.PlayerName==Widget:GetPlayerName() then

                self.IfAddPlayer=false

            end

        end

        if self.IfAddPlayer==true then

            UGCWidgetManagerSystem.CreateWidgetAsync(UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/MainLobby/Item/UMG_GamePlayer.UMG_GamePlayer_C'),function(w)
                if w then

                    self:InitOnWidgetAddToVB(self.Players:AddChildToVerticalBox(w))
                    w:Init(ps)
                    table.insert(self.PlayersWidget,w)

                end
            end)

        end

    end

end

function UMG_Lobby_MainUI:InitOnWidgetAddToVB(slot)

    if slot then

        slot:SetPadding({10,10,10,10})

        slot:SetHorizontalAlignment(EHorizontalAlignment.HAlign_Fill)

        slot:SetVerticalAlignment(EVerticalAlignment.VAlign_Fill)

        slot:SetSize({0,ESlateSizeRule.Automatic})

    end

end
-- function UMG_Lobby_MainUI:Tick(MyGeometry, InDeltaTime)
-- end
-- function UMG_Lobby_MainUI:Destruct()
-- end
return UMG_Lobby_MainUI