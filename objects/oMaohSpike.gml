#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 and oMaohTheGiant.spikeLeftSeq=2
{
  oMaohTheGiant.spikeLeftTime=0
  oMaohTheGiant.spikeLeftSeq=3
}
else if type=2 and oMaohTheGiant.spikeRightSeq=2
{
  oMaohTheGiant.spikeRightTime=0
  oMaohTheGiant.spikeRightSeq=3
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Collision_oAttackBase
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.damageType="PIERCE" or other.damageType="SHOT" or other.damageType="ELEMENTAL"
{
  playSound(global.snd_MMBulletDeflect,0,1,1)
  var tEffect;
  tEffect=instance_create(other.x,other.y,oEffect)
  tEffect.sprite_index=sMMchargeComplete
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  with other {instance_destroy()}
}
#define Collision_oMaohBreakPlatform
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1 and (oMaohTheGiant.spikeLeftSeq=2 or oMaohTheGiant.spikeLeftSeq=3)
{
  with other
  {
    var tEffect;
    for(i=0;i<5;i+=1)
    {
      tEffect=instance_create(x+random(32),y+random(16),oEffectGrav)
      tEffect.sprite_index=sMaohDebris; tEffect.image_speed=0; tEffect.image_index=choose(0,1,2)
      tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-3-random(1)
      tEffect.grav=0.5; tEffect.type=2; tEffect.fadeSpd=0.08
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1; tEffect.rotation=0
    }
    instance_destroy()
  }
  oMaohTheGiant.spikeLeftTime=0
  oMaohTheGiant.spikeLeftSeq=4
}
else if type=2 and (oMaohTheGiant.spikeRightSeq=2 or oMaohTheGiant.spikeRightSeq=3)
{
  with other
  {
    var tEffect;
    for(i=0;i<5;i+=1)
    {
      tEffect=instance_create(x+random(32),y+random(16),oEffectGrav)
      tEffect.sprite_index=sMaohDebris; tEffect.image_speed=0; tEffect.image_index=choose(0,1,2)
      tEffect.xSpd=random_range(-2,2); tEffect.ySpd=-3-random(1)
      tEffect.grav=0.5; tEffect.type=2; tEffect.fadeSpd=0.08
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1; tEffect.rotation=0
    }
    instance_destroy()
  }
  oMaohTheGiant.spikeRightTime=0
  oMaohTheGiant.spikeRightSeq=4
}
