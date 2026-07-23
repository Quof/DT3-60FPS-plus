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
maxLife=5800
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[3]=1
resType[5]=1
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
moveSpd=0

atkProg=0
atkTime=20
atkDelay=50
fireballRate=0

groundMoveSpd=20
groundFireFreq=3
armorBreak=0

myDirType=0

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
  ridParts[i].image_xscale=-1
}

for(i=0;i<7;i+=1)
{
  ridTail[i]=instance_create(x,y,oRidleyParts); ridTail[i].sprite_index=sRidleyTailSeg; ridTail[i].depth=8; ridTail[i].type=3
  ridTail[i].tailSeg=i
  ridTail[i].myOwner=id
  ridTail[i].image_xscale=-1
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
    jeremyText="Hex has made it nearly impossible for me to check Ridley's behavior data, so there's not much I'll be able to tell you. I see a lava tag and something to do with damage type immunity, but that's really all I can decipher. You're gonna have to figure this one out on your own. Oh yeah, if you didn't know, you can throw down a bunch of bombs by charging and then going into Morph Ball mode."
    chaoText="It's Samus' nemesis from the Metroid series. He's fought in nearly all of the games since he seems to be able to revive or be rebuilt. In one game, he built a robotic version of himself."
    devText="I knew right away when I was going to do a Metroid level, that Ridley would be the end boss. Since Gate 5 is the last of Gates that give permanent Ability Sets, and the last of its kind, I wanted it to end on a high note. I'll let you see how that goes."
    baseColor=c_yellow; image_blend=baseColor
    with oRidleyParts
    {
      jeremyText=oRidley.jeremyText
      chaoText=oRidley.chaoText
      devText=oRidley.devText
      baseColor=c_yellow; image_blend=baseColor
    }
    activateBoss=2
  }

  if bActive=true and life>0
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
        tNewAttack=instance_create(x+(9*image_xscale),y-4,oMetBulletPass)
        tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=7
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
        tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
      }
    }

    atkTime+=1
    if atkProg=0 //-------------------- Shoot fireball stream at a high rate --------------------
    {
      if atkTime>=atkDelay and atkTime<=atkDelay+100 {atkTime=1000}
      else if atkTime=1001 {ridParts[0].image_index=1}
      else if atkTime=1004 {ridParts[0].image_index=2}
      else if atkTime=1010
      {
        if bossProgress>=3 {fireballRate=2}
        else {fireballRate=3}
      }
      else if atkTime=1026 {fireballRate=0}
      else if atkTime=1038 {ridParts[0].image_index=1}
      else if atkTime=1041 {ridParts[0].image_index=0}
      else if atkTime=1052 {atkTime=0; atkProg=1}
    }
    else if atkProg=1 //-------------------- Fly up --------------------
    {
      if atkTime>=30
      {
        bWave=0
        y-=8
        if y<=-96 {atkTime=0; atkProg=2}
      }
    }
    else if atkProg=2 //-------------------- Swoop down in a U shape, shooting fireballs at a slow rate --------------------
    {
      speed=moveSpd
      if atkTime=1
      {
        direction=270
        if oPlayer1.x<xCenter {myDirType=0}
        else {myDirType=1}
        if myDirType=0 {x=144; image_xscale=1}
        else {x=480; image_xscale=-1}
      }
      else if atkTime>=30 and atkTime<=99 //Fly down
      {
        if atkTime=41 {ridParts[0].image_index=1}
        else if atkTime=44 {ridParts[0].image_index=2}
        else if atkTime=50
        {
          if bossProgress=0 {fireballRate=20}
          else if bossProgress>=1 and bossProgress<=2 {fireballRate=17}
          else {fireballRate=13}
        }
        moveSpd=4
        if y>=144 {atkTime=100}
      }
      else if atkTime>=100 and atkTime<=999 //Arc around
      {
        if myDirType=0 {direction+=1.33}
        else {direction-=1.33}
        if direction>=89 and direction<=91 {direction=90; atkTime=1000}
      }
      else if atkTime>=1000 and atkTime<=1999 //Fly up
      {
        if atkTime=1005 {fireballRate=0}
        else if atkTime=1009 {ridParts[0].image_index=1}
        else if atkTime=1013 {ridParts[0].image_index=0}
        if y<=-96 {moveSpd=0; atkTime=0; atkProg=3}
      }
    }
    else if atkProg=3 //-------------------- Zigzag across room while spinning tail and shooting fireballs at a very slow rate --------------------
    {
      speed=moveSpd
      if atkTime=1
      {
        ridParts[0].image_index=2
        oRidleyParts.tailType=3
        myDirType=choose(0,1)
        if myDirType=0 //Right
        {
          x=-48; image_xscale=1
          direction=choose(40+random(20),300+random(20))
        }
        else //Left
        {
          x=room_width+48; image_xscale=-1
          direction=choose(120+random(20),220+random(20))
        }
        y=128+random(144)
      }
      else if atkTime=30
      {
        moveSpd=6

        if bossProgress=0 {fireballRate=26}
        else if bossProgress>=1 and bossProgress<=2 {fireballRate=23}
        else {fireballRate=16}
      }
      else if atkTime>=31 and atkTime<=999 //Zigzag
      {
        if myDirType=0 //Right
        {
          if y<=112 {y+=4; direction=300+random(20)}
          else if y>=288 {y-=4; direction=40+random(20)}
          if x>=room_width+96 {atkTime=1000}
        }
        else //Left
        {
          if y<=112 {y+=4; direction=220+random(20)}
          else if y>=288 {y-=4; direction=120+random(20)}
          if x<=-96 {atkTime=1000}
        }
      }
      else if atkTime>=1000
      {
        ridParts[0].image_index=0
        speed=0; moveSpd=0; fireballRate=0
        atkTime=0; atkProg=4
      }
    }
    else if atkProg=4 //-------------------- Fly from one side and unload a barrage of fireballs --------------------
    {
      if atkTime=1
      {
        oRidleyParts.tailType=1
        myDirType=choose(0,1)
        if myDirType=0 //Right
        {
          x=-48; image_xscale=1
          direction=choose(40+random(20),300+random(20))
        }
        else //Left
        {
          x=room_width+48; image_xscale=-1
          direction=choose(120+random(20),220+random(20))
        }
        y=128+random(144)
      }
      else if atkTime>=30 and atkTime<=99 //Fly in
      {
        x+=6*image_xscale
        if myDirType=0 and x>=80 {atkTime=100}
        else if myDirType=1 and x<=560 {atkTime=100}
      }
      else if atkTime=105 {ridParts[0].image_index=1}
      else if atkTime=109 {ridParts[0].image_index=2}
      else if atkTime=115 {fireballRate=1}
      else if atkTime=165 {fireballRate=0}
      else if atkTime=170 {ridParts[0].image_index=1}
      else if atkTime=174 {ridParts[0].image_index=0}
      else if atkTime>=190 //Fly up
      {
        bWave=0
        y-=8
        if y<=-96
        {
          atkTime=0
          if bossProgress=0 {atkProg=5}
          else {atkProg=6}
        }
      }
    }
    else if atkProg=5 //-------------------- Fly down --------------------
    {
      if atkTime=1 {x=128+random(384)}
      else if atkTime>=30
      {
        y+=8
        if y>=208 {bWave=1; atkTime=0; atkProg=0}
      }
    }
    else if atkProg=6 //-------------------- Crash to ground, then charge along ground, then target player direction from side and charge --------------------
    {
      if atkTime=1
      {
        myDirType=choose(0,1)
        if myDirType=0 //Right
        {
          image_xscale=1
          x=80
        }
        else //Left
        {
          image_xscale=-1
          x=560
        }
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
      else if atkTime=106 {oRidleyParts.tailType=0}
      else if atkTime=110 {ridParts[0].image_index=1}
      else if atkTime=114 {ridParts[0].image_index=2; playSound(global.snd_RidleyScreamA,0,0.98,1)}
      else if atkTime=150 {ridParts[0].image_index=1}
      else if atkTime=154 {ridParts[0].image_index=0}
      else if atkTime>=165 and atkTime<=499 //Slide across floor
      {
        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_red
        tAfterI.image_alpha=0.6; tAfterI.image_xscale=image_xscale; tAfterI.depth=8; tAfterI.imageFade=0.03
        tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0; tAfterI.bFollow=-1

        if myDirType=0 //Right
        {
          x+=groundMoveSpd
          if x>=room_width+96 {atkTime=1000}
        }
        else //Left
        {
          x-=groundMoveSpd
          if x<=-96 {atkTime=1000}
        }

        if atkTime mod groundFireFreq=0 //Fireballs from ground slide
        {
          var tNewAttack;
          tNewAttack=instance_create(x-(12*image_xscale),yGround,oGravPassBullet)
          tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=7
          tNewAttack.atkPower=atkPower; tNewAttack.yVel=-10; tNewAttack.image_blend=make_color_rgb(255,200,200)
        }
      }
      else if atkTime>=1000
      {
        y=-96
        atkTime=0; atkProg=5
      }
    }
    else if atkProg=7 //-------------------- Fly up (Change to Phase 2) --------------------
    {
      if atkTime>=1 and atkTime<=99
      {
        y-=8
        if y<=-96 {atkTime=100}
      }
      else if atkTime=130
      {
        var tEffect;
        for(i=0;i<12;i+=1)
        {
          tEffect=instance_create(208+random(48),208+random(16),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6; tEffect.depth=4
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.25-random(2)
          tEffect=instance_create(384+random(48),208+random(16),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6; tEffect.depth=4
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.25-random(2)
        }
        with (295914) {instance_destroy()}
        with (295915) {instance_destroy()}
        tile_layer_delete(11)
      }
      else if atkTime>=131 and atkTime<=999 //Change room
      {
        tile_layer_shift(9,0,2)
        (295787).y+=2
        for(i=0;i<16;i+=1)
        {
          tEffect=instance_create((295787).x+random(576),(295787).y+random(4),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.25+random(0.25); tEffect.image_alpha=0.6; tEffect.depth=4
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-0.25-random(2)
        }
        if (295787).y>=room_height+8 {atkTime=1000}
      }
      else if atkTime=1001 //Hex taunts
      {
        with (295787) {instance_destroy()}
        tile_layer_delete(9)
        msgCreate(0,0,"Hex","You don't think I was putting everything on just that armor do you?",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if atkTime>=1002 and atkTime<=1099 //Recover life
      {
        if life<maxLife
        {
          life+=75
          if life>maxLife {life=maxLife}
        }
      }
      else if atkTime=1130 //Start phase 2
      {
        with oBossLifeDisplay {instance_destroy()}
        oEvCh13MainA.sceneProgress=1
        with oRidleyParts {instance_destroy()}
        instance_destroy()
      }
    }

    if armorBreak=1 //Break armor
    {
      playSound(global.snd_RidleyScreamB,0,0.98,1)
      with oEnemyBase {resType[3]=2; resType[5]=4}
      var tEffect;
      for(i=0;i<12;i+=1)
      {
        tEffect=instance_create(x-((16+random(90))*image_xscale),y-16+random(95),oEffect)
        tEffect.sprite_index=sRobotExplosion; tEffect.depth=4; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      baseColor=c_white; image_blend=baseColor
      armorBreak=2
    }
    else if armorBreak>=2 and armorBreak<=59 {armorBreak+=1}
    else if armorBreak=60
    {
      msgCreate(0,0,"Jeremy","That's it! You broke his armor!#Take him down!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
      armorBreak=100
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.95 and lifePercent>=0.9 and bossProgress=0 //Add in ground slide to attack sequence
    {
      bossProgress+=1
    }
    else if lifePercent<=0.89 and lifePercent>=0.51 and bossProgress=1 //Break armor
    {
      armorBreak=1
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.21 and bossProgress=2 //Speed up fireball rate slightly and ground slide
    {
      groundMoveSpd=48
      groundFireFreq=1
      bossProgress+=1
    }
    else if lifePercent<=0.2 and lifePercent>=0.11 and bossProgress=3
    {
      var tAtkShield;
      tAtkShield=instance_create(x,y,oAtkTypeShield); tAtkShield.ownerID=id
      tAtkShield.xOffset=0; tAtkShield.yOffset=0; tAtkShield.atkType=5; tAtkShield.atkUp=1
      with oEnemyBase {resType[5]=3}
      bossProgress+=1
    }
    else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=4
    {
      if global.bBossGallery=1
      {
        bossRoomTally(34)
        global.newMapX=1496; global.newMapY=720; room_goto(rBossGallery)
      }
      else
      {
        playSound(global.snd_RidleyScreamB,0,0.98,1)
        var tWepDrop,tHeartDrop;
        for(i=0;i<4;i+=1)
        {
          var tWepDrop;
          tWepDrop=instance_create(296+(i*16),240,oWeaponPickup)
          tWepDrop.sprite_index=sMetroidMissile
          tHeartDrop=instance_create(296+(i*16),256,oHealthPickup)
          tHeartDrop.sprite_index=sMetroidHealthPickup
          tHeartDrop=instance_create(296+(i*16),272,oHealthPickup)
          tHeartDrop.sprite_index=sMetroidHealthPickup
        }
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
