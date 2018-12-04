if not wac then return end

ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.PrintName			= "[WAC]UH-60 Black Hawk (Sandstorm)"
ENT.Author				= "Gredwitch"
ENT.Category			= "Gredwitch's Stuff"
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Model			= "models/gredwitch/uh60_sandstorm/uh60.mdl"
ENT.SmokePos		= Vector(-30.0071,0,90.874)
ENT.FirePos			= ENT.SmokePos
ENT.maxEnterDistence = 400
ENT.EngineForce	= 53
ENT.Weight		= 9980
ENT.thirdPerson = {
	distance = 650
}
ENT.TopRotor = {
	dir = -1,
	pos = Vector(72.0071,0,130.874),
	model = "models/gredwitch/uh60_sandstorm/uh60_tr.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-308.973,-21.8256,125.977),
	model = "models/gredwitch/uh60_sandstorm/uh60_br.mdl"
}

ENT.Wheels={
	{
		mdl="models/gredwitch/uh60_sandstorm/uh60_wb.mdl",
		pos=Vector(-225.824,0,8.2788),
		friction=60,
		mass=600,
	},
	{
		mdl="models/gredwitch/uh60_sandstorm/uh60_wl.mdl",
		pos=Vector(110.9526,57.4,10.6282),
		friction=60,
		mass=600,
	},
	{
		mdl="models/gredwitch/uh60_sandstorm/uh60_wr.mdl",
		pos=Vector(110.9526,-57.4,11.6282),
		friction=60,
		mass=600,
	},

}

ENT.Seats = {
	{
		pos=Vector(169.545,-25.0917,40.293),
		exit=Vector(100,-100,0),
		weapons={"GAU-19 Minigun"},
	},
	{
		pos=Vector(169.545,25.0917,40.293),
		exit=Vector(100,100,0),
	},
	{
		pos=Vector(120.7074,-26.0022,33.7),
		ang=Angle(0,-90,0),
		exit=Vector(57.6,-100,0),
		weapons={"GAU-19 Turret"},
	},
	{
		pos=Vector(120.7074,26.0022,33.7),
		ang=Angle(0,90,0),
		exit=Vector(57.6,100,0),
	},
	{
		pos=Vector(120.7074,0,33.7),
		ang=Angle(0,180,0),
		exit=Vector(26.3,100,0),
	},
	{
		pos=Vector(70.7301,10.6074,33.7241),
		ang=Angle(0,180,0),
		exit=Vector(26.3,100,0),
	},
	{
		pos=Vector(70.7301,-10.6074,33.7241),
		ang=Angle(0,180,0),
		exit=Vector(26.3,100,0),
	},
	{
		pos=Vector(70.7301,-30.6074,33.7241),
		ang=Angle(0,180,0),
		exit=Vector(26.3,100,0),
	},
	
	{
		pos=Vector(30.7301,30.6074,33.7241),
		exit=Vector(26.3,100,0),
	},
	{
		pos=Vector(30.7301,10.6074,33.7241),
		exit=Vector(26.3,100,0),
	},
	{
		pos=Vector(30.7301,-10.6074,33.7241),
		exit=Vector(26.3,100,0),
	},
	{
		pos=Vector(30.7301,-30.6074,33.7241),
		exit=Vector(26.3,100,0),
	},
}

ENT.Weapons = {
	["GAU-19 Minigun"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(151.1033,49.3655,47.984),
			},
			Ammo = 2000,
			FireRate = 2000,
			BulletType = "wac_base_12mm",
			Sounds = {
				shoot = "WAC/uh60_sandstorm/shoot1p.wav",
				stop = "WAC/uh60_sandstorm/stop3p.wav",
			}
		}
	},
	["GAU-19 Turret"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(121.1033,-49.3655,47.984),
			ShootOffset = Vector(30,0,0),
			FireRate = 2000,
			BulletType = "wac_base_12mm",
			Ammo = 2000,
			Loop = true,
			Sounds = {
				spin = "",
				shoot1p = "WAC/uh60_sandstorm/shoot1p.wav",
				stop1p = "WAC/uh60_sandstorm/stop1p.wav",
				stop3p = "WAC/uh60_sandstorm/stop3p.wav",
				shoot3p = "WAC/uh60_sandstorm/shoot3p.wav",
			}
		}
	},
}

ENT.WeaponAttachments = {
	gun = {
		model = "models/gredwitch/uh60_sandstorm/uh60_gun.mdl",
		pos = Vector(121.1033,-49.3655,47.984),
		restrictPitch = false,
	},

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
	Blades = "WAC/uh60_sandstorm/external.wav",
	Engine = "WAC/uh60_sandstorm/internal_alt.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
	Radio =  "HelicopterVehicle/MissileNearby.mp3",
}
