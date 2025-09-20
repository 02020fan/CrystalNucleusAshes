---@class UMG_Lobby_Quit_C:UUserWidget
---@field Jump UWidgetAnimation
---@field Button_1 UButton
---@field UMG_Lobby_Item_Quit UMG_Lobby_Item_Quit_C
--Edit Below--

local UMG_Quit = {} 

function UMG_Quit:Construct()

    self:PlayAnimation(self.Jump,0,0,EUMGSequencePlayMode.Forward,1)

end


-- function UMG_Quit:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Quit:Destruct()

-- end

return UMG_Quit