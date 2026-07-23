#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-24,-60,24,-1)
image_speed=0.3

//Enemy base statistics
eName="CHAOS Robear"
eLevel=32
maxLife=1100
life=maxLife
pointWorth=68
atkPower=10
resType[1]=2
resType[2]=1
stunResist=15
baseItemChance=75
moneyWorth=10
affiliation=7
dieSound=0
dieEffect=0

initDir=0
runAcc=2.25
bJumpReady=1
gunShot=25
gunDelay=50

deathAnim=0

jeremyText="This is like other stationary bomb launchers except this one throws two at one time. One is aimed at you and the other is aimed at where you're going to be. It has a large HP count."
chaoText="This sprite comes from the Megaman ZX game on the DS."
devText="There was a point when I thought about removing AP awards from enemy kills and keeping them strictly to collectibles and a bit on story progression."
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
    if gunShot<gunDelay-1
    {
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    //Fire at player
    gunShot+=1
    if gunShot=gunDelay {sprite_index=sCHAOS_Robear_Lift; image_speed=0; image_index=0}
    else if gunShot=gunDelay+4 {image_index=1}
    else if gunShot=gunDelay+8 {image_index=2}
    else if gunShot=gunDelay+15
    {
      sprite_index=sCHAOS_Robear_Throw
      var targetYVel;
      targetYVel=intercept_target_arc(oPlayer1,8,0.3)
      if targetYVel>9 {targetYVel=9}
      else if targetYVel<-9 {targetYVel=-9}
      if x>oPlayer1.x {tDir=-1}
      else {tDir=1}
      var tNewAttack;
      tNewAttack=instance_create(x+(14*image_xscale),y-40,oGravBulletAlt)
      tNewAttack.sprite_index=sLargeSnowball; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0
      tNewAttack.xVel=8*tDir; tNewAttack.yVel=targetYVel; tNewAttack.damageType="ELEMENTAL"
      tNewAttack.xGrav=0; tNewAttack.yGrav=0.3

      //Check distance to player
      xThrow=point_distance(x,0,oPlayer1.x,0)/48
      if xThrow>8 {xThrow=8}
      else if xThrow<0.75 {xThrow=0.75}
      tNewAttack=instance_create(x+(14*image_xscale),y-40,oGravBulletAlt)
      tNewAttack.sprite_index=sLargeSnowball; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=0
      tNewAttack.xVel=xThrow*tDir; tNewAttack.yVel=-6; tNewAttack.damageType="ELEMENTAL"
      tNewAttack.xGrav=0; tNewAttack.yGrav=0.3
    }
    else if gunShot>=gunDelay+19
    {
      sprite_index=sCHAOS_Robear_Idle; image_speed=0.3
      gunShot=0
    }

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
    deathAnim+=1
    if deathAnim mod 2=0
    {
      if deathAnim mod 4=0 {playSound(global.snd_BombExplode,0,0.85,1)}
      tEffect=instance_create(x+random_range(-24,24),y-random(60),oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_alpha=0.5+(image_alpha/3)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.025
    if image_alpha<0.5
    {
      playSound(global.snd_BombExplode,0,0.92,1)
      for(i=0;i<8;i+=1)
      {
        tDir=random_range(-3.5,3.5)
        tEffect=instance_create(x+random_range(-20,20),y-random(58),oEffectGrav); tEffect.sprite_index=sRobearParts
        tEffect.image_speed=0; tEffect.type=2; tEffect.image_index=i
        tEffect.xSpd=tDir; tEffect.ySpd=-2.5-random(2); tEffect.fadeSpd=0.03; tEffect.rotation=choose(-tDir,tDir)
        tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
      }
      instance_destroy()
    }
  }
  enemyStepEvent()
}
