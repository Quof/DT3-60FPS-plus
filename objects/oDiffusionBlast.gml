#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-6,-2,6,2)
image_speed=0.5

damageType="SPECIAL"
weaponTag=41
atkLv=global.stSamus_Missile[0]
atkPower=75+global.stSamus_Missile[0]+global.skillTree[13]
atkPower=weaponDmgMod(1,atkPower)
stunTime=12
weaponRehitTime=30
bCanPierce=1
blastDamage=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if blastDamage=0 //Start splash
  {
    for(i=0;i<4;i+=1)
    {
      tEffect=instance_create(x,y,oEffectC)
      tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.5; tEffect.depth=6; tEffect.newBlend=-1; tEffect.followID=-1
      tEffect.rotation=0; tEffect.moveArc=6; tEffect.fadeSpd=0.05; tEffect.scaleSpd=0
      tEffect.speed=3; tEffect.direction=90*(i+1)
      tEffect=instance_create(x,y,oEffectC)
      tEffect.sprite_index=sEfDiffusionParticle; tEffect.image_speed=0.5; tEffect.depth=6; tEffect.newBlend=-1; tEffect.followID=-1
      tEffect.rotation=0; tEffect.moveArc=-6; tEffect.fadeSpd=0.05; tEffect.scaleSpd=0
      tEffect.speed=3; tEffect.direction=270-(90*i)
    }

    atkPower=75+(global.stSamus_Missile[0]*2)+global.skillTree[13]
    sprite_index=sSamusDiffusionBlast; depth=9
    image_index=0; image_speed=0
    image_xscale=2; image_yscale=2
    speed=0
    blastDamage=10
  }
  else if blastDamage>=10 //Diffusion blast
  {
    blastDamage+=1
    if blastDamage=13 {image_index=1}
    else if blastDamage=16 {image_index=2}
    else if blastDamage=19 {image_index=3}
    else if blastDamage=22 {image_index=4}
    else if blastDamage=25 {instance_destroy()}
  }
}
#define Collision_oDamagableBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.bTakingDamage=false and bCanDealDamage=true and other.bActive=true
{
  if sprite_index=sSamusSuperMissile and blastDamage=0 {blastDamage=1}
}
