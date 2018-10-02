if not wac then return end
if SERVER then AddCSLuaFile('shared.lua') end
ENT.Base 				= "wac_hc_base"
ENT.Type 				= "anim"
ENT.Category			= "Gredwitch's Stuff"
ENT.PrintName			= "[WAC]Halif-Life 2 Mil Mi 8"
ENT.Author				= "Gredwitch"
ENT.Spawnable			= true
ENT.AdminSpawnable		= true

ENT.Model            = "models/gredwitch/hl2mi8/hl2mi8.mdl"
ENT.RotorWidth		= 190
ENT.EngineForce        = 40
ENT.Weight            = 1451
ENT.SmokePos        = Vector(-225.7,6,82.4)
ENT.FirePos         = ENT.SmokePos
ENT.AutomaticFrameAdvance = true

ENT.TopRotor = {
	dir = -1,
	pos = Vector(-121.5,0,189.7),
	model = "models/gredwitch/hl2mi8/hl2mi8_tr.mdl"
}

ENT.BackRotor = {
	dir = -1,
	pos = Vector(-625.4,34.1,180.2),
	model = "models/gredwitch/hl2mi8/hl2mi8_br.mdl"
}

ENT.thirdPerson = {
	distance = 800
}

ENT.Wheels={
	{
		mdl="models/gredwitch/hl2mi8/hl2mi8_wf.mdl",
		pos=Vector(8.1,0,14.9),
		friction=5,
		mass=25,
	},
	{
		mdl="models/gredwitch/hl2mi8/hl2mi8_wl.mdl",
		pos=Vector(-164,90,20.6),
		friction=5,
		mass=50,
	},
	{
		mdl="models/gredwitch/hl2mi8/hl2mi8_wr.mdl",
		pos=Vector(-164,-90,20.6),
		friction=5,
		mass=50,
	},
}

ENT.Seats = {
	{
		pos=Vector(40.2,23,65.2),
		exit=Vector(45,70,70),
	},
	{
		pos=Vector(40.2,-23,65.2),
		exit=Vector(45,-70,70),
	}
}

ENT.Sounds={
	Start="WAC/Heli/h6_start.wav",
}