/*
**  Usage:
**      turn_toward_direction(direction,turnspeed)
**
**  Arguments:
**      direction       direction you wish to achieve, degrees
**      turnspeed       rate at which to turn, degrees
**
**  Returns:
**      nothing, but rotates the calling instance toward
**      a desired direction by a given number of degrees
**
**  GMLscripts.com
*/


//edited turn_toward_direction() to not use the built-in direction values of GM, hope this works
var wdir, turnspeed, step, tDiff;
wdir = argument0
turnspeed = argument1
step = turnspeed * gDeltaTime
_direction = _direction mod 360
if _direction < 0 { _direction += 360 }

tDiff = angle_difference(wdir, _direction)
if abs(tDiff) <= turnspeed
{ _direction = wdir }

else
{ _direction += sign(tDiff) * step }
