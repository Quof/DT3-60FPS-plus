#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-24,-78,24,-1)
image_speed=0

//Enemy base statistics
eName="X Hunter - Byte"
eLevel=18
maxLife=3000
life=maxLife
atkPower=7
resType[0]=2
resType[1]=2
resType[2]=2
resType[5]=4
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
runAcc=8

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
    if instance_exists(oMMBit) {showBossHP.newOffsetX=433}
    jeremyText="You're in the Boss Gallery now it seems. I'm not telling you anything about this guy, you already know what he can do. Plus I'm feeling lazy, leave me alone."
    chaoText="My brother is still locked out for some reason. I wish he was able to come back. Even communication is blocked out..."
    devText="Byte also stayed relatively the same. Byte is even easier than Bit was in the original."
    if room=rMega4_SigmaB7
      devText+=" Together this is a pretty intense fight. Their behavior isn't 100% like it was in their original setting, but very very close."
    activateBoss=2
  }

  if bActive=true and life>0
  {
    atkProg+=1
    if actionState=0 //----- Throw Bomb -----
    {
      if atkProg=1
      {
        if x<xCenter {image_xscale=1}
        else {image_xscale=-1}
      }
      if atkProg=26 {sprite_index=sByte_ReadyFire}
      else if atkProg=30 {image_index=1}
      else if atkProg=34 {image_index=2}
      else if atkProg=38
      {
        playSound(global.snd_MarioCannon,0,0.95,37000)
        sprite_index=sByte_Fire; image_index=0
        var newBomb;
        newBomb=instance_create(x+(53*image_xscale),y-43,oByteBomb)
        newBomb.atkPower=atkPower; newBomb.image_xscale=-image_xscale
        newBomb.xVel=6*image_xscale; newBomb.yVel=0
      }
      else if atkProg=46 {sprite_index=sByte_ReadyFire; image_index=2}
      else if atkProg=50 {image_index=1}
      else if atkProg=54 {image_index=0}
      else if atkProg=58
      {
        sprite_index=sByte_Idle
        atkProg=0
        actionState=1
      }
    }
    else if actionState=1 //Wait
    {
      if atkProg>=45
      {
        atkProg=0
        actionState=2
      }
    }
    else if actionState=2 //Charge
    {
      if atkProg=1 {sprite_index=sByte_ReadyCharge}
      else if atkProg=5 {image_index=1}
      else if atkProg=9
      {
        sprite_index=sByte_Charge
        image_index=0
        xVel=runAcc*image_xscale
      }
    }
    else if actionState=3 //Bounced off wall
    {
      if atkProg=1
      {
        playSound(global.snd_BombExplode,0,0.95,1)
        with oByteBomb {instance_destroy()}
        var newAttack,xPlace,yPlace;
        if x<xCenter {xPlace=xCenter-roomSpan}
        else {xPlace=xCenter+roomSpan}
        yPlace=80
        for(i=0;i<9;i+=1)
        {
          newAttack=instance_create(xPlace,yPlace+(i*24),oDamageExplosion)
          newAttack.atkPower=atkPower; newAttack.sprite_index=sBombExplosion
          newAttack.image_xscale=0.75; newAttack.image_yscale=0.75; newAttack.decayTime=-100
        }
      }
    }

    yVel+=0.5
    if isCollisionBottom(1)
    {
      yVel=0
      if actionState=3
      {
        xVel=0
        sprite_index=sByte_Idle
        atkProg=0
        actionState=0
      }
    }
    if isCollisionLeft(1) and xVel<0
    {
      xVel=0
      if actionState=2
      {
        x+=2; xVel=2
        y-=2; yVel=-5
        atkProg=0
        actionState=3
      }
    }
    if isCollisionRight(1) and xVel>0
    {
      xVel=-0
      if actionState=2
      {
        x-=2; xVel=-2
        y-=2; yVel=-5
        atkProg=0
        actionState=3
      }
    }
    if isCollisionSolid()
      y-=2

    moveTo(xVel,yVel)

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.84 and lifePercent>=0.69 and bossProgress=0
    {
      runAcc+=0.25
      bossProgress+=1
    }
    else if lifePercent<=0.68 and lifePercent>=0.51 and bossProgress=1
    {
      runAcc+=0.25
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.36 and bossProgress=2
    {
      runAcc+=0.25
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      resType[5]-=1
      bossProgress+=1
    }
    else if lifePercent<=0.35 and lifePercent>=0.21 and bossProgress=3
    {
      runAcc+=0.25
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0 and bossProgress=4
    {
      runAcc+=0.25
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      sprite_index=sByte_Idle
      with oByteBomb {instance_destroy()}
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
