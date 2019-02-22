if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 40 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]A-6 Intruder (Bomber)"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.Model	    = "models/gredwitch/a6/a6.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/mm1/box.mdl"
ENT.rotorPos	= Vector(0,0,74)
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 600
ENT.Weight	    = 12000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.SmokePos	= Vector(-266.6,0,73.8919)
ENT.FirePos	    = ENT.SmokePos

if CLIENT then
	ENT.thirdPerson = {
		distance = 600
	}
end

ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/gredwitch/a6/a6_wb.mdl",
		pos=Vector(7,-47.1,-19.4),
		friction=10,
		mass=1000,
	},
	{
		mdl="models/gredwitch/a6/a6_wb.mdl",
		pos=Vector(7,47.1,-19.4),
		friction=10,
		mass=1000,
	},
	{
		mdl="models/gredwitch/a6/a6_wf.mdl",
		pos=Vector(153.58,1.1,-15.89),
		friction=10,
		mass=3000,
	},
}

ENT.Seats = {
	{
		pos=Vector(140,10,60),
		exit=Vector(63,100,70),
		weapons={"Mk 82"}
	},
	{
		pos=Vector(140,-15,60),
		exit=Vector(63,100,70),
		weapons={"AGM-88"}
	}
}

ENT.Weapons = {
	["AGM-88"] = {
		class = "wac_pod_mis",
		info = {
			Pods = {
				Vector(5,136,50),
				Vector(5,-136,50),
			},
			Sequential = true,
			FaF = true,
			Ammo = 2,
			FireRate = 50,
		}
	},
	["Mk 82"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(20,-91,38),
				Vector(20,91,38),
			},
			Sequential = true,
			Kind = "gb_bomb_mk82",
			Ammo = 2,
		}
	},
}

ENT.Sounds={
	Start="WAC/a6/Start.wav",
	Blades="WAC/a6/external.wav",
	Engine="WAC/a6/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}


ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(300,15,95),
	offset = Vector(-1,0,0),
	viewPos = Vector(2,0,0),
	maxAng = Angle(90, 90, 0),
	minAng = Angle(-90, -90, 0),
	seat = 2
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
				ed:SetOrigin(Vector(-80,40.36,48.57)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(25)
				util.Effect("wac_heatwave", ed)
				local ed=EffectData()
				ed:SetEntity(self)
				ed:SetOrigin(Vector(-80,-40.36,48.57)) // offset
				ed:SetMagnitude(throttle)
				ed:SetRadius(25)
				util.Effect("wac_heatwave", ed)
			end
		end
	end
end


//hud

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

	cam.Start3D2D(self:LocalToWorld(Vector(20,3.75,37.75)+spos), ang,0.015)
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

	surface.SetTextPos(30, 410) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 445)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	cam.End3D2D()
end