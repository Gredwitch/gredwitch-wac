include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*16+Vector(0,0,100))
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
	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and self.rotorRpm>0.8 and phys:GetVelocity():Length() > 1600 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50 then
			
			self:SetBodygroup(1,1)
			self:SetBodygroup(2,1)
			self:SetBodygroup(3,1)
			self:SetBodygroup(4,1)
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				self.wheels[i]:SetColor(Color(255,255,255,0))
				self.wheels[i]:SetSolid(SOLID_NONE)
			end
		elseif self.controls.throttle<0 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50 then
			if self.wheels then
				for i=1,3 do 
					self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
					self.wheels[i]:SetColor(Color(255,255,255,255))
					self.wheels[i]:SetSolid(SOLID_VPHYSICS)
				end
			end
			
			self:SetBodygroup(1,0)
			self:SetBodygroup(2,0)
			self:SetBodygroup(3,0)
			self:SetBodygroup(4,0)
		end
	end
	
	if self.rotor2 then
		local vel = ph:GetVelocity()	
		local pos = self:GetPos()
		local lvel = self:WorldToLocal(pos+vel)
		local throttle = self.controls.throttle/2 + 0.5
		local phm = FrameTime()*66
		local brake = (throttle+1)*self.rotorRpm/900+self.rotor.phys:GetAngleVelocity().z/100
		self.rotor2.phys:AddAngleVelocity(Vector(0,0,self.engineRpm*30 + throttle*self.engineRpm*20)*self.rotorDir*phm)
		self.rotor2.phys:AddAngleVelocity(Vector(0,0,-brake + lvel.x*lvel.x/500000)*self.rotorDir*phm)
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)

	self.rotorModel.TouchFunc=nil
	
	self.rotor2 = ents.Create("prop_physics")
	self.rotor2:SetModel("models/props_junk/sawblade001a.mdl")
	self.rotor2:SetPos(self:LocalToWorld(self.rotorPos2))
	self.rotor2:SetAngles(self:GetAngles() + Angle(90, 0, 0))
	self.rotor2:SetOwner(self.Owner)
	self.rotor2:Spawn()
	self.rotor2:SetNotSolid(true)
	self.rotor2.phys = self.rotor2:GetPhysicsObject()
	self.rotor2.phys:EnableGravity(false)
	self.rotor2.phys:SetMass(5)
	--self.rotor2.phys:EnableDrag(false)
	self.rotor2:SetNoDraw(true)
	self.rotor2.health = 100
	self.rotor2.wac_ignore = true
	if self.RotorModel2 then
		local e = ents.Create("wac_hitdetector")
		e:SetModel(self.RotorModel2)
		e:SetPos(self:LocalToWorld(self.rotorPos2))
		e:SetAngles(self:GetAngles())
		e:Spawn()
		e:SetOwner(self.Owner)
		e:SetParent(self.rotor2)
		e.wac_ignore = true
		local obb=e:OBBMaxs()
		self.RotorWidth=(obb.x>obb.y and obb.x or obb.y)
		self.RotorHeight=obb.z
		self.rotorModel2=e
		self:AddOnRemove(e)
	end
	constraint.Axis(self.Entity, self.rotor2, 0, 0, self.rotorPos2, Vector(0,0,1), 0,0,0.01,1)
	self:AddOnRemove(self.rotor2)
end