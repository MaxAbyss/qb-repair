local fixing, turn = false, false
local zcoords, mcolor = 0.0, 0
local position = 0
local RepairLoc = false
local RepairId = false

local function RepairOption()
    RepairId = exports['qb-radialmenu']:AddOption({
        id = 'RepairVehicle',
        title = 'Repair Vehicle',
        icon = 'car',
        type = 'client',
        event = 'qb-repair:fixCarS',
        shouldClose = true
    }, RepairId)
end

local function RepairRemoveMenu()
    if RepairId then
        exports['qb-radialmenu']:RemoveOption(RepairId)
        RepairId = nil
    end
end

CreateThread(function()
    for k, v in pairs(Config.VehicleRepairLocation) do
        local Rep = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(Rep, 446)
        SetBlipAsShortRange(Rep, true)
        SetBlipScale(Rep, 0.8)
        SetBlipColour(Rep, 59)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.Name)
        EndTextCommandSetBlipName(Rep)
        local RepairZone = BoxZone:Create(vector3(v.coords.x, v.coords.y, v.coords.z), v.Length, v.Width, {
            name= v.Name,
            debugPoly= false,
            heading= v.Heading,
            minZ= v.MinZ,
            maxZ= v.MaxZ,
        })
        RepairZone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                RepairLoc = true
                RepairOption()
            else
                RepairLoc = false
                RepairRemoveMenu()
            end
        end)
    end
end)

RegisterNetEvent('qb-repair:fixCarS', function()
	TriggerEvent('qb-repair:fixCar')		
end)



RegisterNetEvent('qb-repair:fixCar', function()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, false)
	fixing = true	
	FreezeEntityPosition(vehicle, true)
	TriggerServerEvent('qb-repair:costRepair')
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, 'car_repair', 0.7)
    TriggerEvent('animations:client:EmoteCommandStart', {"jcarlowrider2"})
    QBCore.Functions.Progressbar("jcarlowrider2", "Preparing for hack", Config.RepairTime, false, true, {
        disableMovement = true,
        disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify('Cancelled preparing equipement', 'error')
    end)
	Wait(Config.RepairTime)
	fixing = false
	SetVehicleDeformationFixed(vehicle)
	FreezeEntityPosition(vehicle, false)
	SetVehicleEngineHealth(vehicle, 9999)
	SetVehiclePetrolTankHealth(vehicle, 9999)
	SetVehicleFixed(vehicle)
	zcoords, mcolor, turn = 0.0, 0, false
end)
