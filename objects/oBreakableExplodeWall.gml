#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
offsetX=0
offsetY=0
explodeDelay=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("xSet") {offsetX=xSet}
if variable_local_exists("ySet") {offsetY=ySet}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if explodeDelay>0
  {
    explodeDelay+=1
    if explodeDelay>=3
    {
      awardAwesome(10)
      var tEffect;
      tEffect=instance_create(x+8,y+8,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.followID=-1; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.85,1)}
      newAttack=instance_create(x+8,y+8,oFieldBlast)
      newAttack.image_xscale=0.3; newAttack.image_yscale=0.15; newAttack.animSpd=1; newAttack.visible=0
      newAttack=instance_create(x+8,y+8,oFieldBlast)
      newAttack.image_xscale=0.15; newAttack.image_yscale=0.3; newAttack.animSpd=1; newAttack.visible=0
      instance_destroy()
    }
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="EXPLOSION" and explodeDelay=0 //Blow up wall
{
  sprite_index=sNull
  visible=0
  explodeDelay=1
}
if other.damageType!="EXPLOSION" and explodeDelay=0 //Cause effect when hit by something other than explosive damage
{
  var tEffect;
  tEffect=instance_create(x+8,y+8,oEffectB)
  tEffect.type=4; tEffect.sprite_index=sBelmontWepEffect; tEffect.newBlend=-1; tEffect.image_speed=0.33
  tEffect.direction=random(360); tEffect.speed=random(3)+2
  tEffect.AccelX=-0.25; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_background_part(bwBack,bwLeft,bwTop,bwWidth,bwHeight,x+offsetX,y+offsetY)
