
ENT.Base = "wac_hc_base"
ENT.Type = "anim"
ENT.Author = wac.author
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true

ENT.PrintName = "[WAC]Bell AH-1G"

ENT.Model = "models/sentry/ah1g.mdl"
ENT.DamageModel = "models/sentry/ah1g_destroyed.mdl"
ENT.TopRotor = {
	dir = 1,
	pos = Vector(0, 0, 112.8),
	model = "models/sentry/ah1g_r.mdl",
	damage = "models/sentry/ah1g_r_d.mdl"
}
ENT.TailBoom = {
	pos = Vector(0,0,0),
	model = "models/sentry/ah1g_tail.mdl",
	angles = Angle(0, 0, 0),
	damage_rip = "models/sentry/ah1g_tail_destroyed.mdl",
	damage_explosion = "models/sentry/ah1g_tail_destroyed.mdl"
}
ENT.BackRotor = {
	pos = Vector(-307,0,107.0),
	model = "models/sentry/ah1g_tr.mdl",
	angles = Angle(0, 0, 0),
	damage = "models/sentry/ah1g_tr_d.mdl"
}

ENT.SmokePos = Vector(-80, 0, 80.8)
ENT.FirePos = Vector(-80, 0, 80.8)
ENT.Seats = {
	{
		pos = Vector(55,0,51),
		exit = Vector(85,-80,0),
		weapons = {"XM195", "FFAR"},
		NoHud = true,
	},
	{
		pos = Vector(105,0,40),
		exit = Vector(105,80,0),
		weapons = {"M28"},
		--NoHud = true,
	},	
}

ENT.Weapons = {
	["XM195"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(60,42,40),
			},
			Ammo = 950,
			Firerate = 800,
			BulletType = "gb_rocket_hvar",
			Sounds = {
				shoot = "Warkanum/minigun_shoot.wav",
				stop = "Warkanum/minigun_wind_stop.wav",
			},
			BulletType = "wac_base_20mm"
		}
	},
	["FFAR"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(60,56.5,40),
				Vector(60,-42,40),
				Vector(60,-56.5,40),
			},
			Sequential = true,
			Ammo = 21,
			Firerate = 150
		}
	},
	["M28"] = {
		class = "wac_pod_gunner",
		info = {
			ShootPos = Vector(119.5, -7.5, 20),
			ShootOffset = Vector(30, 0, 0),
			BulletType = "wac_base_20mm",
			FireRate = 700,
			Ammo = 800
		}
	}
}

ENT.Camera = {
	model = "models/props_junk/PopCan01a.mdl",
	pos = Vector(155,0,42),
	offset = Vector(-1,0,0),
	viewPos = Vector(10, 0, 3.5),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 2
}

ENT.WeaponAttachments = {

	gunMount1 = {
		model = "models/sentry/ah1g_turret.mdl",
		pos = Vector(119.5,0,20),
		restrictPitch = true
	},
	gun = {
		model = "models/sentry/ah1g_gun.mdl",
		pos = Vector(119.5, 0, 20),
		offset = Vector(0,0,0)
	},
	
}

ENT.Sounds = {
	Start = "WAC/ah1g/start.wav",
	Blades = "WAC/ah1g/external.wav",
	Engine = "WAC/ah1g/internal.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
	Radio =  "HelicopterVehicle/MissileNearby.mp3",
}
function ENT:DrawPilotHud() end
function ENT:DrawWeaponSelection() end
