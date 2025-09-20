---@class UMG_GamePlayer_C:UUserWidget
---@field Common_Avatar_BP Common_Avatar_BP_C
---@field PlayerLevel UTextBlock
---@field PlayerName UTextBlock
--Edit Below--
local UMG_GamePlayer = {} 


function UMG_GamePlayer:Construct()

end

function UMG_GamePlayer:Init(PS)

    if PS then

      self.Common_Avatar_BP:InitView(1,UGCGameSystem.GetUIDByPlayerState(PS),PS.IconURL,PS.PlatformGender,PS.SegmentLevel,PS.PlayerLevel,true,true);

      self.PlayerName:SetText(PS.PlayerName or "nil");

      self.LocalPlayerName=PS.PlayerName or "nil";

      self.PlayerLevel:SetText(tostring(PS:GetLevel() or "nil"));
      
    end

end

function UMG_GamePlayer:GetPlayerName()

  if self.LocalPlayerName then

    return self.LocalPlayerName

  end

end

-- function UMG_GamePlayer:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_GamePlayer:Destruct()

-- end

return UMG_GamePlayer