#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.2
bCanTakeDamage=false

//Enemy base statistics
eName="Cackletta"
maxLife=4
life=maxLife
atkPower=4
stunResist=50
affiliation=1
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
xCenter=464
yGround=272
roomSpan=176

atkSequence=0
atkTime=0
lightAmt=1
lightWarn=35
lightDecay=15
fireAmt=2
teleAmt=4
myBats=4
timeTillReHit=0

halfTimeFloorFire=1; floorFireSide=0

floorSeq=0
repeatAction=0
hLineEffect=0

currentTele=0
lightTeleX[0]=320
lightTeleX[1]=496
lightTeleX[2]=432
lightTeleX[3]=608
lightTeleX[4]=xCenter

jeremyText="I guess this is all you Claire, since Jerry is being a little bitch about fighting her. The most notable attack she has is her Lightning Spam. There's an indicator on where the lightning will strike which has about one second of a delay before actually striking. Her secondary attack is a fireball. These aren't as threatening as the lightning, but do take care if she decides to mix the two."
chaoText="That was a lame cheapshot. She started attacking before her title card went away."
devText="There were a ton of Mario enemies I could've used for a boss encounter here. For the end level boss, I wanted something that gave off that sinister vibe and remembered being a bit creeped out by Cackletta in the 'Mario & Luigi' games. She seemed the perfect fit for the 'villain' of this Gate level. There isn't necessarily a villain used in every Gate, but for this first one, I felt it somewhat necessary to set the mood."
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
    activateBoss=2
  }

  if bActive=true and life>0
  {
    if timeTillReHit>0 //Set after dealing damage to Cackletta and keeps the player from falling on her again and taking damage
    {
      timeTillReHit-=1
      if timeTillReHit=0 {bCanDealDamage=true}
    }

    atkTime+=1*gDeltaTime
    if atkSequence=0 //---------- Attack: Lightning 1 ----------
    {
      if atkTime=25 {sprite_index=sCacklettaArmSwing}
      else if atkTime=29
      {
        sprite_index=sCacklettaWings
        atkTime+=bossProgress*3
      }
      else if atkTime=40
      {
        var tAtkLight,tExLightSpan,tAtkAmt;
        tAtkAmt=lightAmt
        if life=1
          tAtkAmt+=1
        for(i=0;i<tAtkAmt;i+=1)
        {
          if i=0
            tAtkLight=instance_create(oPlayer1.x,yGround,oCackLightning)
          else
          {
            tExLightSpan=(xCenter-roomSpan)+random(roomSpan*2)
            tAtkLight=instance_create(tExLightSpan,yGround,oCackLightning)
          }
          tAtkLight.type=i
          tAtkLight.warnTime=lightWarn
          tAtkLight.decay=lightDecay
        }
        atkTime+=bossProgress*3
      }
      else if atkTime=55
      {
        sprite_index=sCacklettaIdle
        atkTime+=bossProgress*7
      }
      else if atkTime=80 {atkSequence+=1; atkTime=0}
    }
    else if atkSequence=1 //---------- Attack: Fire 1 ----------
    {
      if atkTime=5 {sprite_index=sCacklettaArmSwing}
      else if atkTime=9
      {
        sprite_index=sCacklettaWings
        playSound(global.snd_Fireball,0,0.99,1)
        var tFire;
        for(i=0;i<8;i+=1)
        {
          tFire=instance_create(x,y-24-random(sprite_height-24),oPassBullet)
          if i<3 {tFire.direction=0}
          else {tFire.direction=180}
          tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
          tFire.bulletSpeed=(10+random(2)); tFire.decayTime=-100
        }
        atkTime+=bossProgress*4
      }
      else if atkTime=40
      {
        sprite_index=sCacklettaIdle
        var tFire;
        for(i=0;i<fireAmt;i+=1)
        {
          if i<fireAmt/2
          {
            tFire=instance_create(xCenter-roomSpan-68,yGround-8-(i*16),oPassBullet)
            tFire.direction=0
          }
          else
          {
            tFire=instance_create(xCenter+roomSpan+68,yGround-8-(i*16),oPassBullet)
            tFire.direction=180
          }
          tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
          tFire.bulletSpeed=(1+fireAmt); tFire.decayTime=150
        }
        atkTime+=bossProgress*5*gDeltaTime
      }
      else if atkTime=60
      {
        if bossProgress=0 {atkSequence=100}
        else if bossProgress=1 {atkSequence+=1}
        else if bossProgress=2
        {
          repeatAction+=1
          if repeatAction=2
          {
            repeatAction=0
            atkSequence+=1
          }
        }
        atkTime=0
      }
    }
    else if atkSequence=2 //---------- Attack: Lightning 2 ----------
    {
      if atkTime=10 {sprite_index=sCacklettaArmSwing}
      else if atkTime=14
      {
        sprite_index=sCacklettaWings
        atkTime+=bossProgress*5
      }
      else if atkTime=40
      {
        var tAtkLight,tExLightSpan;
        for(i=0;i<lightAmt;i+=1)
        {
          if i=0
            tAtkLight=instance_create(oPlayer1.x,yGround,oCackLightning)
          else
          {
            tExLightSpan=(xCenter-roomSpan)+random(roomSpan*2)
            tAtkLight=instance_create(tExLightSpan,yGround,oCackLightning)
          }
          tAtkLight.type=i
          tAtkLight.warnTime=lightWarn/2
          tAtkLight.decay=lightDecay/2
        }
        atkTime+=bossProgress*4
      }
      else if atkTime=60
      {
        repeatAction+=1
        if repeatAction=bossProgress*2
        {
          sprite_index=sCacklettaIdle
          repeatAction=0
          atkSequence+=1
        }
        atkTime=0
      }
    }
    else if atkSequence=3 //---------- Attack: Fire 2 ----------
    {
      if atkTime=5 {sprite_index=sCacklettaArmSwing}
      else if atkTime=9
      {
        sprite_index=sCacklettaWings
        playSound(global.snd_Fireball,0,0.99,1)
        var tFire;
        for(i=0;i<16;i+=1)
        {
          tFire=instance_create(x,y-24-random(sprite_height-24),oPassBullet)
          if i mod 2=0 {tFire.direction=42+i}
          else {tFire.direction=138-i}
          tFire.sprite_index=sBowserFire1
          tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
          tFire.bulletSpeed=(6+random(3)); tFire.decayTime=-100
        }
        atkTime+=bossProgress*3
      }
      else if atkTime=35 {sprite_index=sCacklettaLaugh}
      else if atkTime>=40 and atkTime<=150+(bossProgress*40)
      {
        if atkTime mod 14-(bossProgress*4)=0
        {
          playSound(global.snd_Fireball,0,0.98,1)
          var tFire,tRanX;
          tRanX=(xCenter-roomSpan+16)+random(roomSpan*2-32)
          tFire=instance_create(tRanX,-4,oPassBullet)
          tFire.direction=260+random(20); tFire.sprite_index=sBowserFire1
          tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
          tFire.bulletSpeed=(1+(fireAmt*1.25)); tFire.decayTime=150

          tFire=instance_create(oPlayer1.x,-4,oPassBullet)
          tFire.direction=270; tFire.sprite_index=sBowserFire1
          tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
          tFire.bulletSpeed=4; tFire.decayTime=150
        }
      }
      else if atkTime=160+(bossProgress*40)
      {
        sprite_index=sCacklettaIdle
        atkTime+=bossProgress*2
      }
      else if atkTime>=170+(bossProgress*40)
      {
        if bossProgress=1 {atkSequence=100}
        else if bossProgress=2 {atkSequence+=1}
        atkTime=0
      }
    }
    else if atkSequence=4 //---------- Attack: Teleport Lightning ----------
    {
      if atkTime=1 //Choose new location
      {
        newLoc=lightTeleX[currentTele]
        currentTele+=1
        if currentTele>=5 {currentTele=0}
        if life=1 {atkTime+=5*gDeltaTime}
      }
      else if atkTime>=20 and atkTime<=90 //Go to new location
      {
        var tMoveSpd;
        if life=1 {tMoveSpd=16}
        else {tMoveSpd=8}
        if x<newLoc {x+=tMoveSpd*gDeltaTime}
        else {x-=tMoveSpd*gDeltaTime}

        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index
        tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
        tAfterI.imageFade=0.15; ; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0

        if x=newLoc {atkTime=100}
      }
      else if atkTime=102 //Anim start (And fire from side on bottom)
      {
        sprite_index=sCacklettaArmSwing
        if halfTimeFloorFire mod 2=0
        {
          floorFireSide+=1
          if floorFireSide mod 2=0
          {
            tFire=instance_create(xCenter-roomSpan-68,yGround-8,oPassBullet)
            tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
            tFire.bulletSpeed=5; tFire.decayTime=150
          }
          else
          {
            tFire=instance_create(xCenter+roomSpan+68,yGround-8,oPassBullet)
            tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
            tFire.bulletSpeed=5; tFire.decayTime=150; tFire.direction=180
          }
        }
      }
      else if atkTime=106 //Use lightning
      {
        sprite_index=sCacklettaWings
        var tAtkLight;
        tAtkLight=instance_create(oPlayer1.x,yGround,oCackLightning)
        tAtkLight.type=0; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
        if repeatAction mod 2=0
        {
          var tAtkLight;
          tAtkLight=instance_create(x,yGround,oCackLightning)
          tAtkLight.type=1; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
        }
        else
        {
          var tAtkLight;
          tAtkLight=instance_create(x-24,yGround,oCackLightning)
          tAtkLight.type=1; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
          tAtkLight=instance_create(x+24,yGround,oCackLightning)
          tAtkLight.type=1; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
        }
      }
      else if atkTime=112 //Repeat
      {
        sprite_index=sCacklettaIdle
        halfTimeFloorFire+=1
        repeatAction+=1
        if repeatAction=teleAmt
        {
          repeatAction=0
          newLoc=xCenter
          atkTime=115
        }
        else {atkTime=0}
      }
      else if atkTime>=120 and atkTime<=190 //Go to middle
      {
        var tMoveSpd;
        if life=1 {tMoveSpd=16}
        else {tMoveSpd=8}
        if x<newLoc {x+=tMoveSpd*gDeltaTime}
        else {x-=tMoveSpd*gDeltaTime}

        var tAfterI;
        tAfterI=instance_create(x,y,oEnemyAfterImage)
        tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index
        tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
        tAfterI.imageFade=0.15; ; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0

        if x=newLoc
        {
          if life=1 {halfTimeFloorFire=1; floorFireSide=0; atkSequence+=1}
          else {atkSequence=100}
          atkTime=0
        }
      }
    }
    else if atkSequence=5 //---------- Attack: Platform Lightning ----------
    {
      if atkTime=20 {sprite_index=sCacklettaLaugh}
      else if atkTime=25 //Choose location
      {
        locA=0; locAnum=0
        locB=0; locBnum=0
        if repeatAction=0 {locA=296; locAnum=4} //1
        else if repeatAction=1 {locA=424; locAnum=6} //2
        else if repeatAction=2 {locA=584; locAnum=4} //3
        else if repeatAction=3 {locA=296; locAnum=4; locB=424; locBnum=6} //1,2
        else if repeatAction=4 {locA=296; locAnum=4; locB=584; locBnum=4} //1,3
        else if repeatAction=5 {locA=424; locAnum=6; locB=584; locBnum=4} //2,3
        else if repeatAction=6 {locA=296; locAnum=4; locB=584; locBnum=4} //1,3
        else if repeatAction=7 {locA=424; locAnum=6; locB=584; locBnum=4} //2,3
        else if repeatAction=8 {locA=296; locAnum=4; locB=424; locBnum=6} //1,2
      }
      else if atkTime=30 //Use lightning
      {
        var tAtkLight;
        for(i=0;i<locAnum;i+=1)
        {
          tAtkLight=instance_create(locA+(i*16),yGround,oCackLightning)
          tAtkLight.type=i; tAtkLight.warnTime=lightWarn+30; tAtkLight.decay=lightDecay-5
        }
        for(i=0;i<locBnum;i+=1)
        {
          tAtkLight=instance_create(locB+(i*16),yGround,oCackLightning)
          tAtkLight.type=1; tAtkLight.warnTime=lightWarn+30; tAtkLight.decay=lightDecay-5
        }
      }
      else if atkTime=60 //Fire from side on bottom
      {
        if halfTimeFloorFire mod 2=0
        {
          floorFireSide+=1
          if floorFireSide mod 2=0
          {
            for(i=0;i<2;i+=1)
            {
              tFire=instance_create(xCenter-roomSpan-68,yGround-8-(i*20),oPassBullet)
              tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
              tFire.bulletSpeed=5; tFire.decayTime=150
            }

          }
          else
          {
            for(i=0;i<2;i+=1)
            {
              tFire=instance_create(xCenter+roomSpan+68,yGround-8-(i*20),oPassBullet)
              tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
              tFire.bulletSpeed=5; tFire.decayTime=150; tFire.direction=180
            }
          }
        }
        halfTimeFloorFire+=1
        repeatAction+=1
        if repeatAction=9
        {
          halfTimeFloorFire=1; floorFireSide=0
          repeatAction=0
          atkSequence=100
        }
        atkTime=0
      }
    }
    else if atkSequence=100 //---------- Summon bats and bring out phone ----------
    {
      if atkTime=25
      {
        sprite_index=sCacklettaArmSwing
        myBats=4
      }
      else if atkTime=29
      {
        sprite_index=sCacklettaWings
        var tBat;
        for(i=0;i<8;i+=1)
        {
          tBat=instance_create(x,y-(sprite_height/2),oCackBat)
          tBat.type=0; tBat.xSpd=(random_range(-2.5,2.5))/4; tBat.ySpd=random(1)/4
        }
      }
      else if atkTime=60
      {
        sprite_index=sCacklettaPhone1; image_index=0
        bCanTakeDamage=true
      }
      else if atkTime>=61
      {
        if image_index>=3.6
        {
          sprite_index=sCacklettaPhone2; image_index=0
          atkSequence+=1
          atkTime=0
        }
      }
    }
    else if atkSequence=101 //---------- Use phone and spawn bats from side ----------
    {
      if atkTime=15
      {
        var tBat;
        for(i=0;i<4;i+=1)
        {
          if i<=1 //left
          {
            tBat=instance_create(xCenter-roomSpan-68,yGround-32-random(32),oCackBat)
            tBat.xSpd=2+i
            tBat.xSpd=tBat.xSpd*gDeltaTime
          }
          else //right
          {
            tBat=instance_create(xCenter+roomSpan+68,yGround-32-random(32),oCackBat)
            tBat.xSpd=-2-i
            tBat.xSpd=tBat.xSpd*gDeltaTime
          }
          tBat.type=1
        }
        atkTime+=bossProgress*15
      }
      else if atkTime=150
      {
        sprite_index=sCacklettaIdle
        bCanTakeDamage=false
        atkSequence=0; atkTime=0
      }
    }

    //Floor movement
    /*if floorSeq>=1 and floorSeq<=2
    {
      if floorSeq=1
      {
        var tEffect;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(344,280+(i*12),oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

          tEffect=instance_create(584,280+(i*12),oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        oSlavePlatform.yVel=1*gDeltaTime
        floorSeq=2
      }
      tile_layer_shift(999999,0,1)
      if !instance_exists(oSlavePlatform)
      {
        oMarioLava.depth=10
        tile_layer_depth(1000010,10)
        tile_layer_delete(999999)
        floorSeq=3
      }
    }*/

    if floorSeq>=1 and floorSeq<=2
    {
      if floorSeq=1
      {
        var tEffect;
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(344,280+(i*12),oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

          tEffect=instance_create(584,280+(i*12),oEffect)
          tEffect.sprite_index=sMMSmokeCloud
          tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        (GID(132430)).yVel=1
        floorSeq=2
      }
      tile_layer_shift(999999,0,1)
      if !instance_exists((GID(132430)))
      {
        oMarioLava.depth=10
        tile_layer_depth(1000010,10)
        tile_layer_delete(999999)
        floorSeq=3
      }
    }


    //---------- Boss Difficulty Curve ----------
    if bossProgress=0 and life=3
    {
      lightAmt+=1
      lightWarn-=4
      lightDecay+=4
      fireAmt+=2
      bossProgress+=1
    }
    else if bossProgress=1 and life=2
    {
      lightAmt+=1
      lightWarn-=4
      lightDecay+=4
      bossProgress+=1
    }
    else if floorSeq=0 and life=1
    {
      lightWarn-=1
      lightDecay+=1
      teleAmt+=2
      floorSeq=1
    }
  }
  else if life<=0 //Defeat animation
  {
    atkTime+=1*gDeltaTime
    if atkSequence=0 //Fall to the floor
    {
      if atkTime mod 5=0
      {
        var tEffect;
        for(i=0;i<6;i+=1)
        {
          tEffect=instance_create(x-12+random(24),bbox_bottom-4-random(sprite_height-8),oKillEffect)
          tEffect.speed=5*gDeltaTime; tEffect.direction=random(360); tEffect.friction=0.1+random(0.3)
          tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
        }
      }
      if current_frame mod (1/gDeltaTime)==0 and y<yGround {y+=1}

      if atkTime>=105 {atkTime=0; atkSequence+=1}
    }
    else if atkSequence=1 //Slight wait
    {
      if atkTime>=30 {atkSequence+=1}
    }
    else if atkSequence=2 //Fade away
    {
      if atkTime mod 2=0
      {
        var tEffect;
        for(i=0;i<5;i+=1)
        {
          tEffect=instance_create(bbox_left+random(sprite_width),bbox_bottom+1+random(4),oKillEffect)
          tEffect.speed=6*gDeltaTime; tEffect.direction=80+random(20)
          tEffect.friction=0.2+random(0.6); tEffect.image_xscale=0.3+random(0.2); tEffect.image_yscale=0.3+random(0.2)
          tEffect.image_blend=make_color_rgb(173,73,222); tEffect.fadeAlpha=0.04+random(0.04)
          tEffect.imageRot=0
        }
      }
      hLineEffect+=0.25*gDeltaTime
      if hLineEffect>=29 {atkTime=0; atkSequence+=1}
    }
    else if atkSequence=3 //Slight wait
    {
      if atkTime>=30 {atkSequence+=1}
    }
    else if atkSequence=4
    {
      if global.bBossGallery=1
      {
        bossRoomTally(1)
        global.newMapX=408; global.newMapY=1376; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanTakeDamage=true
{
  yAdjust=0
  with oPlayer1
  {
    if platformCharacterIs(ON_GROUND)
      other.yAdjust=-12
    if platformCharacterIs(IN_AIR)
      other.yAdjust=0
  }
  veloAssist=0
  if oPlayer1.yVel>0
    veloAssist=round(oPlayer1.yVel/2)

  if bbox_bottom+yAdjust+veloAssist<oPlayer1.bbox_bottom
  {
    if bCanDealDamage=true
    {
      with other
        hitPlayer(other)
    }
  }
  else
  {
    if global.hasAbilToken[0]>=2 and oPlayer1.starmanTime<=0
    {
      if oPlayer1.bCanTakeHit=true and oPlayer1.bCanTakeDamage=true and oPlayer1.dashInvulnerabilityTime=0
      {
        with oPlayer1
        {
          if platformCharacterIs(ON_GROUND)
            yVel=-2
          if platformCharacterIs(IN_AIR)
          {
            if kJump or kUp
              yVel=-13.5
            else
              yVel=-6.5
          }
          scrSlowFall(5,0.4,0)
          y-=16
        }

        //Damage effect
        var tFlash,tEffect;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.image_alpha=0.5
        tFlash.fadeSpeed=0.1
        playSound(global.snd_MarioStomp,0,0.98,1)
        for(i=0;i<9;i+=1)
        {
          tEffect=instance_create(x-12+random(24),bbox_top+8,oKillEffect)
          tEffect.speed=5; tEffect.direction=55+(i*8)+random(4)
          tEffect.friction=0.1+random(0.3); tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
        }
        oPlayer1.canAirDash=1
        oPlayer1.doubleJumpCheck=1
        life-=1 //Damage Cackletta
        sprite_index=sCacklettaIdle
        timeTillReHit=50
        bCanDealDamage=false
        bCanTakeDamage=false
        atkSequence=0
        atkTime=0
        if life=1
        {
          myHeartDrop=instance_create(x,y-24,oHealthPickup)
        }
        if life=0 //Boss defeat
        {
          sprite_index=sCacklettaDefeat
          bCanDealDamage=false
          atkSequence=0
          atkTime=0
        }
      }
    }
    else
    {
      if bCanDealDamage=true
      {
        with other
          hitPlayer(other)
      }
    }
  }
}
else
{
  if bCanDealDamage=true
  {
    with other
      hitPlayer(other)
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0
{
  event_inherited()
  if sprite_index=sCacklettaWings
  {
    draw_sprite(sCacklettaHands,-1,x,y-50)
  }
}
else
  draw_sprite_part(sprite_index,0,0,0,sprite_width,sprite_height-hLineEffect,x-(sprite_width/2),y-sprite_height+4+hLineEffect)
