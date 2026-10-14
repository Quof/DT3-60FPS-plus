event_inherited()
bActive=1

//Enemy base statistics
if global.gameProgress>=4930 {atkPower=12}
else {atkPower=10}

if room=rWarshipZ_A or room=rWarshipZ_B
{
  atkPower=14
}
/*
spinSpd=-12
changeDelay=0
moveSpd=0
*/
bCanTakeDamage=false
bCauseKnockback=false
bShowHealthBar=false
changeTime=0
if variable_local_exists("moveDelay")
{
    changeDelay=moveDelay
}

if !variable_local_exists("spinSpd")
    spinSpd=-4
if !variable_local_exists("changeDelay")
    changeDelay=0
if !variable_local_exists("moveSpd")
    moveSpd=0
