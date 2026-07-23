#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_index=1

//Enemy base statistics
eName="CHAOS Air Gunner"
eLevel=27
maxLife=115
life=maxLife
pointWorth=30
atkPower=7
resType[0]=1
resType[1]=1
stunResist=2
baseItemChance=55
baseDropIndex=85
affiliation=7
dieSound=0
dieEffect=0
runAcc=2
xVel=0

gunShot=15
gunDelay=45

deathAnim=0

jeremyText="These guys, like their other CHAOS buddies, are pretty straight forward. It will try to keep a bit of distance while shooting at you and will never change its altitude."
chaoText="The sprite is from Contra: Hard Corps."
devText="For this chapter, I was going for more of an arcade kind of feel. With mostly run and gun, quick encounters. Where most enemies die quickly but deal out moderate to high damage."
extraInfo="Has a jetpack!"

if global.CHAOS_Upgrade=1
{
  sprite_index=sCAdv_AirGunner
  eName="CHAOS Advanced Air Gunner"
  eLevel=35
  maxLife=185
  life=maxLife
  atkPower=9
  pointWorth=61
  jeremyText+=" The advanced version of these give it improved durability and power."
}
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
    if bActive=true and stunnedTime=0
    {
      //Facing direction
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
      //Look up or down
      if point_distance(0,y,0,returnPlayerYCenter())<28 {image_index=1}
      else
      {
        if y<oPlayer1.y-26 {image_index=2}
        else {image_index=0}
      }
      //Movement
      if point_distance(x,0,oPlayer1.x,0)<82
      {
        if image_xscale=1 {direction=180}
        else {direction=0}
        speed=runAcc/1.5
      }
      else if point_distance(x,0,oPlayer1.x,0)>74 and point_distance(x,0,oPlayer1.x,0)<80 {speed=0}
      else
      {
        if image_xscale=1 {direction=0}
        else {direction=180}
        speed=runAcc
      }
      //Attack
      gunShot+=1
      if gunShot=gunDelay-8 //Fire warning
      {
        var tEffect,tXadj,tYadj;
        if image_index=0 {tXadj=8; tYadj=32}
        else if image_index=1 {tXadj=14; tYadj=21}
        else if image_index=2 {tXadj=13; tYadj=7}
        tEffect=instance_create(x+(tXadj*image_xscale),y-tYadj,oEffect)
        tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
        tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
      }
      if gunShot>=gunDelay //Fire at player when ready
      {
        var tNewAttack,tXadj,tYadj;
        if image_index=0 {tXadj=8; tYadj=32}
        else if image_index=1 {tXadj=14; tYadj=21}
        else if image_index=2 {tXadj=13; tYadj=7}
        tNewAttack=instance_create(x+(tXadj*image_xscale),y-tYadj,oPassBullet)
        tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5
        tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(tXadj*image_xscale),y-tYadj,oPlayer1.x,returnPlayerYCenter())
        gunShot=0
      }
    }
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      if global.CHAOS_Upgrade=0 {sprite_index=sCHAOS_AirDie}
      else {sprite_index=sCAdv_AirDie}
      if random(100)<=4 {global.recHeardWilhelm+=1; playSound(global.snd_Wilhelm,0,0.95,1)}
      flyX=1.5*-image_xscale
    }
    x+=flyX; y+=0.5
    image_angle+=2*-image_xscale
    image_alpha-=0.035
    if image_alpha<0
    {
      playSound(global.snd_HardHit1,0,0.98,1)
      tEffect=instance_create(x,y-17,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.5; tEffect.image_alpha=0.75
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
  enemyStepEvent()
}
else {speed=0}
