if SERVER then
	AddCSLuaFile()
	util.AddNetworkString("WAC-ModelDetailWarning")
end

local found=false
local f=file.Find('wac/*.lua', "LUA")
for k,v in pairs(f) do
	if v=="aircraft.lua" then
		include('wac/aircraft.lua')
		found=true
	end
end
local foundG=false
local fG=file.Find('autorun/client/gredwitch_addon_verify.lua', "LUA")
for k,v in pairs(f) do
	foundG=true
end

timer.Simple(5,function()
	if not found and not WACFrame then
		if CLIENT then
			WACFrame=vgui.Create('DFrame')
			WACFrame:SetTitle("WAC is not installed")
			WACFrame:SetSize(ScrW()*0.95, ScrH()*0.95)
			WACFrame:SetPos((ScrW() - WACFrame:GetWide()) / 2, (ScrH() - WACFrame:GetTall()) / 2)
			WACFrame:MakePopup()
			
			local h=vgui.Create('DHTML')
			h:SetParent(WACFrame)
			h:SetPos(WACFrame:GetWide()*0.005, WACFrame:GetTall()*0.03)
			local x,y = WACFrame:GetSize()
			h:SetSize(x*0.99,y*0.96)
			h:SetAllowLua(true)
			h:OpenURL('http://mattjeanes.com/abyss/wac-warning.html')
		elseif SERVER then
			timer.Create("WAC-NotInstalled", 10, 0, function() print("WAC Aircraft is not installed!") end)
		end
	end
	if not foundG then
		if CLIENT then
			WACFrame=vgui.Create('DFrame')
			WACFrame:SetTitle("Grediwtch's Base addon is not installed")
			WACFrame:SetSize(ScrW()*0.95, ScrH()*0.95)
			WACFrame:SetPos((ScrW() - WACFrame:GetWide()) / 2, (ScrH() - WACFrame:GetTall()) / 2)
			WACFrame:MakePopup()
			
			local h=vgui.Create('DHTML')
			h:SetParent(WACFrame)
			h:SetPos(WACFrame:GetWide()*0.005, WACFrame:GetTall()*0.03)
			local x,y = WACFrame:GetSize()
			h:SetSize(x*0.99,y*0.96)
			h:SetAllowLua(true)
			h:OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=1131455085.html')
		elseif SERVER then
			timer.Create("GredWAC-NotInstalled", 10, 0, function() print("Grediwtch's Base addon is not installed") end)
		end
	else
		print("VERIFTRUE")
	end
end)

if not found then return end

if CLIENT then
	net.Receive("WAC-ModelDetailWarning", function()
		if GetConVarNumber("r_rootlod")>0 then
			chat.AddText(Color(255,62,62), "WARNING: ", Color(255,255,255), "The "..net.ReadString().." requires 'high' model detail.")
			chat.PlaySound()
		end
	end)
end

if wac and wac.aircraft then wac.aircraft.spawnCategoryC = "WAC Community" end