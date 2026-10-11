/*
Warmaster II: an invisible damaging box (oWM2_HitBox) in front of the caller, for slashes and body attacks.
argument0: distance from the caller's x to the box's near side, in the direction it faces (can be negative)
argument1: the box's top, relative to the caller's y (up is negative)
argument2: width
argument3: height
argument4: how long it lasts (30fps ticks)
argument5: 1 = moves with the caller, 0 = stays where it was made
Returns the box.
*/
var tL,tH;
if scaleForFacing>=0 {tL=x+argument0}
else {tL=x-argument0-argument2}
tH=instance_create(tL,y+argument1,oWM2_HitBox)
tH.image_xscale=argument2
tH.image_yscale=argument3
tH.hitTime=argument4
tH.atkPower=atkPower
if argument5=1
{
  tH.owner=id
  tH.relX=tL-x
  tH.relY=argument1
}
return tH
