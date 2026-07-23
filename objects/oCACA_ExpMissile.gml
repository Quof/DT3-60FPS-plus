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
    speed=bulletSpeed
    image_angle=direction
    straightTime-=1
    if straightTime<=0 {missProg=1}
  }
  else if missProg=1
  {
    image_angle+=5
    timeTillLaunch-=1
    if timeTillLaunch=10
    {
      direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
      explodePointX=oPlayer1.x
      explodePointY=returnPlayerYCenter()
    }
    if timeTillLaunch<=0
    {
      playSound(global.snd_CShotB,0,0.93,1)
      bulletSpeed=11
      missProg=2
    }
  }
  else if missProg=2
  {
    speed=bulletSpeed
    image_angle=direction

    if point_distance(x,y,explodePointX,explodePointY)<bulletSpeed
    {
      newAttack=instance_create(x,y,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
      newAttack.image_xscale=1.25; newAttack.image_yscale=1.25; newAttack.decayTime=-100
      instance_destroy()
    }
  }
}
else {speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if missProg=2
{
  pointFrm+=0.2
  draw_sprite_ext(sChaoTarget,pointFrm,explodePointX,explodePointY,1.25,1.25,0,c_white,0.75)
}
event_inherited()
