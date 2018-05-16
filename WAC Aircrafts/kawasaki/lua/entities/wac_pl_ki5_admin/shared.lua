if not wac then return end
if SERVER then AddCSLuaFile() end

ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Kawasaki Ki-5 (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false
ENT.engineHealth 		= 100
ENT.Model            	= "models/gredwitch/kawasaki/kawasaki_ki-5.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel          = "models/gredwitch/kawasaki/kawasaki ki-5 propeller.mdl"
ENT.rotorPos        	= Vector(51,0,0)
ENT.TopRotorDir         = 1
ENT.EngineForce        	= 5000
ENT.Weight            	= 4320
ENT.SeatSwitcherPos		= Vector(0,0,0)
ENT.SmokePos        	= ENT.rotorPos
ENT.FirePos             = ENT.SmokePos

ENT.Agility = {
	Thrust = 17
}
ENT.thirdPerson = {
	distance = 400
}
ENT.Wheels = {
	{
		mdl="models/gredwitch/kawasaki/kawasaki_ki-5_wr.mdl",
		pos=Vector(-10,45,-60),
		friction=5,
		mass=200,
	},
	{
		mdl="models/gredwitch/kawasaki/kawasaki_ki-5_wl.mdl",
		pos=Vector(-10,-45,-60),
		friction=5,
		mass=200,
	},
	{
		mdl="models/cessna/cessna172_nwheel.mdl",
		pos=Vector(-215.5,0,-15),
		friction=5,
		mass=400,
	}
}

ENT.Seats = {
	{
		pos=Vector(-75,0,0),
		exit=Vector(30,60,85),
		weapons={"Type 97", "100Kg Bombs"}
	}
}

ENT.Weapons = {
	["Type 97"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(30,-2,30),
				Vector(30,2,30),
			},
			FireRate = 500,
			BulletType = "wac_base_7mm",
			Sequential = false,
			TkAmmo = 0,
			Ammo = 425,
			Sounds = {
				shoot = "WAC/stuka/gun.wav",
				stop = "WAC/stuka/gun_stop.wav",
			}
		}
	},
	["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Sequential = false,
			FireRate = 100,
			Pods = {
				Vector(-20, 90, -38),
				Vector(-20, -90, -38)
			},
			Kind  = "gb_bomb_sc100",
			Admin = 1,
		},
	}
}

ENT.Camera = {
	model = "models/weapons/c_arms.mdl",	
	pos = Vector(45, 0, 43),
	offset = Vector(5,0,0),
	viewPos = Vector(0,0,0),
	minAng = Angle(-90, -360, 0),
	minAng = Angle(-90, -360, 0),
	seat = 2
}

ENT.Sounds = {
	Start="WAC/Stuka/Start.wav",
	Blades="WAC/Stuka/external.wav",
	Engine="WAC/Stuka/internal.wav",
}

local function DrawLine(v1,v2) end
function ENT:DrawPilotHud() end