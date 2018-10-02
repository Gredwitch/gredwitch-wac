
include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

ENT.IgnoreDamage = false
ENT.UsePhysRotor = true
ENT.Submersible	= false
ENT.CrRotorWash	= true
ENT.RotorWidth	= 200
ENT.EngineForce	= 20
ENT.BrakeMul = 1
ENT.AngBrakeMul	= 0.01
ENT.Weight = 5000

ENT.Agility = {
	Rotate = Vector(1, 1, 1),
	Thrust = 1
}

function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)
	if self:IsValid() then
		self:SetNWFloat("roll", self.controls.roll)
		self:SetNWFloat("pitch", self.controls.pitch)
		self:SetNWFloat("yaw", self.controls.yaw)
		self:SetNWFloat("throttle", self.controls.throttle)
	end
	if !IsValid( self.TailboomWeld ) || !IsValid(self.Tailboom) then

		self:KillBackRotor( )
		self.Entity:SetBodygroup(1,1)
		if self.Tailboom:IsValid() then
		if !self.TailExploded then 
			self.Tailboom:SetModel(self.TailBoom.damage_rip)
		end
		local tbp = self.Tailboom:GetPhysicsObject( )
			if tbp:IsValid( ) then

				tbp:SetMass( 1000 )
				tbp:EnableGravity( true )
				tbp:EnableDrag( true )

			end
		end
	
	end
--	if self.deadTopRotor then
--	
--		local vel = self.deadTopRotor.Phys:GetAngleVelocity()
--		self.deadTopRotor.Phys:AddAngleVelocity(-vel/100)
--	end
--	if self.deadBackRotor then
--		local vel = self.deadBackRotor.Phys:GetAngleVelocity()
--		self.deadBackRotor.Phys:AddAngleVelocity(-vel/100)
--	end
	
end

function ENT:KillTopRotor()
	if !self.topRotor then return end
	self:setEngine(false)

	self:SetNWFloat("up",0)
	self:SetNWFloat("uptime",0)

	self.topRotor.vis:SetModel(self.TopRotor.damage)
	self.rotorRpm = 0
	self.deadTopRotor = self.topRotor
	self.topRotor = nil
end	


function ENT:KillBackRotor()
	if !self.backRotor then return end
	self.backRotor:SetModel(self.BackRotor.damage)
	self.deadBackRotor = self.backRotor
	self.backRotor = nil
end


function ENT:DamageEngine(amt)
	if wac.aircraft.cvars.nodamage:GetInt() == 1 then
		return
	end
	if self.disabled then return end
	self.engineHealth = self.engineHealth - amt

	if self.engineHealth < 80  then
		if !self.sounds.MinorAlarm:IsPlaying() then
			self.sounds.MinorAlarm:Play()
		end
		if !self.Smoke and self.engineHealth>0 then
			self.Smoke = self:CreateSmoke()
		end

		if self.engineHealth < 50 then
			if !self.sounds.LowHealth:IsPlaying() then
				self.sounds.LowHealth:Play()
			end
			self:setEngine(false)
			self.engineDead = true

			if self.engineHealth < 20 and !self.EngineFire then
				local fire = ents.Create("env_fire_trail")
				fire:SetPos(self:LocalToWorld(self.FirePos))
				fire:Spawn()
				fire:SetParent(self.Entity)
				self.Burning = true
				self.sounds.LowHealth:Play()
				self.EngineFire = fire
			end

			if self.engineHealth < 0 and !self.disabled then
				self.disabled = true
				self.engineRpm = 0
				self.rotorRpm = 0
				self:SetModel(self.DamageModel)
				self:KillTopRotor()
				if IsValid(self.TailboomWeld) then
				self.Tailboom:SetModel(self.TailBoom.damage_explosion)
				self.TailExploded = true
				constraint.RemoveConstraints(self.Tailboom, "Weld")	
				end
					
				local lasta=(self.LastDamageTaken<CurTime()+6 and self.LastAttacker or self.Entity)
				for k, p in pairs(self.passengers) do
					if p and p:IsValid() then
						p:TakeDamage(p:Health() + 20, lasta, self.Entity)
					end
				end

				for k,v in pairs(self.seats) do
					v:Remove()
				end
				self.passengers={}
				self:StopAllSounds()

				self:setVar("rotorRpm", 0)
				self:setVar("engineRpm", 0)
				self:setVar("up", 0)

				self.IgnoreDamage = false
				--[[ this affects the base class
					for name, vec in pairs(self.Aerodynamics.Rotation) do
						vec = VectorRand()*100
					end
					for name, vec in pairs(self.Aerodynamics.Lift) do
						vec = VectorRand()
					end
					self.Aerodynamics.Rail = Vector(0.5, 0.5, 0.5)
				]]
				local effectdata = EffectData()
				effectdata:SetStart(self.Entity:GetPos())
				effectdata:SetOrigin(self.Entity:GetPos())
				effectdata:SetScale(1)
				util.Effect("Explosion", effectdata)
				util.Effect("HelicopterMegaBomb", effectdata)
				util.Effect("cball_explode", effectdata)
				util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 300, 300)
				self:setEngine(false)
				if self.Smoke then
					self.Smoke:Remove()
					self.Smoke=nil
				end
				if self.RotorWash then
					self.RotorWash:Remove()
					self.RotorWash=nil
				end
				self:SetNWBool("locked", true)
			end
		end
	end
	if self.Smoke then
		local rcol = math.Clamp(self.engineHealth*3.4, 0, 170)
		self.Smoke:SetKeyValue("rendercolor", rcol.." "..rcol.." "..rcol)
	end
	self:SetNWFloat("health", self.engineHealth)
end

function ENT:addRotors( )
	if self.UsePhysRotor then
	
		--self.Tailboom = self:addEntity("prop_physics")
		self.Tailboom = ents.Create("prop_physics")
		self.Tailboom:SetModel(self.TailBoom.model)
		self.Tailboom:SetPos(self:LocalToWorld(self.TailBoom.pos))
		self.Tailboom:SetAngles(self:LocalToWorldAngles(self.TailBoom.angles))
		--self.Tailboom:SetOwner( self.Owner )
		self.Tailboom:Spawn( )
		self.Tailboom:Activate( )

		local tbp = self.Tailboom:GetPhysicsObject( )
		if tbp:IsValid( ) then

			tbp:SetMass(50)
			tbp:EnableGravity( false )
			tbp:EnableDrag( false )
			tbp:EnableCollisions( true )
			tbp:Wake( )

		end
		if wac.aircraft.cvars.nodamage:GetInt() == 0 then
			self.TailboomWeld = constraint.Weld( self.Tailboom, self, 0, 0, 5000, true, true )
		else
			self.TailboomWeld = constraint.Weld( self.Tailboom, self, 0, 0, 0, true, true )
		end
		
		self.topRotor = self:addEntity("prop_physics")
		self.topRotor:SetModel("models/props_junk/sawblade001a.mdl")
		self.topRotor:SetPos(self:LocalToWorld(self.TopRotor.pos))
		self.topRotor:SetAngles(self:LocalToWorldAngles(self.TopRotor.angles))
		self.topRotor:SetOwner(self.Owner)
		self.topRotor:SetNotSolid(true)
		self.topRotor:Spawn()
		self.topRotor.Phys = self.topRotor:GetPhysicsObject()
		self.topRotor.Phys:EnableGravity(false)
		self.topRotor.Phys:SetMass(5)
		self.topRotor.Phys:EnableDrag(false)
		self.topRotor:SetNoDraw(true)
		self.topRotor.fHealth = 100
		self.topRotor.wac_ignore = true
		if self.TopRotor.model then
			local e = self:addEntity("wac_hitdetector")
			self:SetNWEntity("wac_air_rotor_main", e)
			e:SetModel(self.TopRotor.model)
			e:SetPos(self.topRotor:GetPos())
			e:SetAngles(self.topRotor:GetAngles())
			
			e.TouchFunc = function(touchedEnt, pos)
				local ph = touchedEnt:GetPhysicsObject()
				if ph:IsValid() then
					if 
							not table.HasValue(self.passengers, touchedEnt)
							and !table.HasValue(self.entities, touchedEnt)
							and touchedEnt != self
							and !string.find(touchedEnt:GetClass(), "func*")
							and IsValid(self.topRotor)
							and touchedEnt:GetMoveType() != MOVETYPE_NOCLIP
					then
						local rotorVel = self.topRotor:GetPhysicsObject():GetAngleVelocity():Length()
						local dmg, mass;
						if touchedEnt:GetClass() == "worldspawn" then
							dmg = rotorVel*rotorVel/100000
							mass = 10000
						else
							dmg=(rotorVel*rotorVel + ph:GetVelocity():Length()*ph:GetVelocity():Length())/100000
							mass = touchedEnt:GetPhysicsObject():GetMass()
						end
						ph:AddVelocity((pos-self.topRotor:GetPos())*dmg/mass)
						self.phys:AddVelocity((self.topRotor:GetPos() - pos)*dmg/mass)
						self:DamageBigRotor(dmg)
						e.Entity:TakeDamage(dmg, IsValid(self.passengers[1]) and self.passengers[1] or self.Entity, self.Entity)
					end
				end
			end
			
			e:Spawn()
			e:SetNotSolid(true)
			e:SetParent(self.topRotor)
			e.wac_ignore = true
			local obb = e:OBBMaxs()
			self.RotorWidth = (obb.x>obb.y and obb.x or obb.y)
			self.RotorHeight = obb.z
			self.topRotor.vis = e
		end
		self.backRotor = self:addBackRotor()
		self:SetNWEntity("rotor_rear", self.backRotor)
		constraint.Axis(self.Entity, self.topRotor, 0, 0, self.TopRotor.pos, Vector(0,0,1), 0,0,0,1)
		if self.TwinBladed then
			constraint.Axis(self.Entity, self.backRotor, 0, 0, self.BackRotor.pos, Vector(0,0,1),0,0,0,1)
		else
			constraint.Axis(self.Tailboom, self.backRotor, 0, 0, self.BackRotor.pos, Vector(0, 1, 0), 0,0,0,1)
		end
		self:AddOnRemove(self.topRotor)
		self:AddOnRemove(self.backRotor)
	end
end

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*0.1)
	e.Owner = p
	e:Spawn()
	e:Activate()
	return e
end