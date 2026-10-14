/*
** Requires shiftTime, shiftMax, moveSpd, bShowLine

** shiftTime: Starting time
** shiftMax: Max distance
** moveSpd: Move speed
** bShowLine: Show movement line
** ** If true - Needs: offsetX, offsetY
*/
event_inherited()

//Enemy base statistics
if global.location=99
{
  if room=rWarshipM or room=rWarshipB {atkPower=10} //spsp ns
  if room=rWarshipM {depth=10} //spsp ns
  else if room=rDCS_R {atkPower=12} //spsp ns
  else if room=rWarshipZ_A or room=rWarshipZ_B or room=rWarshipZ_C or room=rWarshipZ_D or room=rWarshipZ_H
  {
    atkPower=14
  }
  else
  {
    sprite_index=sWS_RedSpikeBall
    atkPower=12
  }
}
else {atkPower=10}
damageType="ELEMENTAL"
initDir=_direction
bCanTakeDamage=false
bShowHealthBar=false

alarm[0]=1
