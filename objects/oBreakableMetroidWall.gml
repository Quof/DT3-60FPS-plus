#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
bHit=0
xAdj=0
yAdj=0
breakFrameFix=0
image_speed=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("xMove") {xAdj=xMove}
if variable_local_exists("yMove") {yAdj=yMove}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if breakFrameFix=1 {breakFrameFix=2}
  else if breakFrameFix>=2
  {
    awardAwesome(10)
    if spIndex=sMetroidBlockBreak
    {
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMetroidBlockBreak; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
    else if spIndex=sMetroidBlockHit
    {
      tEffect=instance_create(x+8,y+8,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
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
if spIndex=sMetroidBlockHit
{
  if bHit=0 {bHit=1}
}
else if spIndex=sMetroidBlockBreak and breakFrameFix=0 {breakFrameFix=1}
#define Collision_oSamusMissile
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bHit=0 {bHit=1}
if spIndex=sMetroidBlockHit and spImage=1 and breakFrameFix=0
{
  breakFrameFix=1
}
else if spIndex=sMetroidBlockHit and other.sprite_index=sSamusSuperMissile and spImage=2 and breakFrameFix=0
{
  breakFrameFix=1
}
#define Collision_oSamusBExplosion
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bHit=0 {bHit=1}
if spIndex=sMetroidBlockHit and spImage=0
{
  awardAwesome(10)
  tEffect=instance_create(x+8,y+8,oEffect)
  tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_destroy()
}
#define Collision_oDiffusionBlast
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bHit=0 {bHit=1}
if spIndex=sMetroidBlockHit and spImage=2 and breakFrameFix=0
{
  breakFrameFix=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bHit=0 {draw_background_part(bwBack,bwLeft,bwTop,bwWidth,bwHeight,x+xAdj,y+yAdj)}
else if bHit=1 {draw_sprite(spIndex,spImage,x+xAdj,y+yAdj)}
