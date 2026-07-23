#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2
image_xscale=-1
bCanDealDamage=0
bShowHealthBar=0

//Enemy base statistics
eName="Distorted Organ"
eLevel=40
maxLife=1
life=maxLife
stunResist=50
resType[1]=1
resType[5]=1
affiliation=8
dieSound=0
dieEffect=0
inactiveDist=10000

tentaclesTime=0
tentaclesFrm=0

jeremyText=""
chaoText=""
devText=""
extraInfo=""

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)

  if life>0
  {
    tentaclesTime+=1
    if tentaclesTime=11 {tentaclesFrm=1}
    else if tentaclesTime=22 {tentaclesFrm=2}
    else if tentaclesTime=33 {tentaclesFrm=1}
    else if tentaclesTime>=44 {tentaclesFrm=0; tentaclesTime=0}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      image_speed=0
      playSound(global.snd_DistStatic,0,1,1)
      playSound(global.snd_HardHit1,0,1,1)
      tEfCir=instance_create(x,y,oDist_CircleInvert)
    }

    if deathAnim mod 4=0
    {
      if deathAnim mod 8=0 {playSound(global.snd_BombExplode,0,0.8,1)}
      tEffect=instance_create(x+random_range(-10,10),y-1-random(42),oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.04
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sDist_TentaclesA,tentaclesFrm,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
