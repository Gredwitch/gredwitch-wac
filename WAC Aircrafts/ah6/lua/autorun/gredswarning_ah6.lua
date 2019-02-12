	
if SERVER then AddCSLuaFile() end

timer.Simple(5,function()
	if CLIENT then
		if GetConVar("gred_cl_enable_popups"):GetInt() != 1 then return end
		GredwitchBase=steamworks.ShouldMountAddon(1131455085) and steamworks.IsSubscribed(1131455085)
		WACBase=steamworks.ShouldMountAddon(104990330) and steamworks.IsSubscribed(104990330)
		if !GredwitchBase then
			GredFrame=vgui.Create('DFrame')
			GredFrame:SetTitle("Grediwtch's Base is not installed / enabled. To disable this, open the spawnmenu, open the top right 'Options' tab, click on 'Misc' under the 'Gredwitch's Stuff' subtab and untick the 'Enable pop ups about missing content' checkbox.")
			GredFrame:SetSize(ScrW()*0.95, ScrH()*0.95)
			GredFrame:SetPos((ScrW() - GredFrame:GetWide()) / 2, (ScrH() - GredFrame:GetTall()) / 2)
			GredFrame:MakePopup()
			
			local h=vgui.Create('DHTML')
			h:SetParent(GredFrame)
			h:SetPos(GredFrame:GetWide()*0.005, GredFrame:GetTall()*0.03)
			local x,y = GredFrame:GetSize()
			h:SetSize(x*0.99,y*0.96)
			h:SetAllowLua(true)
			h:OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=1131455085.html')
		
		end
		if !WACBase then
			GredWACFrame=vgui.Create('DFrame')
			GredWACFrame:SetTitle("WAC is not installed / enabled. To disable this, open the spawnmenu, open the top right 'Options' tab, click on 'Misc' under the 'Gredwitch's Stuff' subtab and untick the 'Enable pop ups about missing content' checkbox.")
			GredWACFrame:SetSize(ScrW()*0.95, ScrH()*0.95)
			GredWACFrame:SetPos((ScrW() - GredWACFrame:GetWide()) / 2, (ScrH() - GredWACFrame:GetTall()) / 2)
			GredWACFrame:MakePopup()
			
			local h=vgui.Create('DHTML')
			h:SetParent(GredWACFrame)
			h:SetPos(GredWACFrame:GetWide()*0.005, GredWACFrame:GetTall()*0.03)
			local x,y = GredWACFrame:GetSize()
			h:SetSize(x*0.99,y*0.96)
			h:SetAllowLua(true)
			h:OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=104990330.html')
		end
	end
end)