if not wac then return end
if SERVER then AddCSLuaFile() end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Aichi D3A1 Val"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false
ENT.Model            	= "models/gredwitch/d3a1/d3a1.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel          = "models/gredwitch/d3a1/d3a1_prop.mdl"
ENT.rotorPos        	= Vector(123.81,0,81.11)
ENT.TopRotorDir         = 1
ENT.EngineForce        	= 5000
ENT.Weight            	= 4320
ENT.SeatSwitcherPos		= Vector(0,0,0)
ENT.SmokePos        	= ENT.rotorPos
ENT.FirePos             = ENT.SmokePos

ENT.Agility = {
	Thrust = 16
}
ENT.thirdPerson = {
	distance = 600
}
ENT.Wheels = {
	{
		mdl="models/gredwitch/d3a1/d3a1_wf.mdl",
		pos=Vector(37.32,68.9,21),
		friction=5,
		mass=400,
	},
	{
		mdl="models/gredwitch/d3a1/d3a1_wf.mdl",
		pos=Vector(37.32,-68.9,21),
		friction=5,
		mass=400,
	},
	{
		mdl="models/gredwitch/d3a1/d3a1_wb.mdl",
		pos=Vector(-248.35,0,69.74),
		friction=5,
		mass=800,
	}
}

ENT.Seats = {
	{
		pos=Vector(0,0,84),
		exit=Vector(30,60,85),
		weapons={"Type 97", "100Kg Bombs"}
	},
	{
		pos=Vector(-40,0,84),
		ang=Angle(0,180,0),
		exit=Vector(30,60,85),
		weapons={"Type 92"}
	}
}

ENT.Weapons = {
	["Type 97"] = {
		class = "wac_pod_mg", 
		info = {
			Pods = {
				Vector(113.39,-9.34,102),
				Vector(113.39,9.34,102),
			},
			FireRate = 900,
			Sequential = false,
			Ammo = 1800,
			BulletType = "wac_base_7mm",
			Sounds = {
				shoot = "WAC/d3a1/shoot.wav",
				stop = "WAC/d3a1/stop.wav",
			}
		}
	},
	["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(19,-191.56,65.23),
				Vector(30.51,4.62,46.8),
				Vector(19,191.56,65.23),
			},
			Kind  = "gb_bomb_sc100"
		}
	},
	["Type 92"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(-52, 0, 110),
			ShootOffset = Vector(43,0,0),
			FireRate = 450,
			BulletType = "wac_base_7mm",
			Ammo = 1000,
			Sounds = {
			    shoot1p = "",
				shoot3p  = "",
				spin = "WAC/d3a1/spin.wav",
			}
		}
	}
}

ENT.WeaponAttachments={
	gun = {
		model = "models/gredwitch/d3a1/d3a1_gun.mdl",
		pos = Vector(-55.81,0,106.90),
	},
}

ENT.Camera = {
	model = "models/mm1/box.mdl",	
	pos = Vector(-92.63, 0, 114.43),
	offset = Vector(50,0,0),
	viewPos = Vector(0,0,0),
	minAng = Angle(-90, -360, 0),
	minAng = Angle(-90, -360, 0),
	seat = 2
}

ENT.Sounds = {
	Start="WAC/d3a1/Start.wav",
	Blades="WAC/d3a1/external.wav",
	Engine="WAC/d3a1/internal.wav",
}

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

	cam.Start3D2D(self:LocalToWorld(Vector(17,3.75,38.5)+spos), ang,0.015)
	surface.SetDrawColor(HudCol)

	local a=self:GetAngles()
	a.y=0
	local up=a:Up()
	up.x=0
	up=up:GetNormal()

	local size=140
	local dist=10
	local step=14
	surface.SetTextColor(HudCol)
	surface.SetFont("wac_heli_small")

	surface.SetTextPos(125, 450) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(300, 450)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	cam.End3D2D()
end