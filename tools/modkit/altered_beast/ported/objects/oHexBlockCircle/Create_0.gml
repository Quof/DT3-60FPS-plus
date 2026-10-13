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
bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
changeTime=0
