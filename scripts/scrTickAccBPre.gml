/*
Like scrTickAccB, for code that moves (or copies the speed for moving) BEFORE changing the speed at 30fps:
above 30fps call scrTickAcc before the move instead, and move with (speed + scrTickAccBPre(slot))*gDeltaTime.
(Each 30fps tick then moves at the speed the tick started with, like the 30fps code.)
0 at 30fps, and 0 if scrTickAcc wasn't called for this slot this frame.
*/
if gDeltaTime==1 return 0
if !variable_local_exists("tkF") return 0
if tkF[argument0]!=oGame.time return 0
return tkB[argument0]-tkA[argument0]