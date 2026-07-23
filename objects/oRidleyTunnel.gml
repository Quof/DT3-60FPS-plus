#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1

//Enemy base statistics
eName="Ridley"
eLevel=25
maxLife=4800
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bWave=1
moveWaveX=pi/2
moveWaveY=pi/2
moveSpd=5

atkProg=0
atkTime=0
fireballRate=0
fireType=0

tailCycle=0
cycleMax=2

myDirType=0

//Misc Data
xCenter=240
yGround=208
roomSpan=144

currentSpawn=0
spawnSpot[0]=144
spawnSpot[1]=240
spawnSpot[2]=336

tunnelRaidCurrent=0
raidSpot[0]=144
raidSpot[1]=336

deathAnim=0

//Body Data
ridParts[0]=instance_create(x,y,oRidleyParts); ridParts[0].depth=4; ridParts[0].type=0
ridParts[1]=instance_create(x,y,oRidleyParts); ridParts[1].sprite_index=sRidleyWings; ridParts[1].depth=5; ridParts[1].type=1
ridParts[2]=instance_create(x,y,oRidleyParts); ridParts[2].sprite_index=sRidleyArms; ridParts[2].depth=6; ridParts[2].type=2
for(i=0;i<3;i+=1)
{
  ridParts[i].myOwner=id
}

for(i=0;i<7;i+=1)
{
  ridTail[i]=instance_create(x,y,oRidleyParts); ridTail[i].sprite_index=sRidleyTailSeg; ridTail[i].depth=8; ridTail[i].type=3
  ridTail[i].tailSeg=i
  ridTail[i].myOwner=id
}
ridTail[6].sprite_index=sRidleyTailEnd; ridTail[6].depth=9
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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    jeremyText="Once again, he's changed up his attack patterns. I don't think he'll be able to change his armor type in here though. Remember that you can regain your air dash by successfully dealing damage. Another thing to note is your Charge Beam pierces through his fireballs."
    chaoText="It's Samus' nemesis from the Metroid series. He's fought in nearly all of the games since he seems to be able to revive or be rebuilt. In one game, he built a robotic version of himself."
    devText="I knew right away when I was going to do a Metroid level, that Ridley would be the end boss. Since Gate 5 is the last of Gates that give permanent Ability Sets, and the last of its kind, I wanted it to end on a high note. I'll let you see how that goes."
    with oRidleyParts
    {
      jeremyText=oRidleyTunnel.jeremyText
      chaoText=oRidleyTunnel.chaoText
      devText=oRidleyTunnel.devText
    }
    activateBoss=2
  }

  if life>0
  {
    if bWave=1 //Idle wave motion
    {
      moveWaveY+=0.2
      y+=sin(moveWaveY)
      if x+16<oPlayer1.x {image_xscale=1}
      else if x-16>oPlayer1.x {image_xscale=-1}
    }

    if fireballRate>0 //-- Spit fireballs --
    {
      if atkTime mod fireballRate=0
      {
        playSound(global.snd_RidleyFire,0,0.98,1)
        var tNewAttack;
        if fireType=0
        {
          tNewAttack=instance_create(x+(13*image_xscale),y-4,oMetBulletPass)
          tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
          tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
        }
        else if fireType=1
        {
          tNewAttack=instance_create(x+(13*image_xscale),y-4,oMetBulletPass)
          tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
          tNewAttack.direction=20
          tNewAttack=instance_create(x+(13*image_xscale),y-4,oMetBulletPass)
          tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
          tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
          tNewAttack.direction=160
        }
      }
    }

    atkTime+=1
    if atkProg=0 //-------------------- Fly up under player, go left and right, use fireball --------------------
    {
      if atkTime=1 //Choose spot
      {
        bWave=0
        fireType=0
        x=spawnSpot[currentSpawn]
        currentSpawn+=1
        if currentSpawn>=3 {currentSpawn=0}
        y=room_height+64
        myDirType=choose(0,1)
      }
      else if atkTime>=2 and atkTime<=99
      {
        y-=6
        if y<=304 {bWave=1; atkTime=100}
      }
      else if atkTime>=101 and atkTime<=220
      {
        if myDirType=0 //Left
        {
          x-=5
          if x<=144 {myDirType=1}
        }
        else if myDirType=1 //Right
        {
          x+=5
          if x>=336 {myDirType=0}
        }
      }

      if atkTime=110 {ridParts[0].image_index=1}
      else if atkTime=113 {ridParts[0].image_index=2}
      else if atkTime=118
      {
        if bossProgress>=0 and bossProgress<=1 {fireballRate=20}
        else if bossProgress>=2 and bossProgress<=3 {fireballRate=16}
        else if bossProgress>=4 {fireballRate=12}
      }
      else if atkTime=195 {fireballRate=0}
      else if atkTime=200 {ridParts[0].image_index=1}
      else if atkTime=203 {ridParts[0].image_index=0}
      else if atkTime=221 {ridParts[0].image_index=1}
      else if atkTime=224 {ridParts[0].image_index=2; playSound(global.snd_RidleyScreamA,0,0.98,32000)}
      else if atkTime=251 {ridParts[0].image_index=1}
      else if atkTime=254 {ridParts[0].image_index=0; bWave=0}
      else if atkTime>=265
      {
        event_user(0)
        y-=20
        if y<=-96 {atkTime=0; atkProg=1}
      }
    }
    else if atkProg=1 //-------------------- Speed down screen, then up opposite side of screen, spraying lots of fireballs --------------------
    {
      if atkTime=1
      {
        fireType=1
        x=raidSpot[tunnelRaidCurrent]
        tunnelRaidCurrent+=1
        if tunnelRaidCurrent>=2 {tunnelRaidCurrent=0}
        if x=144 {image_xscale=1} else {image_xscale=-1}
        y=-96
        ridParts[0].image_index=2
        var tWarnSign;
        for(i=0;i<4;i+=1)
        {
          tWarnSign=instance_create(x,64+(i*76),oEfWarningPopup); tWarnSign.warnMax=35
        }
      }
      else if atkTime>=40 and atkTime<=99
      {
        var tEffect,tXadj;
        for(i=0;i<5;i+=1)
        {
          if image_xscale=1 {tXadj=-64+random(90)}
          else {tXadj=64-random(90)}
          tEffect=instance_create(x+tXadj,y-16+random(80),oEffectGrav)
          tEffect.sprite_index=sRidleyFireball; tEffect.image_alpha=0.8; tEffect.image_xscale=0.4+random(0.3); tEffect.image_yscale=0.4+random(0.3)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.type=2; tEffect.fadeSpd=0.02; tEffect.rotation=3
          tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=random_range(-0.5,0.5); tEffect.grav=0; tEffect.depth=4
        }
        event_user(0)
        y+=20
        if bossProgress>=0 and bossProgress<=1 {fireballRate=3}
        else if bossProgress>=2 and bossProgress<=3 {fireballRate=2}
        else if bossProgress>=4 {fireballRate=1}
        if y>=room_height+64
        {
          if x=144 {x=366; image_xscale=-1} else {x=144; image_xscale=1}
          fireballRate=0; atkTime=100
        }
      }
      else if atkTime>=140 and atkTime<=199
      {
        var tEffect,tXadj;
        for(i=0;i<5;i+=1)
        {
          if image_xscale=1 {tXadj=-64+random(90)}
          else {tXadj=64-random(90)}
          tEffect=instance_create(x+tXadj,y-16+random(80),oEffectGrav)
          tEffect.sprite_index=sRidleyFireball; tEffect.image_alpha=0.8; tEffect.image_xscale=0.4+random(0.3); tEffect.image_yscale=0.4+random(0.3)
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.type=2; tEffect.fadeSpd=0.02; tEffect.rotation=3
          tEffect.xSpd=random_range(-0.5,0.5); tEffect.ySpd=random_range(-0.5,0.5); tEffect.grav=0; tEffect.depth=4
        }
        event_user(0)
        y-=20
        if bossProgress>=0 and bossProgress<=1 {fireballRate=3}
        else if bossProgress>=2 and bossProgress<=3 {fireballRate=2}
        else if bossProgress>=4 {fireballRate=1}
        if y<=-96 {fireballRate=0; atkTime=0; atkProg=2}
      }
    }
    else if atkProg=2 //-------------------- Fly down and unload a barrage of fireballs --------------------
    {
      if atkTime=1
      {
        fireType=0
        x=spawnSpot[currentSpawn]
        currentSpawn+=1
        if currentSpawn>=3 {currentSpawn=0}
        y=-96
        ridParts[0].image_index=0
      }
      else if atkTime>=30 and atkTime<=99 //Fly down
      {
        y+=4
        if y>=32 {bWave=1; atkTime=100}
      }
      else if atkTime=105 {ridParts[0].image_index=1}
      else if atkTime=108 {ridParts[0].image_index=2}
      else if atkTime=113 {fireballRate=1}
      else if atkTime=148 {fireballRate=0}
      else if atkTime=153 {ridParts[0].image_index=1}
      else if atkTime=156 {ridParts[0].image_index=0}
      else if atkTime>=160 //Fly up
      {
        atkTime=0; atkProg=3
      }
    }
    else if atkProg=3 //-------------------- Hover over player, use tail, use fireball --------------------
    {
      if atkTime=10 {fireType=0; oRidleyParts.tailType=3}
      else if atkTime>=11 and atkTime<=40 //Track player, tail spins
      {
        if atkTime=11 {playSound(global.snd_PlayerJump[0],0,1,12000)}
        else if atkTime=31 {playSound(global.snd_PlayerJump[0],0,1,12000)}
        var tChkMove;
        tChkMove=point_distance(x,0,oPlayer1.x,0)
        distMax=64
        if tChkMove<distMax-(distMax/6)
        {
          if image_xscale=1 {x-=moveSpd/2}
          else {x+=moveSpd/2}
        }
        else if tChkMove>distMax
        {
          if image_xscale=1 {x+=moveSpd}
          else {x-=moveSpd}
        }
      }
      else if atkTime=50 //Find player for tail stab
      {
        var tChkDir;
        tChkDir=point_direction(ridTail[0].x,ridTail[0].y,oPlayer1.x,oPlayer1.y-26)
        oRidleyParts.tailType=4; oRidleyParts.tailAngle=tChkDir
        playSound(global.snd_PlayerJump[0],0,1,8000)
      }
      else if atkTime>=51 and atkTime<=60 {oRidleyParts.tailSep+=3} //Extend tail
      else if atkTime>=61 and atkTime<=70 {oRidleyParts.tailSep-=3} //Detract tail
      else if atkTime=71 {oRidleyParts.tailType=1}
      else if atkTime>=75 and atkTime<=118 //Track player and use fire
      {
        var tChkMove;
        tChkMove=point_distance(x,0,oPlayer1.x,0)
        distMax=64
        if tChkMove<distMax-(distMax/6)
        {
          if image_xscale=1 {x-=moveSpd/2}
          else {x+=moveSpd/2}
        }
        else if tChkMove>distMax
        {
          if image_xscale=1 {x+=moveSpd}
          else {x-=moveSpd}
        }

        if atkTime=76 {ridParts[0].image_index=1}
        else if atkTime=79 {ridParts[0].image_index=2}
        else if atkTime=82
        {
          if bossProgress>=0 and bossProgress<=3 {fireballRate=3}
          else if bossProgress>=4 {fireballRate=2}
        }
        else if atkTime=112 {fireballRate=0}
        else if atkTime=115 {ridParts[0].image_index=1}
        else if atkTime=118 {ridParts[0].image_index=0}
      }
      else if atkTime=119 //Check if Ridley repeats the tail stab
      {
        tailCycle+=1
        if tailCycle>=cycleMax
        {
          tailCycle=0
          bWave=0
          atkTime=1000
        }
        else
        {
          atkTime=9
        }
      }
      else if atkTime>=1040 and atkTime<=1999 //Fly down
      {
        y+=6
        if y>=room_height+64 {atkTime=2000}
      }
      else if atkTime=2001
      {
        atkTime=0; atkProg=0
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.85 and lifePercent>=0.71 and bossProgress=0
    {
      bossProgress+=1
    }
    else if lifePercent<=0.7 and lifePercent>=0.56 and bossProgress=1
    {
      bossProgress+=1
    }
    else if lifePercent<=0.55 and lifePercent>=0.37 and bossProgress=2
    {
      bossProgress+=1
    }
    else if lifePercent<=0.36 and lifePercent>=0.13 and bossProgress=3
    {
      cycleMax+=1
      bossProgress+=1
    }
    else if lifePercent<=0.12 and bossProgress=4
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      with oEnemyBase {resType[5]=3}
      bossProgress+=1
    }
  }
  else
  {
    deathAnim+=1
    if deathAnim=1
    {
      if global.bBossGallery=1
      {
        bossRoomTally(36)
        global.newMapX=1784; global.newMapY=720; room_goto(rBossGallery)
      }
      else
      {
        ridParts[0].image_index=2
        oRidleyParts.tailType=1
        with oEnemyBase {bCanDealDamage=0}
      }
    }
    else if deathAnim>=2 and deathAnim<=999
    {
      if deathAnim mod 2=0
      {
        var tEffect,tXadj;
        if image_xscale=1 {tXadj=-64+random(90)}
        else {tXadj=64-random(90)}
        tEffect=instance_create(x+tXadj,y-16+random(80),oEffect)
        tEffect.sprite_index=sSamusMissileHit; tEffect.followID=-1
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=4
      }
      if deathAnim mod 35=0
      {
        playSound(global.snd_RidleyScreamA,0,0.98,56000+random(12000))
      }
      y-=2
      if y<=-96
      {
        deathAnim=1000
        oEvCh13MainA.sceneProgress=4
      }
    }
  }
  oRidleyParts.image_blend=image_blend
  oRidleyParts.image_xscale=image_xscale
  enemyStepEvent()
}
else {speed=0}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tAfterI;
tAfterI=instance_create(x,y,oEnemyAfterImage)
tAfterI.sprite_index=sprite_index; tAfterI.image_alpha=0.6; tAfterI.image_xscale=image_xscale
tAfterI.depth=8; tAfterI.imageFade=0.03; tAfterI.bFollow=-1; tAfterI.xShift=0; tAfterI.yShift=0
tAfterI.imageFade=0.02; ; tAfterI.xScaling=0; tAfterI.yScaling=0
