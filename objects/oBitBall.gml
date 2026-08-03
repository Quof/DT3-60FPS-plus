#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkProg=0
bulletSpeed=0
_speed=0
_direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGame.time mod (2/gDeltaTime)=0
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=5; tEffect.sprite_index=sBitBall; tEffect.fadeSpd=0.1
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  }

  _speed=bulletSpeed
  diff=angle_difference(_direction,point_direction(x,y,oPlayer1.x,returnPlayerYCenter()))
  if diff<20 and diff>-20
  {
    if bulletSpeed<6 {bulletSpeed+=0.25*gDeltaTime}
  }
  else
  {
    if bulletSpeed>2 {bulletSpeed-=0.25*gDeltaTime}
  }
  turn_toward_directionUnderscore(point_direction(x,y,oPlayer1.x,returnPlayerYCenter()),3)



  atkProg+=1*gDeltaTime
  if atkProg>=decayTime {instance_destroy()}
}
else _speed=0

correctSpeedDirection(self)
