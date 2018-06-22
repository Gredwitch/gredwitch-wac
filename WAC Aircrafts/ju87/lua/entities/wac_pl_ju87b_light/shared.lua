if not wac then return end
if SERVER then AddCSLuaFile() end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Ju-87B 100Kg bombs"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false
ENT.Model            = "models/sentry/stuka.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/sentry/stuka_prop.mdl"

ENT.rotorPos        = Vector(161,0,81)
ENT.TopRotorDir        = 1

ENT.EngineForce        = 5000
ENT.Weight            = 4320
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.SmokePos        = Vector(121,0,75)
ENT.FirePos            = Vector(121,0,95)

ENT.Agility = {
	Thrust = 15
}

ENT.Wheels = {
	{
		mdl="models/sentry/stuka_wheel.mdl",
		pos=Vector(67,55.7,6),
		friction=0,
		mass=200,
	},
	{
		mdl="models/sentry/stuka_wheel.mdl",
		pos=Vector(67,-55.7,6),
		friction=0,
		mass=200,
	},
	{
		mdl="models/sentry/stuka_bwheel.mdl",
		pos=Vector(-217.5,0,62),
		friction=0,
		mass=200,
	}
}


ENT.Weapons = {
	["MG17"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(85,-71.05,65),
				Vector(85,71.05,65),
			},
			FireRate = 1000,
			BulletType = "wac_base_7mm",
			Ammo = 2000,
			Sounds = {
				shoot = "WAC/stuka/gun.wav",
				stop = "WAC/stuka/gunstop.wav",
			}
		}
	},
	["Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Sequential = true,
			FireRate = 300,
			Pods = {
				Vector(50, 0, 50), --Middle
				Vector(43, 170, 67),--Left
				Vector(43, 180, 68),--Left
				Vector(43, -170, 67),--Right
				Vector(43, -180, 68),--Right
				
			},
			Kind = "gb_bomb_sc100",
		},
	},
	
	["Gunner"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
	            shoot1p = "",
	            shoot3p = "",
            	spin = "wac/fw190/shoot_start.wav"
            },
			BulletType = "wac_base_7mm",
			ShootPos = Vector(-80,0,100),
			Ammo = 1400,
			ShootOffset = Vector(50, 5, 55)
		}
	}
}


ENT.Seats = {
	{
		pos=Vector(25,0,83.2),
		exit=Vector(30,60,85),
		weapons={"MG17", "Bombs"}
	},
	{
		pos=Vector(-18.5,0,77),
		exit=Vector(-10,60,85),
		ang=Angle(0,180,0),
		weapons = {"Gunner"}
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
	Start="WAC/Stuka/start.wav",
	Blades="WAC/Stuka/external.wav",
	Engine="WAC/Stuka/internal.wav",
	Radio="radio/german.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
}

local function DrawLine(v1,v2) end
function ENT:DrawPilotHud() end