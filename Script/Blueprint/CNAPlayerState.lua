local CNAPlayerState = {}
 
CNAPlayerState.AllExperience = 500; -- integer

function CNAPlayerState:ReceiveBeginPlay()

    CNAPlayerState.SuperClass.ReceiveBeginPlay(self)

    self:SaveInit()

end

function CNAPlayerState:SaveInit()

    local TheSaveTable=UGCPlayerStateSystem.GetPlayerArchiveData(UGCGameSystem.GetUIDByPlayerState(self))

    if TheSaveTable.AllExperience then

        self.AllExperience = TheSaveTable.AllExperience;

    end

end

function CNAPlayerState:OnRep_AllExperience()

    local Level,Exp=self:GetLevelEXP();

    print("CNAPlayerState:OnRep_AllExperience PlayerLevel",Level);

    UGCEventSystem.SendEvent(CNAEventDefine.UpdateLevelExp,Exp,Level);

end

function CNAPlayerState:GetLevelEXP()

    local PlayerLevel=1;

    local CurrentExperience=self.AllExperience;

    print("CNAPlayerState:OnRep_AllExperience",self.AllExperience);

    for i = 1,CNAGameData.MaxLevel, 1 do

        if CurrentExperience >= CNAGameData.EXP[i] then

            CurrentExperience=CurrentExperience-CNAGameData.EXP[i];

            PlayerLevel=PlayerLevel+1;

        else
            break;
        end

    end

    if CurrentExperience>CNAGameData.EXP[CNAGameData.MaxLevel] then

        CurrentExperience=CNAGameData.EXP[CNAGameData.MaxLevel];

        PlayerLevel=CNAGameData.MaxLevel;

    end

    print("CNAPlayerState:OnRep_AllExperience",CurrentExperience);

    print("CNAPlayerState:OnRep_AllExperience PlayerLevel",PlayerLevel);

    return PlayerLevel,CurrentExperience;
end

function CNAPlayerState:GetLevel()
    local PlayerLevel=1;

    local CurrentExperience=self.AllExperience;

    print("CNAPlayerState:OnRep_AllExperience",self.AllExperience);

    for i = 1,CNAGameData.MaxLevel, 1 do

        if CurrentExperience >= CNAGameData.EXP[i] then

            CurrentExperience=CurrentExperience-CNAGameData.EXP[i];

            PlayerLevel=PlayerLevel+1;

        else
            break;
        end

    end

    if CurrentExperience>CNAGameData.EXP[CNAGameData.MaxLevel] then

        CurrentExperience=CNAGameData.EXP[CNAGameData.MaxLevel];

        PlayerLevel=CNAGameData.MaxLevel;

    end

    print("CNAPlayerState:OnRep_AllExperience",CurrentExperience);

    print("CNAPlayerState:OnRep_AllExperience PlayerLevel",PlayerLevel);

    return PlayerLevel;
    
end
--[[
function CNAPlayerState:ReceiveTick(DeltaTime)
    CNAPlayerState.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function CNAPlayerState:ReceiveEndPlay()
    CNAPlayerState.SuperClass.ReceiveEndPlay(self) 
end
--]]


function CNAPlayerState:GetReplicatedProperties()
    return
    "AllExperience";
end


--[[
function CNAPlayerState:GetAvailableServerRPCs()
    return
end
--]]

return CNAPlayerState