
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*40)
	ent:Spawn()
	ent:Activate()
	ent:SetSkin(math.random(0,5))
	ent.Owner=ply
	return ent
end

ENT.AutomaticFrameAdvance = true

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, -4, 0),
		Right = Vector(0, 0, 40), -- Rotate towards flying direction
		Top = Vector(0, -10, 0)
	},
	Lift = {
		Front = Vector(0, 0, 24.5), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.5)
	},
	Rail = Vector(1, 5, 5),
	Drag = {
		Directional = Vector(0.01, 0.01, 0.01),
		Angular = Vector(0.05, 0.1, 0.05)
	}
}
function ENT:PhysicsUpdate(ph)
	self:base("wac_pl_base").PhysicsUpdate(self,ph)
	
	local geardown,t1=self:LookupSequence("gearsdown")
	local gearup,t2=self:LookupSequence("gearsup")	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and self.rotorRpm>0.8 and phys:GetVelocity():Length() > 1600 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50  and self:GetSequence() != gearup then
			self:ResetSequence(gearup) 
			self:SetPlaybackRate(1.0)
			self:SetBodygroup(1,1)
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				self.wheels[i]:SetColor(Color(255,255,255,0))
				self.wheels[i]:SetSolid(SOLID_NONE)
			end
		elseif self.controls.throttle<0 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50  and self:GetSequence() == gearup then
			self:ResetSequence(geardown)
			self:SetPlaybackRate(1.0)

			timer.Simple(self:SequenceDuration(),function()
				if self.wheels then
					for i=1,3 do 
						self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
						self.wheels[i]:SetColor(Color(255,255,255,255))
						self.wheels[i]:SetSolid(SOLID_VPHYSICS)
					end
					self:SetBodygroup(1,0)
				end
			end)
		end
	end
end

function ENT:Think()
	self:base("wac_pl_base").Think(self)
	local curskin = self:GetSkin()
	if self.engineHealth <= 20 then
		if curskin <= 5  then self:SetSkin(curskin + 6) end
	else
		if curskin > 5  then self:SetSkin(curskin - 6) end
	end
	local geardown=self:LookupSequence("gearsdown")
	local gearup=self:LookupSequence("gearsup")
	local cursec = self:GetSequence()
	if cursec == gearup then
		self:SetBodygroup(2,2)
	elseif cursec == geardown then
		self:SetBodygroup(2,0)
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	
	self.rotorModel.TouchFunc=nil
end