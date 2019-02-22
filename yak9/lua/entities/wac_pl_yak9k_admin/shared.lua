if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Yakovlev Yak-9K (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model           	= "models/gredwitch/yak9/yak9k.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        	= "models/gredwitch/yak9/yak9k_prop.mdl"

ENT.rotorPos       		= Vector(161.18,0,69.24)
ENT.TopRotorDir        	= 1

ENT.EngineForce       	= 200
ENT.Weight            	= 2550
ENT.SeatSwitcherPos		= Vector(0,0,0)
ENT.SmokePos       	 	= ENT.rotorPos
ENT.FirePos            	= ENT.rotorPos

ENT.thirdPerson = {
	distance = 550
}

ENT.Agility = {
	Thrust = 18
}

ENT.Wheels={
	{
		mdl="models/gredwitch/yak9/yak9k_wl.mdl",
		pos=Vector(73.77,72.43,-0.88),
		friction=0,
		mass=500,
	},
	{
		mdl="models/gredwitch/yak9/yak9k_wr.mdl",
		pos=Vector(73.77,-72.43,-0.88),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/yak9/yak9k_wb.mdl",
		pos=Vector(-150.34,0,45.83),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(3.98,0,60),
		exit=Vector(-50,70,10),
		weapons={"Berezin UB", "45mm NS-45"}
	},
}


ENT.Weapons = {
	["Berezin UB"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(155,8.98,83.45),
			},
			FireRate = 800,
			Ammo = 1,
			TkAmmo = 0,
			TracerColor = "Green",
			Sounds = {
				shoot = "WAC/yak9/shoot.wav",
				stop = "WAC/yak9/stop.wav"
			}
		}
	},
	["45mm NS-45"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(180.57,0,69.24)
			},
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 270,
			TracerColor = "Green",
			BulletType = "wac_base_40mm",
			Sounds = {
				shoot = "WAC/yak9/45mm_shoot.wav",
				stop  = "WAC/yak9/45mm_stop.wav"
			}
		}
	}
}
ENT.Sounds={
	Start="WAC/yak9/Start.wav",
	Blades="WAC/yak9/external.wav",
	Engine="WAC/yak9/internal.wav",
	-- Radio="radio/american.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}

function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end