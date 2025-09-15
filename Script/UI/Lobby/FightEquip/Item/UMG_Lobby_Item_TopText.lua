---@class UMG_Lobby_Item_TopText_C:UUserWidget
---@field Content UTextBlock
---@field TextContent FText
--Edit Below--
local UMG_Lobby_Item_TopText = { bInitDoOnce = false } 


function UMG_Lobby_Item_TopText:Construct()
	
    self.Content:SetText(self.TextContent);
end


-- function UMG_Lobby_Item_TopText:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_Item_TopText:Destruct()

-- end

return UMG_Lobby_Item_TopText