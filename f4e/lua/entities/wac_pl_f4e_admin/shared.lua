if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 48 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]F-4E Phantom II (Admin)"
ENT.Author				= "Gredwitch"
ENT.Engines = 2
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/gredwitch/f4e/f4e.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/mm1/box.mdl"

ENT.rotorPos        = Vector(0,0,0)
ENT.TopRotorDir        = 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce        = 10000
ENT.Weight            = 18825
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos        = ENT.rotorPos
ENT.FirePos            = ENT.SmokePos

if CLIENT then
	ENT.thirdPerson = {
		distance = 700
	}
end

ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/gredwitch/f4e/f4e_wl.mdl",
		pos=Vector(-101.3,107,-1.5),
		friction=10,
		mass=600,
	},
	{
		mdl="models/gredwitch/f4e/f4e_wr.mdl",
		pos=Vector(-101.3,-107,-1.5),
		friction=10,
		mass=600,
	},
	{
		mdl="models/gredwitch/f4e/f4e_wf.mdl",
		pos=Vector(176,0,8),
		friction=10,
		mass=600,
	},
}

ENT.Seats = {
	{
		pos=Vector(131,-0.5,80),
		exit=Vector(138,100,90),
		weapons={"M61 Vulcan", "Mk 77 Napalm", "1000LB bombs", "AIM-9 Missiles", "AIM-7 Missiles"},
	},
	{
		pos=Vector(82, 0, 86),
		exit=Vector(82,100,40),
		weapons={"Mk 77 Napalm", "1000LB bombs","AIM-9 Missiles","AIM-7 Missiles"}
	},
}

ENT.Weapons = {
	["M61 Vulcan"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(280,0,50),
			},
			Ammo = 1,
			TkAmmo = 0,
			BulletType = "wac_base_20mm",
			Firerate = 3900
		}
	},
	["Mk 77 Napalm"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-20,82,28),
			},
			Kind = "gb_bomb_mk77",
			Admin = 1
		}
	},
	["1000LB bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(-20,-82,31),
			},
			Kind = "gb_bomb_1000gp",
			Admin = 1
		}
	},
	["AIM-7 Missiles"] = {
		class = "wac_pod_mis",
		info = {
			Sequential = true,
			Pods = {
				Vector(-140,-19,46),
				Vector(-140,19,46),
			},
			Ammo = 1,
			model = "models/hawx/aim-07 sparrow.mdl",
			FireRate = 60,
			TkAmmo = 0,
			
		}
	},
	["AIM-9 Missiles"] = {
		class = "wac_pod_mis",
		info = {
			Sequential = true,
			Pods = {
				Vector(-15,94,40),
				Vector(-15,-94,40),
			},
			Ammo = 1,
			model = "models/hawx/aim-9 sidewinder.mdl",
			FireRate = 60,
			TkAmmo = 0,
		}
	}
}
ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(235,0,35),
	offset = Vector(0,0,0),
	viewPos = Vector(0,0,0),
	maxAng = Angle(90, 45, 0),
	minAng = Angle(-20, -45, 0),
	seat = 1
}

ENT.Sounds={
	Start="WAC/f4/Start.wav",
	Blades="WAC/f4/external.wav",
	Engine="WAC/f4/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}

// heatwave
if CLIENT then
	local cureffect=0
	function ENT:Think()
		self:base("wac_pl_base").Think(self)
		local throttle = self:GetNWFloat("up", 0)
		local active = self:GetNWBool("active", false)
		local v=LocalPlayer():GetVehicle()
		if IsValid(v) then
			local ent=v:GetNWEntity("wac_aircraft")
			if ent==self and active and throttle > 0.2 and CurTime()>cureffect then
				cureffect=CurTime()+0.02
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-256,0,57.5)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(30)
				util.Effect("wac_heatwave", ed)
			end
		end
	end
end

local function DrawLine(v1,v2)
	surface.DrawLine(v1.y,v1.z,v2.y,v2.z)
end

local mHorizon0 = Material("WeltEnSTurm/WAC/Helicopter/hud_line_0")
local HudCol = Color(70,199,50,150)
local Black = Color(0,0,0,200)

local mat = {
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_0"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_high"),
	Material("WeltEnSTurm/WAC/Helicopter/hud_line_low"),
}

local function getspaces(n)
	if n<10 then
		n="      "..n
	elseif n<100 then
		n="    "..n
	elseif n<1000 then
		n="  "..n
	end
	return n
end


function ENT:DrawPilotHud()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(self:GetRight(), 90)
	ang:RotateAroundAxis(self:GetForward(), 90)

	local uptm = self.SmoothVal
	local upm = self.SmoothUp
	local spos=self.Seats[1].pos

	cam.Start3D2D(self:LocalToWorld(Vector(30,3.75,37.75)+spos), ang,0.015)
	surface.SetDrawColor(HudCol)
	surface.DrawRect(234, 247, 10, 4)
	surface.DrawRect(254, 247, 10, 4)
	surface.DrawRect(247, 234, 4, 10)
	surface.DrawRect(247, 254, 4, 10)

	local a=self:GetAngles()
	a.y=0
	local up=a:Up()
	up.x=0
	up=up:GetNormal()

	local size=180
	local dist=10
	local step=12
	for p=-180,180,step do
		if a.p+p>-size/dist and a.p+p<size/dist then
			if p==0 then
				surface.SetMaterial(mat[1])
			elseif p>0 then
				surface.SetMaterial(mat[2])
			else
				surface.SetMaterial(mat[3])
			end
			surface.DrawTexturedRectRotated(250+up.y*(a.p+p)*dist,250-up.z*(a.p+p)*dist,300,300,a.r)
		end
	end

	surface.SetTextColor(HudCol)
	surface.SetFont("wac_heli_small")

	surface.SetTextPos(90, 400) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(90, 435)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	cam.End3D2D()
end


