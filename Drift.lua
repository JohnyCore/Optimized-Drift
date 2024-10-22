require "lib.moonloader"

local script_name = "Drift"
local script_version = "0.0.1"
local script_author = "DjC"

local pCar
local sCar
local dToggle = false

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(0) end

    sampAddChatMessage("{ff5b4f}[Drift v" .. script_version .. "] {FFFFFF}Loaded, Use (/drift) to activate/deactivate it.", -1)

    sampRegisterChatCommand("drift", toggleDrift)

    while true do
        wait(0)
        if dToggle == true then
            if isCharInAnyCar(playerPed) then 
                pCar = storeCarCharIsInNoSave(playerPed)
                sCar = getCarSpeed(pCar)
                isCarInAirProper(pCar)
                setCarCollision(pCar, true)

                if isKeyDown(VK_LSHIFT) and isVehicleOnAllWheels(pCar) and doesVehicleExist(pCar) and sCar > 5.0 then
                    setCarCollision(pCar, false)
                    if isCarInAirProper(pCar) then
                        setCarCollision(pCar, true)
                        if isKeyDown(VK_A) then 
                            addToCarRotationVelocity(pCar, 0, 0, 0.05)
                        end
                        if isKeyDown(VK_D) then
                            addToCarRotationVelocity(pCar, 0, 0, -0.05)
                        end
                    end
                end
            end
        end
    end -- WHILE
end -- MAIN

function toggleDrift()
    dToggle = not dToggle
    if dToggle then
        sampAddChatMessage("{ff5b4f}Drift mode {FFFFFF}activated!", -1)
    else
        sampAddChatMessage("{ff5b4f}Drift mode {FFFFFF}deactivated!", -1)
    end
end
