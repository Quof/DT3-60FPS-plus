#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-34,8,-1)
image_speed=0.22

//Enemy base statistics
eName="CHAOS Soldier"
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

initDir=0
runAcc=2.25
bJumpReady=1
gunShot=15
gunDelay=35

deathAnim=0
flyX=0
flyY=0

jeremyText="These have behavior similar to the Green Orcs, except that they'll stop getting closer at times, and when they are stationary, they'll shoot at you. Their fire rate is pretty good too. While they aren't too durable, they can be a threat when their numbers are great."
chaoText="These come from 'Contra: Hard Corps' for the Sega Genesis. They're the standard cannon-fodder in the game."
devText="There's a small chance that something slightly different will happen when these die. Due to the sheer number of these that are blown through, you'll more than likely come across it a few times."

if global.CHAOS_Upgrade=1
{
  sprite_index=sCAdvSoldierIdle
  eName="CHAOS Advanced Soldier"
  eLevel=35
  maxLife=170
  life=maxLife
  atkPower=9
  pointWorth=47
  jeremyText+=" The advanced version of these give it improved durability and power. Note that your charged X-Buster won't 1-shot them most likely now."
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
    //---------- Movement ----------
    if yVel=0 and bJumpReady=1
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}

      if point_distance(x,y,oPlayer1.x,oPlayer1.y)<192 //Stand
      {
        if global.CHAOS_Upgrade=0 {sprite_index=sZakoSoldierIdle}
        else {sprite_index=sCAdvSoldierIdle}
        xVel=0
      }
      else //Walk
      {
        if global.CHAOS_Upgrade=0 {sprite_index=sZakoSoldierRun}
        else {sprite_index=sCAdvSoldierRun}
        if image_xscale=1 {xVel=runAcc}
        else {xVel=-runAcc}
      }
    }
    else //Jump
    {
      if gunShot>28 {gunShot=28}
      if global.CHAOS_Upgrade=0 {sprite_index=sZakoSoldierJump}
      else {sprite_index=sCAdvSoldierJump}
    }

    //Check if cliff edge and jump
    if yVel=0 and bJumpReady=1
    {
      var tDrop;
      tDrop=0
      if aiCheckHoriz(1,1,0,16,4)
      {
        if aiCheckVert(0,3,24,16,4)=1
        {
          tDrop=1
        }
      }

      if tDrop=0
      {
        xVel=(runAcc*1.25)*image_xscale
        y-=4
        yVel=-6
        bJumpReady=0
      }
    }

    if gunShot<gunDelay-6 {gunShot+=1}
    else
    {
      if xVel=0 and yVel=0 and bJumpReady=1 {gunShot+=1}
    }

    if gunShot=gunDelay-5 and xVel=0 and yVel=0 and bJumpReady=1 //Fire warning (on ground)
    {
      var tEffect;
      tEffect=instance_create(x+(16*image_xscale),y-32,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
      tEffect.image_xscale=0.4; tEffect.image_yscale=0.4
    }
    if gunShot>=gunDelay and xVel=0 and yVel=0 and bJumpReady=1 //Fire at player when ready (on ground)
    {
      var tNewAttack;
      tNewAttack=instance_create(x+(16*image_xscale),y-32,oPassBullet)
      tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=5; tNewAttack.depth=9
      tNewAttack.decayTime=-100; tNewAttack.direction=point_direction(x+(16*image_xscale),y-32,oPlayer1.x,returnPlayerYCenter())
      gunShot=0
    }

    yVel+=0.25
    if isCollisionBottom(1)
    {
      yVel=0
      bJumpReady=1
    }
    if isCollisionLeft(1)
    {
      if xVel!=0 {xVel=runAcc}
    }
    if isCollisionRight(1)
    {
      if xVel!=0 {xVel=-runAcc}
    }
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
