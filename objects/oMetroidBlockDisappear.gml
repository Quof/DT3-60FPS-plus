#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(0,0,sprite_width,sprite_height)

bHit=0
breakTime=0
breakDelay=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //If the character is standing on the platform, it breaks
  if isCollisionCharacterTop(1,0) and breakTime=0 and breakDelay=0
  {
    breakDelay=3
    bHit=1
  }
  //Break delay after player stands on it
  if breakDelay>0
  {
    breakDelay-=1
    if breakDelay=0
    {
      tEffect=instance_create(x+4,y+4,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x+4,y+12,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x+12,y+4,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x+12,y+12,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      sprite_index=sNull
      breakTime=45
    }
  }
  //Reassemble block after time
  if breakTime>0
  {
    breakTime-=1
    if breakTime=0 {sprite_index=sMetroidBlockDisappear}
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bHit=0 {bHit=1}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if breakTime=0
{
  if bHit=0 {draw_background_part(bwBack,bwLeft,bwTop,bwWidth,bwHeight,x,y)}
  else if bHit=1 {draw_sprite(sMetroidBlockDisappear,0,x,y)}
}
