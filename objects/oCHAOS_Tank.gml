#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-8,-34,8,-1)
image_speed=0.25

//Enemy base statistics
eName="CHAOS Tank"
eLevel=29
maxLife=4000
life=maxLife
pointWorth=160
atkPower=8
resType[0]=1
resType[1]=1
resType[2]=2
resType[3]=2
resType[5]=2
stunResist=50
baseItemChance=70
baseDropIndex=90
moneyWorth=10
affiliation=7
dieSound=0
dieEffect=0

runAcc=1.5
gunShot=60
gunDelay=125
multiShot=0
armorBreak=0

detectDistX=296
inactiveDist=detectDistX*1.75

deathAnim=0

jeremyText="Its movement is very limited, not much to concern yourself with there. What you need to watch for is the bomb barrage which ends with a seeker missile. You'll need to blow off some of its armor if you want to do any decent amount of damage to it as well. It also has regeneration capabilities."
chaoText="The sprite is from Contra 3: The Alien Wars on the SNES."
devText="The first encounter with this was originally going to be against 2 tanks, but that was a bit too difficult for this flat field."
extraInfo="Regenerates armored plating."
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
    if armorBreak>0 //Restore armor
    {
      armorBreak+=1
      if armorBreak>=300
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]-=1
        }
        baseColor=c_white
        image_blend=baseColor
        armorBreak=0
      }
    }
    else
    {
      if life<maxLife {life+=1}
    }

    //Facing direction
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    //Movement
    if point_distance(x,0,oPlayer1.x,0)>152
    {
      if image_xscale=1 {xVel=runAcc}
      else {xVel=-runAcc}
    }
    else if point_distance(x,0,oPlayer1.x,0)<104
    {
      if image_xscale=1 {xVel=-runAcc*0.75}
      else {xVel=runAcc*0.75}
    }

    //Fire at player
    gunShot+=1
    if gunShot>=gunDelay
    {
      //Check distance to player
      xThrow=point_distance(x,0,oPlayer1.x,0)/48
      xThrow*=1.1
      if xThrow>8 {xThrow=8}
      else if xThrow<0.75 {xThrow=0.75}

      if multiShot mod 2=0 {xThrow*=random_range(0.75,1.25)} //Offset every other shot
      var tNewAttack;
      tNewAttack=instance_create(x+(28*image_xscale),y-77,oGravBulletAlt)
      tNewAttack.sprite_index=sNotorBangerBomb; tNewAttack.atkPower=atkPower; tNewAttack.bExplode=1
      tNewAttack.xVel=xThrow*image_xscale; tNewAttack.yVel=-6; tNewAttack.damageType="EXPLOSION"
      tNewAttack.xGrav=0; tNewAttack.yGrav=0.4
      multiShot+=1
      if multiShot<5 {gunShot=gunDelay-5}
      else
      {
        playSound(global.snd_BombLaunch,0,0.85,41000)
        var tMissile;
        tMissile=instance_create(x-(50*image_xscale),y-58,oHomingMissile)
        tMissile.atkPower=atkPower; tMissile.targetTime=20; tMissile.sprite_index=sJunkCarMissile
        tMissile.bulletSpeed=7; tMissile.seekThres=20; tMissile.minSpd=3; tMissile.maxSpd=8
        tMissile.turnSpd=4; tMissile.accel=0.2
        if image_xscale=1 {tMissile.direction=135}
        else {tMissile.direction=45}
        multiShot=0
        gunShot=0
      }
    }

    if isCollisionBottom(1)
    {
      yVel=0
    }
    if isCollisionLeft(1)
    {
      xVel=runAcc
    }
    if isCollisionRight(1)
    {
      xVel=-runAcc
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim>=1 and deathAnim<=39
    {
      if deathAnim mod 5=0 {playSound(global.snd_HardHit1,0,0.97,1)}
      if deathAnim mod 3=0
      {
        tEffect=instance_create(x+random_range(-48,48),y-6-random(64),oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=40
    {
      instance_destroy()
    }
  }
  enemyStepEvent()
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if armorBreak=0 and other.damageType="EXPLOSION"
{
  for(i=0;i<6;i+=1)
  {
    resType[i]+=1
  }
  baseColor=make_color_rgb(160,160,255)
  image_blend=baseColor

  var tEffect;
  for(i=0;i<8;i+=1)
  {
    tEffect=instance_create(x+random_range(-48,48),y-6-random(64),oEffect)
    tEffect.sprite_index=sMMGlassBreak; tEffect.followID=-1; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
    tEffect.newBlend=1; tEffect.decay=9+irandom(6); tEffect.xSpd=random_range(-2,2); tEffect.ySpd=random_range(-2,2)
    tEffect.image_angle=random(360); tEffect.image_blend=make_color_rgb(200,40,0)
  }
  armorBreak=1
}
