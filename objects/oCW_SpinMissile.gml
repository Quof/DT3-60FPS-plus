#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: turnDir
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
timeTillIAbortMyself=0
_direction=0
_speed=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  timeTillIAbortMyself+=1*gDeltaTime
  //if timeTillIAbortMyself>=1 and timeTillIAbortMyself<=30
  if timeTillIAbortMyself>0 and timeTillIAbortMyself<=30 //60fps change: covers every frame of tick 1, so it turns and moves as far as at 30fps
  {
    _direction+=turnDir*gDeltaTime
    if sprite_index=sC_MarkBullet and gDeltaDoTicks
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.newBlend=-1; tEffect.fadeSpd=0.04; tEffect.image_speed=0.33
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
  }
  else if timeTillIAbortMyself=31
  {
    _direction=point_direction(x,y,oPlayer1.x,oPlayer1.y)
  }

  image_angle=_direction
  if sprite_index=sC_MarkBullet
  {
    //if timeTillIAbortMyself>=1 and timeTillIAbortMyself<=25 {_speed=3}
    if timeTillIAbortMyself>0 and timeTillIAbortMyself<=25 {_speed=3} //60fps change: see above
    else if timeTillIAbortMyself>=31 {_speed=8}
  }
  else
  {
    //if timeTillIAbortMyself>=1 and timeTillIAbortMyself<=10 {_speed=2.75}
    if timeTillIAbortMyself>0 and timeTillIAbortMyself<=10 {_speed=2.75} //60fps change: see above
    else if timeTillIAbortMyself>=31 {_speed=8}
  }

  if timeTillIAbortMyself>=100 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
