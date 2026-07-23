#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bDestroyed=0
myColor=255
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false and bDestroyed=1
{
  myColor-=5
  image_blend=make_color_rgb(255,myColor,myColor)
  if myColor>=165 //Fire effect
  {
    if oGame.time mod 7=0 //Burn sound
    {
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_Fireball,0,0.8,1)}
    }
    if sprite_index=sBW_DestPropB {modTime=4}
    else modTime=2
    if oGame.time mod modTime=0 //Fire effect
    {
      tEffect=instance_create(x+8+random(sprite_width-16),y+6+random(sprite_height-12),oEffect)
      tEffect.sprite_index=sFlameUp; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.25+random(0.25); tEffect.depth=30
    }
  }

  if myColor<=100 //Destroy
  {
    if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.9,1)}
    tEffect=instance_create(x+(sprite_width/2),y+(sprite_height/2),oEffect)
    tEffect.sprite_index=sShipExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
    tEffect.image_xscale=1.75; tEffect.image_yscale=1.75; tEffect.depth=30; tEffect.image_alpha=0.9
    instance_destroy()
  }
}
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (other.damageType="ELEMENTAL" or other.damageType="SHOT" or other.damageType="EXPLOSION") and other.weaponTag<100 and bDestroyed=0
{
  global.recPlantsBurned+=1
  awardAwesome(50)
  bDestroyed=1
}
