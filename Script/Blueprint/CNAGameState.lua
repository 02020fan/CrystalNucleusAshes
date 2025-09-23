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


-- function CNAGameState:GetReplicatedProperties()
--     return "PlayerNums";
-- end


return CNAGameState;
