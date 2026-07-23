#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-14,-14,14,14)

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"

fireProg=0
moveSpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  tRanSize=random(0.2)
  tEffect=instance_create(x-(16*image_xscale)+random(32*image_xscale),y-(16*image_yscale)+random(32*image_yscale),oEffect)
  tEffect.sprite_index=choose(sSamusCannonHit,sSamusMissileHit)
  tEffect.image_xscale=0.3+tRanSize; tEffect.image_yscale=0.3+tRanSize
  tEffect.image_alpha=0.4+random(0.2); tEffect.image_speed=0.4+random(0.3)
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  tEffect.image_blend=make_color_rgb(16,98,240)

  trackTime-=1
  if fireProg=0 //Track player x
  {
    if y>oVaultDemon.moveYcenter-96 {y-=2}

    if x>oPlayer1.x {if moveSpd>-5.5 {moveSpd-=0.5}}
    else if x<oPlayer1.x {if moveSpd<5.5 {moveSpd+=0.5}}
    x+=moveSpd
    image_angle+=-moveSpd*2
    if trackTime<=0 {trackTime=20; fireProg+=1}
  }
  else if fireProg=1 //Slight wait
  {
    if trackTime<=0 {yVel=1; fireProg+=1}
  }
  else if fireProg=2 //Fall to ground and explode
  {
    if yVel<16 {yVel+=0.4}
    moveTo(xVel,yVel)
    if isCollisionBottom(1)
    {
      newAttack=instance_create(x,bbox_bottom,oDamageExplosion)
      newAttack.atkPower=atkPower; newAttack.sprite_index=sBTFirePillar; newAttack.decayTime=-100; newAttack.image_speed=0.5
      newAttack.image_xscale=1.5+(oVaultDemon.bossProgress/10); newAttack.image_yscale=1.5+(oVaultDemon.bossProgress/10)
      newAttack.image_blend=make_color_rgb(16,98,240)
      instance_destroy()
    }
    if y>room_height+32 {instance_destroy()}
  }
}
