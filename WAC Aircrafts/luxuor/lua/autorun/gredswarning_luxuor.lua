	
if SERVER then AddCSLuaFile() end

timer.Simple(5,function()
	if CLIENT then
		if GetConVar("gred_cl_enable_popups"):GetInt() != 1 then return end
		WACBase=steamworks.ShouldMountAddon(104990330) and steamworks.IsSubscribed(104990330)
		RequiredContent=steamworks.ShouldMountAddon(918407116) and steamworks.IsSubscribed(918407116)
		RequiredContent1=steamworks.ShouldMountAddon(218869210) and steamworks.IsSubscribed(218869210)
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
		if !RequiredContent then
			GredWACCFrame=vgui.Create('DFrame')
			GredWACCFrame:SetTitle("Required content is not installed / enabled. To disable this, open the spawnmenu, open the top right 'Options' tab, click on 'Misc' under the 'Gredwitch's Stuff' subtab and untick the 'Enable pop ups about missing content' checkbox.")
			GredWACCFrame:SetSize(ScrW()*0.95, ScrH()*0.95)
			GredWACCFrame:SetPos((ScrW() - GredWACCFrame:GetWide()) / 2, (ScrH() - GredWACCFrame:GetTall()) / 2)
			GredWACCFrame:MakePopup()
			
			local h=vgui.Create('DHTML')
			h:SetParent(GredWACCFrame)
			h:SetPos(GredWACCFrame:GetWide()*0.005, GredWACCFrame:GetTall()*0.03)
			local x,y = GredWACCFrame:GetSize()
			h:SetSize(x*0.99,y*0.96)
			h:SetAllowLua(true)
			h:OpenURL('https://steamcommunity.com/workshop/filedetails/?id=918407116.html')
		end
		if !RequiredContent1 then
			GredWACCFrame1=vgui.Create('DFrame')
			GredWACCFrame1:SetTitle("Required content is not installed / enabled. To disable this, open the spawnmenu, open the top right 'Options' tab, click on 'Misc' under the 'Gredwitch's Stuff' subtab and untick the 'Enable pop ups about missing content' checkbox.")
			GredWACCFrame1:SetSize(ScrW()*0.95, ScrH()*0.95)
			GredWACCFrame1:SetPos((ScrW() - GredWACCFrame1:GetWide()) / 2, (ScrH() - GredWACCFrame1:GetTall()) / 2)
			GredWACCFrame1:MakePopup()
			
			local h=vgui.Create('DHTML')
			h:SetParent(GredWACCFrame1)
			h:SetPos(GredWACCFrame1:GetWide()*0.005, GredWACCFrame1:GetTall()*0.03)
			local x,y = GredWACCFrame1:GetSize()
			h:SetSize(x*0.99,y*0.96)
			h:SetAllowLua(true)
			h:OpenURL('https://steamcommunity.com/workshop/filedetails/?id=218869210.html')
		end
	end
end)