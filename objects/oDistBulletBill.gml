#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
eName="Distorted Bullet Bill"
eLevel=40
maxLife=5000
life=maxLife
pointWorth=2
atkPower=12
resType[1]=2
resType[2]=5
resType[3]=1
resType[4]=5
stunResist=50
affiliation=1
dieEffect=0
detectDistX=128
actProg=0
ySpd=0

jeremyText=""
chaoText=""
devText=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and life>0
  {
    actProg+=1
    if actProg=1
    {
      visible=1
      playSound(global.snd_MarioCannon,0,0.88,14000)
    }
    else if actProg>=4
    {
      if xSpd>0.5 {xSpd-=0.1}
      else if xSpd<-0.5 {xSpd+=0.1}

      if ySpd<4 {ySpd+=0.2}
    }
    x+=xSpd
    y+=ySpd
  }
  else if life<=0
  {
    tEffect=instance_create(x,y,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
#define Collision_oSolid
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if actProg>=10
{
  life=0
}
