---@class UMG_Lobby_Equipment_C:UUserWidget
---@field Button_1 UButton
---@field Shopname UTextBlock
---@field TextContent FText
--Edit Below--
local UMG_Lobby_Equipment = { bInitDoOnce = false } 


function UMG_Lobby_Equipment:Construct()
	self.Shopname:SetText(self.TextContent)
end


-- function UMG_Lobby_Equipment:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_Equipment:Destruct()

-- end

return UMG_Lobby_Equipment