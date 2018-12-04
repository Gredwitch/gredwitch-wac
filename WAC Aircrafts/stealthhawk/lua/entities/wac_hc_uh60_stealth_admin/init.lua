include("shared.lua")
AddCSLuaFile("shared.lua")


function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+Vector(0,0,10))
	ent:SetSkin(math.random(0,3))
	ent.Owner=ply
	ent:Spawn()
	ent:Activate()
	ent:SetBodygroup(3,1)
	return ent
end