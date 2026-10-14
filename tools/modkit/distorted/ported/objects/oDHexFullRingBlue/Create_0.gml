/*Requires: spinSpd,changeDelay,moveSpd
--Defaults
spinSpd=-3
changeDelay=0
moveSpd=0
*/
event_inherited()
bActive=1
rockBounce=0
rockTime=0
rockY=0
rockFix=0

distortionTime=0

//Enemy base statistics
if global.gameProgress>=4930 {atkPower=12}
else {atkPower=10}
bCanTakeDamage=false
bCauseKnockback=true
if room=rLC_LowerPassage {bCauseKnockback=false}
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
//spsp: cons(rya

if room=rAbomD or room=rAbomE or room=rAbomF
{
    spinSpd=-1
    changeDelay=0
    moveSpd=0
}
else if global.location=110 and room!=rDistFinal_Round3
{
    spinSpd=-3
    changeDelay=0
    moveSpd=0
}

alarm[0]=1
