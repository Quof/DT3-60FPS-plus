#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
warTarget=oCHAOS_Warmaster_Main
if room=rWarshipZ_E3
{
  if global.bBossGallery=1 {warTarget=oCHAOS_Warmaster_EX}
  else {warTarget=oFedex}
}
else if room=rBT_WarmasterA {warTarget=oCHAOS_Warmaster_Fixed}

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
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=moveSpd*image_xscale
  atkTime+=1
  if atkTime=3 {image_index=1}
  else if atkTime=6 {image_index=2}
  else if atkTime=9 {image_index=3}
  else if atkTime=12 {image_index=4}
  else if atkTime>=15 {instance_destroy()}
}
