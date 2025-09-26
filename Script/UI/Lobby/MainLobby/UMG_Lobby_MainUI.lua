---@class UMG_Lobby_MainUI_C:UUserWidget
---@field Amored UMG_Lobby_Equipment_C
---@field Begin UMG_Lobby_StartGame_C
---@field CancleMatch UMG_Lobby_StartGame_C
---@field CancleReady UMG_Lobby_StartGame_C
---@field CanvasPanel_0 UCanvasPanel
---@field Equipment UMG_Lobby_Equipment_C
---@field IfAddOtherPlayers UMG_Lobby_IfAddOtherPlayers_C
---@field Image_1 UImage
---@field Match UWidgetSwitcher
---@field Player01 UMG_GamePlayer_C
---@field PlayerInfo UMG_Lobby_PlayerInfo_C
---@field Players UVerticalBox
---@field Quit UMG_Lobby_Quit_C
---@field Ready UMG_Lobby_StartGame_C
---@field RoomState UMG_Lobby_RoomState_C
---@field Shop UMG_Lobby_Equipment_C
---@field Weapon UMG_Lobby_Equipment_C
--Edit Below--
local PromiseFuture = require("common.PromiseFuture")
local UMG_Lobby_MainUI = {} 
function UMG_Lobby_MainUI:Construct()
    
	self.Equipment.FightShop.OnClicked:Add(self.EquipmentFightShop,self)
    self.Weapon.FightShop.OnClicked:Add(self.WeaponFightShop,self)
    self.Shop.FightShop.OnClicked:Add(self.ShopFightShop,self)
    self.Begin.MainButton.OnClicked:Add(self.BeginMatch,self)
    self.Ready.MainButton.OnClicked:Add(self.ReadyMatch,self)
    self.CancleReady.MainButton.OnClicked:Add(self.FunCancleReady,self)
    self.CancleMatch.MainButton.OnClicked:Add(self.FunCancleMatch,self)

end

function UMG_Lobby_MainUI:FunCancleReady()
    UnrealNetwork.CallUnrealRPC(UGCGameSystem.GetLocalPlayerController(),UGCGameSystem.GetLocalPlayerController(), "RPC_Server_SetLobbyReadyStatus", false)
end

function UMG_Lobby_MainUI:ReadyMatch()
    print("Player is ready.")
    -- ugcprint("Player is ready.")
    UnrealNetwork.CallUnrealRPC(UGCGameSystem.GetLocalPlayerController(),UGCGameSystem.GetLocalPlayerController(), "RPC_Server_SetLobbyReadyStatus", true)
end

function UMG_Lobby_MainUI:FunCancleMatch()
    UGCMultiMode.RequestCancelMatch()
end

function UMG_Lobby_MainUI:BeginMatch()
    local bIsReady=true

    for _, PS in pairs(UGCGameSystem.GetAllPlayerState(false)) do
        bIsReady = bIsReady and PS.bIsLobbyReady
    end

    if bIsReady then
        UGCMultiMode.RequestMatch(1002,self.OnMatchSuccess,self,self.IfAddOtherPlayers:GetIfAddPlayers())
    else
        print("Not all players are ready.")
        UGCWidgetManagerSystem.ShowTipsUI("还有玩家未准备")
    end
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
function UMG_Lobby_MainUI:AddLobbyTeammate(PS)
    if PS then
        print("Adding Lobby Teammate:")
        UGCWidgetManagerSystem.CreateWidgetAsync(UGCGameSystem.GetUGCResourcesFullPath('Asset/UI/Lobby/MainLobby/Item/UMG_GamePlayer.UMG_GamePlayer_C'),
        function(Widget)
            if Widget then
                print("Created UMG_GamePlayer widget for teammate:")
                Widget:Init(PS)
                print("Initialized widget with PlayerState: " .. (PS.PlayerName or "Unknown"))
                self.Players:AddChildToVerticalBox(Widget)
                print("Added teammate widget to Players list.")
            else
                print("Failed to create UMG_GamePlayer widget.")
            end
        end)
    else
        print("Invalid PlayerState provided to AddLobbyTeammate.")
    end
end

function UMG_Lobby_MainUI:InitPlayerSlot(Slot)
    
end

function UMG_Lobby_MainUI:InitMatchUI(IsLeader)
    if IsLeader then
        print("Setting Match UI to Begin for Team Leader")
        self.Match:SetActiveWidget(self.Begin)
        print("Match UI set to Begin")
    else
        self.Match:SetActiveWidget(self.Ready)
    end
end

-- function UMG_Lobby_MainUI:Tick(MyGeometry, InDeltaTime)
-- end
-- function UMG_Lobby_MainUI:Destruct()
-- end
return UMG_Lobby_MainUI