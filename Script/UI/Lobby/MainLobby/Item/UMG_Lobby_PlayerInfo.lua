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

        self.PlayerName:SetText(PS.PlayerName or "nil");
        
        self.UID:SetText((UGCGameSystem.GetUIDByPlayerState(PS) or "nil"));

        local Level,Exp=PS:GetLevelEXP();

        self.TextBlock_NowExp:SetText(tostring(Exp));

        self.PlayerLevel:SetText("LV."..tostring(Level));

        self.TextBlock_TargetExp:SetText(tostring(CNAGameData.EXP[Level] or "nil"));

        self.ProgressBar_Exp:SetPercent(Exp/(CNAGameData.EXP[Level] or 1));

        if PS.PlatformGender==0 then

            self.Gendar:SetVisibility(ESlateVisibility.Collapsed);

        elseif PS.PlatformGender==1 then

            self.Gendar:SetActiveWidgetIndex(0);

        elseif PS.PlatformGender==2 then

            self.Gendar:SetActiveWidgetIndex(1);

        else

            self.Gendar:SetVisibility(ESlateVisibility.Collapsed);

        end
        
    end
end

function UMG_Lobby_PlayerInfo:LocalAddListender()

    UGCEventSystem.AddEventListener(CNAEventDefine.UpdateLevelExp,self.UpdateExperience,self);
    
end

function UMG_Lobby_PlayerInfo:UpdateExperience(Exp,Level)

    self.TextBlock_NowExp:SetText(tostring(Exp));

    self.PlayerLevel:SetText("LV."..tostring(Level));

    self.TextBlock_TargetExp:SetText(tostring(CNAGameData.EXP[Level] or "nil"));

    self.ProgressBar_Exp:SetPercent(Exp/(CNAGameData.EXP[Level] or 1));

end


-- function UMG_Lobby_PlayerInfo:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_Lobby_PlayerInfo:Destruct()

-- end

return UMG_Lobby_PlayerInfo