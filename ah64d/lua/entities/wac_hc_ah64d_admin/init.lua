
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
	if self.active then
		self:SetBodygroup(4,2)
	else
		self:SetBodygroup(4,0)
	end
end