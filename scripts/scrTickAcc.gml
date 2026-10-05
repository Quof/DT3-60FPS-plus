/*
Speeding up / slowing down by a per-tick amount that depends on conditions (caps, "slow down until stopped", homing...):
  xVel = scrTickAcc(xVel, acc, slot)
  ...then move with (xVel + scrTickAccB(slot))*gDeltaTime instead of xVel*gDeltaTime.

0: the speed variable's current value
1: this tick's change, worked out with the object's original conditions (0 when it doesn't change). Pass it every frame;
   above 30fps only the value given at the start of each 30fps tick is used.
2: slot 0-2, so an object can use this for more than one speed (x, y, bullet speed)

At 30fps this just returns speed+acc, and the movement correction is 0.

Above 30fps: the 30fps code checks its conditions once per tick and changes the speed by a whole tick's amount, so speeds
land on different values when checked every frame with smaller steps (e.g. "if speed<12" caps a bit lower, and the bullet
then drifts from the 30fps one forever). Here the change is decided once per 30fps tick (counted from when the speed was
last set by something else, so it lines up with the object's own timers), spread over that tick's frames, and the speed
lands exactly on speed+acc at the end of the tick, so conditions see the same numbers as at 30fps. scrTickAccB(slot) corrects
the movement so each tick moves the same distance as the 30fps code (which changes the speed first, then moves).
*/
var v, s, fpt;
v = argument0
s = argument2
if !variable_local_exists("tkK")
{
  var i;
  for (i=0; i<3; i+=1) {tkK[i]=0; tkS[i]=0; tkA[i]=0; tkOut[i]=0; tkOn[i]=0; tkB[i]=0; tkF[i]=-1}
}
if gDeltaTime==1 {tkB[s]=0; return v+argument1}
fpt = round(1/gDeltaTime)
if tkOn[s]=0 or v!=tkOut[s] or tkK[s]>=fpt
{
  //start of a 30fps tick: either the last one finished, or the speed was set by something else
  tkS[s] = v
  tkA[s] = argument1
  tkK[s] = 0
  tkOn[s] = 1
}
tkK[s] += 1
if tkK[s]>=fpt {v = tkS[s] + tkA[s]} //exactly the 30fps value (same rounding)
else {v = tkS[s] + tkA[s]*tkK[s]*gDeltaTime}
tkB[s] = tkA[s]*(1-gDeltaTime)*0.5 //movement correction for this frame (scrTickAccB)
tkF[s] = oGame.time
tkOut[s] = v
return v
