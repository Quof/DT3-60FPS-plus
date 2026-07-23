#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-20,-40,20,-1)
image_speed=0.33
bActive=true
bShowHealthBar=false

//Enemy base statistics
eName="CHAOS Siege Beast Tank"
eLevel=33
maxLife=6000
life=maxLife
pointWorth=50
atkPower=6
resType[0]=2
stunResist=50
affiliation=7
dieSound=0
dieEffect=0
atkDefense=50
stabilityDmg=7
speedMod=1

runAcc=1.65
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
eName=string("Lv.") +string(siegeLv) +string(" CHAOS Siege Beast Tank")

maxLife=6000+((siegeLv-1)*6000)
life=maxLife
runAcc=1.65+((siegeLv-1)*0.09)
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
      xVel=(runAcc*image_xscale)/1.5
      slowTime-=1
      if slowTime<=0 {bSlowed=0}
    }
    else {xVel=runAcc*image_xscale}
    xVel=xVel

    yVel+=0.3
    if isCollisionBottom(1)
      yVel=0
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
    if y>room_height+24
      instance_destroy()
  }
  else if life<=0
  {
    playSound(global.snd_HardHit1,0,0.98,1)
    tEffect=instance_create(x,y-55,oEffect)
    tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    oTD_HUD.tdStat_Resources+=150+(250*siegeLv)
    instance_destroy()
  }
  enemyStepEvent()
}
