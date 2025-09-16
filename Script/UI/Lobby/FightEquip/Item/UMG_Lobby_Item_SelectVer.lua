---@class UMG_Lobby_Item_SelectVer_C:UUserWidget
---@field SelectButton UButton
---@field Text UTextBlock
---@field TextContent FText
--Edit Below--
local UMG_Lobby_Item_Select = { bInitDoOnce = false } 


function UMG_Lobby_Item_Select:Construct()
	self.Text:SetText(self.TextContent);
end


-- function UMG_Lobby_Item_Select:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_Item_Select:Destruct()

-- end

return UMG_Lobby_Item_Select