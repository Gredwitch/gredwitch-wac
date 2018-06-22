include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*20)
	e.Owner = p
	e:Spawn()
	e:Activate()
	return e
end

ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, -0.5, 0),
		Right = Vector(0, 0, 70), -- Rotate towards flying direction
		Top = Vector(0, 0, 0)
	},
	Lift = {
		Front = Vector(0, 0, 13.25), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.25)
	},
	Rail = Vector(1, 5, 20),
	Drag = {
		Directional = Vector(0.01, 0.01, 0.01),
		Angular = Vector(0.05, 0.05, 0.05)
	}
}

function ENT:PhysicsUpdate(ph)
	self:base("wac_pl_base").PhysicsUpdate(self,ph)
	
	local ammo = self.weapons["AGM-88 HARM"]:GetAmmo()
	local ammo9 = self.weapons["AIM-9"]:GetAmmo()
	if ammo == 2 then 
		self:SetBodygroup(3,0)
		self:SetBodygroup(4,0)
	elseif ammo == 1 then 
		self:SetBodygroup(3,1)
		self:SetBodygroup(4,0)
	elseif ammo == 0 then 
		self:SetBodygroup(3,1)
		self:SetBodygroup(4,1)
	end
	if ammo9 == 2 then 
		self:SetBodygroup(1,0)
		self:SetBodygroup(2,0)
	elseif ammo9 == 1 then 
		self:SetBodygroup(1,0)
		self:SetBodygroup(2,1)
	elseif ammo9 == 0 then 
		self:SetBodygroup(1,1)
		self:SetBodygroup(2,1)
	end
	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.controls.throttle>0 and self.rotorRpm>0.8 and phys:GetVelocity():Length() > 1600 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,62)) ) > 50 then
			self:SetBodygroup(0,0)
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
			self:SetBodygroup(0,1)
		end
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)
	
	self.rotorModel.TouchFunc=nil
end