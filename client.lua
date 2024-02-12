ESX = exports["es_extended"]:getSharedObject()

Hajden = {}
Hajden.debug = false
function DebugPrint(...)
    if Hajden.debug then print("[DEBUG]", ...) end
end

local ox_target = exports.ox_target
local drawZones = Hajden.debug

function flymesto()
    local ped = GetPlayerPed(-1)
    if ped ~= nil then
        DoScreenFadeOut(5000)
        if lib.progressBar({
            duration = 30000,
            label = 'You are flying back to Los Santos',
            useWhileDead = false,
            canCancel = false,
        }) then
            DoScreenFadeIn(5000)
            SetEntityCoords(ped, -1038.7996, -2730.5225, 21.2126)
            SetEntityHeading(ped, 196.6723)
            -- exports["okokNotify"]:Alert("WELCOME BACK TO THE CITY OF LOS SANTOS", "", 5000, "success")
            -- Your Notify
        end
    end
end

function flyperico()
    local ped = GetPlayerPed(-1)
    if ped ~= nil then
        DoScreenFadeOut(5000)
        if lib.progressBar({
            duration = 30000,
            label = 'You are flying to Cayo Perico',
            useWhileDead = false,
            canCancel = false,
        }) then
            DoScreenFadeIn(5000)
            SetEntityCoords(ped, 4444.2573, -4485.3647, 4.2336)
            SetEntityHeading(ped, 194.7927)
            -- exports["okokNotify"]:Alert("WELCOME ON CAYO PERICO", "", 5000, "success")
            -- Your Notify
        end
    end
end

Citizen.CreateThread(function()
    local modelHash = GetHashKey("s_m_m_pilot_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(100)
        DebugPrint("NOT LOADED")
    end

    local ped_pos = vector3(-1039.7996, -2731.5225, 19.2126)
   -- local ground,posZ = GetGroundZFor_3dCoord(ped_pos.x + .0, ped_pos.y + .0, ped_pos.z + 999.0, 1)
    local cayopedik = CreatePed(4, modelHash, ped_pos.x, ped_pos.y, ped_pos.z, 196.6723, false, true)
    FreezeEntityPosition(cayopedik, true)
    SetEntityVelocity(cayopedik, 0.0, 0.0, 0.0)
    TaskStandStill(cayopedik, -1)
    SetEntityAsMissionEntity(cayopedik, true, true)
    SetPedCanBeTargetted(cayopedik, true)
    SetPedCanPlayAmbientAnims(cayopedik, true)
    SetPedCanRagdoll(cayopedik, true)
    SetEntityAsMissionEntity(cayopedik, true, true)
    SetEntityInvincible(cayopedik, true)
    SetPedRelationshipGroupHash(cayopedik, GetHashKey("PLAYER"))

    ox_target:addBoxZone({
        coords = vec3(ped_pos.x, ped_pos.y, ped_pos.z),
        size = vec3(2, 2, 3),
        rotation = 45,
        drawSprite = true,
        options = {
            {
                name = 'cayopedik',
                onSelect = function()
                    lib.registerContext({
                        id = 'cayo_menu',
                        title = "Cayo Perico",
                        menu = 'cayo_menu',
                        options = {
                            {
                                title = 'Fly to Cayo Perico',
                                description = 'Price: 1000$',
                                icon = 'plane',
                                onSelect = function()
                                    lib.hideContext('cayo_menu')
                                    -- exports["okokNotify"]:Alert("Fly to Cayo Perico", "You are going on the plane!", 5000, 'success')
                                    -- Your Notify
                                    lib.callback('hajden_flytocayo:pay', false, function()
                                        print("Enjoy the flight")
                                    end)
                                end,
                            },
                            {
                                title = 'Close Menu',
                                icon = 'xmark',
                                onSelect = function()
                                    lib.hideContext('cayo_menu')
                                end,
                            },
                        }
                    })
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        -- exports["okokNotify"]:Alert("Fly to Cayo Perico", "You can't fly in a vehicle 😂", 5000, 'error')
                        -- Your Notify
                    else
                        lib.showContext('cayo_menu')
                    end
                end,
                icon = "fa-solid fa-comment",
                label = "Talk to",
            }
        }
    })
end)

Citizen.CreateThread(function()
    local modelHash = GetHashKey("s_m_m_pilot_01")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(100)
        DebugPrint("NOT LOADED")
    end

    local ped_pos = vector3(4444.2573, -4485.3647, 4.2336)
    --local ground,posZ = GetGroundZFor_3dCoord(ped_pos.x + .0, ped_pos.y + .0, ped_pos.z + 999.0, 1)
    local mestopedik = CreatePed(4, modelHash, ped_pos.x, ped_pos.y, -3, 194.6723, false, true)
    FreezeEntityPosition(mestopedik, true)
    SetEntityVelocity(mestopedik, 0.0, 0.0, 0.0)
    TaskStandStill(mestopedik, -1)
    SetEntityAsMissionEntity(mestopedik, true, true)
    SetPedCanBeTargetted(mestopedik, true)
    SetPedCanPlayAmbientAnims(mestopedik, true)
    SetPedCanRagdoll(mestopedik, true)
    SetEntityAsMissionEntity(mestopedik, true, true)
    SetEntityInvincible(mestopedik, true)
    SetPedRelationshipGroupHash(mestopedik, GetHashKey("PLAYER"))

    ox_target:addBoxZone({
        coords = vec3(ped_pos.x, ped_pos.y, ped_pos.z),
        size = vec3(2, 2, 3),
        rotation = 45,
        drawSprite = true,
        options = {
            {
                name = 'mestopedik',
                onSelect = function()
                    lib.registerContext({
                        id = 'mesto_menu',
                        title = "Los Santos",
                        menu = 'mesto_menu',
                        options = {
                            {
                                title = 'Fly back to Los Santos',
                                description = 'Price: 0$',
                                icon = 'plane',
                                onSelect = function()
                                    lib.hideContext('mesto_menu')
                                    -- exports["okokNotify"]:Alert("Fly to Los Santos", "You are going on the plane!", 5000, 'success')
                                    -- Your Notify
                                    flymesto()
                                end,
                            },
                            {
                                title = 'Close Menu',
                                icon = 'xmark',
                                onSelect = function()
                                    lib.hideContext('mesto_menu')
                                end,
                            },
                        }
                    })
                    if IsPedInAnyVehicle(PlayerPedId(), true) then
                        -- exports["okokNotify"]:Alert("Fly to Los Santos", "You can't fly in a vehicle 😂!", 5000, 'error')
                        -- Your Notify
                    else
                        lib.showContext('mesto_menu')
                    end
                end,
                icon = "fa-solid fa-comment",
                label = "Talk to",
            }
        }
    })
end)

lib.callback.register('hajden_flytocayo:flyperico', function()
    flyperico()
end)

lib.callback.register('hajden_flytocayo:flymesto', function()
    flymesto()
end)