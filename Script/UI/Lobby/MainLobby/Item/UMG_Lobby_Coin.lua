---@class UMG_Lobby_Coin_C:UUserWidget
---@field Image_Currency_Icon UImage
---@field Image_Currency_Status1 UImage
---@field NewButton_Currency_Increase UButton
---@field NewButton_Currency_Tips UButton
---@field TextBlock_Currency_Amount UTextBlock
---@field Icon UTexture2D
---@field Count int32
--Edit Below--
local UMG_Lobby_Coin = { bInitDoOnce = false } 


function UMG_Lobby_Coin:Construct()
	self.TextBlock_Currency_Amount:SetText(tostring(self.Count or 0))
	self.Image_Currency_Icon:SetBrushFromTexture(self.Icon,false)
end


-- function UMG_Lobby_Coin:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_Coin:Destruct()

-- end

function UMG_Lobby_Coin:OnUpdate()
    
end

return UMG_Lobby_Coin