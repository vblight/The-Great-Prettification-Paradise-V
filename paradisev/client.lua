AddTextEntry('PARADISEV', 'Paradise V')
local names = {
    'Original 1', 'Original 2', 'Original 3', 'Original 4',
    'Los Santos Storm Chasers', 'Hippie (Weathered)', 'San Andreas Ghost Hunters (Weathered)', 'Plain / Paint-through',
    'Hippie (Clean)', 'San Andreas Ghost Hunters (Clean)', 'Belly-Up Seafood', 'Classic Flames',
    'Blaine County Pirate Radio (Clean)', 'Blaine County Pirate Radio (Weathered)',
    'Los Santos Cryptid Society (Clean)', 'Los Santos Cryptid Society (Weathered)',
    'Space Docker Appreciation Society (Clean)', 'Space Docker Appreciation Society (Weathered)'
}
local function message(text)
    print('[Paradise] '..text)
    TriggerEvent('chat:addMessage', {color={120,190,220}, args={'Paradise V',text}})
end
local function currentVan()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle == 0 or GetEntityModel(vehicle) ~= joaat('paradisev') then
        message('Sit in a Paradise V (paradisev) first.')
        return nil
    end
    if GetPedInVehicleSeat(vehicle, -1) ~= ped then
        message('Use the driver seat to change the livery.')
        return nil
    end
    return vehicle
end
RegisterCommand('paradiselivery', function(_,args)
    local vehicle = currentVan()
    if not vehicle then return end
    local choice = tonumber(args[1])
    if not choice or choice ~= math.floor(choice) or choice < 1 or choice > #names then
        return message('Use /paradiselivery 1 through 18. Originals: 1–4; Storm: 5; Weathered Hippie/Ghost: 6/7; Plain: 8; Clean Hippie/Ghost: 9/10; Belly-Up: 11; Flames: 12; Pirate Radio: 13/14; Cryptid Society: 15/16; Space Docker: 17/18.')
    end
    local count = GetVehicleLiveryCount(vehicle)
    if count < choice then
        return message(('Game reports %d liveries. Reconnect after starting the resource and check for another Paradise replacement.'):format(count))
    end
    SetVehicleLivery(vehicle, choice - 1)
    message(('Selected %d: %s'):format(choice, names[choice]))
end, false)

RegisterCommand('paradisecheck', function()
    local vehicle = currentVan()
    if not vehicle then return end
    local primary,secondary = GetVehicleColours(vehicle)
    message(('Liveries: %d (expected 18); current native index: %d; primary: %d; secondary: %d.'):format(GetVehicleLiveryCount(vehicle),GetVehicleLivery(vehicle),primary,secondary))
end, false)
