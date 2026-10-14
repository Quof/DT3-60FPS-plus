warTarget=oCHAOS_Warmaster_Main
if room=rWarshipZ_E3
{
  if global.bBossGallery=1 {warTarget=oCHAOS_Warmaster_EX}
  else {warTarget=oFedex}
}
else if room=rBT_WarmasterA or room=rFinalCurse or room=rSerasFunhouse {warTarget=oCHAOS_Warmaster_Fixed}  //spsp

//Flame Ground Trail
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkTime=0
if warTarget.DIFFICULTY=1 {moveSpd=7}
else
{
  moveSpd=8
  if warTarget=oCHAOS_Warmaster_EX
  {
    if oCHAOS_Warmaster_EX.ATTACK_FORM=2
    {
      if image_xscale=1.1 {moveSpd=13}
      else if image_xscale=1.3 {moveSpd=11}
      else if image_xscale=1.6 {moveSpd=9}
    }
  }
  else if warTarget=oFedex
  {
    if oFedex.ATTACK_FORM=2
    {
      if image_xscale=1.1 {moveSpd=13}
      else if image_xscale=1.3 {moveSpd=11}
      else if image_xscale=1.6 {moveSpd=9}
    }
  }
}
