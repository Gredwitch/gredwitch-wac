if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]Junkers Ju 88"
ENT.Model				= "models/gredwitch/ju88/ju88.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/ju88/ju88_prop.mdl"
ENT.OtherRotorModel		= "models/gredwitch/ju88/ju88_prop.mdl"
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 9000
ENT.EngineForce		= 3354
ENT.rotorPos 	= Vector(210, -106, -10)
ENT.OtherRotorPos = Vector(210, 106, -10)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.OtherRotorDir = -1
ENT.Engines = 2
ENT.maxEnterDistence = 400

ENT.thirdPerson = {
	distance = 600
}

ENT.Agility = {
	Thrust = 15
}

ENT.Wheels={
	{
		mdl="models/gredwitch/ju88/ju88_wr.mdl",
		pos=Vector(80,-104,-90),
		friction=10,
		mass=1000,
	},
	{
		mdl="models/gredwitch/ju88/ju88_wl.mdl",
		pos=Vector(80,104,-90),
		friction=10,
		mass=1000,
	},
	{
		mdl="models/gredwitch/ju88/ju88_wb.mdl",
		pos=Vector(-275,0,-46),
		friction=10,
		mass=1000,
	},
}

ENT.Seats = {
	{
		pos=Vector(156,0,0),
		exit=Vector(400,0,0),
		weapons={"Front MG 15","100Kg Bombs"}
	},
	{
		pos=Vector(143,0,0),
		ang=Angle(0,180,0),
		exit=Vector(400,0,0),
		weapons={"Back MG 15"}
	},
}

ENT.Weapons = {
	["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(70,0,-28),
				Vector(70,12,-28),
				Vector(70,-12,-28),
				
				Vector(110,0,-28),
				Vector(110,12,-28),
				Vector(110,-12,-28),
				
				Vector(150,0,-28),
				Vector(150,12,-28),
				Vector(150,-12,-28),
				
				Vector(70,0,-20),
				Vector(70,12,-20),
				Vector(70,-12,-20),
				
				Vector(110,0,-20),
				Vector(110,12,-20),
				Vector(110,-12,-20),
				
				Vector(150,0,-20),
				Vector(150,12,-20),
				Vector(150,-12,-20),
				
				Vector(70,0,-12),
				Vector(70,12,-12),
				Vector(70,-12,-12),
				
				Vector(110,0,-12),
				Vector(110,12,-12),
				Vector(110,-12,-12),
				
				Vector(150,0,-12),
				Vector(150,12,-12),
				Vector(150,-12,-12),
				
				Vector(110,0,-4),
				
			},
			Kind = "gb_bomb_sc100",
		}
	},
	["Front MG 15"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(300,-12,-20)
			},
			Sounds = {
				shoot = "wac/ju88/shoot.wav",
				stop = "wac/ju88/stop.wav",
			},
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 375,
			FireRate = 1000,
		}
	},
	["Back MG 15"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
	            shoot1p = "",
	            shoot3p = "",
            	spin = "wac/he111/shoot.wav"
            },
			ShootPos = Vector(100,0,35),
			ShootOffset = Vector(40,0,0),
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 600,
			FireRate = 1000
		}
	}
}

ENT.WeaponAttachments={
	gun = {
		model = "models/gredwitch/ju88/mg15_gun.mdl",
		pos = Vector(100,0,30),
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl", 
	pos = Vector(100,0,40),
	offset = Vector(30,0,0), 
	viewPos = Vector(0,0,0),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 2
}

ENT.Sounds={
	Start="wac/ju88/start.wav",
	Blades="wac/ju88/external.wav",
	Engine="",
	Radio="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}