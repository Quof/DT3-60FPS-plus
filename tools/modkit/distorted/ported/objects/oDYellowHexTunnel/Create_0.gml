/*Requires: spinSpd,changeDelay,moveSpd
--Defaults
spinSpd=-3
changeDelay=0
moveSpd=0
*/
event_inherited()
bActive=1

if !variable_local_exists("spinSpd")
    spinSpd=-4
if !variable_local_exists("changeDelay")
    changeDelay=0
if !variable_local_exists("moveSpd")
    moveSpd=0
if !variable_local_exists("myType")
    myType=1
//Enemy base statistics
atkPower=13

bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
changeTime=0

myGrapplePoint=instance_create(x,y,oStrikeChainPoint)
if room=rYellowRide
{
    myGrapplePoint.image_xscale=3
    myGrapplePoint.image_yscale=3
}
alarm[0]=1
