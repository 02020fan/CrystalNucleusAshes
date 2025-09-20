---@class UMG_Lobby_Quit_C:UUserWidget
---@field Main UButton
--Edit Below--
local UMG_Lobby_Quit = {} 


function UMG_Lobby_Quit:Construct()
	self.Main.OnClicked:Add(self.GoToQuit,self)
end

function UMG_Lobby_Quit:GoToQuit()
    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_Quit);
end

-- function UMG_Lobby_Quit:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_Quit:Destruct()

-- end

return UMG_Lobby_Quit