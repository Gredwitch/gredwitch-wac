include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*20)
	e.Owner = p
	e:Spawn()
	e:Activate()
	e:SetSkin(math.random(0,3))	
	return e
end

ENT.AutomaticFrameAdvance = true // needed for gear anims

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, -2, 0),
		Right = Vector(0, 0, 40), -- Rotate towards flying direction
		Top = Vector(0, -40, 0)
	},
	Lift = {
		Front = Vector(0, 0, 10), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.5)
	},
	Rail = Vector(1, 5, 20),
	Drag = {
		Directional = Vector(0.01, 0.01, 0.01),
		Angular = Vector(0.05, 0.1, 0.1)
	}
}

function ENT:PhysicsUpdate(ph)
	self:base("wac_pl_base").PhysicsUpdate(self,ph)

	if self.rotorRpm > 0.8 and self.rotorRpm < 0.89 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,1)
	elseif self.rotorRpm > 0.9 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,2)
	elseif self.rotorRpm < 0.8 and IsValid(self.rotorModel) then
		self.rotorModel:SetBodygroup(1,0)
	end
	
	local geardown,t1=self:LookupSequence("geardown")
	local gearup,t2=self:LookupSequence("gearup")	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and self.rotorRpm>0 and phys:GetVelocity():Length() > 1200 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50  and self:GetSequence() != gearup then
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
			geardown,time1=self:LookupSequence("gearup")

			timer.Simple(time1,function()
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

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	
	self.rotorModel.TouchFunc=nil
end