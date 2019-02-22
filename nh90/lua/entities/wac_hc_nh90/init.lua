
include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal*30)
	ent:Spawn()
	ent:Activate()
	ent.Owner=ply
	ent:ResetSequence("gearsdown")
	return ent
end


function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)
	
	if self:GetNWInt("seat_1_actwep") == 1 then
		-- self:ResetSequence("rampup")
	else
		-- self:ResetSequence("rampdown")
	end
	
	local gearsdown,t1=self:LookupSequence("gearsdown")
	local gearsup,t2=self:LookupSequence("gearsup")	
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	if IsValid(phys) and not self.disabled then
		if self.rotorRpm>0.5 and phys:GetVelocity():Length() > 100 and trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,10)) ) > 1000  and self:GetSequence() != gearsup then
			self:ResetSequence(gearsup) 
			self:SetPlaybackRate(1.0)
			self:SetBodygroup(1,1)
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				self.wheels[i]:SetColor(Color(255,255,255,0))
				self.wheels[i]:SetSolid(SOLID_NONE)
			end
		elseif trace.HitPos:Distance( self:LocalToWorld(Vector(0,0,10)) ) < 750  and self:GetSequence() == gearsup then
			self:ResetSequence(gearsdown)
			self:SetPlaybackRate(1.0)
			gearsdown,time1=self:LookupSequence("gearsup")

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