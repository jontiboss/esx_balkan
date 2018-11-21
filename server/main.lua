ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_balkan:StartScene')
AddEventHandler('esx_balkan:StartScene', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	
	TriggerClientEvent('esx_balkan:balkan', _source)
	
	

end)

