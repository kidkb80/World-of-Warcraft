if IsAddOnLoaded('Tukui') then return; end --Tukui already removes texture
ExtraActionButton1.style:SetTexture(nil)
ExtraActionButton1.style.SetTexture = function() end