if not wac then return end
if SERVER then AddCSLuaFile() end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Messerschmitt BF-109E (Bomber)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.Model	    = "models/gredwitch/me109/me109.mdl"
ENT.RotorPhModel	= "models/props_junk/sawblade001a.mdl"
ENT.RotorModel	= "models/gredwitch/me109/me109_prop.mdl"
ENT.rotorPos	= Vector(162,0,74)
ENT.TopRotorDir	= 1

ENT.EngineForce	= 6500
ENT.Weight	    = 3347
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul		= 0.02
ENT.SmokePos	= ENT.rotorPos
ENT.FirePos	    = ENT.rotorPos

if CLIENT then
	ENT.thirdPerson = {
		distance = 500
	}
end

ENT.Agility = {
	Thrust = 23
}

ENT.Wheels={
	{
		mdl="models/gredwitch/me109/me109_wr.mdl",
		pos=Vector(78.4,-42.8,15.3),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/me109/me109_wl.mdl",
		pos=Vector(78.4,42.8,15.3),
		friction=0,
		mass=550,
	},
	{
		mdl="models/gredwitch/me109/me109_wb.mdl",
		pos=Vector(-146.6,0,68.4),
		friction=0,
		mass=550,
	},
}

ENT.Seats = {
	{
		pos=Vector(30,0,68),
		exit=Vector(33,60,68),
		weapons={"MG17", "MG FF","250Kg bomb"}
    }
}					

ENT.Weapons = {
	["MG17"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(107,6.9,92.4),
				Vector(107,-6.9,92.4),
			},
			Sounds = {
				shoot = "WAC/bf109/gun.wav",
				stop = "WAC/bf109/gun_stop.wav",
			},
			FireRate = 1000,
			Ammo = 2000,
			Sequential = false,
		}
	},
	["MG FF"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(80.3,86.12,63.5),
				Vector(80.3,-86.12,63.5),
			},
			Sounds = {
				shoot = "WAC/bf109/gun.wav",
				stop = "WAC/bf109/gun_stop.wav",
			},
			BulletType = "wac_base_20mm",
			FireRate = 530,
			Ammo = 120,
			Sequential = false,
		}
	},
	["250Kg bomb"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(36.6,0,45),
			},
			Kind = "gb_bomb_sc100"
		}
	}
}
ENT.Sounds={
	Start="WAC/Bf109/Start.wav",
	Blades="WAC/BF109/external.wav",
	Engine="WAC/BF109/internal.wav",
	Radio="radio/german.wav",
	MissileAlert="",
	MissileShoot="",
	MinorAlarm="",
	LowHealth="",
	CrashAlarm=""
}

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

	cam.Start3D2D(self:LocalToWorld(Vector(21,3.75,37.75)+spos), ang,0.015)
	surface.SetDrawColor(HudCol)
	surface.DrawRect(234, 247, 10, 4)
	surface.DrawRect(254, 247, 10, 4)
	surface.DrawRect(247, 234, 4, 10)
	surface.DrawRect(247, 254, 4, 10)

	local a=self:GetAngles()
	a.y=0
	local up=a:Up()
	up.x=0
	up=up:GetNormal()

	local size=180
	local dist=10
	local step=12
	for p=-180,180,step do
		if a.p+p>-size/dist and a.p+p<size/dist then
			if p==0 then
				surface.SetMaterial(mat[1])
			elseif p>0 then
				surface.SetMaterial(mat[2])
			else
				surface.SetMaterial(mat[3])
			end
			surface.DrawTexturedRectRotated(250+up.y*(a.p+p)*dist,250-up.z*(a.p+p)*dist,300,300,a.r)
		end
	end

	surface.SetTextColor(HudCol)
	surface.SetFont("wac_heli_small")

	surface.SetTextPos(30, 510) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(30, 545)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["MG17"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["MG17"]:GetAmmo()
		surface.DrawText("MG17      " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["MG FF"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["MG FF"]:GetAmmo()
		surface.DrawText("MG FF     " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["250Kg bomb"] then
		surface.SetTextPos(330,510)
		local n = self.weapons["250Kg bomb"]:GetAmmo()
		surface.DrawText("250Kg bomb" .. getspaces(n))
	end

	cam.End3D2D()
end
function ENT.DrawWeaponSelection() end