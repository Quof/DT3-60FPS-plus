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
bCanDealDamage=false
myProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  myProg+=1
  if myProg=1
  {
    var tEffect;
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
  else if myProg=29 {bCanDealDamage=true}
  else if myProg>=30 {speed=12}

  if myProg>=50 {instance_destroy()}
  if !instance_exists(myOwner) {instance_destroy()}
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Collision_oFacCleaner
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(myOwner) //Be sure owner exists
{
  if other.id=myOwner.id
  {
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEfCleanBotElec; tEffect.image_alpha=0.75
    tEffect.image_speed=0.4; tEffect.direction=random(360); tEffect.friction=0.01
    tEffect.speed=random(1)+1; tEffect.fadeSpd=0.01
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=random_range(-5,5)
    if myOwner.bRockForm=0
    {
      playSound(global.snd_Slam,0,0.85,29000)
      myOwner.bRockForm=1
      myOwner.shotTime=0
      myOwner.life+=180
      myOwner.sprite_index=sFacCleanerRock
      myOwner.stunResist=15
      for(i=0;i<6;i+=1)
      {
        myOwner.resType[i]=2
      }
      myOwner.resType[0]=1
      if myOwner.life>myOwner.maxLife {myOwner.life=myOwner.maxLife}
    }
    instance_destroy()
  }
}
