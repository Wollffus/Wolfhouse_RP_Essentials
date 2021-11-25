# Wolfhouse_RP_Essentials
# Ditial Life RP   


### Installation 
- Add the Wolfhouse_RP_Essentials file to your server resources directory 
- Add `ensure Wolfhouse_RP_Essentials` to your `server.cfg` file.  

 This file has 20 different functions packed into one. Just comment out any of the ones you dont want to use if any in the Wolfhouse.lua  

- Example of how to comment out:  

- These two dashes and two brackets here-------------->--[[  --Mele and weapon Damage  Citizen.CreateThread(function()   while true do N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.4)              &lt;---------Whatever you comment out in between the two top dashes and brackets and the two lower brackets>     Wait(0)     N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.7)     Wait(0)   end end)]] &lt;------------- These two brackets here  
 
- Features: Helicopter HUD and Takeoff/Landing Control 
- Disable Dispatch 
- Stop weapon drops 
- Stop health regen 
- Enable PvP 
- Walk injured when hurt, seek medical attention 
- Speed Limiter 
- Disable Idle Cinamatic Cam Remove 
- Ammunation ambiant sound 
- Stops Pistol Whipping 
- Adjust mele damage (longer fist fights) 
- Removes NPC cops 
- Add crouch option 
- Stops spam jumping (chance to fall if jumping) 
- Stamina Buff (run longer) 
- Headshot Nerf (chance of no one tap headshot) 
- Blindfire disable (stops player from shooting from cover) 
- Disables weapon drops (NPC dont drop weapons when killed) 
- Aim Assist (disabled) Disables shooting from car (can change to drive by option with speed set) 
- Adjust Ped density
