	
if SERVER then AddCSLuaFile() end

timer.Simple(5,function()
	if CLIENT then
		WACBase=steamworks.ShouldMountAddon(104990330) and steamworks.IsSubscribed(104990330)
		if !WACBase then
			GredWACFrame=vgui.Create('DFrame')
			GredWACFrame:SetTitle("WAC is not installed / enabled")
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