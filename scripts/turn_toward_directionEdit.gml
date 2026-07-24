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

var wdir, tempdir, turnspeed;
wdir=argument0
turnspeed=argument1
if abs(wdir-_direction) > 180
{
  if wdir>180
  {
    tempdir=wdir-360
    if abs(tempdir-_direction)>turnspeed {_direction-=turnspeed}
    else {_direction=wdir}
  }
  else
  {
    tempdir=wdir+360
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
