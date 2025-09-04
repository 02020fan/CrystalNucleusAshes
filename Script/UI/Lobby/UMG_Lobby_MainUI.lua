---@class UMG_Lobby_MainUI_C:UUserWidget
---@field BeginGame UMG_Lobby_StartGame_C
---@field Debris UMG_Lobby_Coin_C
---@field Feats UMG_Lobby_Coin_C
---@field Matching UMG_Lobby_StartGame_C
---@field ReadyGame UMG_Lobby_StartGame_C
---@field REINST_UMG_Lobby_Quit_C_0 UMG_Lobby_Quit_C
---@field SelectDifficulty UMG_Lobby_StartGame_C
---@field UMG_Lobby_IfAddOtherPlayers UMG_Lobby_IfAddOtherPlayers_C
---@field UMG_Lobby_PlayerInfo UMG_Lobby_PlayerInfo_C
---@field UMG_Lobby_Quit UMG_Lobby_Quit_C
---@field WidgetSwitcher_0 UWidgetSwitcher
--Edit Below--
local UMG_Lobby_MainUI = { bInitDoOnce = false } 

--[==[ Construct
function UMG_Lobby_MainUI:Construct()
	
end
-- Construct ]==]

-- function UMG_Lobby_MainUI:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_MainUI:Destruct()

-- end

return UMG_Lobby_MainUI