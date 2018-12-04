if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]UH-60 Stealth Black Hawk (Admin)"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Model			= "models/gredwitch/stealthhawk/uh60.mdl"
ENT.SmokePos		= Vector(-104.32,36,98.752)
ENT.FirePos			= Vector(-104.32,36,98.752)
ENT.maxEnterDistence = 400
ENT.EngineForce	= 53
ENT.Weight		= 9980
ENT.thirdPerson = {
	distance = 650
}
ENT.TopRotor = {
	dir = -1,
	pos = Vector(-1.3,0,141),
	model = "models/gredwitch/stealthhawk/uh60_toprotor.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-398,-14.67,155),
	model = "models/gredwitch/stealthhawk/uh60_backrotor.mdl"
}

ENT.Wheels={
	{
		mdl="models/gredwitch/stealthhawk/uh60_wb.mdl",
		pos=Vector(-307.6,0,18),
		friction=60,
		mass=600,
	},
	{
		mdl="models/gredwitch/stealthhawk/uh60_wl.mdl",
		pos=Vector(34.2,-59,14),
		friction=60,
		mass=600,
	},
	{
		mdl="models/gredwitch/stealthhawk/uh60_wr.mdl", 
		pos=Vector(34.2,59,14),
		friction=60,
		mass=600,
	},

}

ENT.Seats = {
	{
		pos=Vector(100,-28.75,44.78),
		exit=Vector(100,-100,44.78),
		weapons={"M134 Minigun"},
	},
	{
		pos=Vector(100,28.75,44.78),
		exit=Vector(100,100,44.78),
	},
	{
		pos=Vector(57.6,-24.7,45.2),
		ang=Angle(0,-90,0),
		exit=Vector(57.6,-100,45.2),
		weapons={"M134 Turret"},
	},
	{
		pos=Vector(57.6,24.7,45.2),
		ang=Angle(0,90,0),
		exit=Vector(57.6,100,45.2),
	},
	{
		pos=Vector(26.3,19.57,46),
		ang=Angle(0,180,0),
		exit=Vector(26.3,100,46),
	},
	{
		pos=Vector(26.3,-19.57,46),
		ang=Angle(0,180,0),
		exit=Vector(26.3,-100,46),
	},
	{
		pos=Vector(-60,20.7,45.2),
		exit=Vector(-60,100,45.2),
	},
	{
		pos=Vector(-60,0,45.2),
		exit=Vector(-60,-100,45.2),
	},
	{
		pos=Vector(-60,-20.7,45.2),
		exit=Vector(-60,-100,45.2),
	},
}

ENT.Weapons = {
	["M134 Minigun"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(103,60,72.3),
			},
			Ammo = 1,
			TkAmmo = 0,
			FireRate = 4000,
			BulletType = "wac_base_7mm",
			Sounds = {
				shoot = "WAC/uh60l/shoot1p.wav",
				stop = "WAC/uh60l/stop3p.wav",
			}
		}
	},
	["M134 Turret"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(65,-60,72.3),
			ShootOffset = Vector(40,0,0),
			FireRate = 4000,
			BulletType = "wac_base_7mm",
			Ammo = 1,
			TkAmmo = 0,
			Loop = true,
			Sounds = {
				spin = "",
				shoot1p = "WAC/uh60l/shoot1p.wav",
				stop1p = "WAC/uh60l/stop1p.wav",
				stop3p = "WAC/uh60l/stop3p.wav",
				shoot3p = "WAC/uh60l/shoot3p.wav",
			}
		}
	},
}

ENT.WeaponAttachments = {
	gun = {
		model = "models/gredwitch/stealthhawk/uh60_m134_gun.mdl",
		pos = Vector(73.83,-62.86,70.72),
		restrictPitch = false,
	},
	gunMount = {
		model = "models/gredwitch/stealthhawk/uh60_m134_mount.mdl",
		pos = Vector(69.75,-63,55),
		restrictPitch = true,
	}

}
ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(103,-63,72.3),
	offset = Vector(1,0,0),
	viewPos = Vector(7, 0, 3.5),
	minAng = Angle(-180, -180, -180),
	maxAng = Angle(180, 180, 180),
	seat = 3
}

ENT.Sounds = {
	Start = "WAC/Heli/h6_start.wav",
	Blades = "WAC/Heli/uh60_loop.wav",
	Engine = "",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
	Radio =  "HelicopterVehicle/MissileNearby.mp3",
}
