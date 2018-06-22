if not wac then return end
if SERVER then AddCSLuaFile() end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Fw 190F-8 Würger(admin)"
ENT.Author				= "Chippy"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true
ENT.engineHealth = 150
ENT.AutomaticFrameAdvance = true // needed for gear anims

ENT.Model            = "models/chippy/fw190/body.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/chippy/fw190/prop.mdl"
ENT.rotorPos        = Vector(121.5,5,25)
ENT.TopRotorDir        = 1

ENT.EngineForce        = 345
ENT.Weight            = 9130
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul		= 0.0257
ENT.SmokePos        = Vector(110,5,40.1)
ENT.FirePos			= Vector(110,5,40.1)

if CLIENT then
	ENT.thirdPerson = {
		distance = 400
	}
end

ENT.Wheels={
	{
		mdl="models/chippy/fw190/bwheel.mdl",
		pos=Vector(-151,5,9),
		friction=3,
		mass=900,
	},
	{
		mdl="models/chippy/fw190/fwheel.mdl",
		pos=Vector(71,65,-31),
		friction=0,
		mass=600,
	},
	{
		mdl="models/chippy/fw190/fwheel.mdl",
		pos=Vector(71,-56,-31),
		friction=0,
		mass=600,
	},
}

ENT.Seats = {
	{
		pos=Vector(0,3.4,20.3),
		exit=Vector(3.5,60,100),
		weapons={"MG131", "MG151/20", "250Kg bomb"},
	},
}

ENT.Agility = {
	Thrust = 15
}

ENT.Weapons = {
	["MG131"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(75,-2,51),
				Vector(75,8,51),
			},
			FireRate = 900,
			Ammo = 1,
			TkAmmo = 0,
			Sequential = true,
			Sounds = {
				shoot = "wac/fw190/shoot_start.wav",
				stop = "wac/fw190/shoot_end.wav",
			}	
		}
	},
	["MG151/20"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(75,37,17),
				Vector(75,-29,17)
			},
			FireRate = 750,
			Ammo = 1,
			TkAmmo = 0,
			BulletType = "wac_base_20mm",
			Sequential = true,
			Sounds = {
				shoot = "wac/fw190/shoot_start.wav",
				stop = "wac/fw190/shoot_end.wav",
			},
		}
	},
	["250Kg bomb"] = {
		class = "wac_pod_gbomb",
		info = {
			Pods = {
				Vector(40,5,-11),
			},
			Kind = "gb_bomb_sc250",
			Admin = 1
		}
	}
}

ENT.Sounds = {
	Start="wac/fw190/Start.wav",
	Blades="wac/fw190/external.wav",
	Engine="wac/fw190/internal.wav",
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

	cam.Start3D2D(self:LocalToWorld(Vector(17,3.75,37.75)+spos), ang,0.015)
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

	if self:GetNWInt("seat_1_actwep") == 1 and self.weapons["MG131"] then
		surface.SetTextPos(270,600)
		local n = self.weapons["MG131"]:GetAmmo()
		surface.DrawText("MG131 " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 2 and self.weapons["MG151/20"] then
		surface.SetTextPos(270,600)
		local n = self.weapons["MG151/20"]:GetAmmo()
		surface.DrawText("MG151/20 " .. getspaces(n))
	end
	
	if self:GetNWInt("seat_1_actwep") == 3 and self.weapons["250Kg bomb"] then
		surface.SetTextPos(270,600)
		local n = self.weapons["250Kg bomb"]:GetAmmo()
		surface.DrawText("250Kg bomb " .. getspaces(n))
	end
	cam.End3D2D()
end
function ENT.DrawWeaponSelection() end