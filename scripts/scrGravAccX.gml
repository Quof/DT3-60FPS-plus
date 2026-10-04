/*
scrGravAcc for a second (horizontal) speed variable, with its own state:
  xVel = scrGravAccX(xVel, acc, order)
See scrGravAcc.
*/
var v, a;
v = argument0
a = argument1
if gDeltaTime==1
{
  if argument2>0 {return v+a}
  return v
}
if !variable_local_exists("grMX") {grMX=v+1; grHX=0}
if v==grMX {v+=grHX}
else {v+=argument2*a*0.5}
v += a*gDeltaTime*0.5
grMX = v
grHX = a*gDeltaTime*0.5
return v
