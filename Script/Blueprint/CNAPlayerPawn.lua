local CNAPlayerPawn = {}
 
--[[
function CNAPlayerPawn:ReceiveBeginPlay()
    CNAPlayerPawn.SuperClass.ReceiveBeginPlay(self)
end
--]]

--[[
function CNAPlayerPawn:ReceiveTick(DeltaTime)
    CNAPlayerPawn.SuperClass.ReceiveTick(self, DeltaTime)
end
--]]

--[[
function CNAPlayerPawn:ReceiveEndPlay()
    CNAPlayerPawn.SuperClass.ReceiveEndPlay(self) 
end
--]]

--[[
function CNAPlayerPawn:GetAvailableServerRPCs()
    return
end
--]]

function CNAPlayerPawn:GetReplicatedProperties()
    return {"__SubObjectRepList", "Lazy"}
end


return CNAPlayerPawn