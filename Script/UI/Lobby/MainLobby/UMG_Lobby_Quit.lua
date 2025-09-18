---@class UMG_Quit_C:UUserWidget
---@field Jump UWidgetAnimation
---@field Button_1 UButton
---@field UMG_Lobby_Item_Quit UMG_Lobby_Item_Quit_C
--Edit Below--

local UMG_Quit = {} 

function UMG_Quit:Construct()
	self.Button_1.OnClicked:Add(self.GoToLobby,self)

    self:PlayAnimation(self.Jump,0,1,EUUMGSequencePlayMode.Forward,false,0)

end

function UMG_Quit:GoToLobby()

    LobbyFlow:Go(LobbyFlow.WidgetType.Lobby_MainLobby);

end

-- function UMG_Quit:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Quit:Destruct()

-- end

return UMG_Quit