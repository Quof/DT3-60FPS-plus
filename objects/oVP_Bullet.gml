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
atkPower=9
bCanGraze=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=bulletSpeed
  if bCanGraze=1
  {
    if point_distance(x,y,oIdentifier.x,oIdentifier.y)<21
    {
      playSound(global.snd_Bite,0,0.95,70000)
      var tEffect;
      for(i=0;i<4;i+=1)
      {
        tEffect=instance_create(x,y,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfDiffusionParticle; tEffect.direction=random(360)+(i*90); tEffect.speed=4; tEffect.newBlend=-1
        tEffect.fadeSpd=0.1; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.friction=0.33
      }
      oIdentifier.degradeDelay=20
      oIdentifier.chaoGraze+=50
      if oIdentifier.chaoGraze>oIdentifier.chaoGrazeMax {oIdentifier.chaoGraze=oIdentifier.chaoGrazeMax}
      bCanGraze=0
    }
  }
}
else {speed=0}
#define Collision_oIdentifier
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true and global.gamePaused=false
{
  with oPlayer1
    hitPlayer(other.id)
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
