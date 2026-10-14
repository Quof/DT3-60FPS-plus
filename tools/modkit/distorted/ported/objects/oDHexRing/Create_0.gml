/*Requires: spinSpd,changeDelay,moveSpd
--Defaults
spinSpd=-3
changeDelay=0
moveSpd=0
*/
event_inherited()
bActive=1

//Enemy base statistics
if global.gameProgress>=4930 {atkPower=12}
else {atkPower=10}

if room=rWarshipZ_A or room=rWarshipZ_B
{
  atkPower=14
}
if room=rHexPlat4 or room=rHexPlat42 or room=rHexPlat43 or room=rHexPlat4_old
{
    atkPower=77
}
bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
changeTime=0
// spsp should work and stay to be consistent with other rings
if !variable_local_exists("spinSpd")
    spinSpd=-4
if !variable_local_exists("changeDelay")
    changeDelay=0
if !variable_local_exists("moveSpd")
    moveSpd=0

if variable_local_exists("moveDelay")
{
    changeDelay=moveDelay
}

alarm[0]=1
