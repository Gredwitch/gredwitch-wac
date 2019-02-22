
include("shared.lua")

ENT.thirdPerson = {
	distance = 600
}


ENT.altitude = 0
ENT.throttle = 0
ENT.pitch = 0
ENT.yaw = 0
ENT.roll = 0

local METER_IN_UNIT = 0.01905
local FEET_IN_METER = 3.28084

function ENT:Think()
	self:base("wac_hc_base").Think(self)
	local lvel = self:GetVelocity():Length()*METER_IN_UNIT
	self:SetPoseParameter("speed", lvel*1.94384)
	
	local trace = {
		start = self:GetPos(),
		endpos = self:GetPos()-Vector(0,0,10000/FEET_IN_METER/METER_IN_UNIT),
		mask = MASK_SOLID_BRUSHONLY+MASK_WATER
	}
	trace = util.TraceLine(trace)
	if trace.Hit then
		self.altitude = trace.Fraction*10000
	end
	self:SetPoseParameter("alt", self.altitude)
	self:SetPoseParameter("alt100", self.altitude)
	
	self:SetPoseParameter("attitude_pitch", -self:GetAngles().p)
	self:SetPoseParameter("attitude_roll", -self:GetAngles().r)
	self:SetPoseParameter("vert", (self:GetVelocity().z*0.75/100)*-1)
	local rpm_mod = self:GetVelocity():Length()/2
	local rpm = self.rotorRpm*70
	local frt = FrameTime()
	self.yaw = self.yaw - (self.yaw-self:GetNWFloat("yaw"))*frt*10
	self:SetPoseParameter("rpm_main", rpm*rpm+rpm_mod)
	self:SetPoseParameter("rpm_rear", rpm*rpm/1.5-math.abs(self.yaw*100))
	self:SetPoseParameter("heading", -self:GetAngles().y)
	self.throttle = self.throttle - (self.throttle-self:GetNWFloat("throttle"))*frt*10
	self.pitch = self.pitch - (self.pitch-self:GetNWFloat("pitch"))*frt*10
	self.roll = self.roll - (self.roll-self:GetNWFloat("roll"))*frt*10

	self:SetPoseParameter("collective", self.throttle*50+50)
	self:SetPoseParameter("pitch", -self.pitch)
	self:SetPoseParameter("yaw", -self.yaw)
	self:SetPoseParameter("roll", self.roll)
	self:SetPoseParameter("clock_hour", os.date("%H")+((os.date("%M")*0.0166)))
	self:SetPoseParameter("clock_minute", os.date("%M"))
end