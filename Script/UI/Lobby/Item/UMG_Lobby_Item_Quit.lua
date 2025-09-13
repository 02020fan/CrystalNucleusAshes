---@class UMG_Lobby_Item_Quit_C:UUserWidget
---@field Image_0 UImage
---@field ReturnToLobby UButton
--Edit Below--

local UMG_Lobby_Item_Quit = {} 


function UMG_Lobby_Item_Quit:Construct()
	self.ReturnToLobby.OnClicked:Add(self.ReturnToMainLobby,self)
end

function UMG_Lobby_Item_Quit:ReturnToMainLobby()
    print("Clicked ReturnToLobby")
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_MainLobby);
end
-- function UMG_Lobby_Item_Quit:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_Item_Quit:Destruct()

-- end

return UMG_Lobby_Item_Quit