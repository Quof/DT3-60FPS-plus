/*
Movement correction for a speed changed this frame with scrTickAcc (see there): move with (speed + scrTickAccB(slot))*gDeltaTime.
0 at 30fps, and 0 if scrTickAcc wasn't called for this slot this frame (the speed isn't changing).
*/
if gDeltaTime==1 return 0
if !variable_local_exists("tkF") return 0
if tkF[argument0]!=oGame.time return 0
return tkB[argument0]