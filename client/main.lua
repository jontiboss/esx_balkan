local isInCutScene = false
local blips = {
     {title="Bilkatalog", colour=46, id=400, x = -1149.76, y = -1703.11, z = 9.45}
}
  
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.35)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


--mainThread
Citizen.CreateThread(function()
    while true do
    
    Citizen.Wait(0)
        --render zoones
		local coords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(coords, -32.7, -1102.04, 25.6, true) < 50 then
            DrawMarker(27, -32.7, -1102.04, 25.6, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 100, 255, 0, 100, false, true, 2, false, false, false, false)
            if GetDistanceBetweenCoords(coords, -32.7, -1102.04, 25.6, true) < 1.5 then
            Draw3DText(-32.7, -1102.04, 27.0, tostring("Tryck på ~r~[E]~w~ för att kolla i bilkatalogen"))
            if IsControlPressed(0,  38) then
			TriggerServerEvent('esx_balkan:StartScene')
			Citizen.Wait(3000)
            end
        end
    end
    end
end) 

RegisterNetEvent('esx_balkan:balkan')
AddEventHandler('esx_balkan:balkan', function()
			RequestModel(-236444766)
			while not HasModelLoaded(-236444766) do
				Wait(0)
            end
            
            
            TriggerEvent("jonti-cinema:activate")
            --Create scene
			SetEntityHeading(GetPlayerPed(-1), 241.61)
            local SpawnObject = CreatePed(4, -236444766, -31.41, -1107.1, 25.2)
            SetEntityHeading(SpawnObject, 338.61)
            SetPlayerControl(PlayerId(),false,256)
            isInCutScene = true
            SetEntityCoords(GetPlayerPed(-1), -33.03, -1101.81, 25.6)
			FreezeEntityPosition(SpawnObject, true)
            TaskGoToCoordAnyMeans(GetPlayerPed(-1), -29.61, -1104.02, 25.6, 1.0, 0, 0, 786603, 1.0)
            SetEntityHeading(GetPlayerPed(-1), 159.7)
           ------------------------------------------------------------------------------------------



           
            local RandScene = math.random(4)

            if RandScene == 1 then
                BillingScene(SpawnObject)
            end

            if RandScene == 2 then
                MateScene(SpawnObject)
            end
            if RandScene == 3 then
                WelcomeScene(SpawnObject)
            
            end
                
            if RandScene == 4 then
                SleekScene(SpawnObject)
            end
       
            Citizen.Wait(51000)
            
			--Tp player to elevator
            isInCutScene = false
            SetPlayerControl(PlayerId(),true,256)
            DeleteEntity(SpawnObject)
            SetEntityCoords(GetPlayerPed(-1), 241.2, -1004.91, -99.0)
            TriggerEvent("jonti-cinema:activate")
            SetFollowPedCamViewMode(1)
end)
--Force cam view
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
        if isInCutScene then             
			SetFollowPedCamViewMode(4)
		end
	end
end)



function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0*scale, 0.35*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150) 
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end


    function BillingScene(SpawnObject)
    RequestAnimDict("amb@world_human_hang_out_street@female_arms_crossed@base")
    TaskPlayAnim(SpawnObject, "amb@world_human_hang_out_street@female_arms_crossed@base", "base", 1.0, -1.0, 500000, 1, 1, false, false, false)
    TriggerEvent('InteractSound_CL:PlayOnOne', "Hassan_1",1.0)  
       
   
    end

   function SleekScene(SpawnObject)
  
    RequestAnimDict("WORLD_HUMAN_BINOCULARS")
    TaskStartScenarioInPlace(SpawnObject, "WORLD_HUMAN_BINOCULARS", 0, false)
    TriggerEvent('InteractSound_CL:PlayOnOne', "Hassan_slisk",1.0)     
    end

   function WelcomeScene(SpawnObject)
    RequestAnimDict("misschinese2_crystalmazemcs1_ig")
    TaskPlayAnim(SpawnObject, "misschinese2_crystalmazemcs1_ig", "dance_loop_tao", 1.0, -1.0, 500000, 1, 1, false, false, false)
    TriggerEvent('InteractSound_CL:PlayOnOne', "Hassan_party",1.0)  
      
    end

   function MateScene(SpawnObject)
    RequestAnimDict("anim@mp_freemode_return@f@idle")
    TaskPlayAnim(SpawnObject, "anim@mp_freemode_return@f@idle", "idle_a", 1.0, -1.0, 500000, 1, 1, false, false, false)
    TriggerEvent('InteractSound_CL:PlayOnOne', "Hassan_saljare",1.0)   
    end
   