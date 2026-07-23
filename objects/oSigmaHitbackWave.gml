#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
image_yscale=0.5

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false

maxLife=oSigmaA.largeWaveHP
life=maxLife
atkPower=6
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0

atkProg=0
moveSpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    if atkProg=0 //Go up
    {
      y-=8
      if y<=176 {atkProg=1}
    }
    else if atkProg=1 //Grow
    {
      image_yscale+=0.3
      if image_yscale>=3 {atkProg=2}
    }
    else if atkProg=2 //Fire
    {
      x+=moveSpd
      if image_xscale=1 and moveSpd<7 {moveSpd+=0.2}
      if image_xscale=-1 and moveSpd>-7 {moveSpd-=0.2}
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    for(i=0;i<8;i+=1)
    {
      tEffect=instance_create(x,y-96+(i*24),oEffect); tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    instance_destroy()
  }
  enemyStepEvent()
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
if bTakingDamage=false and other.bCanDealDamage=true and atkProg=2 and life>0
{
  if image_xscale=1
  {
    if moveSpd>=3 {moveSpd=0}
    else if moveSpd>=-5 {moveSpd-=1.5}
  }
  else
  {
    if moveSpd<=-3 {moveSpd=0}
    else if moveSpd<=5 {moveSpd+=1.5}
  }
}
event_inherited()
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
