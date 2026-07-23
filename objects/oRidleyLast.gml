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
maxLife=6400
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
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

atkProg=0
atkTime=0
fireballRate=0
fireCircleAmt=24
groundMoveSpd=24
groundCycle=0
cycleMax=2
groundFireFreq=5
breakArmor=0

myDirType=0
moveSpd=4

//Misc Data
xCenter=320
yGround=336
roomSpan=288

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
  ridTail[i].bCanDealDamage=0
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
    jeremyText="Ridley is really pissed off now. He's going to be more aggressive and will most definitely utilize the lava to his advantage. Hex has also altered his body armor again. Watch him closely to see what you need to use."
    chaoText="It's Samus' nemesis from the Metroid series. He's fought in nearly all of the games since he seems to be able to revive or be rebuilt. In one game, he built a robotic version of himself."
    devText="I knew right away when I was going to do a Metroid level, that Ridley would be the end boss. Since Gate 5 is the last of Gates that give permanent Ability Sets, and the last of its kind, I wanted it to end on a high note. I'll let you see how that goes."
    with oRidleyParts
    {
      jeremyText=oRidleyLast.jeremyText
      chaoText=oRidleyLast.chaoText
      devText=oRidleyLast.devText
    }
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if bWave=1 //Idle wave motion
    {
      moveWaveY+=0.2
      y+=sin(moveWaveY)
      if x<oPlayer1.x {image_xscale=1}
      else {image_xscale=-1}
    }

    if fireballRate>0 //-- Spit fireballs --
    {
      if atkTime mod fireballRate=0
      {
        playSound(global.snd_RidleyFire,0,0.98,1)
        var tNewAttack;
        tNewAttack=instance_create(x+(13*image_xscale),y-4,oMetBulletPass)
        tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
        tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
      }
    }

    atkTime+=1
    if atkProg=0 //-------------------- Rise up from lava and spray lava balls around --------------------
    {
      if atkTime=1
      {
        myDirType=choose(0,1)
        if myDirType=0 {x=96; image_xscale=1}
        else {x=544; image_xscale=-1}
        y=room_height+48
        bWave=0
        oRidleyParts.tailType=1
        ridParts[0].image_index=2
        if baseColor!=c_yellow {baseColor=c_maroon; image_blend=baseColor; event_user(0)}
      }
      else if atkTime=20 {playSound(global.snd_RidleyScreamA,0,0.98,18000)}
      else if atkTime>=30 and atkTime<=199
      {
        if atkTime=64 {ridParts[0].image_index=1}
        else if atkTime=68 {ridParts[0].image_index=0}
        y-=5
        if y>=304 and y<=464 //Lava effects
        {
          var tEffect,tXadj;
          for(i=0;i<6;i+=1)
          {
            if myDirType=0 {tXadj=-64+random(90)}
            else {tXadj=64-random(90)}
            tEffect=instance_create(x+tXadj,y-16+random(80),oEffectGrav)
            tEffect.sprite_index=sRidleyFireball; tEffect.image_alpha=0.8; tEffect.image_xscale=0.4+random(0.3); tEffect.image_yscale=0.4+random(0.3)
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.type=2; tEffect.fadeSpd=0.02; tEffect.rotation=3
            tEffect.xSpd=random_range(-0.2,0.2); tEffect.ySpd=-6-random(3); tEffect.grav=0.33; tEffect.depth=4
          }
        }
        if y>=288 and y<=320 //Lava balls
        {
          var tNewAttack,tXarea;
          if myDirType=0 {tXarea=64} else {tXarea=512}
          for(i=0;i<2;i+=1)
          {
            tNewAttack=instance_create(tXarea+random(64),352+random(8),oGravPassBullet)
            tNewAttack.sprite_index=sRidleyFireball; tNewAttack.atkPower=atkPower; tNewAttack.image_blend=make_color_rgb(255,200,200)
            tNewAttack.image_xscale=0.75; tNewAttack.image_yscale=0.75; tNewAttack.yVel=random_range(-9,-10)
            tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
            if myDirType=0 {tNewAttack.xVel=2+random(3)} else {tNewAttack.xVel=-2-random(3)}
          }
        }
        if y<=216 //Stop and use fire circle
        {
          bWave=1
          playSound(global.snd_RidleyFire,0,1,1)
          var tNewAttack,tDir;
          tDir=0
          for(i=0;i<fireCircleAmt;i+=1)
          {
            tNewAttack=instance_create(x-(30*image_xscale),y+31,oMetBulletPass)
            tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=4; tNewAttack.decayTime=-100; tNewAttack.direction=tDir
            tNewAttack=instance_create(x-(30*image_xscale),y+31,oMetBulletPass)
            tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
            tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=7; tNewAttack.decayTime=-100; tNewAttack.direction=tDir+((360/fireCircleAmt)/2)
            tDir+=360/fireCircleAmt
          }

          var tEffect;
          tEffect=instance_create(x-(30*image_xscale),y+31,oEffect)
          tEffect.sprite_index=sEfEnergyRip; tEffect.followID=-1; tEffect.image_xscale=2; tEffect.image_yscale=2
          tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.depth=4
          atkTime=200
        }
      }
      else if atkTime=225
      {
        atkTime=0; atkProg=1
      }
    }
    else if atkProg=1 //-------------------- Unload a barrage of fireballs --------------------
    {
      if atkTime=35 {ridParts[0].image_index=1}
      else if atkTime=38 {ridParts[0].image_index=2}
      else if atkTime=43 {fireballRate=1}
      else if atkTime=93 {fireballRate=0}
      else if atkTime=98 {ridParts[0].image_index=1}
      else if atkTime=101 {ridParts[0].image_index=0}
      else if atkTime>=116 //Fly up
      {
        bWave=0
        y-=8
        if y<=-96
        {
          atkTime=0; atkProg=2
        }
      }
    }
    else if atkProg=2 //-------------------- Slam down, charge in player direction along ground, come back and leave fire pillars --------------------
    {
      if atkTime=1
      {
        if baseColor!=c_yellow {baseColor=c_white; image_blend=baseColor; event_user(0)}
        if oPlayer1.x<xCenter {x=208; image_xscale=1}
        else {x=432; image_xscale=-1}
        var tWarnSign;
        tWarnSign=instance_create(x,yGround-16,oEfWarningPopup); tWarnSign.warnMax=35
      }
      else if atkTime>=36 and atkTime<=99 //Hit ground
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
        tAfterI.image_alpha=0.6; tAfterI.image_xscale=image_xscale; tAfterI.depth=8; tAfterI.imageFade=0.03
        tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0; tAfterI.bFollow=-1

        y+=20
        if y>=yGround-64
        {
          if x<oPlayer1.x {image_xscale=1} else {image_xscale=-1}
          playSound(global.snd_HardHit1,0,1,1)
          var tEffect;
          for(i=0;i<32;i+=1)
          {
            tEffect=instance_create(x+random_range(-40,12),yGround+4-random(16),oEffect)
            tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6; tEffect.depth=4
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.25-random(2)
          }
          atkTime=100
        }
      }
      else if atkTime=106 {oRidleyParts.tailType=0; ridParts[0].image_index=1}
      else if atkTime=109 {ridParts[0].image_index=2; playSound(global.snd_RidleyScreamA,0,0.98,32000)}
      else if atkTime=136 {ridParts[0].image_index=1}
      else if atkTime=139 {ridParts[0].image_index=0}
      else if atkTime>=149 and atkTime<=499 //Slide across floor
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
        tAfterI.image_alpha=0.6; tAfterI.image_xscale=image_xscale; tAfterI.depth=8; tAfterI.imageFade=0.03
        tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0; tAfterI.bFollow=-1

        if image_xscale=1 //Right
        {
          x+=groundMoveSpd
          if x>=room_width+96 {x+=groundCycle*30; atkTime=1000}
        }
        else //Left
        {
          x-=groundMoveSpd
          if x<=-96 {x-=groundCycle*30; atkTime=1000}
        }

        if atkTime mod groundFireFreq=0 and x>=160 and x<=480 //Fire pillars from ground slide
        {
          playSound(global.snd_Flame1,0,1,9600)
          var tFirePillar;
          tFirePillar=instance_create(x-(8*image_xscale),yGround,oDracFireWave)
          tFirePillar.atkPower=atkPower
        }
      }
      else if atkTime=1001 //Check if Ridley comes back
      {
        image_xscale*=-1
        groundCycle+=1
        if groundCycle>=cycleMax
        {
          groundCycle=0
          atkTime=2000
        }
        else
        {
          playSound(global.snd_RidleyScreamA,0,0.98,48000)
          atkTime=120
        }
      }
      else if atkTime=2001
      {
        atkTime=0; atkProg=3
      }
    }
    else if atkProg=3 //-------------------- Hover over player, use tail, use fireball --------------------
    {
      if atkTime=1
      {
        for(i=0;i<7;i+=1) {ridTail[i].bCanDealDamage=1}

        if oPlayer1.x<xCenter {x=192; image_xscale=1}
        else {x=448; image_xscale=-1}
        y=-96
      }
      else if atkTime>=11 and atkTime<=99 //Fly down
      {
        y+=8
        if y>=192
        {
          bWave=1
          atkTime=100
        }
      }
      else if atkTime=110 {oRidleyParts.tailType=3}
      else if atkTime>=111 and atkTime<=140 //Track player, tail spins
      {
        if atkTime=111 {playSound(global.snd_PlayerJump[0],0,1,12000)}
        else if atkTime=131 {playSound(global.snd_PlayerJump[0],0,1,12000)}
        var tChkMove;
        tChkMove=point_distance(x,0,oPlayer1.x,0)
        distMax=96
        if tChkMove<distMax-(distMax/6)
        {
          if image_xscale=1 {x-=moveSpd}
          else {x+=moveSpd}
        }
        else if tChkMove>distMax
        {
          if image_xscale=1 {x+=moveSpd}
          else {x-=moveSpd}
        }
      }
      else if atkTime=150 //Find player for tail stab
      {
        var tChkDir;
        tChkDir=point_direction(ridTail[0].x,ridTail[0].y,oPlayer1.x,oPlayer1.y-26)
        oRidleyParts.tailType=4; oRidleyParts.tailAngle=tChkDir
        playSound(global.snd_PlayerJump[0],0,1,8000)
      }
      else if atkTime>=151 and atkTime<=160 {oRidleyParts.tailSep+=3} //Extend tail
      else if atkTime>=161 and atkTime<=170 {oRidleyParts.tailSep-=3} //Detract tail
      else if atkTime=171 {oRidleyParts.tailType=1}
      else if atkTime>=175 and atkTime<=218 //Track player and use fire
      {
        var tChkMove;
        tChkMove=point_distance(x,0,oPlayer1.x,0)
        distMax=96
        if tChkMove<distMax-(distMax/6)
        {
          if image_xscale=1 {x-=moveSpd}
          else {x+=moveSpd}
        }
        else if tChkMove>distMax
        {
          if image_xscale=1 {x+=moveSpd}
          else {x-=moveSpd}
        }

        if atkTime=176 {ridParts[0].image_index=1}
        else if atkTime=179 {ridParts[0].image_index=2}
        else if atkTime=182
        {
          if bossProgress>=0 and bossProgress<=3 {fireballRate=3}
          else if bossProgress>=4 {fireballRate=2}
        }
        else if atkTime=212 {fireballRate=0}
        else if atkTime=215 {ridParts[0].image_index=1}
        else if atkTime=218 {ridParts[0].image_index=0}
      }
      else if atkTime=219 //Check if Ridley repeats the tail stab
      {
        groundCycle+=1
        if groundCycle>=cycleMax-1
        {
          groundCycle=0
          atkTime=1000
        }
        else
        {
          atkTime=109
        }
      }
      else if atkTime=1001
      {
        for(i=0;i<7;i+=1) {ridTail[i].bCanDealDamage=0}
        atkTime=0; atkProg=4
      }
    }
    else if atkProg=4 //-------------------- Choose a side, dive into lava --------------------
    {
      if atkTime=30
      {
        bWave=0
        if x<xCenter {myDirType=0; image_xscale=-1}
        else {myDirType=1; image_xscale=1}
      }
      else if atkTime>=31 and atkTime<=999 //Go to side
      {
        if myDirType=0
        {
          x-=6
          if x<=96 {image_xscale=1; atkTime=1000}
        }
        else
        {
          x+=6
          if x>=544 {image_xscale=-1; atkTime=1000}
        }
      }
      else if atkTime>=1001 and atkTime<=1999 //Go down
      {
        if y<368 {y+=3}
        else {y+=6}
        if atkTime=1005 {ridParts[0].image_index=1}
        else if atkTime=1008 {ridParts[0].image_index=2}
        else if atkTime=1011
        {
          if bossProgress>=0 and bossProgress<=3 {fireballRate=3}
          else if bossProgress>=4 {fireballRate=2}
        }
        else if atkTime=1051 {fireballRate=0}
        else if atkTime=1054 {ridParts[0].image_index=1}
        else if atkTime=1057 {ridParts[0].image_index=0}

        if y>=room_height+48 {atkTime=2000}
      }
      else if atkTime>=2001
      {
        atkTime=0; atkProg=0
      }
    }
    else if atkProg=7 //-------------------- Fly up, crash into ground (Change to Phase 3) --------------------
    {
      if atkTime>=1 and atkTime<=99
      {
        y-=8
        if y<=-96
        {
          x=xCenter
          ridParts[0].image_index=2
          atkTime=100
        }
      }
      else if atkTime=105
      {
        var tWarnSign;
        tWarnSign=instance_create(xCenter,yGround-16,oEfWarningPopup); tWarnSign.warnMax=35
      }
      else if atkTime>=150
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
        tAfterI.image_alpha=0.6; tAfterI.image_xscale=image_xscale; tAfterI.depth=8; tAfterI.imageFade=0.03
        tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0; tAfterI.bFollow=-1

        y+=20
        if y>=yGround-64
        {
          var tEffect;
          for(i=0;i<12;i+=1)
          {
            tEffect=instance_create(160+random(320),yGround-32+random(128),oEffect)
            tEffect.sprite_index=sShipExplosion; tEffect.image_speed=0.25+random(0.25); tEffect.depth=4
            tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          }
        }
        if y>=room_height+32
        {
          global.bossTrack=3
          global.gameProgress=3010
          global.newMapX=240; global.newMapY=208
          room_goto(rSamus5_Lv4_RidleyTunnel)
        }
      }
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.88 and lifePercent>=0.77 and bossProgress=0
    {
      fireCircleAmt+=4
      bossProgress+=1
    }
    else if lifePercent<=0.76 and lifePercent>=0.66 and bossProgress=1
    {
      fireCircleAmt+=6
      cycleMax+=1
      bossProgress+=1
    }
    else if lifePercent<=0.65 and lifePercent>=0.51 and bossProgress=2
    {
      fireCircleAmt+=4
      breakArmor=3; baseColor=c_yellow; image_blend=baseColor; event_user(0)
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.33 and bossProgress=3
    {
      groundMoveSpd=40
      groundFireFreq-=1
      fireCircleAmt+=8
      bossProgress+=1
    }
    else if lifePercent<=0.32 and lifePercent>=0.11 and bossProgress=4
    {
      fireCircleAmt+=8
      cycleMax+=1
      breakArmor=3; baseColor=c_yellow; image_blend=baseColor; event_user(0)
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=5
    {
      if global.bBossGallery=1
      {
        bossRoomTally(35)
        global.newMapX=1640; global.newMapY=720; room_goto(rBossGallery)
      }
      else
      {
        playSound(global.snd_RidleyScreamB,0,0.98,1)
        with oEnemyBase
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=1
          }
        }
        atkTime=0; atkProg=7
        fireballRate=0
        ridParts[0].image_index=0
        oRidleyParts.tailType=1
        bossProgress+=1
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
//Set resist stats
if baseColor=c_white
{
  if bossProgress<=4 {with oEnemyBase {resType[3]=2; resType[4]=3; resType[5]=4}}
  else {with oEnemyBase {resType[3]=2; resType[4]=3; resType[5]=3}}
}
else if baseColor=c_maroon
{
  with oEnemyBase {resType[3]=3; resType[4]=1; resType[5]=2}
}
else if baseColor=c_yellow
{
  with oEnemyBase {resType[3]=1; resType[4]=3; resType[5]=1}
}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if breakArmor>0
{
  if other.weaponTag=42
  {
    breakArmor-=1
    if breakArmor=0
    {
      playSound(global.snd_RidleyScreamB,0,0.98,1)
      var tEffect;
      for(i=0;i<12;i+=1)
      {
        tEffect=instance_create(x-((16+random(90))*image_xscale),y-16+random(95),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.depth=4; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      baseColor=c_white; image_blend=baseColor; event_user(0)
    }
  }
}
