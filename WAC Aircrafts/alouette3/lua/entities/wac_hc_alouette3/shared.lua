ENT.Base 		   		= "wac_hc_base"
ENT.Type 		   		= "anim"
ENT.Author 		   		= "Gredwitch"
ENT.Category 	   		= "Gredwitch's Stuff"
ENT.Spawnable     		= true
ENT.AdminSpawnable		= true
ENT.SmokePos 	   		= Vector(-80,0,50)
ENT.FirePos		    	= Vector(-50,0,100)
ENT.MaxEnterDistance 	= 100
ENT.EngineForce			= 30
ENT.Weight 				= 9000
ENT.PrintName 			= "[WAC]Alouette III"
ENT.Model 				= "models/gredwitch/alouette3/alouette3.mdl"
ENT.WheelStabilize		=-150

ENT.thirdPerson = {
	distance = 550
}
ENT.TopRotor = {
	pos = Vector(0,0,0),
	model = "models/gredwitch/alouette3/alouette3_tr.mdl",
}
ENT.BackRotor = {
	pos = Vector(-321.53,-8.92,79.71),
	model = "models/gredwitch/alouette3/alouette3_br.mdl",
}
ENT.Wheels = {
	{
		mdl="models/gredwitch/alouette3/alouette3_wf.mdl",
		pos=Vector(84.16,0,-19.24),
		friction=100,
		mass=400,
	},
	{
		mdl="models/gredwitch/alouette3/alouette3_wl.mdl",
		pos=Vector(-57.20,62,-17.23),
		friction=100,
		mass=400,
	},
	{
		mdl="models/gredwitch/alouette3/alouette3_wr.mdl",
		pos=Vector(-57.20,-62,-17.23),
		friction=100,
		mass=400,
	},
}
ENT.Seats = {
	{
		pos = Vector(103.17,22.4,28.57),
		exit = Vector(80,80,5),
		weapons = {"MGs","Hydra 70"}
	},
	{
		pos = Vector(103.17,-22.4,28.57),
		exit = Vector(80,-80,5),
	},
	{
		pos = Vector(103.17,0,28.57),
		exit = Vector(80,-80,5),
	},
}

ENT.Weapons = {
	["Hydra 70"] = {
		class = "wac_pod_grocket",
		info = {
			Pods = {
				Vector(25.9,-88.79,10.30),
				Vector(25.9,88.79,10.30),
			},
			Ammo = 14,
			FireRate = 300,
		}
	},
	["MGs"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(26.47,103.91,32.4),
				Vector(26.47,-103.91,32.4),
				Vector(26.47,103.91,25.4),
				Vector(26.47,-103.91,25.4),
			},
			Ammo = 800,
			FireRate = 550,
			Sequential = false,
			BulletType = "wac_base_7mm",
			Sounds = {
				shoot = "huey/gun.wav",
				stop = "huey/gun_stop.wav"
			}
		}
	},
}


ENT.Sounds = {
	Start = "WAC/Heli/ah1_start.wav",
	Blades = "npc/attack_helicopter/aheli_rotor_loop1.wav",
	Engine = "WAC/heli/bellinternal.wav",
	MissileAlert = "HelicopterVehicle/MissileNearby.mp3",
	MissileShoot = "HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm = "HelicopterVehicle/MinorAlarm.mp3",
	LowHealth = "HelicopterVehicle/LowHealth.mp3",
	CrashAlarm = "HelicopterVehicle/CrashAlarm.mp3",
}


ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(156.083,0,-5.95776),
	offset = Vector(1,0,0),
	viewPos = Vector(7, 0, 3.5),
	maxAng = Angle(50, 90, 0),
	minAng = Angle(-5, -90, 0),
	seat = 2
}