#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
maxLife=150
life=maxLife
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if other.damageType!="NORMAL"
  {
    life-=other.atkPower
    if other.damageType!="EXPLOSION"
    {
      playSound(global.snd_EnemyHitMM,0,1,1)
      with other {instance_destroy()}
    }
    if life<=0
    {
      awardAwesome(20)
      if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.9,1)}
      newAttack=instance_create(x+8,y+32,oFieldBlast)
      newAttack.image_xscale=0.66; newAttack.image_yscale=1.6; newAttack.animSpd=0.9; newAttack.visible=0

      tEffect=instance_create(x+8,y+12,oEffect); tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x+8,y+32,oEffect); tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect=instance_create(x+8,y+52,oEffect); tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
}
