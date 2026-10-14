// Requires: turbulance, shakeTime (-1 for infinite)
if instance_number(oVarViewShaker)>1 {instance_destroy(); exit}
phasecheck=0 //spsp ns
if room!=rDistortedAbom or !instance_exists(oDAbomMain) //spsp ns
{
x=oPlayer1.x
y=oPlayer1.y
view_object[0]=oVarViewShaker
}
else
{
  if oDAbomMain.spinPhase<oDAbomMain.lastCameraPhase
  {
    x=oDAbomMain.MyCamera.x
    y=oDAbomMain.MyCamera.y
    view_object[0]=oVarViewShaker
    phasecheck=1
  }
  else
  {
    x=oPlayer1.x
    y=oPlayer1.y
    view_object[0]=oVarViewShaker
  }
}
shakeAmt=0
