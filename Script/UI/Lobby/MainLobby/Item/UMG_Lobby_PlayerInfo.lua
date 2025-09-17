---@class UMG_Lobby_PlayerInfo_C:UUserWidget
---@field Common_Avatar_BP Common_Avatar_BP_C
---@field Gendar UWidgetSwitcher
---@field PlayerLevel UTextBlock
---@field PlayerName UTextBlock
---@field ProgressBar_Exp UProgressBar
---@field TextBlock_0 UTextBlock
---@field TextBlock_NowExp UTextBlock
---@field TextBlock_TargetExp UTextBlock
---@field UID UTextBlock
--Edit Below--
local UMG_Lobby_PlayerInfo = {} 


function UMG_Lobby_PlayerInfo:Construct()

    print("UMG_Lobby_PlayerInfo:Construct");
	local PC=UGCGameSystem.GetLocalPlayerController();

    print("UMG_Lobby_PlayerInfo:PC");

    local PS=UGCGameSystem.GetPlayerStateByPlayerController(PC);

    print("UMG_Lobby_PlayerInfo:PS");

    if PS then

        self.Common_Avatar_BP:InitView(1,UGCGameSystem.GetUIDByPlayerState(PS),PS.IconURL,PS.PlatformGender,PS.SegmentLevel,PS.PlayerLevel,true,true);

        print("PS.Gender"..PS.PlatformGender);

        self.PlayerName:SetText(PS.PlayerName or "nil");
        
        self.UID:SetText((UGCGameSystem.GetUIDByPlayerState(PS) or "nil"));

    end

end


-- function UMG_Lobby_PlayerInfo:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_PlayerInfo:Destruct()

-- end

-- function UMG_Lobby_PlayerInfo:OnUpdate(Data)
    
--     self.Data = Data

--     ---@type FPlayerAccountInfo
--     local PlayerAccountInfo = self.Data.PlayerAccountInfo

--     self.TextBlock_PlayerName:SetText(PlayerAccountInfo.PlayerName or "nil")
--     self.TextBlock_PlayerLevel:SetText("Lv. " .. self.Data.Level or 0)

--     self.TextBlock_NowExp:SetText(tostring(self.Data.NowExp or 2))
--     self.TextBlock_TargetExp:SetText(tostring(self.Data.TargetExp or 10))
--     self.ProgressBar_Exp:SetPercent(self.Data.ExpRatio or 0.2)

--     -- 刷新头像
--     self.Common_Avatar_BP:InitView(1, PlayerAccountInfo.UID, PlayerAccountInfo.IconURL, PlayerAccountInfo.Gender,
--             PlayerAccountInfo.SegmentLevel, PlayerAccountInfo.PlayerLevel, true, true)
            
-- end

return UMG_Lobby_PlayerInfo