Trigger = {
    PID = true, -- Toggle Player ID above their head with F5
    HELI = true, -- Helicopter HUD and Realisitc takeoff/landing
    DISPATCH = true, -- Disable police and ems native dispatch
    HOSTILEPNC = true, -- Make NPCs Hostile (Find the lines below in client.lua and change 3 [Hostile when provoked] to 0 for non hostile or 5 for always hostile)
                        --    SetRelationshipBetweenGroups(3, GetHashKey('PLAYER'), GetHashKey(group)) -- 5 is always hostile
                        --    SetRelationshipBetweenGroups(3, GetHashKey(group), GetHashKey('PLAYER')) -- 5 is always hostile
    HEALTHREGAIN = true, -- True stops native health regeneration, false allows native health regeneration to happen
    PVP = true, -- Self explanitory
    INJURY = true, -- True makes player walk injured when low health, and seek medical attention. False disables this
    SPEEDLIMITER = true, -- True enables Speed limiter (form of cruise control) [X to turn on, Shift+x to turn off], fasle disables this
    IDLECAM = true, -- True Stops the native camera from panning around when player stands idle, false allows
    AMBIANTAMMO = true, -- True Lowers the noises of ammunations gun range, false leaves native ambiance
    MELEDAMAGE = true, -- True to Adjust mele damage to make fist fights last longer, False to keep native damage
    PISTOLWHIP = true, -- True to turn off pistol whipping, false to allow
    PEDDENS = true, -- True to lower the ped and vehicle density to slightly less than half vanilla settings. False to leave vanilla settings
                    --(Find the lines below in client.lua and change 4 to a higher number to have more or a lower number to have less)
                    --    DensityMultiplier = 0.4
    NPCCOPS = true, -- True to remove NPC cops, false to keep
    CROUCH = true, -- True to add updated crouch feature, false to ignore (Left Ctrl to use crouch)
    JUMPSPAM = true, -- True to stop players from jumping spamming, gives rag doll chance when jumping. False to disable
    STAMINA = true, -- True to give staminia buff, allowing longer running. False to disable.
    HEADSHOTS = true, -- True to give chance of headshots not always being 1 tap. False to disable
    BLINDFIRE = true, -- True to stop players from blind firing around corners. False to allow blind firing around corners
    WEAPONDROP = true, -- True to stop NPC wewapon drop rewards. False to allow NPC to drop weapon rewards
    NOVIC = true, -- True to disable vehicle rewards (guns from cars). False to enable vehicle rewards
    AIMASSISTREMOVE = true, -- True to remove aim assist on controllers. False to allow
    DRIVEBY = true, -- True to stop players from shooting from a moving vehicle going above 30mph. False to diable.(Find the lines below in client.lua and change 30 to whatever speed you want set)
                    --	if math.floor(speed * mph) > 30 then
    SNOWFALL = true, -- True makes snow all the time, false disables this
    TIRESMOKE = true -- Enables thicker tire smoke, for burnouts and drifting
    HANDSUP = true -- Enables the handsup emote by using the Y keybind
}
