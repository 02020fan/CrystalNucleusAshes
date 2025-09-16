---@class UMG_Lobby_StartGame_C:UUserWidget
---@field Content UTextBlock
---@field MainButton UButton
---@field TextContent FText
--Edit Below--
local UMG_Lobby_StartGame = { bInitDoOnce = false } 


function UMG_Lobby_StartGame:Construct()
	
    self.Content:SetText(self.TextContent);
end


-- function UMG_Lobby_StartGame:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_StartGame:Destruct()

-- end

return UMG_Lobby_StartGame