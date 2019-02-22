if not wac then return end

if GetConVarNumber("gred_jets_speed") >= 1 then jetspeed = 36 else jetspeed = 33 end
ENT.Base 				= "wac_pl_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]A-4 Skyhawk (Admin)"
ENT.Author				= "Gredwitch"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model	    = "models/gredwitch/a-4/a-4.mdl"
ENT.RotorPhModel        = "models/props_junk/sawblade001a.mdl"
ENT.RotorModel        = "models/mm1/box.mdl"

ENT.SmokePos	= Vector(-190,0,80)
ENT.FirePos	    = ENT.SmokePos
ENT.rotorPos	= ENT.SmokePos
ENT.TopRotorDir	= 1.0
ENT.AutomaticFrameAdvance = true
ENT.EngineForce	= 723
ENT.Weight	    = 2000
ENT.SeatSwitcherPos	= Vector(0,0,0)
ENT.AngBrakeMul	= 0.02
ENT.MaxEnterDistance = 100

if CLIENT then
	ENT.thirdPerson = {
		distance = 550
	}
end


ENT.Agility = {
	Thrust = jetspeed
}

ENT.Wheels={
	{
		mdl="models/gredwitch/a-4/a-4_wf.mdl",
		pos=Vector(116.304,0.217875,0.08842),
		friction=10,
		mass=200,
	},
	{
		mdl="models/gredwitch/a-4/a-4_wr.mdl",
		pos=Vector(-16.6737,-45.3648,15),
		friction=10,
		mass=200,
	},
	{
		mdl="models/gredwitch/a-4/a-4_wl.mdl",
		pos=Vector(-16.6737,45.3643,15),
		friction=10,
		mass=1400,
	},
}

ENT.Seats = {
	{
		pos=Vector(123,0,73),
		exit=Vector(123,100,0),
		weapons={"Colt Mk 12","Mk 82","AIM-9","AGM-88 HARM"}
	}
}

ENT.Weapons = {
	["Colt Mk 12"] = {
		class = "wac_pod_mg",
		info = {
			Pods = {
				Vector(109,-19,70),
				Vector(109,19,70),
			},
			Sounds = {
				shoot = "WAC/f4/gun.wav",
				stop = "WAC/f4/gun_stop.wav",
			},
			Ammo = 1,
			TkAmmo = 0,
			BulletType = "wac_base_20mm",
			FireRate = 1000
		}
	},
	["Mk 82"] = {
		class = "wac_pod_gbomb",
		info = {
			FireRate = 150,
			Pods = {
				Vector(8,0,46.3),
			},
			Admin = 1,
			Kind = "gb_bomb_mk82",
		}
	},
	["AGM-88 HARM"] = {
		class = "wac_pod_mis",
		info = {
			Ammo = 1,
			TkAmmo = 0,
			FaF = true,
			Pods = {
				Vector(7.5,-73.5,46),
				Vector(7.5,73.5,46),
			}
		}
	},
	["AIM-9"] = {
		class = "wac_pod_mis",
		info = {
			Ammo = 1,
			TkAmmo = 0,
			Pods = {
				Vector(4.3,-112,42.7),
				Vector(4.3,112,42.7),
			}
		}
	},
}


ENT.Camera = {
	model = "models/mm1/box.mdl",
	pos = Vector(241.7,0,25),
	offset = Vector(-1,0,0),
	viewPos = Vector(5,0,0),
	maxAng = Angle(45, 90, 0),
	minAng = Angle(-2, -90, 0),
	seat = 1
}

ENT.Sounds={
	Start="WAC/f16/Start.wav",
	Blades="WAC/f16/external.wav",
	Engine="WAC/f16/internal.wav",
	MissileAlert="HelicopterVehicle/MissileNearby.mp3",
	MissileShoot="HelicopterVehicle/MissileShoot.mp3",
	MinorAlarm="HelicopterVehicle/MinorAlarm.mp3",
	LowHealth="HelicopterVehicle/LowHealth.mp3",
	CrashAlarm="HelicopterVehicle/CrashAlarm.mp3"
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
			cam.Start3D2D(self:LocalToWorld(Vector(17,5,25)*self.Scale + t.pos), ang, 0.02*self.Scale)
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

	cam.Start3D2D(self:LocalToWorld(Vector(11,3.75,37.75)+spos), ang,0.015)
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

	surface.SetTextPos(125, 410) 
	surface.DrawText("SPD  "..math.floor(self:GetVelocity():Length()*0.1) .."kn")
	surface.SetTextPos(300, 410)
	local tr=util.QuickTrace(pos+self:GetUp()*10,Vector(0,0,-999999),self.Entity)
	surface.DrawText("ALT  "..math.ceil((pos.z-tr.HitPos.z)*0.01905).."m")

	cam.End3D2D()
end
// heatwave
if CLIENT then
	local cureffect=0
	function ENT:Think()
		self:base("wac_pl_base").Think(self)
		local throttle = self:GetNWFloat("up", 0)
		local active = self:GetNWBool("active", false)
		local ent=LocalPlayer():GetVehicle():GetNWEntity("wac_aircraft")
		if ent==self and active and throttle > 0.2 and CurTime()>cureffect then
			cureffect=CurTime()+0.02
			local ed=EffectData()
			ed:SetEntity(self)
			ed:SetOrigin(self.SmokePos) // offset
			ed:SetMagnitude(throttle)
			ed:SetRadius(25)
			util.Effect("wac_heatwave", ed)
		end
	end
end