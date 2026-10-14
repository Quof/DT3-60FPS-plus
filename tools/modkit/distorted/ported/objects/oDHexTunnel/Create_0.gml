/*Requires: spinSpd,changeDelay,moveSpd
--Defaults
spinSpd=-4
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

//Enemy base statistics
if global.gameProgress>=4930 {atkPower=12}
else {atkPower=10}

if room=rWarshipZ_A or room=rWarshipZ_B or room=rWarshipZ_C
{
  atkPower=14
}
//else if room=rHexPlat43 {indTime=0} //for DDLC
if room=rHexPlat4 or room=rHexPlat42 or room=rHexPlat43 or room=rHexPlat4_old
{
    atkPower=13
}
if room=rHexPlat4
{
    spinSpd=(irandom(2)+1)*(irandom(1)*2-1)
    changeDelay=2000
    moveSpd=4
    //direction=180
    _direction=180 //60fps change: DT3+'s _direction
    image_angle=irandom(359)
}
else if room=rReckoningOne
{
    atkPower=17
}
bCanTakeDamage=false
bCauseKnockback=true
bShowHealthBar=false
changeTime=0
if variable_local_exists("moveDelay")
{
    changeDelay=moveDelay
}
if room=rCh21_WarshipSkies
{
    spinSpd=2; atkPower=14; image_xscale=0.5; image_yscale=0.5
    if oEvCh21Falling.sceneProgress=6 {image_xscale=0.4; image_yscale=0.4}
}
else if room=rDragoonMapA
{
    image_xscale=1.5
    image_yscale=1.5
}
sizeCheck=1

alarm[0]=1
