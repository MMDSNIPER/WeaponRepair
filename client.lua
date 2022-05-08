local ox_inventory = exports.ox_inventory

function openContext()
    lib.registerContext({
        id = 'weapon_menu',
        title = 'Repair Weapon',
        options = {
            ['Do you wish to repair your weapon?'] = {
                event = 'WRepair:repairWeapon'
            }
        }
    })
    lib.showContext('weapon_menu')
end

RegisterNetEvent('WRepair:repairWeapon', function()
    local rcount = ox_inventory:Search('count', 'repairkit_weapon')
    if rcount > 0 then
        lib.callback('WRepair:Cost', false, function(response)
            if response then
                lib.notify({
                    title = 'Success',
                    description = 'You have repaired your weapon!',
                    position = 'top',
                    duration = 3500,
                    style = {
                        backgroundColor = 'darkseagreen',
                        color = 'white'
                    },
                    icon = 'gun',
                    iconColor = 'white'
                })
            else
                lib.notify({
                    title = 'Error',
                    description = 'You have no weapons!',
                    position = 'top',
                    duration = 3500,
                    style = {
                        backgroundColor = 'lightcoral',
                        color = 'white'
                    },
                    icon = 'gun',
                    iconColor = 'white'
                })
            end
        end)
    else
        lib.notify({
            title = 'Error',
            description = 'You are missing a Weapon Kit!',
            position = 'top',
            duration = 3500,
            style = {
                backgroundColor = 'lightcoral',
                color = 'white'
            },
            icon = 'gun',
            iconColor = 'white'
        })
    end
end)

Config = {
    PedModel = `cs_josef`,
    Peds = {
        vector4(12.0596, -1106.9465, 29.7970, 342.0751),
    }
}

-- Create Peds
Citizen.CreateThread(function()
    for i=1, #Config.Peds, 1 do
        -- Blip
        local blip = AddBlipForCoord(Config.Peds[i].x, Config.Peds[i].y)
        SetBlipSprite(blip, 110)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 0)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Repair Station')
        EndTextCommandSetBlipName(blip)

        -- Ped
        RequestModel(Config.PedModel)
        while not HasModelLoaded(Config.PedModel) do 
            Citizen.Wait(1)
        end
        local ped = CreatePed(4, Config.PedModel, Config.Peds[i].x, Config.Peds[i].y, Config.Peds[i].z - 1, Config.Peds[i].w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        exports.qtarget:AddTargetEntity(ped, {
            options = {
                {
                    icon = "fa-solid fa-screwdriver-wrench",
                    label = "Reapir Bench",
                    action = function(entity)
                        openContext()
                    end
                },
            },
            distance = 2
        })
    end
end)