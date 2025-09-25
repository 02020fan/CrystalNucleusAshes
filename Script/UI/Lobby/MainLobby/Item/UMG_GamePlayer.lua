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

      print("UMG_GamePlayer:Init PlayerState valid, initializing view...");

      print("UMG_GamePlayer:Init PlayerState PlayerName="..UGCGameSystem.GetUIDByPlayerState(PS));

      if self.Common_Avatar_BP then

          self.Common_Avatar_BP:InitView(1,UGCGameSystem.GetUIDByPlayerState(PS),PS.IconURL,PS.PlatformGender,PS.SegmentLevel,PS.PlayerLevel,false,false);
          
      else
        print("UMG_GamePlayer:Init Common_Avatar_BP is nil, cannot initialize avatar.");
      end

      print("UMG_GamePlayer:Init Avatar initialized with UID=");

      -- self.PlayerName:SetText(PS.PlayerName);

      print("UMG_GamePlayer:Init PlayerName set to "..PS.PlayerName);

      -- self.PlayerLevel:SetText(tostring(PS:GetLevel()));

      print("UMG_GamePlayer:Init PlayerName="..PS.PlayerName.." Level="..tostring(PS:GetLevel()));

    else
      print("UMG_GamePlayer:Init PlayerState is nil, cannot initialize view.");
    end
end
-- function UMG_GamePlayer:Tick(MyGeometry, InDeltaTime)

-- end

-- function UMG_GamePlayer:Destruct()

-- end

return UMG_GamePlayer