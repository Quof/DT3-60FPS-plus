#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: timeTillLaunch
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="EXPLOSION"
bulletSpeed=3
pointFrm=0
missProg=0
straightTime=20
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
  if missProg=0
  {
    _speed=bulletSpeed
    image_angle=_direction
    //straightTime-=1
    straightTime-=1*gDeltaTime //60fps change: was never scaled, so missiles only flew straight for 5 ticks (instead of 20) at 120fps before curling
    if straightTime<=0 {missProg=1}
  }
  else if missProg=1
  {
    image_angle+=5*gDeltaTime
    timeTillLaunch-=1*gDeltaTime
    if timeTillLaunch=10
    {
      _direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      explodePointX=oPlayer1.x
      explodePointY=returnPlayerYCenter()
    }
    if timeTillLaunch<=0
    {
      playSound(global.snd_CShotB,0,0.93,1)
      bulletSpeed=11
      missProg=2
      emTk=0 //60fps change (added): counts this missile's 30fps ticks since launch (see missProg 2)
    }
  }
  else if missProg=2
  {
    _speed=bulletSpeed
    image_angle=_direction

    //if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed
    if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed and frac(emTk)=0 //60fps change: checked once per 30fps tick (before that tick's move) like at 30fps; checked every frame it always blew up 8-11px before the target point
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
      newAttack.image_xscale=1.25; newAttack.image_yscale=1.25; newAttack.decayTime=-100
      instance_destroy()
    }
    emTk+=gDeltaTime //60fps change (added)
  }
}
else {_speed=0}

correctSpeedDirection(self)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if missProg=2
{
  //pointFrm+=0.2
  pointFrm+=0.2*gDeltaTime //60fps change: Draw runs every frame, so the target marker animated 2x/4x as fast
  draw_sprite_ext(sChaoTarget,pointFrm,explodePointX,explodePointY,1.25,1.25,0,c_white,0.75)
}
event_inherited()
