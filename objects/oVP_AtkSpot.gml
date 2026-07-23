#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.6
decayTime=180
shotDelay=0

var tEffect,tDir;
tDir=0
for(i=0;i<24;i+=1)
{
  tEffect=instance_create(x+lengthdir_x(18,tDir),y+lengthdir_y(18,tDir),oEffect)
  tEffect.sprite_index=sEfDiffusionParticle; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.33
  tEffect.image_speed=0.5; tEffect.speed=1.5; tEffect.direction=tDir
  tDir+=360/24
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  if shotDelay>0 {shotDelay-=1}

  decayTime-=1
  if decayTime<=0
  {
    image_alpha-=0.1
    if image_alpha<=0 {instance_destroy()}
  }
}
#define Collision_oIdentifier
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if decayTime>0 and shotDelay=0
{
  decayTime-=5
  shotDelay=3
  var tNewAttack,tDir,tFindClosest;
  if room=rAbomF {tFindClosest=oVirusParasite_Main}
  else
  {
    if instance_exists(oAbom_ParaBlock) {tFindClosest=instance_nearest(x,y,oAbom_ParaBlock)}
    else {tFindClosest=oPlayer1}
  }
  tDir=point_direction(oIdentifier.x,oIdentifier.y,tFindClosest.x,tFindClosest.y)
  tNewAttack=instance_create(oIdentifier.x,oIdentifier.y,oVP_ChaoBullet)
  tNewAttack.direction=tDir; tNewAttack.image_angle=tDir
}
