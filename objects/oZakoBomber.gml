#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-34,8,-1)

//Enemy base statistics
eName="CHAOS Bomber"
eLevel=27
maxLife=130
life=maxLife
pointWorth=25
atkPower=7
resType[0]=1
resType[1]=1
stunResist=1
baseItemChance=60
baseDropIndex=90
affiliation=7
dieSound=0
dieEffect=0
inactiveDist*=1.75

gunShot=15
gunDelay=50

deathAnim=0
flyX=0
flyY=0

jeremyText="A stationary unit that launches bombs at you. No worries, these guys are nothing like the Sentries in the Data Segment, they have no coordination at all."
chaoText="These come from 'Contra: Hard Corps' for the Sega Genesis. It's actually the same guy as the Zako Soldier in the original game, but instead of switching weapons, it's just two different bots."
devText="I had thought about giving the CHAOS Soldier a weapon swap behavior, but decided for simplicity's sake, to just divide it to two different enemy types."

if global.CHAOS_Upgrade=1
{
  sprite_index=sCAdvBomber
  eName="CHAOS Advanced Bomber"
  eLevel=35
  maxLife=170
  life=maxLife
  atkPower=9
  pointWorth=47
  jeremyText+=" The advanced version of these give it improved durability and power. Note that they have decent damage output now."
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
  if bActive=true and stunnedTime=0 and life>0
  {
    //Look at player
    if gunShot<=45
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //Fire at player
    gunShot+=1
    if gunShot>=gunDelay
    {
      //Check distance to player
      xThrow=point_distance(x,0,oPlayer1.x,0)/48
      if xThrow>8 {xThrow=8}
      else if xThrow<0.75 {xThrow=0.75}

      var tNewAttack;
      tNewAttack=instance_create(x+(14*image_xscale),y-40,oGravBulletAlt)
      tNewAttack.sprite_index=sNotorBangerBomb; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=1
      tNewAttack.xVel=xThrow*image_xscale; tNewAttack.yVel=-6; tNewAttack.damageType="EXPLOSION"
      tNewAttack.xGrav=0; tNewAttack.yGrav=0.4
      gunShot=0
    }

    yVel+=0.25
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
    deathAnim+=1
    if deathAnim=1
    {
      if global.CHAOS_Upgrade=0 {sprite_index=sZakoSoldierDie}
      else {sprite_index=sCAdvSoldierDie}
      if random(100)<=4 {global.recHeardWilhelm+=1; playSound(global.snd_Wilhelm,0,0.95,1)}
      flyX=2*-image_xscale; flyY=-4
    }
    x+=flyX; y+=flyY
    flyY+=0.33
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
