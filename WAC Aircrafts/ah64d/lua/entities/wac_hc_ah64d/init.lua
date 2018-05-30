
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos+Vector(0,0,80))
	e.Owner = p
	e:Spawn()
	e:Activate()
	e:SetSkin(math.random(0,2))

	return e
end

function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)
	if self.rotorRpm > 0.8 and self.rotorRpm < 0.89 and IsValid(self.topRotor) then
		self.topRotor:SetBodygroup(0,1)
		if IsValid(self.backRotorModel) then self.backRotorModel:SetBodygroup(0,1) end
	elseif self.rotorRpm > 0.9 and IsValid(self.topRotor) then
		self.topRotor:SetBodygroup(0,2)
		if IsValid(self.backRotorModel) then self.backRotorModel:SetBodygroup(0,2) end
	else
		self.topRotor:SetBodygroup(0,0)
		if IsValid(self.backRotorModel) then self.backRotorModel:SetBodygroup(0,0) end
	end
	if self.active then
		self:SetBodygroup(5,2)
	else
		self:SetBodygroup(5,0)
	end
end