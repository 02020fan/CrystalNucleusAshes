---@class CNAGameState_C:BP_UGCGameState_C
--Edit Below--
UGCGameSystem.UGCRequire('Script.Common.ue_enum_custom');
require("Script.UGCEventSystem");
require("Script.CNAEventDefine");
require("Script.CNAGameData");

local CNAGameState = {}; 

CNAGameState.PlayerNums=0;


function CNAGameState:ReceiveBeginPlay()

    -- UGCGenericMessageSystem.ListenGlobalMessage(self, UGCGenericMessageSystem.Messages.UGC.Player.PlayerEnter, self, self.UpdatePlayerNums);

end

function CNAGameState:UpdatePlayerNums(PlayerKey)

    self.PlayerNums=UGCGameSystem.GetPlayerNum(true)

end

function CNAGameState:GetReplicatedProperties()
    return "PlayerNums";
end

function CNAGameState:OnRep_PlayerNums()

    LobbyFlow:UpdateRoomNums(self.PlayerNums);

end
return CNAGameState;
