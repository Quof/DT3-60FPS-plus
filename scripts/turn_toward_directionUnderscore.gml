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
//if !gDeltaDoTicks {exit}
var wdir, tempdir, turnspeed;
wdir=argument0
turnspeed=argument1
turnspeed=turnspeed*gDeltaTime
_direction=_direction mod 360
if _direction<0 {_direction+=360}

if abs(wdir-_direction) > 180
{
  if wdir>180
  {
    tempdir=wdir mod 360
    if abs(tempdir-_direction)>turnspeed {_direction-=turnspeed}
    else {_direction=wdir}
  }
  else
  {
    tempdir=wdir mod 360
    if abs(tempdir-_direction)>turnspeed {_direction+=turnspeed}
    else {_direction=wdir}
  }
}
else
{
  if abs(wdir-_direction)>turnspeed
  {
    if wdir>_direction {_direction+=turnspeed}
    else {_direction-=turnspeed}
  }
  else {_direction=wdir}
}
