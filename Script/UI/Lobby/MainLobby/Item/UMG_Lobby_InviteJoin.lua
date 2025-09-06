---@class UMG_Lobby_InviteJoin_C:UUserWidget
---@field Button_2 UButton
---@field TextBlock_126 UTextBlock
---@field TextContent FText
--Edit Below--
local UMG_Lobby_InviteJoin = { bInitDoOnce = false } 


function UMG_Lobby_InviteJoin:Construct()
	self.TextBlock_126:SetText(self.TextContent)
end


-- function UMG_Lobby_InviteJoin:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_InviteJoin:Destruct()

-- end

return UMG_Lobby_InviteJoin