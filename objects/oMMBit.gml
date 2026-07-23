#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-15,-48,15,-1)
image_speed=0

//Enemy base statistics
eName="X Hunter - Bit"
eLevel=18
maxLife=2500
life=maxLife
atkPower=6
resType[0]=2
resType[1]=2
resType[2]=4
resType[5]=2
stunResist=50
affiliation=4
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitMM
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
actionState=0
atkProg=0
ringProg=0
jumpProg=0

runAcc=7
ballTime=180

//Misc Data
xCenter=240
yGround=288
roomSpan=176

deathAnim=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=1; showBossHP.lifeFill=1000
    jeremyText="You're in the Boss Gallery now it seems. I'm not telling you anything about this guy, you already know what he can do. Plus I'm feeling lazy, leave me alone."
    chaoText="Jeremy is locked out of all data mining functions it seems. I don't know what's going on, but it's scaring me. Anyway, Bit is just as he was in X3, simply follow whatever you did there to beat him. Of course, you have invulnerability on your dashes, so use that to your advantage."
    devText="Bit was really easy in the original game, and with Jerry's invulnerability while dashing, Bit would be even easier. It was actually for this reason that I kept Bit very very close to the original."
    if room=rMega4_SigmaB7
      devText+=" With Byte fighting along with him at the same time, the problem with Bit being too easy would be negated."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    atkProg+=1
    if actionState=0 //----- Throw Ring -----
    {
      if atkProg=1
      {
        sprite_index=sBit_ArmUp
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
      }
      else if atkProg=10 {image_index=1}
      else if atkProg=14 {image_index=2}
      else if atkProg=18 {image_index=3}
      else if atkProg=25
      {
        var newRing;
        newRing=instance_create(x+(5*image_xscale),y-58,oBitRing)
        newRing.atkPower=atkPower; newRing.type=image_xscale
      }
      else if atkProg=30 {sprite_index=sBit_Throw; image_index=0}
      else if atkProg=34 {image_index=1}
      else if atkProg=38 {image_index=2}
      else if atkProg=45
      {
        sprite_index=sBit_ArmUp; image_index=0
        atkProg=0
        if bossProgress>=3
        {
          ringProg+=1
          if ringProg=2
          {
            ringProg=0
            actionState=1
          }
        }
        else {actionState=1}
      }
    }
    else if actionState=1 or actionState=3 //----- Jump and dash -----
    {
      if atkProg=30
      {
        sprite_index=sBit_Jump
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
        y-=2
        yVel=-13
      }
      else if atkProg>=31 and atkProg<=199
      {
        if yVel>=0 and y>=oPlayer1.y-16
        {
          yVel=0
          sprite_index=sBit_Dash
          atkProg=200
        }
      }
      else if atkProg>=200 and atkProg<=399
      {
        xVel=runAcc*image_xscale
        if image_xscale=1 and x>=xCenter+roomSpan-32
        {
          xVel=0
          atkProg=400
        }
        else if image_xscale=-1 and x<=xCenter-roomSpan+32
        {
          xVel=0
          atkProg=400
        }
      }
      else if atkProg=401
      {
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
        sprite_index=sBit_Jump
        yVel=1
      }
      else if atkProg>=402 and atkProg<=499
      {
        if y>=yGround
        {
          sprite_index=sBit_ArmUp
          jumpProg+=1
          if jumpProg=2
          {
            atkProg=0; jumpProg=0
            if actionState=1 {actionState=2}
            else {actionState=0}
          }
          else {atkProg=10}
        }
      }
    }
    else if actionState=2 //----- Throw Homing Ball -----
    {
      if atkProg=10
      {
        sprite_index=sBit_ArmUp
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
      }
      else if atkProg=16 {image_index=1}
      else if atkProg=20 {image_index=2}
      else if atkProg=24 {image_index=3}
      else if atkProg=30
      {
        playSound(global.snd_LightballSpread,0,0.94,18000)
        var newBall;
        newBall=instance_create(x+(5*image_xscale),y-58,oBitBall)
        newBall.atkPower=atkPower; newBall.decayTime=180
      }
      else if atkProg=38 {image_index=2}
      else if atkProg=42 {image_index=1}
      else if atkProg=46 {image_index=0}
      else if atkProg=50
      {
        atkProg=0
        actionState=3
      }
    }

    if sprite_index!=sBit_Dash {yVel+=0.5}

    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1) and xVel<0
    {
      xVel=runAcc
    }
    if isCollisionRight(1) and xVel>0
    {
      xVel=-runAcc
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.84 and lifePercent>=0.69 and bossProgress=0
    {
      runAcc+=0.5
      ballTime+=15
      bossProgress+=1
    }
    else if lifePercent<=0.68 and lifePercent>=0.51 and bossProgress=1
    {
      runAcc+=0.5
      ballTime+=15
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.36 and bossProgress=2
    {
      runAcc+=0.5
      ballTime+=15
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=2; tAtkShield.atkUp=1
      resType[2]-=1
      bossProgress+=1
    }
    else if lifePercent<=0.35 and lifePercent>=0.21 and bossProgress=3
    {
      runAcc+=0.5
      ballTime+=15
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      runAcc+=0.5
      ballTime+=15
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sBit_ArmUp
      with oBitRing {instance_destroy()}
      with oBitBall {instance_destroy()}
      notDashable=0
    }
    else if deathAnim>=2 and deathAnim<=90
    {
      if deathAnim mod 9=0 {playSound(global.snd_EnemyDieMM,0,1,1)}
      if oGame.time mod 3=0
      {
        var tEffect;
        tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(abs(sprite_height)),oEffect)
        tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=91
    {
      instance_destroy()
    }
  }
  enemyStepEvent()
}
