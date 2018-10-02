
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*16+Vector(0,0,50))
	e.Owner = p
	e:Spawn()
	e:Activate()
	return e
end

function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)
	if IsValid(self.backRotor) then
		if self.rotorRpm > 0.34 then
			self.backRotor:SetBodygroup(0,1)
		else
			self.backRotor:SetBodygroup(0,0)
		end
	end
end