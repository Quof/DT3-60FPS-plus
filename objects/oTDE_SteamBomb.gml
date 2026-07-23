#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.5
bActive=true
bShowHealthBar=false

//Enemy base statistics
eName="CHAOS Siege Steam Bomb"
eLevel=30
maxLife=400
life=maxLife
pointWorth=5
atkPower=6
resType[0]=2
resType[1]=4
stunResist=10
affiliation=7
dieSound=0
dieEffect=0
atkDefense=50
stabilityDmg=1
speedMod=1

runAcc=2.2
bSlowed=0
slowTime=0

jeremyText="Just use turrets on it."
chaoText="N/A"
devText="N/A"

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
eName=string("Lv.") +string(siegeLv) +string(" CHAOS Siege Steam Bomb")

maxLife=400+((siegeLv-1)*200)
life=maxLife
runAcc=2.2+((siegeLv-1)*0.19)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=true and stunnedTime=0 and life>0
  {
    if bSlowed=1
    {
      speed=runAcc/1.5
      slowTime-=1
      if slowTime<=0 {bSlowed=0}
    }
    else {speed=runAcc}
    speed=speed
  }
  else if life<=0
  {
    playSound(global.snd_HardHit1,0,0.98,1)
    tEffect=instance_create(x,y-19,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    oTD_HUD.tdStat_Resources+=1+(6*siegeLv)
    instance_destroy()
  }
  enemyStepEvent()
}
else {speed=0}
