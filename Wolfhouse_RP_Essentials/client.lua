function disableActions()

---------------------------------------------------------------------------------------------------------- Get weapon Hash
-- print(GetHashKey("WEAPON_SR25"))
-- print(GetHashKey("WEAPON_m700"))

---------------------------------------------------------------------------------------------------------- Snowing always
if Trigger.SNOWFALL then
	Citizen.CreateThread(function()
    	while true
        	do

    	SetWeatherTypePersist("XMAS")
        	SetWeatherTypeNowPersist("XMAS")
        	SetWeatherTypeNow("XMAS")
        	SetOverrideWeather("XMAS")
        	SetForcePedFootstepsTracks(true)
		SetForceVehicleTrails(true)
        	Citizen.Wait(1)
    	end

	end)
end
---------------------------------------------------------------------------------------------------------- Player IDs above head using F5
if Trigger.PID then
	local showPlayerBlips = false
	local ignorePlayerNameDistance = false
	local playerNamesDist = 15
	local displayIDHeight = 1.0 -- Height of ID above players head(starts at center body mass)
	-- Set Default Values for Colors
	local red = 255
	local green = 255
	local blue = 255

	function DrawText3D(x, y, z, text)
		local onScreen, _x, _y = World3dToScreen2d(x, y, z)
		local px, py, pz = table.unpack(GetGameplayCamCoords())
		local dist = Vdist(px, py, pz, x, y, z, 1)

		local scale = (1 / dist) * 2
		local fov = (1 / GetGameplayCamFov()) * 100
		local scale = scale * fov

		if onScreen then
			SetTextFont(5)
			SetTextProportional(1)
			SetTextColour(red, green, blue, 255)
			SetTextDropshadow(0, 0, 0, 0, 255)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			SetTextCentre(1)
			AddTextComponentString(text)
			World3dToScreen2d(x, y, z, 0) -- Added Here
			DrawText(_x, _y)
		end
	end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsControlPressed(1, 327) then
				for i = 0, 99 do N_0x31698aa80e0223f8(i) end
				for id = 0, 255 do
					if ((NetworkIsPlayerActive(id)) and GetPlayerPed(id) ~= GetPlayerPed(-1)) then
						ped = GetPlayerPed(id)
						blip = GetBlipFromEntity(ped)

						x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
						x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
						distance = math.floor(Vdist(x1, y1, z1, x2, y2, z2, true))

						if (ignorePlayerNameDistance) then
							if NetworkIsPlayerTalking(id) then
								red = 0
								green = 255
								blue = 21
								DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
							else
								red = 255
								green = 255
								blue = 255
								DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
							end
						end

						if ((distance < playerNamesDist)) then
							if not (ignorePlayerNameDistance) then
								if NetworkIsPlayerTalking(id) then
									red = 0
									green = 255
									blue = 21
									DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
								else
									red = 255
									green = 255
									blue = 255
									DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
								end
							end
						end
					end
				end
			elseif not IsControlPressed(1, 327) then
				DrawText3D(0, 0, 0, "")
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------- Helicopter Control System
if Trigger.HELI then
	local UI = {
		x = 0.3,
		y = 0.43,
	}

	function Text(text, x, y, scale)
		SetTextFont(4)
		SetTextProportional(0)
		SetTextScale(scale, scale)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow(0, 0, 0, 0, 255)
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
			local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
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
			local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
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
end
---------------------------------------------------------------------------------------------------------- Disable Dispatch
if Trigger.DISPATCH then
  for i = 1, 12 do
    EnableDispatchService(i, false)
	end
end
---------------------------------------------------------------------------------------------------------- Make NPCs Hostile
if Trigger.HOSTILENPC then
	local relationshipTypes = {
		"GANG_1", "GANG_2", "GANG_9", "GANG_10", "AMBIENT_GANG_LOST", "AMBIENT_GANG_MEXICAN", "AMBIENT_GANG_FAMILY", "AMBIENT_GANG_BALLAS", "AMBIENT_GANG_MARABUNTE", "AMBIENT_GANG_CULT", "AMBIENT_GANG_SALVA", "AMBIENT_GANG_WEICHENG",
  "AMBIENT_GANG_HILLBILLY", "DEALER", "HATES_PLAYER", "NO_RELATIONSHIP", "SPECIAL", "MISSION2", "MISSION3", "MISSION4", "MISSION5", "MISSION6", "MISSION7", "MISSION8",
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
end
----------------------------------------------------------------------------------------------------------  Stop health regen

if Trigger.HEALTHREGAIN then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(100)
			SetPlayerHealthRechargeMultiplier(PlayerId(), 0)
		end
	end)
end
----------------------------------------------------------------------------------------------------------  Enable PvP

if Trigger.PVP then
  SetCanAttackFriendly(PlayerPedId(), true, false)
  NetworkSetFriendlyFireOption(true)
end
---------------------------------------------------------------------------------------------------------- Walk injured when hurt, seek medical attention

if Trigger.INJURY then
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

	function showHurt() DisplayNotification("You need to seek medical attention.") end

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)

			if injuredcounter == 20000 then
				ApplyDamageToPed(GetPlayerPed(-1), 23, false)
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

	function DisplayNotification(text)
		SetNotificationTextEntry("STRING")
		AddTextComponentString(text)
		DrawNotification(false, false)
	end

	function showNotHurt() DisplayNotification("You've been treated") end

	function setNotHurt()
		hurt = false
		StillInjured = false
		injuredcounter = 0
		ResetPedMovementClipset(GetPlayerPed(-1))
		ResetPedWeaponMovementClipset(GetPlayerPed(-1))
		ResetPedStrafeClipset(GetPlayerPed(-1))
	end
end
----------------------------------------------------------------------------------------------------------  Speed Limiter

if Trigger.SPEEDLIMITER then
	Citizen.CreateThread(function()
		local resetSpeedOnEnter = true
		while true do
			Citizen.Wait(0)
			local playerPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(playerPed, false)
			if GetPedInVehicleSeat(vehicle, -1) == playerPed and IsPedInAnyVehicle(playerPed, false) then

				-- This should only happen on vehicle first entry to disable any old values
				if resetSpeedOnEnter then
					maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
					SetEntityMaxSpeed(vehicle, maxSpeed)
					resetSpeedOnEnter = false
				end
				-- Disable speed limiter
				if IsControlJustReleased(0, 73) and IsControlPressed(0, 131) then
					maxSpeed = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel")
					SetEntityMaxSpeed(vehicle, maxSpeed)
					showHelpNotification("Speed limiter disabled")
					-- Enable speed limiter
				elseif IsControlJustReleased(0, 73) then
					cruise = GetEntitySpeed(vehicle)
					SetEntityMaxSpeed(vehicle, cruise)
					if useMph then
						cruise = math.floor(cruise * 2.23694 + 0.5)
						showHelpNotification("Speed limiter set to " .. cruise .. " mph. ~INPUT_VEH_SUB_ASCEND~ + ~INPUT_MP_TEXT_CHAT_TEAM~ to disable.")
					else
						cruise = math.floor(cruise * 3.6 + 0.5)
						showHelpNotification("Speed limiter set to " .. cruise .. " km/h. ~INPUT_VEH_SUB_ASCEND~ + ~INPUT_MP_TEXT_CHAT_TEAM~ to disable.")
					end
				end
			else
				resetSpeedOnEnter = true
			end
		end
	end)
end

function showHelpNotification(msg)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

----------------------------------------------------------------------------------------------------------  Disable Idle Cinamatic Cam
if Trigger.IDLECAM then
  DisableIdleCamera(true)
	end
end
----------------------------------------------------------------------------------------------------------  Lower Ammunation ambiant sound (loud gun shots constantly)

if Trigger.AMBIANTAMMO then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if NetworkIsSessionStarted() then
				SetStaticEmitterEnabled('LOS_SANTOS_AMMUNATION_GUN_RANGE', false)
				return
			end
		end
	end)
end
----------------------------------------------------------------------------------------------------------  Mele and weapon Damage

if Trigger.MELEDAMAGE then
	Citizen.CreateThread(function()
		while true do
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.4)
			Wait(0)
			N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.7)
			Wait(0)
		end
	end)
end
---------------------------------------------------------------------------------------------------------- -Disable Pistol Whipping

if Trigger.PISTOLWHIP then
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
end
----------------------------------------------------------------------------------------------------------  Ped density

if Trigger.PEDDENS then
	DensityMultiplier = 0.4
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
end
---------------------------------------------------------------------------------------------------------- Remove NPC Cops

if Trigger.NPCCOPS then
	Citizen.CreateThread(function()
		while true do
			local playerLoc = GetEntityCoords(PlayerPedId())

			ClearAreaOfCops(playerLoc.x, playerLoc.y, playerLoc.z, 200.0)

			Citizen.Wait(300)
		end
	end)
end

---------------------------------------------------------------------------------------------------------- Crouch

if Trigger.CROUCH then
	local crouched = false

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)

			local ped = GetPlayerPed(-1)

			if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
				DisableControlAction(0, 36, true) -- INPUT_DUCK

				if (not IsPauseMenuActive()) then
					if (IsDisabledControlJustPressed(0, 36)) then
						RequestAnimSet("move_ped_crouched")

						while (not HasAnimSetLoaded("move_ped_crouched")) do Citizen.Wait(100) end

						if (crouched == true) then
							ResetPedMovementClipset(ped, 0)
							crouched = false
						elseif (crouched == false) then
							SetPedMovementClipset(ped, "move_ped_crouched", 0.25)
							crouched = true
						end
					end
				end
			end
		end
	end)
end

---------------------------------------------------------------------------------------------------------- -No jump spamming

if Trigger.JUMPSPAM then
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
end

----------------------------------------------------------------------------------------------------------  Stamina Regain

if Trigger.STAMINA then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			RestorePlayerStamina(GetPlayerPed(-1), 2.0)
		end
	end)
end
----------------------------------------------------------------------------------------------------------  Headshots not 1 tap

if Trigger.HEADSHOTS then
	Citizen.CreateThread(function()
		while true do
			Wait(5)

			SetPedSuffersCriticalHits(PlayerPedId(), false)
		end
	end)

	Citizen.CreateThread(function()
		while true do
			ManageReticle()

			Citizen.Wait(0)
		end
	end)
end
----------------------------------------------------------------------------------------------------------  Disable Blind Fire
if Trigger.BLINDFIRE then
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
end
---------------------------------------------------------------------------------------------------------- Weapon Drop

if Trigger.WEAPONDROP then
	function SetWeaponDrops()
		local handle, ped = FindFirstPed()
		local finished = false

		repeat
			if not IsEntityDead(ped) then SetPedDropsWeaponsWhenDead(ped, false) end
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
end

---------------------------------------------------------------------------------------------------------- No Weapons From vehicle
if Trigger.NOVIC then
  DisablePlayerVehicleRewards(PlayerPedId())
	end
end

---------------------------------------------------------------------------------------------------------- Assisted Aim Disable
if Trigger.AIMASSISTREMOVE then
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if GetSelectedPedWeapon(PlayerId()) ~= GetHashKey("WEAPON_PISTOL") then SetPlayerLockonRangeOverride(PlayerId(), 0.0) end
		end
	end)
end

----------------------------------------------------------------------------------------------------------  Allow passengers to shoot
if Trigger.DRIVEBY then
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
				if math.floor(speed * mph) > 30 then
					SetPlayerCanDoDriveBy(PlayerId(), false)
				elseif passengerDriveBy then
					SetPlayerCanDoDriveBy(PlayerId(), true)
				else
					SetPlayerCanDoDriveBy(PlayerId(), false)
				end
			end
		end
	end)
end
