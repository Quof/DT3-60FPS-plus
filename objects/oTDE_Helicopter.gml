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
eName="CHAOS Siege Helicopter"
eLevel=31
maxLife=1200
life=maxLife
pointWorth=10
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

runAcc=2.05
bSlowed=0
slowTime=0

bladeFrm=0

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

maxLife=1200+((siegeLv-1)*600)
life=maxLife
runAcc=2.05+((siegeLv-1)*0.13)
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
    if direction>=90 and direction<270 {image_xscale=-1}
    else {image_xscale=1}

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
    tEfCir=instance_create(x,y-19,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=8; tEfCir.radScl=4; tEfCir.fadeSpeed=0.05
    oTD_HUD.tdStat_Resources+=4+(16*siegeLv)
    instance_destroy()
  }
  enemyStepEvent()
}
else {speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bladeFrm+=0.25
draw_sprite_ext(sTDE_SH_Blades,bladeFrm,x+(8*image_xscale),y-23,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
