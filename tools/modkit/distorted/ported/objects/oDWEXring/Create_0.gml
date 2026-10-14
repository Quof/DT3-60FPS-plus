/*Requires: spinSpd,changeDelay,moveSpd
--Defaults
spinSpd=-3
changeDelay=0
moveSpd=0
*/
event_inherited()
bActive=1

//Enemy base statistics
atkPower=16

bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
changeTime=0

if !variable_local_exists("spinSpd")
    spinSpd=4
if !variable_local_exists("changeDelay")
    changeDelay=0
if !variable_local_exists("moveSpd")
    moveSpd=0
