#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)

drillTime=255
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the Pincher Bot is drilling into the switch
if global.gamePaused=false
{
  if isCollisionCharacterLeft(2,oPincherBot) or isCollisionCharacterRight(2,oPincherBot)
  {
    drillTime-=1.5
    if drillTime<=0
    {
      awardAwesome(400)
      var tEffect;
      tEffect=instance_create(x+16,y+16,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      playSound(global.snd_BombExplode,0,0.92,18000)
      instance_destroy()
    }
  }
  else
  {
    if drillTime<255
      drillTime+=1.5
  }
  image_blend=make_color_rgb(255,drillTime,drillTime)

  yVel+=0.2
  if isCollisionBottom(1)
    yVel=0
  if yVel>12
    yVel=12
  if y>room_height+24
    instance_destroy()
}
