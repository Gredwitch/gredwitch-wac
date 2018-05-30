if not wac then return end
ENT.Base = "wac_pl_base"
ENT.Type = "anim"
ENT.Category = "Gredwitch's Stuff"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.PrintName = "[WAC]Heinkel He 111"
ENT.Model				= "models/gredwitch/he111/he111.mdl"
ENT.RotorPhModel		= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel			= "models/gredwitch/he111/he111_prop.mdl"
ENT.OtherRotorModel		= ENT.RotorModel
ENT.AutomaticFrameAdvance = true
ENT.Weight			= 9000
ENT.EngineForce		= 3354
ENT.rotorPos 	= Vector(170, -104, -15)
ENT.OtherRotorPos = Vector(170, 104, -15)
ENT.FirePos			= ENT.rotorPos
ENT.SmokePos		= ENT.rotorPos
ENT.OtherRotorDir = -1
ENT.Engines = 2
ENT.maxEnterDistence = 400

ENT.thirdPerson = {
	distance = 700
}

ENT.Agility = {
	Thrust = 13
}

ENT.Wheels={
	{
		mdl="models/gredwitch/he111/he111_wr.mdl",
		pos=Vector(61,-104,-81),
		friction=10,
		mass=400,
	},
	{
		mdl="models/gredwitch/he111/he111_wl.mdl",
		pos=Vector(61,104,-81),
		friction=10,
		mass=400,
	},
	{
		mdl="models/gredwitch/he111/he111_wb.mdl",
		pos=Vector(-385,0,-30),
		friction=10,
		mass=800,
	},
}

ENT.Seats = {
	{
		pos=Vector(94,13,-15),
		exit=Vector(96,200,0),
		weapons={"Front MG15","100Kg Bombs"}
	},
	{
		pos=Vector(-30,0,12),
		ang=Angle(0,180,0),
		exit=Vector(96,200,0),
		weapons={"MG 87Z"}
	},
}

ENT.Weapons = {
	["100Kg Bombs"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(25,15,-30),
				Vector(25,-15,-30),
				Vector(65,15,-30),
				Vector(65,-15,-30),
				
				Vector(25,15,-20),
				Vector(25,-15,-20),
				Vector(65,15,-20),
				Vector(65,-15,-20),
				
				Vector(25,15,-10),
				Vector(25,-15,-10),
				Vector(65,15,-10),
				Vector(65,-15,-10),
				
				Vector(25,15,0),
				Vector(25,-15,0),
				Vector(65,15,0),
				Vector(65,-15,0),
				
				Vector(25,15,10),
				Vector(25,-15,10),
				Vector(65,15,10),
				Vector(65,-15,10),
				
				Vector(25,15,20),
				Vector(25,-15,20),
				Vector(65,15,20),
				Vector(65,-15,20),
				
			},
			Kind = "gb_bomb_sc100"
		}
	},
	["Front MG15"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(212.893,-5.16021,-3.64933)
			},
			Sounds = {
				shoot = "wac/he111/shoot.wav",
				stop = "wac/he111/stop.wav",
			},
			Sequential = true,
			Ammo = 1000,
			BulletType = "wac_base_7mm",
			FireRate = 1000,
		}
	},
	["MG 87Z"] = {
		class = "wac_pod_gunner",
		info = {
			Sounds = {
	            shoot1p = "",
	            shoot3p = "",
            	spin = "wac/he111/spin.wav"
            },
			ShootPos = Vector(-50,0,45),
			ShootOffset = Vector(30,0,0),
			Sequential = true,
			BulletType = "wac_base_7mm",
			Ammo = 1850,
			FireRate = 3000
		}
	}
}
ENT.WeaponAttachments={
	gun = {
		model = "models/gredwitch/he111/he111_mg81.mdl",
		pos = Vector(-47.7841,0,40.6234),
		localTo = "gunMount",
	},
	
}

ENT.Camera = {
	model = "models/mm1/box.mdl", 
	pos = Vector(-90,0,48),
	offset = Vector(-50,0,48), 
	viewPos = Vector(0,0,0),
	minAng = Angle(-60, -360,0),
	maxAng = Angle(25, 360,0),
	seat = 2
}

ENT.Sounds={
	Start="wac/he111/start.wav",
	Blades="wac/he111/external.wav",
	Engine="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm="",
}
//hud
function ENT:DrawWeaponSelection()
	local fwd = self:GetForward()
	local ri = self:GetRight()
	local ang = self:GetAngles()
	local Black = Color( 0, 0, 0, 200 )
	ang:RotateAroundAxis(ri, 90)
	ang:RotateAroundAxis(fwd, 90)
	for k, t in pairs(self.Seats) do
		if k != "BaseClass" and self:getWeapon(k) then
			cam.Start3D2D(self:LocalToWorld(Vector(17,5,27)*self.Scale + t.pos), ang, 0.02*self.Scale)
			surface.DrawRect(-10, 0, 500, 30)
			surface.DrawRect(-10, 30, 10, 20)
			local weapon = self:getWeapon(k)
			local lastshot = weapon:GetLastShot()
			local nextshot = weapon:GetNextShot()
			local ammo = weapon:GetAmmo()
			draw.SimpleText(k.." "..t.weapons[self:GetNWInt("seat_"..k.."_actwep")], "wac_heli_big", 0, -2.5, Black, 0)
			draw.SimpleText(ammo, "wac_heli_big", 480, -2.5, Black, 2)
			cam.End3D2D()
		end
	end
end