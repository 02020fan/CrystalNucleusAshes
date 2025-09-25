---@class CNAGameState_C:BP_UGCGameState_C
--Edit Below--
UGCGameSystem.UGCRequire('Script.Common.ue_enum_custom');
require("Script.UGCEventSystem");
require("Script.CNAEventDefine");
require("Script.CNAGameData");

local CNAGameState = {}; 

CNAGameState.IsInLobby=true;

function CNAGameState:ReceiveBeginPlay()

end

function CNAGameState:IsAllTeammateReady()
    local bIsUGCPIE = UGCBlueprintFunctionLibrary.IsUGCPIE(self)

   local bReady = true
   if bIsUGCPIE then ---PIE 默认全部玩家都是一个大厅队伍
      for _, PlayerState in ipairs(self.PlayerArray) do
         bReady = bReady and PlayerState.bIsReadyInLobby
      end
   else
      local PC = UGCGameSystem.GetLocalPlayerController()

      if PC ~= nil then
         for _, PlayerKey in ipairs(PC.LobbyTeammatePlayerKeys) do
            for _, PlayerState in ipairs(self.PlayerArray) do
               if UGCGameSystem.GetPlayerKeyByPlayerState(PlayerState) == PlayerKey then
                  bReady = bReady and PlayerState.bIsReadyInLobby
                  break
               end
            end
         end
      else
         bReady = false
      end
   end

   return bReady
end

-- function CNAGameState:GetReplicatedProperties()
--     return "PlayerNums";
-- end


return CNAGameState;
