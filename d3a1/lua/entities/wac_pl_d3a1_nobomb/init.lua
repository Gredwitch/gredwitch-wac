
include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

ENT.AutomaticFrameAdvance = true // needed for gear anims

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal)
	ent:Spawn()
	ent:Activate()
	ent:SetSkin(math.random(0,7))
	ent.Owner=ply
	return ent
end

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, 0, 0),
		Right = Vector(0, 0, 40), -- Rotate towards flying direction
		Top = Vector(0, -40, 0)
	},
	Lift = {
		Front = Vector(0, 0, 15), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.5)
	},
	Rail = Vector(1, 5, 20),
	Drag = {
		Directional = Vector(0.01, 0.01, 0.01),
		Angular = Vector(0.01, 0.01, 0.01)
	}
}



function ENT:PhysicsUpdate(ph)
	self:base("wac_pl_base").PhysicsUpdate(self,ph)

	--[[if self.rotorRpm > 0.8 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,1)
	elseif self.rotorRpm > 0.9 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,2)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,0)
	end--]]
	
	local geardown,t1=self:LookupSequence("flapsdown")
	local gearup,t2=self:LookupSequence("flapsup")	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and self.rotorRpm>0.8 and phys:GetVelocity():Length() > 1600 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50  and self:GetSequence() != gearup then
			self:ResetSequence(gearup) 
			self:SetPlaybackRate(1.0)
		elseif self.controls.throttle<0 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50  and self:GetSequence() == gearup then
			self:ResetSequence(geardown)
			self:SetPlaybackRate(1.0)
			geardown,time1=self:LookupSequence("flapsup")
		end
	end
end
function ENT:Think()
	self:base("wac_pl_base").Think(self)
	if self.engineHealth <= 20 then
		self:SetSkin(1)
	else
		self:SetSkin(0)
	end
	self.rotorModel:SetSkin(self:GetSkin())
	for i=1,3 do 
		self.wheels[i]:SetSkin(self:GetSkin())
	end
	self:SetBodygroup(18,0)
	self:SetBodygroup(19,0)
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	
	self.rotorModel.TouchFunc=nil
end