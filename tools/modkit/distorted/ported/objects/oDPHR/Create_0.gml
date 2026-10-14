spinSpd=-1
changeDelay=0
moveSpd=0
image_xscale=.2
image_yscale=.2
event_inherited()
bActive=1

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
