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
//delayFrame = 2.25//2 was too little, 2.5 was too much, lol. Delays the explosion attack from taking the next one too soon.
delayFrame = 0 //60fps change: an explosion's damage is per 30fps tick now (Collision below), so a chain takes the 30fps time at every frame rate; the 2.25-tick delay only matched at 120fps (60fps was 3.75 ticks a canister, the original 3)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if (life <= 0)
  {
      if (delayFrame > 0)//andrew addition, the attack spawned has to be delayed a certain amount to match with 30FPS original
      {
        delayFrame -= gDeltaTime
      }
      else
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
    //life-=other.atkPower
    if other.damageType="EXPLOSION" {life-=other.atkPower*gDeltaTime} else {life-=other.atkPower} //60fps change: an explosion stays on the canister and hits it every frame (2x/4x a tick at 60/120fps); per tick as at 30fps. Other attacks are destroyed on the hit
    if other.damageType!="EXPLOSION"
    {
      playSound(global.snd_EnemyHitMM,0,1,1)
      with other {instance_destroy()}
    }
    if life<=0 {event_perform(ev_step,ev_step_normal)} //60fps change (added): it explodes on the hit that breaks it, as at 30fps (the Step event's explosion, its delay 0), not a frame later
  }
}
