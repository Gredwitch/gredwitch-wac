if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]NH Industries NH90"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/gredwitch/nh90/nh90.mdl"
ENT.RotorWidth		= 190
ENT.EngineForce        = 50
ENT.Weight            = 1451
ENT.SmokePos        = Vector(-113.6,-38,125.9)
ENT.AutomaticFrameAdvance = true
ENT.FirePos         = ENT.SmokePos

ENT.TopRotor = {
	dir = -1,
	pos = Vector(0,0,0),
	model = "models/gredwitch/nh90/nh90_tr.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-388.94,24.05,151.75),
	model = "models/gredwitch/nh90/nh90_br.mdl"
}

ENT.thirdPerson = {
	distance = 800
}

ENT.Wheels={
	{
		mdl="models/gredwitch/nh90/nh90_wf.mdl",
		pos=Vector(174.9,0,-9.26),
		friction=5,
		mass=100,
	},
	{
		mdl="models/gredwitch/nh90/nh90_wl.mdl",
		pos=Vector(-33.92,60.32,-14.56),
		friction=5,
		mass=50,
	},
	{
		mdl="models/gredwitch/nh90/nh90_wr.mdl",
		pos=Vector(-33.92,-60.32,-14.56),
		friction=5,
		mass=50,
	},
}

ENT.Seats = {
	{
		pos=Vector(136,23.5,50.6),
		exit=Vector(45,70,70),
		wepaons={"Ramp opened"}
	},
	{
		pos=Vector(136,-23.5,50.6),
		exit=Vector(45,-70,70),
	},
	
	{
		pos=Vector(87.46,-31.8,42.9),
		ang=Angle(0,90,0),
		exit=Vector(87,-16.9,30.4),
	},
	{
		pos=Vector(87.46,31.8,42.9),
		ang=Angle(0,-90,0),
		exit=Vector(87,16.9,30.4),
	},
	
	{
		pos=Vector(70.3,-31.8,42.9),
		ang=Angle(0,90,0),
		exit=Vector(71.8,-16.9,30.4),
	},
	{
		pos=Vector(70.3,31.8,42.9),
		ang=Angle(0,-90,0),
		exit=Vector(71.8,16.9,30.4),
	},
	
	{
		pos=Vector(-37.4,-31.8,42.9),
		ang=Angle(0,90,0),
		exit=Vector(-37.4,-16.9,30.4),
	},
	{
		pos=Vector(-37.4,31.8,42.9),
		ang=Angle(0,-90,0),
		exit=Vector(-37.4,16.9,30.4),
	},
	
	{
		pos=Vector(-54.5,-31.8,42.9),
		ang=Angle(0,90,0),
		exit=Vector(-54.4,-16.9,30.4),
	},
	{
		pos=Vector(-54.4,31.8,42.9),
		ang=Angle(0,-90,0),
		exit=Vector(-54.4,16.9,30.4),
	},
	
	{
		pos=Vector(-71.6,-31.8,42.9),
		ang=Angle(0,90,0),
		exit=Vector(-71.6,-16.9,30.4),
	},
	{
		pos=Vector(-71.6,31.8,42.9),
		ang=Angle(0,-90,0),
		exit=Vector(-71.6,16.9,30.4),
	},
	
	{
		pos=Vector(-105.7,-28.3,42.9),
		ang=Angle(0,73,0),
		exit=Vector(-105.7,-10,30.4),
	},
	{
		pos=Vector(-105.7,28.3,42.9),
		ang=Angle(0,-73,0),
		exit=Vector(-105.7,10,30.4),
	},
	
	{
		pos=Vector(-122.2,-24,42.9),
		ang=Angle(0,73,0),
		exit=Vector(-122.2,-7,30.4),
	},
	{
		pos=Vector(-122.2,24,42.9),
		ang=Angle(0,-73,0),
		exit=Vector(-122.2,7,30.4),
	},
}
ENT.Weapons = {
	["Ramp opened"] = {
		class = "wac_pod_gatling",
		info = {
			Pods = {
				Vector(0,0,0),
			},
			Ammo = 0,
			FireRate = 0
		}
	}
}
ENT.Sounds = {
	Start="WAC/nh90/Start.wav",
	Blades="WAC/nh90/external.wav",
	Engine="WAC/nh90/internal.wav",
}