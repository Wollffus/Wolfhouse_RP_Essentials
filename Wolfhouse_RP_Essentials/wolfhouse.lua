---------------------------------------------------------------------------------------------------------- Helicopter Control System
local UI = {
	x = 0.3,
	y = 0.43,
}

function Text(text, x, y, scale)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextOutline()
	SetTextJustification(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

		local Ped = GetPlayerPed(-1)
		local Heli = IsPedInAnyHeli(Ped)
		local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(-1),false)
		local HeliSpeed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.24
		local Engine = GetIsVehicleEngineRunning(PedVehicle)
		local Height = GetEntityHeightAboveGround(PedVehicle)
		local MainRotorHealth = GetHeliMainRotorHealth(PedVehicle)
		local TailRotorHealth = GetHeliTailRotorHealth(PedVehicle)

		if Heli then
			-- engine display
			if Engine then
				Text("~g~ENG", UI.x + 0.4016, UI.y + 0.476, 0.55)
				Text("~g~__", UI.x + 0.4016, UI.y + 0.47, 0.79)
			elseif Engine == false then
				Text("~r~ENG", UI.x + 0.4016, UI.y + 0.476, 0.55)
				Text("~r~__", UI.x + 0.4016, UI.y + 0.47, 0.79)
			end

			-- Main rotor display
			if MainRotorHealth > 800 and Engine then
				Text("~g~MAIN", UI.x + 0.4516, UI.y + 0.476, 0.55)
				Text("~g~__", UI.x + 0.4516, UI.y + 0.47, 0.79)
			elseif MainRotorHealth > 200 and MainRotorHealth < 800 and Engine then
				Text("~y~MAIN", UI.x + 0.4516, UI.y + 0.476, 0.55)
				Text("~y~__", UI.x + 0.4516, UI.y + 0.47, 0.79)
			elseif MainRotorHealth < 200 and Engine then
				Text("~r~MAIN", UI.x + 0.4516, UI.y + 0.476, 0.55)
				Text("~r~__", UI.x + 0.4516, UI.y + 0.47, 0.79)
			elseif Engine == false then
				Text("~r~MAIN", UI.x + 0.4516, UI.y + 0.476, 0.55)
				Text("~r~__", UI.x + 0.4516, UI.y + 0.47, 0.79)
			end

			-- Tail rotor display
			if TailRotorHealth > 300 and Engine then
				Text("~g~TAIL", UI.x + 0.5, UI.y + 0.476, 0.55)
				Text("~g~__", UI.x + 0.5, UI.y + 0.47, 0.79)
			elseif TailRotorHealth > 100 and TailRotorHealth < 300 and Engine then
				Text("~y~TAIL", UI.x + 0.5, UI.y + 0.476, 0.55)
				Text("~y~__", UI.x + 0.5, UI.y + 0.47, 0.79)
			elseif TailRotorHealth < 100 and Engine then
				Text("~r~TAIL", UI.x + 0.5, UI.y + 0.476, 0.55)
				Text("~r~__", UI.x + 0.5, UI.y + 0.47, 0.79)
			elseif Engine == false then
				Text("~r~TAIL", UI.x + 0.5, UI.y + 0.476, 0.55)
				Text("~r~__", UI.x + 0.5, UI.y + 0.47, 0.79)
			end

			-- Altitude and speed display
			Text(math.ceil(Height), UI.x + 0.549, UI.y + 0.476, 0.45)
			Text("ALTITUDE", UI.x + 0.549, UI.y + 0.502, 0.29)

			Text(math.ceil(HeliSpeed), UI.x + 0.598, UI.y + 0.476, 0.45)
			Text("AIR SPEED", UI.x + 0.598, UI.y + 0.502, 0.29)

			if HeliSpeed < 0.9 and HeliSpeed > 0.1 then
				Text("1", UI.x + 0.598, UI.y + 0.476, 0.45)
			elseif HeliSpeed == 0.0 then
				Text("0", UI.x + 0.598, UI.y + 0.476, 0.45)
			end

			-- Big rectangels on the ui
			DrawRect(UI.x + 0.5, UI.y + 0.5, 0.255, 0.085, 25, 25, 25, 255)
			DrawRect(UI.x + 0.5, UI.y + 0.5, 0.25, 0.075, 51, 51, 51, 255)

			-- Smaller squares in the rectangels.
			DrawRect(UI.x + 0.402, UI.y + 0.5, 0.040, 0.050, 25, 25, 25, 255)
			DrawRect(UI.x + 0.4516, UI.y + 0.5, 0.040, 0.050, 25, 25, 25, 255)
			DrawRect(UI.x + 0.5, UI.y + 0.5, 0.040, 0.050, 25, 25, 25, 255)
			DrawRect(UI.x + 0.549, UI.y + 0.5, 0.040, 0.050, 25, 25, 25, 255)
			DrawRect(UI.x + 0.598, UI.y + 0.5, 0.040, 0.050, 25, 25, 25, 255)

			-- Slows down helicopter on landing and takeoff but not if it's flying fast close to the ground.
			if HeliSpeed > 15.0 and Height < 30.0 then
				SetEntityMaxSpeed(PedVehicle, 300.0)
			elseif HeliSpeed > 15.0 and Height < 10.0 then
				SetEntityMaxSpeed(PedVehicle, 20.0)
			elseif Height < 3.0 then
				SetEntityMaxSpeed(PedVehicle, 1.0)
			elseif Height < 5.0 then
				SetEntityMaxSpeed(PedVehicle, 2.0)
			elseif Height > 5.0 and Height < 10.0 then
				SetEntityMaxSpeed(PedVehicle, 3.0)
			elseif Height > 10.0 and Height < 15.0 then
				SetEntityMaxSpeed(PedVehicle, 4.0)
			elseif Height > 15.0 and Height < 20.0 then
				SetEntityMaxSpeed(PedVehicle, 6.0)
			elseif Height > 20.0 and Height < 25.0 then
				SetEntityMaxSpeed(PedVehicle, 7.0)
			elseif Height > 25.0 and Height < 30.0 then
				SetEntityMaxSpeed(PedVehicle, 10.0)
			elseif Height > 30.0 then
				SetEntityMaxSpeed(PedVehicle, 300.0)
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

		local Ped = GetPlayerPed(-1)
		local Heli = IsPedInAnyHeli(Ped)
		local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(-1),false)
		local HeliSpeed = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.24
		local Engine = GetIsVehicleEngineRunning(PedVehicle)
		local Height = GetEntityHeightAboveGround(PedVehicle)

		-- Shuts down engine 5 seconds after landing.
		if Heli then
			if Height < 3.0 and HeliSpeed == 0 and Engine then
				Citizen.Wait(5000)
				SetVehicleEngineOn(PedVehicle, false, true, true)
			end
		end
	end
end)

---------------------------------------------------------------------------------------------------------- Disable Dispatch

Citizen.CreateThread(function()
  Wait(0)
  EnableDispatchService(1, false)
  EnableDispatchService(2, false)
  EnableDispatchService(3, false)
  EnableDispatchService(4, false)
  EnableDispatchService(5, false)
  EnableDispatchService(6, false)
  EnableDispatchService(7, false)
  EnableDispatchService(8, false)
  EnableDispatchService(9, false)
  EnableDispatchService(10, false)
  EnableDispatchService(11, false)
  EnableDispatchService(12, false)
  SetPlayerWantedLevel(PlayerId(), 0, false)
  SetPlayerWantedLevelNow(PlayerId(), false)
  SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
  DisablePlayerVehicleRewards(-1)
end)

Citizen.CreateThread(function()
while true do
Wait(0)
RemoveVehiclesFromGeneratorsInArea(408.41 - 100.0, -994.21 - 100.0, 29.0 - 100.0, 408.41 + 100.0, -994.21 + 100.0, 29.0 + 100.0)
RemoveVehiclesFromGeneratorsInArea(1405.14 - 100.0, 1120.8 - 100.0, 114.8 - 100.0, 1405.14 + 100.0, 1120.8 + 100.0, 114.8 + 100.0)
RemoveVehiclesFromGeneratorsInArea(535.38 - 100.0, -192.28 - 100.0, 53.94 - 100.0, 535.38 + 100.0, -192.28 + 100.0, 53.94 + 100.0)
RemoveVehiclesFromGeneratorsInArea(581.44 - 100.0, 38.82 - 100.0, 92.5 - 100.0, 581.44 + 100.0, 38.82 + 100.0, 92.5 + 100.0)
end
end)

Citizen.CreateThread(function()
while true do
  Wait(1)

  RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_CARBINERIFLE'))
  RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL'))
  RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'))
end
end)

---------------------------------------------------------------------------------------------------------- Make NPCs Hostile

local relationshipTypes = {
  "GANG_1",
  "GANG_2",
  "GANG_9",
  "GANG_10",
  "AMBIENT_GANG_LOST",
  "AMBIENT_GANG_MEXICAN",
  "AMBIENT_GANG_FAMILY",
  "AMBIENT_GANG_BALLAS",
  "AMBIENT_GANG_MARABUNTE",
  "AMBIENT_GANG_CULT",
  "AMBIENT_GANG_SALVA",
  "AMBIENT_GANG_WEICHENG",
  "AMBIENT_GANG_HILLBILLY",
  "DEALER",
  "HATES_PLAYER",
  "NO_RELATIONSHIP",
  "SPECIAL",
  "MISSION2",
  "MISSION3",
  "MISSION4",
  "MISSION5",
  "MISSION6",
  "MISSION7",
  "MISSION8",
}

Citizen.CreateThread(function()
    while true do
        Wait(50)
        for _, group in ipairs(relationshipTypes) do
              SetRelationshipBetweenGroups(3, GetHashKey('PLAYER'), GetHashKey(group)) -- 5 is always hostile
              SetRelationshipBetweenGroups(3, GetHashKey(group), GetHashKey('PLAYER')) -- 5 is always hostile
        end
    end
end)

----------------------------------------------------------------------------------------------------------  Stop health regen

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
  end
end)

----------------------------------------------------------------------------------------------------------  Enable PvP

Citizen.CreateThread(function()
  while true do
    Wait(0)

    local player = PlayerId()
      local playerPed = PlayerPedId()

      NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(playerPed, true, true)

    end
  end)

---------------------------------------------------------------------------------------------------------- Walk injured when hurt, seek medical attention

local hurt = false
local player = PlayerPedId()
local injuredcounter = 0
Citizen.CreateThread(function()
while true do
Wait(0)
if GetEntityHealth(GetPlayerPed(-1)) <= 159 then
setHurt()
StillInjured = true
elseif hurt and GetEntityHealth(GetPlayerPed(-1)) > 160 then
setNotHurt()
showNotHurt()
end
end
end)

function setHurt()
hurt = true
RequestAnimSet("move_m@injured")
SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
Citizen.Wait(10000)
showHurt()
end

function showHurt()
	DisplayNotification("You need to seek medical attention.")
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if injuredcounter == 20000 then
		ApplyDamageToPed(GetPlayerPed(-1),  23, false)
		elseif injuredcounter == 36000 then
		local ped = GetPlayerPed(-1)
    local currentHealth = GetEntityHealth(ped)
		GetEntityHealth(ped, currentHealth - 5)
        Citizen.Wait(5000)
		elseif injuredcounter == 46000 then -- 46000
			DisplayNotification("You need to get to a hospital now!.")
		elseif injuredcounter == 54000 then -- 54000
			-- dead kill them AGAIN
			ApplyDamageToPed(player, 800, false)
			DisplayNotification("You did not get treated in time.")

		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if StillInjured then
		injuredcounter = injuredcounter + 1
		else
			Citizen.Wait(0)
		end
	end
end)

function DisplayNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end



function showNotHurt()
	DisplayNotification("You've been treated")
end

function setNotHurt()
hurt = false
StillInjured = false
injuredcounter = 0
ResetPedMovementClipset(GetPlayerPed(-1))
ResetPedWeaponMovementClipset(GetPlayerPed(-1))
ResetPedStrafeClipset(GetPlayerPed(-1))
end

----------------------------------------------------------------------------------------------------------  Speed Limiter

Citizen.CreateThread(function()
  local resetSpeedOnEnter = true
  while true do
    Citizen.Wait(0)
    local playerPed = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(playerPed,false)
    if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then

      -- This should only happen on vehicle first entry to disable any old values
      if resetSpeedOnEnter then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        resetSpeedOnEnter = false
      end
      -- Disable speed limiter
      if IsControlJustReleased(0,73) and IsControlPressed(0,131) then
        maxSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")
        SetEntityMaxSpeed(vehicle, maxSpeed)
        showHelpNotification("Speed limiter disabled")
      -- Enable speed limiter
      elseif IsControlJustReleased(0,73) then
        cruise = GetEntitySpeed(vehicle)
        SetEntityMaxSpeed(vehicle, cruise)
        if useMph then
          cruise = math.floor(cruise * 2.23694 + 0.5)
          showHelpNotification("Speed limiter set to "..cruise.." mph. ~INPUT_VEH_SUB_ASCEND~ + ~INPUT_MP_TEXT_CHAT_TEAM~ to disable.")
        else
          cruise = math.floor(cruise * 3.6 + 0.5)
          showHelpNotification("Speed limiter set to "..cruise.." km/h. ~INPUT_VEH_SUB_ASCEND~ + ~INPUT_MP_TEXT_CHAT_TEAM~ to disable.")
        end
      end
    else
      resetSpeedOnEnter = true
    end
  end
end)

function showHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

----------------------------------------------------------------------------------------------------------  Disable Idle Cinamatic Cam
Citizen.CreateThread(function()
	while true do
	  N_0xf4f2c0d4ee209e20()
	  Wait(1000)
	end
  end)

----------------------------------------------------------------------------------------------------------  Lower Ammunation ambiant sound (loud gun shots constantly)

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      if NetworkIsSessionStarted() then
          SetStaticEmitterEnabled('LOS_SANTOS_AMMUNATION_GUN_RANGE', false)
          return
      end
  end
end)

----------------------------------------------------------------------------------------------------------  Mele and weapon Damage

Citizen.CreateThread(function()
  while true do
N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.4)
    Wait(0)
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.7)
    Wait(0)
  end
end)

---------------------------------------------------------------------------------------------------------- -Disable Pistol Whipping

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
local ped = PlayerPedId()
      if IsPedArmed(ped, 6) then
    DisableControlAction(1, 140, true)
          DisableControlAction(1, 141, true)
          DisableControlAction(1, 142, true)
      end
  end
end)

----------------------------------------------------------------------------------------------------------  Ped density

DensityMultiplier = 0.6
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetPedDensityMultiplierThisFrame(DensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(DensityMultiplier, DensityMultiplier)
	end
end)

---------------------------------------------------------------------------------------------------------- Remove NPC Cops

Citizen.CreateThread(function()
	while true do
		local playerLoc = GetEntityCoords(PlayerPedId())

		ClearAreaOfCops(playerLoc.x, playerLoc.y, playerLoc.z, 200.0)

		Citizen.Wait(300)
	end
end)

---------------------------------------------------------------------------------------------------------- Crouch

local crouched = false

Citizen.CreateThread( function()
    while true do
        Citizen.Wait( 1 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK

            if ( not IsPauseMenuActive() ) then
                if ( IsDisabledControlJustPressed( 0, 36 ) ) then
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do
                        Citizen.Wait( 100 )
                    end

                    if ( crouched == true ) then
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true
                    end
                end
            end
        end
    end
end )

---------------------------------------------------------------------------------------------------------- -No jump spamming

local ragdoll_chance = 0.5

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		if IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped) then
			local chance_result = math.random()
			print('Ragdoll probability: ' .. chance_result)
			if chance_result < ragdoll_chance then
				Citizen.Wait(600)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
				SetPedToRagdoll(ped, 5000, 1, 2)
				print('Ragdolling')
			else
				Citizen.Wait(2000)
			end
		end
	end
end)

----------------------------------------------------------------------------------------------------------  Stamina Regain

Citizen.CreateThread( function()
  while true do
    Citizen.Wait(0)
    RestorePlayerStamina(GetPlayerPed(-1), 2.0)
    end
  end)

----------------------------------------------------------------------------------------------------------  Headshots not 1 tap

Citizen.CreateThread(function()
  while true do
      Wait(5)

      SetPedSuffersCriticalHits(PlayerPedId(), false)
  end
end)

Citizen.CreateThread( function()
  while true do
      ManageReticle()

      Citizen.Wait( 0 )
  end
end )

----------------------------------------------------------------------------------------------------------  Disable Blind Fire

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if IsPedInCover(ped, 1) and not IsPedAimingFromCover(ped, 1) then
			DisableControlAction(2, 24, true)
			DisableControlAction(2, 142, true)
			DisableControlAction(2, 257, true)
		end
	end
end)

---------------------------------------------------------------------------------------------------------- Weapon Drop

function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        SetWeaponDrops()
    end
end)


---------------------------------------------------------------------------------------------------------- No Weapons From vehicle

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        id = PlayerId()
        DisablePlayerVehicleRewards(id)
    end
end)

---------------------------------------------------------------------------------------------------------- Assisted Aim Disable
Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(0)
	  if GetSelectedPedWeapon(PlayerId()) ~= GetHashKey("WEAPON_PISTOL") then
		SetPlayerLockonRangeOverride(PlayerId(), 0.0)
	  end
	end
end)


----------------------------------------------------------------------------------------------------------  Allow passengers to shoot
local passengerDriveBy = true


Citizen.CreateThread(function()
  while true do
    Wait(1)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
    local speed = GetEntitySpeed(vehicle)
    local kmh = 3.6
    local mph = 2.23694
    local vehicleClass = GetVehicleClass(vehicle)
    local vehicleModel = GetEntityModel(vehicle)

    if vehicleClass ~= 15 and 16 then
    GetEntitySpeed(GetPedInVehicleSeat(GetPlayerPed(-1), false))
    -- If you want mph, then replace kmh with mph under here. If you want more or less than 30 also change it here
    if math.floor(speed*mph) > 30 then
        SetPlayerCanDoDriveBy(PlayerId(), false)
      elseif passengerDriveBy then
        SetPlayerCanDoDriveBy(PlayerId(), true)
      else
        SetPlayerCanDoDriveBy(PlayerId(), false)
      end
    end
  end
end)