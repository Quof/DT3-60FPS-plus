/*
Gravity (or any constant acceleration) for objects that move by their own speed variable:
  yVel = scrGravAcc(yVel, acc, order)
Call it where the 30fps code did "speed+=acc", but always BEFORE the move.
(scrGravAccX is the same for a second, horizontal speed: it keeps its own state.)

0: the speed variable's current value
1: acceleration per 30fps tick
2: 1 if the 30fps code accelerates and then moves; -1 if it moves and then accelerates

At 30fps: order 1 just returns speed+acc. Order -1 returns the speed unchanged; the caller keeps its original
speed+=acc line after the move, guarded with "if gDeltaTime==1".

Above 30fps: half of each frame's acceleration is added before the move and half after it, which follows the
smooth curve. (The "after" half is added at the start of the next call, before the next move, so the moves are
the same.) The 30fps steps sit g/2 off that curve (above it when accelerating first, below it when moving first),
so whenever the speed was set by something other than this script since the last call (a launch, bounce,
landing, cap or spawn) acc/2 times the order is added once, so the arc matches 30fps.
*/
var v, a;
v = argument0
a = argument1
if gDeltaTime==1
{
  if argument2>0 {return v+a}
  return v
}
if !variable_local_exists("grM") {grM=v+1; grH=0}  //first call: counts as an impulse
if v==grM {v+=grH}                //untouched since the last call: the second half of last frame's acceleration
else {v+=argument2*a*0.5}         //impulse: start the smooth curve where the 30fps steps put it
v += a*gDeltaTime*0.5
grM = v
grH = a*gDeltaTime*0.5
return v
