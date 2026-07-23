#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanDealDamage=0

//Enemy base statistics
eName="Hex"
eLevel=40
maxLife=14000
life=maxLife
atkPower=10
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
bossProgress=0
activateBoss=0

//--------------------
phaseTimeShiftA=0
phaseTimeShiftB=0
phaseTimeShiftC=0
phaseTimeShiftD=0
phaseTimeShiftE=0
//Animation Data
wingFrm=-1
xJitter=0
fadeoutHexAF_Scale=1
fadeoutHexAF_Alpha=0.33
bHexCircleBack=0
hexCircleBack_Alpha=0
hexCircleBack_Angle=0
hexCBackAlphaUp=1
dashSpeed=0
bHexFlame=0
hexFlameFrm=0
bMoveHexUp=0
bJumpedOn=0
finalMomentTime=0
topFireAmt=0
topFireFrm=0

//Movement Data
bMoveOpposite=0
moveSpd=0
xPoint=0
yPoint=0
mySide=1 //1-Left, 2-Right
sideSwap=0
currHspd=0; currVspd=0
maxSpeed=3
bRunAway=0
closeTime=0
centerMyself=0
bHexChains=0

//Attack Data
bSliceAtk=1
sliceTime=150
sliceDelay=240

bSwapDeter=0
swapDeterTime=810
swapDeterDelay=930
preSwapWarnAngle=0

bHexHands=0
hexHandTime=170
hexHandDelay=200

bCeilingAtk=0
ceilingAtkTime=430
ceilingAtkDelay=490

bFloorFire=0
floorFireTime=280
floorFireDelay=330

bEyeSummon=0
eyeSumTime=0
eyeSumDelay=75
eyeSumDir=1

bRainLightning=0
lightRainTime=180
lightRainDelay=250
lightRainX=208

desperationProg=0
desperationTime=0
despBubbleShield=0
despWarn=0
despX1=224; despX2=320; despX3=416; despX4=512; despX5=608
despTopLoop=0
despSpin=0

//Shield Data
shieldProg=0
shieldTime=0

midFightShield=0

//Misc Data
xCenter=448
yGround=288
roomSpan=240
jerryWeakWarn=0
jerryWeakened=0
platformSpawn=0
platformA=0
platformB=0
platformC=0
heartDrop=0

backChange=0
backTime=0

jeremyText="Once again, I've got nothing on him... oh wait! I found something! Okay, check this out. Dealing damage to Hex will cause him to increment some invisible counter for some desperation-like attack. Huh, from what I'm seeing, dealing too much damage to him will cause him to become invulnerable? Wait what... According to this, Hex has a way of fully recovering his HP instantly. Okay, he also has an ability that can one-shot you. When you see a lightning spark on your idle character, swap to them immediately or it's instant Game Over, ouch. And it also looks like my text is bleeding off the edge of the window. This is weird you guys. What the hell is Hex trying to pull here?#Gobbldepoop.#Bleh, Hex is screwing with things on my end and inserting words into my scan info."
chaoText="Hex has a ton of things at his disposal. More than anything else you've faced. I don't know how much truth there is to Jeremy's info, but there is some sort of desperation attack type of thing, just one from what I'm seeing. Anyway, he has an ability to somewhat cut off swapping to your partner. He doesn't really attack much directly, but will summon things to fight for him. Big note, I can scan almost ANYTHING Hex summons up."
devText="Hex blocks dev commentary."

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
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //-------------------- Manage Background Change --------------------
    if backChange=0 //Wait for change
    {
      backTime+=1
      if backTime>=60 {backTime=0; backChange+=1}
    }
    else if backChange=1 //Fade in skull background
    {
      background_alpha[1]+=0.01
      if background_alpha[1]>=1 {backChange+=1}
    }

    //-------------------- Movement --------------------
    if bMoveOpposite=1
    {
      if mySide=2 //Right
      {
        if oPlayer1.x>xCenter
        {
          sideSwap+=1
          if sideSwap=15 {sideSwap=0; mySide=1}
        }
        else {sideSwap=0}

        var tXCheck;
        tXCheck=(xCenter-oPlayer1.x)/1.85
        xPoint=608-tXCheck
      }
      else //Left
      {
        if oPlayer1.x<xCenter
        {
          sideSwap+=1
          if sideSwap=15 {sideSwap=0; mySide=2}
        }
        else {sideSwap=0}

        var tXCheck;
        tXCheck=(oPlayer1.x-xCenter)/1.85
        xPoint=288+tXCheck
      }

      var tYCheck;
      tYCheck=(yGround-oPlayer1.y)/4.5
      yPoint=176-tYCheck

      if x>xPoint
      {
        if currHspd>-maxSpeed {currHspd-=0.4}
        else {currHspd+=0.4}
      }
      else if x<xPoint
      {
        if currHspd<maxSpeed {currHspd+=0.4}
        else {currHspd-=0.4}
      }
      if y>yPoint
      {
        if currVspd>-maxSpeed {currVspd-=0.4}
        else {currVspd+=0.4}
      }
      else if y<yPoint
      {
        if currVspd<maxSpeed {currVspd+=0.4}
        else {currVspd-=0.4}
      }
      hspeed=currHspd; vspeed=currVspd

      //Speed away
      if bRunAway=1
      {
        if point_distance(x,y,oPlayer1.x,returnPlayerYCenter())<96
        {
          closeTime+=1
          if closeTime>=13 and closeTime<=99 {dashSpeed=9; closeTime=100}
        }

        if closeTime>=100
        {
          closeTime+=1
          var tAfterI;
          tAfterI=instance_create(x,y,oEnemyAfterImage)
          tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.image_blend=c_green
          tAfterI.image_alpha=0.7; tAfterI.image_xscale=image_xscale; tAfterI.depth=26; tAfterI.imageFade=0.05
          tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0
          tAfterI.bFollow=0; tAfterI.idFollow=-1; tAfterI.xFollow=0; tAfterI.yFollow=0

          direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())-180
          if oPlayer1.x<xCenter and x<xCenter {direction=0}
          else if oPlayer1.x>xCenter and x>xCenter {direction=180}
          speed=dashSpeed
          if dashSpeed>6 {dashSpeed-=0.33}

          if closeTime>=121 {closeTime=0}
        }
      }
    }

    //----- Recenter Hex -----
    if centerMyself=1
    {
      speed=0
      if x<447 {x+=2}
      else if x>449 {x-=2}
      if y<159 {y+=2}
      else if y>161 {y-=2}

      if point_distance(x,y,448,160)<4
      {
        x=448; y=160
        bSliceAtk=0
        midFightShield=1
        centerMyself=0
      }
    }

    //-------------------- Hex Shield Orb --------------------
    if shieldProg=-1 //Retract wings
    {
      shieldTime+=1
      if shieldTime=5 {wingFrm=1}
      else if shieldTime=10 {wingFrm=0}
      else if shieldTime=15 {wingFrm=-1}
      else if shieldTime>=20 {shieldProg+=1; shieldTime=0}
    }
    else if shieldProg=0 //Spawn orbs
    {
      shieldTime+=1
      if shieldTime>=20
      {
        if bossProgress=0
        {
          for(i=0;i<4;i+=1)
          {
            myShield=instance_create(x,y,oHex_ShieldOrb)
            myShield.myDir=45+(i*90); myShield.atkPower=atkPower
          }
        }
        else if bossProgress>=4 and bossProgress<=5
        {
          for(i=0;i<3;i+=1)
          {
            myShield=instance_create(x,y,oHex_ShieldOrb)
            myShield.myDir=90+(i*120); myShield.atkPower=atkPower
          }
        }
        else if bossProgress>=7 and bossProgress<=8
        {
          for(i=0;i<2;i+=1)
          {
            myShield=instance_create(x,y,oHex_ShieldOrb)
            myShield.myDir=i*180; myShield.atkPower=atkPower
          }
        }
        else if bossProgress>=11 and bossProgress<=12
        {
          myShield=instance_create(x,y,oHex_ShieldOrb)
          myShield.myDir=90; myShield.atkPower=atkPower
        }
        image_index=1
        bCanTakeDamage=false
        shieldProg+=1; shieldTime=0
      }
    }
    else if shieldProg=1 //Wait till orbs are destroyed
    {
      if !instance_exists(oHex_ShieldOrb)
      {
        if desperationProg=0 //Start desperation attack
        {
          with oHex_SwapDeterrent {instance_destroy()}
          with oHex_Sapper {instance_destroy()}
          with oHF_HexHand {instance_destroy()}
          topFireAmt+=1
          bSliceAtk=0; bHexHands=0; bSwapDeter=0
          swapDeterTime=780; hexHandTime=150; sliceTime=140
          despBubbleShield=1
          shieldProg+=1
          desperationProg+=1
        }
        else
        {
          bCanTakeDamage=true
          shieldProg+=2
        }
      }
    }
    else if shieldProg=3 //Hex animation
    {
      shieldTime+=1
      if shieldTime=10 {image_index=2}
      else if shieldTime>=11 and shieldTime<=26
      {
        if xJitter=1 {xJitter=-1}
        else {xJitter=1}
      }
      else if shieldTime=27
      {
        wingFrm=0; xJitter=0
        var tEffect,tXspd;
        for(i=0;i<32;i+=1)
        {
          tXspd=random_range(-4,4)
          tEffect=instance_create(x+random_range(-3,3),y+random_range(-12,12),oEffectGrav)
          tEffect.type=2; tEffect.sprite_index=sHex_A_EfFeather
          tEffect.xSpd=tXspd; tEffect.ySpd=-2-random(2); tEffect.fadeSpd=0.04; tEffect.rotation=-tXspd*9
          tEffect.grav=0.3; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        }
      }
      else if shieldTime=31 {wingFrm=1}
      else if shieldTime=35
      {
        wingFrm=2; shieldTime=0
        if bossProgress<=2 {shieldProg=4}
        else {shieldProg=5}
      }
    }
    else if shieldProg=4 //Spawn eyes
    {
      shieldTime+=1
      if shieldTime>=65
      {
        var tMyEye;
        tMyEye=instance_create(x,y,oHF_HexEye); tMyEye.atkPower=atkPower; tMyEye.type=0
        tMyEye=instance_create(x,y,oHF_HexEye); tMyEye.atkPower=atkPower; tMyEye.type=1
        shieldTime=0; shieldProg+=1
      }
    }

    //-------------------- ATTACK: SCREEN SLICE --------------------
    if bSliceAtk=1
    {
      sliceTime+=1
      if sliceTime>=sliceDelay
      {
        var tSrnSlice,tXX1,tYY1,tXX2,tYY2;
        tXX1=oPlayer1.x-240; tYY1=returnPlayerYCenter()-240
        tXX2=oPlayer1.x+240; tYY2=returnPlayerYCenter()-240
        tSrnSlice=instance_create(tXX1,tYY1,oHex_First_Slash)
        tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=315
        tSrnSlice=instance_create(tXX2,tYY2,oHex_First_Slash)
        tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=225
        sliceTime=0
      }
    }

    //-------------------- ATTACK: SWAP DETERRENT --------------------
    if bSwapDeter=1
    {
      if !instance_exists(oHex_SwapDeterrent)
      {
        swapDeterTime+=1
        if swapDeterTime>=swapDeterDelay
        {
          instance_create(oPlayerIdle.x,oPlayerIdle.y-26,oHex_SwapDeterrent)
          swapDeterTime=0
        }
      }
    }

    //-------------------- ATTACK: HEX HAND --------------------
    if bHexHands=1
    {
      hexHandTime+=1
      if hexHandTime>=hexHandDelay and hexHandTime<=hexHandDelay+100
      {
        playSound(global.snd_HardHit2,0,1,6000)
        var tHexHand;
        tHexHand=instance_create(xCenter-192,560,oHF_HexHand); tHexHand.atkPower=atkPower; tHexHand.image_xscale=-1
        tHexHand=instance_create(xCenter+192,560,oHF_HexHand); tHexHand.atkPower=atkPower
        hexHandTime=10000
      }
      else if hexHandTime>=10010
      {
        if !instance_exists(oHF_HexHand) {hexHandTime=0}
      }
    }

    //-------------------- ATTACK: FALLING DOOM --------------------
    if bCeilingAtk=1
    {
      ceilingAtkTime+=1
      if ceilingAtkTime>=ceilingAtkDelay
      {
        playSound(global.snd_Infect,0,1,12000)
        var tAtk;
        for(i=0;i<8;i+=1)
        {
          tAtk=instance_create(224+(i*64),-16,oHF_FallingDoom)
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=0.75; tAtk.image_speed=0.33; tAtk.direction=270
        }
        ceilingAtkTime=0
      }
    }

    //-------------------- ATTACK: FLOOR FIRE --------------------
    if bFloorFire=1
    {
      floorFireTime+=1
      if floorFireTime>=floorFireDelay and floorFireTime<=floorFireDelay+100
      {
        var tFloorFire;
        tFloorFire=instance_create(xCenter-roomSpan+8,yGround+48,oHF_FloorFire); tFloorFire.atkPower=atkPower
        floorFireTime=10000
      }
      else if floorFireTime>=10010
      {
        if !instance_exists(oHF_FloorFire) {floorFireTime=0}
      }
    }

    //-------------------- ATTACK: RAIN LIGHTNING --------------------
    if bRainLightning=1
    {
      lightRainTime+=1
      if lightRainTime=lightRainDelay
      {
        playSound(global.snd_LightballSpread,0,1,12000)
        lightRainX=208
        var tEffect,tDir;
        tDir=0
        for(i=0;i<16;i+=1)
        {
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sMMchargeEffect1; tEffect.image_speed=0.25; tEffect.image_xscale=3; tEffect.image_yscale=3
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.direction=tDir
          tEffect.speed=6; tEffect.friction=0.2
          tDir+=360/16
        }
      }
      if lightRainTime>=lightRainDelay+40
      {
        if lightRainTime mod 3=0
        {
          var tAtk,tDir;
          tDir=point_direction(lightRainX,8,oPlayer1.x,returnPlayerYCenter())
          tAtk=instance_create(lightRainX,8,oHF_HexBulletRed)
          tAtk.sprite_index=sHFight_HandZap; tAtk.atkPower=atkPower; tAtk.bulletSpeed=6
          tAtk.image_speed=0.33; tAtk.decayTime=-100; tAtk.direction=tDir
          lightRainX+=32
          if lightRainX>=688 {lightRainTime=0}
        }
      }
    }

    //-------------------- ATTACK: SUMMON MOVING EYE --------------------
    if bEyeSummon=1
    {
      eyeSumTime+=1
      if eyeSumTime>=eyeSumDelay
      {
        var tEyeSummon;
        tEyeSummon=instance_create(x,y,oHF_MovingEye)
        if eyeSumDir=1 {tEyeSummon.moveSpeed=2; eyeSumDir=2}
        else {tEyeSummon.moveSpeed=-2; eyeSumDir=1}
        eyeSumTime=0
      }
    }

    //-------------------- Control how Jerry is weakened --------------------
    if jerryWeakened>0
    {
      jerryWeakened+=1
      if jerryWeakened=80
      {
        msgCreate(0,0,"Jerry","Crap, you guys, that poison is doing its thing again!",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if jerryWeakened=220
      {
        topFireAmt+=1
        jerryWeakWarn=0
      }
    }

    //-------------------- Create platforms --------------------
    if platformSpawn>0 and platformSpawn<=300
    {
      platformSpawn+=1
      if platformSpawn=55
      {
        bMoveOpposite=1
      }
      else if platformSpawn=75
      {
        platformA=instance_create(288,288,oHF_Platform); platformA.type=0
        platformB=instance_create(544,288,oHF_Platform); platformB.type=0
        platformC=instance_create(288,128,oHF_Platform); platformC.type=1
      }
      else if platformSpawn=160
      {
        msgCreate(0,0,"Hex","Really Jeremy? Three whole platforms is all you could muster?",0,1,oMessagePerson,0); newMessage.fadingTime=130
      }
      else if platformSpawn=290
      {
        msgCreate(0,0,"Jeremy","I know your next trick. It'll be enough for them.",0,1,oMessagePerson,0); newMessage.fadingTime=120
      }
    }
    else if platformSpawn>=500 and platformSpawn<=550
    {
      platformSpawn+=1
      if platformSpawn>=511 and platformSpawn<=900
      {
        platformA.yVel=1; platformB.yVel=1
        if platformA.y>=224
        {
          platformA.yVel=0; platformB.yVel=0
          platformA.y=224; platformB.y=224
          platformSpawn=1000
        }
      }
    }

    //-------------------- Mid fight shield --------------------
    if midFightShield>=1
    {
      midFightShield+=1
      if midFightShield<=145
      {
        if midFightShield mod 11=0
        {
          tSrnSlice=instance_create(oPlayer1.x,0,oHex_First_Slash)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=270
        }
      }
      else if midFightShield>=150 and midFightShield<=200
      {
        if midFightShield mod 11=0
        {
          tSrnSlice=instance_create(xCenter-roomSpan,returnPlayerYCenter(),oHex_First_Slash)
          tSrnSlice.atkPower=atkPower; tSrnSlice.image_angle=0
        }
      }
      else if midFightShield>=210
      {
        bCanTakeDamage=true
        bRainLightning=1
        despBubbleShield=0
        midFightShield=0
      }
    }

    //-------------------- Move Hex up near the end of the fight --------------------
    if bMoveHexUp=1
    {
      y-=1
      if y<=116
      {
        bHexChains=1
        var tScnFlash;
        tScnFlash=instance_create(0,0,oScreenFlash)
        tScnFlash.image_blend=c_maroon; tScnFlash.image_alpha=0.75; tScnFlash.fadeSpeed=0.05
        bMoveHexUp=0
      }
    }

    //-------------------- Remove Ability: Megaman --------------------
    if phaseTimeShiftA>0 and phaseTimeShiftA<=100
    {
      phaseTimeShiftA+=1
      if phaseTimeShiftA=40
      {
        var tRemoveAbility;
        tRemoveAbility=instance_create(x,y,oHF_AbilitySteal); tRemoveAbility.type=1
        phaseTimeShiftA=200
      }
    }
    else if phaseTimeShiftA>=500
    {
      phaseTimeShiftA+=1
      if phaseTimeShiftA=540
      {
        msgCreate(0,0,"Jerry","Oooh damn. Hex just removed my Mega Man abilities.",0,1,oMessagePerson,0); newMessage.fadingTime=100
      }
      else if phaseTimeShiftA=640
      {
        msgCreate(0,0,"Hex","This just in! You're going to die!",0,1,oMessagePerson,0); newMessage.fadingTime=80
      }
    }

    //-------------------- Remove Ability: Samus --------------------
    if phaseTimeShiftB>0 and phaseTimeShiftB<=200
    {
      phaseTimeShiftB+=1
      if phaseTimeShiftB=2
      {
        msgCreate(0,0,"Jeremy","I fixed those resist values back, Hex.",0,1,oMessagePerson,0); newMessage.fadingTime=90
      }
      if phaseTimeShiftB=90
      {
        msgCreate(0,0,"Hex","I noticed, but how about this?",0,1,oMessagePerson,0); newMessage.fadingTime=90
      }
      else if phaseTimeShiftB=140
      {
        var tRemoveAbility;
        tRemoveAbility=instance_create(x,y,oHF_AbilitySteal); tRemoveAbility.type=2
        phaseTimeShiftB=300
      }
    }

    //-------------------- Remove Ability: Dashing --------------------
    if phaseTimeShiftC>0 and phaseTimeShiftC<=100
    {
      phaseTimeShiftC+=1
      if phaseTimeShiftC=40
      {
        var tRemoveAbility;
        tRemoveAbility=instance_create(x,y,oHF_AbilitySteal); tRemoveAbility.type=5
        phaseTimeShiftC=150
      }
    }
    else if phaseTimeShiftC>=200
    {
      phaseTimeShiftC+=1
      if phaseTimeShiftC=240
      {
        msgCreate(0,0,"Hex","Ah, that's the one I was looking for. No more dashing!",0,1,oMessagePerson,0); newMessage.fadingTime=100
      }
      else if phaseTimeShiftC=340
      {
        msgCreate(0,0,"Jeremy","I also took away some of your attacks, Hex!",0,1,oMessagePerson,0); newMessage.fadingTime=90
      }
      else if phaseTimeShiftC=430
      {
        msgCreate(0,0,"Hex","Whatever, I've got more.",0,1,oMessagePerson,0); newMessage.fadingTime=70
      }
    }

    //-------------------- Remove Ability: Link --------------------
    if phaseTimeShiftD>0
    {
      phaseTimeShiftD+=1
      if phaseTimeShiftD=30
      {
        if swapDeterTime>150 {swapDeterTime-=150}
        with oHex_SwapDeterrent {instance_destroy()}
        with oHex_Sapper {instance_destroy()}
      }
      if phaseTimeShiftD=40
      {
        var tRemoveAbility;
        tRemoveAbility=instance_create(x,y,oHF_AbilitySteal); tRemoveAbility.type=3
      }
    }

    //-------------------- Remove Ability: Belmont --------------------
    if phaseTimeShiftE>0 and phaseTimeShiftE<=100
    {
      phaseTimeShiftE+=1
      if phaseTimeShiftE=10
      {
        msgCreate(0,0,"Hex","This is it!",0,1,oMessagePerson,0); newMessage.fadingTime=70
      }
      else if phaseTimeShiftE=60
      {
        var tRemoveAbility;
        tRemoveAbility=instance_create(x,y,oHF_AbilitySteal); tRemoveAbility.type=4
        phaseTimeShiftE=150
      }
    }
    else if phaseTimeShiftE>=200 //Set up final phase
    {
      phaseTimeShiftE+=1
      if phaseTimeShiftE=230
      {
        msgCreate(0,0,"Hex","Oh this is too good. You were so close yet so far away.",0,1,oMessagePerson,0); newMessage.fadingTime=100
      }
      else if phaseTimeShiftE=330
      {
        bSliceAtk=0
        bHexFlame=1
        bMoveHexUp=1
        msgCreate(0,0,"Hex","Let's see. How to kill your friends, Jeremy...",0,1,oMessagePerson,0); newMessage.fadingTime=90
      }
      else if phaseTimeShiftE=340
      {
        var tSideFire;
        for(i=0;i<3;i+=1)
        {
          tSideFire=instance_create(xCenter-32,128+(i*40),oHF_SideFire); tSideFire.image_speed=0.3+(i*0.05)
          tSideFire=instance_create(xCenter+32,128+(i*40),oHF_SideFire); tSideFire.image_speed=0.3+(i*0.05)
        }
        tSideFire=instance_create(xCenter-14,180,oHF_SideFire); tSideFire.image_speed=0.5
        tSideFire=instance_create(xCenter+14,180,oHF_SideFire); tSideFire.image_speed=0.5
      }
      else if phaseTimeShiftE=420
      {
        msgCreate(0,0,"Jerry","What do we do now?",0,1,oMessagePerson,0); newMessage.fadingTime=80
      }
      else if phaseTimeShiftE=500
      {
        msgCreate(0,0,"Hex","You all die.",0,1,oMessagePerson,0); newMessage.fadingTime=70
      }
      else if phaseTimeShiftE=570
      {
        msgCreate(0,0,"Jeremy","No, there's another way.",0,1,oMessagePerson,0); newMessage.fadingTime=80
      }
      else if phaseTimeShiftE=650
      {
        msgCreate(0,0,"Jerry","How, we have no weapons?",0,1,oMessagePerson,0); newMessage.fadingTime=80
      }
      else if phaseTimeShiftE=730
      {
        msgCreate(0,0,"Hex","This is great. You guys seriously think you still have a chance.",0,1,oMessagePerson,0); newMessage.fadingTime=110
      }
      else if phaseTimeShiftE=840
      {
        msgCreate(0,0,"Jeremy","You guys know what to do. I can't say it or Hex might close up that opportunity.",0,2,oMessagePerson,0); newMessage.fadingTime=120
      }
      else if phaseTimeShiftE=960
      {
        msgCreate(0,0,"Hex","I'm enjoying this false hope you're giving them.",0,1,oMessagePerson,0); newMessage.fadingTime=100
      }
      else if phaseTimeShiftE=1060
      {
        for(i=0;i<5;i+=1)
        {
          tHeartDrop=instance_create(xCenter-roomSpan+64+(i*12),280,oHealthPickup)
          tHeartDrop=instance_create(xCenter+roomSpan-64-(i*12),280,oHealthPickup)
        }
        bEyeSummon=1
        instance_create(x,y,oHex_Final_JumpOn)
        msgCreate(0,0,"Jeremy","Trust me on this. It will work.",0,1,oMessagePerson,0); newMessage.fadingTime=90
      }
    }

    if desperationProg>=1 and desperationProg<=9 //Desperation Attack
    {
      event_user(0)
    }
  }
  enemyStepEvent()

  //---------- Boss Difficulty Curve ----------
  if bossProgress=0 //Phase 1
  {
    if shieldProg=1
    {
      if instance_number(oHex_ShieldOrb)<=2
      {
        topFireAmt+=1
        bHexHands=1
        bossProgress+=1
      }
    }
  }
  else if lifePercent<=0.92 and lifePercent>=0.84 and bossProgress=1 //Phase 1
  {
    topFireAmt+=1
    sliceDelay-=5
    swapDeterDelay-=10
    bossProgress+=1
  }
  else if lifePercent<=0.83 and lifePercent>=0.69 and bossProgress=2 //Phase 2
  {
    msgCreate(0,0,"Hex","Let's try something else.",0,1,oMessagePerson,0); newMessage.fadingTime=70
    topFireAmt+=1
    bCeilingAtk=1
    sliceDelay-=5
    swapDeterDelay-=10
    bossProgress+=1
  }
  else if lifePercent<=0.68 and lifePercent>=0.62 and bossProgress=3 //Phase 3
  {
    msgCreate(0,0,"Hex","You're forgetting something.",0,1,oMessagePerson,0); newMessage.fadingTime=70
    topFireAmt+=1
    jerryWeakWarn=1
    sliceDelay-=5
    swapDeterDelay-=10
    ceilingAtkDelay+=90
    bHexHands=0
    jerryWeakened=1
    bossProgress+=1
  }
  else if lifePercent<=0.61 and lifePercent>=0.56 and bossProgress=4 //Phase 4
  {
    topFireAmt+=1
    shieldProg=-1; shieldTime=0
    sliceDelay-=5
    bossProgress+=1
  }
  else if lifePercent<=0.55 and lifePercent>=0.5 and bossProgress=5 //Phase 5
  {
    topFireAmt+=1
    abilSetRemove(0)
    oPlayerIdle.sprite_index=sJerryIdle
    msgCreate(0,0,"Jerry","Awesome, I can move again!",0,1,oMessagePerson,0); newMessage.fadingTime=70
    tHeartDrop=instance_create(xCenter-roomSpan+64+(i*12),280,oHealthPickup)
    tHeartDrop=instance_create(xCenter+roomSpan-64-(i*12),280,oHealthPickup)
    jerryWeakened=0; jerryWeakWarn=0
    ceilingAtkDelay-=80
    platformSpawn=1
    bossProgress+=1
  }
  else if lifePercent<=0.49 and lifePercent>=0.45 and bossProgress=6 //Phase 6
  {
    topFireAmt+=1
    bHexCircleBack=1
    msgCreate(0,0,"Hex","Ah, there we are!",0,1,oMessagePerson,0); newMessage.fadingTime=70
    for(i=0;i<6;i+=1)
    {
      resType[i]=1
    }
    resType[0]=3
    bRunAway=1
    bFloorFire=1
    with oHF_HexEye {bDestroyMe=1}
    bossProgress+=1
  }
  else if lifePercent<=0.44 and lifePercent>=0.37 and bossProgress=7 //Phase 7
  {
    topFireAmt+=1
    for(i=0;i<6;i+=1)
    {
      resType[i]=3
    }
    bCeilingAtk=0
    shieldProg=-1; shieldTime=0
    phaseTimeShiftA=1
    sliceDelay-=5
    swapDeterDelay-=10
    bHexHands=1
    bossProgress+=1
  }
  else if bossProgress=8 //Phase 7
  {
    if shieldProg=1
    {
      if instance_number(oHex_ShieldOrb)<=1
      {
        bRunAway=0
        topFireAmt+=1
        phaseTimeShiftB=1
        bossProgress+=1
      }
    }
  }
  else if lifePercent<=0.36 and lifePercent>=0.32 and bossProgress=9 //Phase 8
  {
    var tSideSpike;
    for(i=0;i<8;i+=1)
    {
      tSideSpike=instance_create(xCenter-roomSpan-36,48+(i*34),oHF_SideSpike)
      tSideSpike=instance_create(xCenter+roomSpan+36,48+(i*34),oHF_SideSpike); tSideSpike.image_xscale=-1
    }
    topFireAmt+=1
    bCanTakeDamage=false
    despBubbleShield=1
    swapDeterDelay-=30
    bMoveOpposite=0
    centerMyself=1
    bossProgress+=1
  }
  else if lifePercent<=0.31 and lifePercent>=0.25 and bossProgress=10 //Phase 9
  {
    topFireAmt+=1
    phaseTimeShiftC=1
    swapDeterDelay-=10
    bHexHands=0
    bossProgress+=1
  }
  else if lifePercent<=0.24 and lifePercent>=0.18 and bossProgress=11 //Phase 10
  {
    topFireAmt+=1
    shieldProg=-1; shieldTime=0
    phaseTimeShiftD=1
    swapDeterDelay-=10
    bossProgress+=1
  }
  else if bossProgress=12 //Phase 10
  {
    if shieldProg>=1
    {
      if instance_number(oHex_ShieldOrb)<=0
      {
        with platformC {instance_destroy()}
        topFireAmt+=1
        platformSpawn=500
        bFloorFire=0
        bossProgress+=1
      }
    }
  }
  else if lifePercent<=0.17 and lifePercent>=0.06 and bossProgress=13 //Phase 11
  {
    topFireAmt+=1
    bSwapDeter=0
    swapDeterTime=0
    with oHex_SwapDeterrent {instance_destroy()}
    with oHex_Sapper {instance_destroy()}
    phaseTimeShiftE=1
    bRainLightning=0
    bossProgress+=1
  }
  else if lifePercent<=0.05 and lifePercent>=0 and bossProgress=14 //This is only to keep the player from reducing Hex's HP to 0
  {
    for(i=0;i<6;i+=1)
    {
      resType[i]=1
    }
    bossProgress+=1
  }
  
  if life<=0 //Defeat animation
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oTrapBase {instance_destroy()}
      with oEProjectileBase {instance_destroy()}
      with oHF_MovingEye {instance_destroy()}
      with oAttackBase {instance_destroy()}
    }
    else if deathAnim>=2 and deathAnim<=60
    {
      image_alpha-=0.02
    }
    else if deathAnim>71
    {
      oEvCh20MainA.sceneProgress=1
      instance_destroy()
    }
  }
}
else
{
  hspeed=0; vspeed=0
  
  if bJumpedOn=1
  {
    finalMomentTime+=1
    if finalMomentTime=1
    {
      if global.bBossGallery=1
      {
        bossRoomTally(58)
        global.newMapX=1240; global.newMapY=256; room_goto(rBossGallery)
      }
      else
      {
        var tempMplay;
        tempMplay=findMusic(0)
        playMusic(tempMplay,0,0)
        oPlayer1.bCanTakeDamage=false
        msgCreate(48,48,"Jerry","Mario is the best damn franchise, bitches!!",0,1,oMessagePerson,0); newMessage.fadingTime=90
      }
    }
    else if finalMomentTime=60
    {
      msgCreate(48,118,"Claire","You think so?",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=120
    {
      msgCreate(48,48,"Jerry","Don't hate.",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=180
    {
      msgCreate(48,118,"Claire","I'm not hating.",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=240
    {
      msgCreate(48,48,"Jerry","Oh I know. I'm just messing around.",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=300
    {
      msgCreate(48,118,"Claire","I like the Marios as well.",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=360
    {
      msgCreate(48,48,"Jerry","I just think it's funny we beat him like this.",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=420
    {
      msgCreate(48,118,"Claire","You and me, both!",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=480
    {
      msgCreate(48,48,"Jerry","Hey Jeremy, unfreeze this. We had the fun we needed.",0,1,oMessagePerson,0); newMessage.fadingTime=90
    }
    else if finalMomentTime=560
    {
      life=0
      global.gamePaused=false
    }
  }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if jerryWeakened>=180 //Check player status
{
  if global.activeCharacter=0 //Disable all abilities when Jerry is active
  {
    global.activeAbility[0]=0
    for(i=0;i<4;i+=1)
    {
      global.hasShoes[i]=1
    }
    global.hasAbilToken[1]=1
    global.hasAbilToken[3]=1
    oPlayer1.sprite_index=sJerrySickFall
    oPlayer1.image_index=3
  }
  else
  {
    global.activeAbility[0]=1
    for(i=0;i<4;i+=1)
    {
      global.hasShoes[i]=2
    }
    global.hasAbilToken[2]=5
    global.hasAbilToken[4]=8
    oPlayerIdle.sprite_index=sJerrySickFall
    oPlayerIdle.image_index=3
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Desperation Attack

if desperationProg=1 //--------------------------------------------------
{
  y-=1
  if y<=96
  {
    desperationProg+=1
  }
}
else if desperationProg=2 //--------------------------------------------------
{
  desperationTime+=1
  if desperationTime=45
  {
    var tScnFlash,tZapTrap;
    tScnFlash=instance_create(0,0,oScreenFlash)
    tScnFlash.image_alpha=0.75; tScnFlash.fadeSpeed=0.05
    for(i=0;i<4;i+=1)
    {
      tZapTrap=instance_create(304+(96*i),32,oZapTrap)
      tZapTrap.image_angle=270; tZapTrap.image_xscale=8
    }
  }

  if desperationTime<=1030
  {
    //Top loop
    despTopLoop+=1
    if despTopLoop=50
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=100
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=150
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=200
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=250
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX2+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX4+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
    }
    else if despTopLoop=300
    {
      var tAtk;
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(despX1+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX3+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
        tAtk=instance_create(despX5+(16*i),32,oHF_HexBulletRed)
        tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
      }
      despTopLoop=0
    }
  }

  //Side bullets
  if desperationTime=120
  {
    var tAtk;
    for(i=0;i<4;i+=1)
    {
      tAtk=instance_create(xCenter+roomSpan+8,yGround-8-(16*i),oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100; tAtk.direction=180
    }
  }
  else if desperationTime=180
  {
    var tAtk;
    for(i=0;i<4;i+=1)
    {
      tAtk=instance_create(xCenter-roomSpan-8,yGround-72-(16*i),oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
    }
  }
  else if desperationTime=310
  {
    var tAtk;
    for(i=0;i<12;i+=1)
    {
      tAtk=instance_create(xCenter+roomSpan+8,yGround-8-(16*i),oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=1; tAtk.decayTime=-100; tAtk.direction=180
    }
  }
  else if desperationTime=660
  {
    var tAtk;
    for(i=0;i<40;i+=1)
    {
      tAtk=instance_create(40+(16*i),32,oPassBullet)
      tAtk.sprite_index=sHFight_DespBulletA; tAtk.atkPower=atkPower
      tAtk.bulletSpeed=1; tAtk.decayTime=-100; tAtk.image_speed=0.33; tAtk.direction=270
    }
  }
  else if desperationTime=1030 {instance_create(xCenter-roomSpan+24,yGround-24,oTempWarningSymbol)}
  else if desperationTime>=1080
  {
    with oZapTrap {instance_destroy()}
    var tScnFlash;
    tScnFlash=instance_create(0,0,oScreenFlash)
    tScnFlash.image_alpha=0.75; tScnFlash.fadeSpeed=0.05
    bHexFlame=1
    despTopLoop=0
    desperationTime=0
    desperationProg+=1
  }
}
else if desperationProg=3 //--------------------------------------------------
{
  desperationTime+=1
  if desperationTime<=480
  {
    if desperationTime mod 8=0 //Bullet line
    {
      var tAtk;
      tAtk=instance_create(xCenter-roomSpan-8,yGround-24,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100
    }

    if desperationTime>=30
    {
      if desperationTime mod 14=0 //Bullet circle
      {
        var tAtk,tDir;
        tDir=0
        for(i=0;i<15;i+=1)
        {
          tAtk=instance_create(x,y,oHF_HexBulletRed)
          tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=tDir+despSpin
          tDir+=360/15
        }
        despSpin+=5
      }
    }

    if desperationTime>=60
    {
      if desperationTime mod 35=0
      {
        var tAtk;
        for(i=0;i<4;i+=1)
        {
          tAtk=instance_create(304+(96*i),32,oHF_HexBulletRed)
          tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3; tAtk.decayTime=-100; tAtk.direction=270
          tAtk.image_xscale=0.8; tAtk.image_yscale=0.8; tAtk.image_blend=make_color_rgb(200,200,255)
        }
      }
    }

    //Seeking bullets
    despTopLoop+=1
    if despTopLoop=50
    {
      tAtk=instance_create(x,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk.direction=point_direction(x,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
    }
    else if despTopLoop=100
    {
      tAtk=instance_create(x-128,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk.direction=point_direction(x-128,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
    }
    else if despTopLoop=150
    {
      tAtk=instance_create(x+128,y-96,oHF_HexBulletRed)
      tAtk.sprite_index=sHFight_DespBulletB; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2; tAtk.decayTime=-100
      tAtk.image_xscale=1.5; tAtk.image_yscale=1.5; tAtk.direction=point_direction(x+128,y-96,oPlayer1.x,returnPlayerYCenter())
      tAtk.image_blend=make_color_rgb(200,255,200)
      despTopLoop=0
    }
  }

  if desperationTime>=480 //End desperation attack
  {
    y+=1
    if y>=160
    {
      var tHeartDrop;
      for(i=0;i<2;i+=1)
      {
        tHeartDrop=instance_create(xCenter-roomSpan+64+(i*12),280,oHealthPickup)
        tHeartDrop=instance_create(xCenter+roomSpan-64-(i*12),280,oHealthPickup)
      }
      bSliceAtk=1; bHexHands=1; bSwapDeter=1
      despBubbleShield=0; bHexFlame=0
      bCanTakeDamage=true
      shieldProg+=1
      desperationProg=10
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//----- Top Background Fire -----
if topFireAmt>1
{
  topFireFrm+=0.25
  for(i=0;i<topFireAmt;i+=1)
  {
    draw_sprite_ext(sHFight_FloorFire,topFireFrm,xCenter-176+(22*i),196,1,1,0,c_white,0.2)
  }
}

//----- Chains -----
if bHexChains=1
{
  draw_sprite_ext(sHFight_Chain,0,x+4,y-6,1,1,30,c_white,1)
  draw_sprite_ext(sHFight_Chain,0,x-4,y-6,1,1,150,c_white,1)
  draw_sprite_ext(sHFight_Chain,0,x+4,y+6,1,1,330,c_white,1)
  draw_sprite_ext(sHFight_Chain,0,x-4,y+6,1,1,210,c_white,1)
  draw_sprite_ext(sHFight_Chain,0,x,y,1,1,0,c_white,1)
  draw_sprite_ext(sHFight_Chain,0,x,y,1,1,180,c_white,1)
}
//----- Swap Deterrent warning -----
if swapDeterTime>=swapDeterDelay-60 and swapDeterTime<=swapDeterDelay
{
  preSwapWarnAngle-=10
  draw_sprite_ext(sHFight_SwapDeterrent,0,oPlayerIdle.x,oPlayerIdle.y-26,1.25,1.25,preSwapWarnAngle,c_red,0.3)
}
//----- Jerry Paralysis warning -----
if jerryWeakWarn>0
{
  jerryWeakWarn+=6
  var tPXX,tPYY;
  if global.activeCharacter=0 {tPXX=oPlayer1.x; tPYY=returnPlayerYCenter()}
  else {tPXX=oPlayerIdle.x; tPYY=oPlayerIdle.y-26}
  for(i=0;i<8;i+=1)
  {
    draw_sprite_ext(sHexStealSkull,image_index,tPXX+lengthdir_x(30,jerryWeakWarn+(i*45)),tPYY+lengthdir_y(30,jerryWeakWarn+(i*45)),0.5,0.5,image_angle,image_blend,0.7)
  }
}
//----- Hex Circle Back -----
if bHexCircleBack=1
{
  if hexCBackAlphaUp=1
  {
    hexCircleBack_Alpha+=0.0004
    if hexCircleBack_Alpha>=0.09 {hexCBackAlphaUp=0}
  }
  else
  {
    hexCircleBack_Alpha-=0.0004
    if hexCircleBack_Alpha<=0.05 {hexCBackAlphaUp=1}
  }
  hexCircleBack_Angle-=0.5
  draw_sprite_ext(sHexBackCircle,0,448,160,1,1,hexCircleBack_Angle,c_white,hexCircleBack_Alpha)
}
//----- Fadeout AF -----
fadeoutHexAF_Scale+=0.05
fadeoutHexAF_Alpha-=0.008
if fadeoutHexAF_Scale>=2
{
  fadeoutHexAF_Scale=1
  fadeoutHexAF_Alpha=0.33
}
draw_sprite_ext(sprite_index,image_index,x,y,fadeoutHexAF_Scale,fadeoutHexAF_Scale,image_angle,image_blend,fadeoutHexAF_Alpha)
//----- Upper wings -----
if wingFrm>=0
{
  draw_sprite_ext(sHex_A_WingsTop,wingFrm,x+xJitter+4,y-9,1,1,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHex_A_WingsTop,wingFrm,x+xJitter-4,y-9,-1,1,image_angle,image_blend,image_alpha)
}
//----- Main body -----
draw_sprite_ext(sprite_index,image_index,x+xJitter,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
//----- Lower wings -----
if wingFrm>=0
{
  draw_sprite_ext(sHex_A_WingsBottom,wingFrm,x+xJitter+2,y-3,1,1,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHex_A_WingsBottom,wingFrm,x+xJitter-2,y-3,-1,1,image_angle,image_blend,image_alpha)
}
//----- Hex Flame -----
if bHexFlame=1
{
  hexFlameFrm+=0.33
  draw_sprite_ext(sHexFireRing,hexFlameFrm,x,y,image_xscale,image_yscale,image_angle,image_blend,0.3)
}
//----- Hex Bubble Shield -----
if despBubbleShield=1
{
  draw_sprite_ext(sWaterBarrier,oGame.time/4,x,y,0.75,0.75,image_angle,image_blend,0.3)
}
//----- Hex Desperation Lightning Warn -----
if desperationTime>=1 and desperationTime<=45 and desperationProg=2
{
  if desperationTime mod 9=0
  {
    if despWarn=1 {despWarn=0}
    else {despWarn=1}
  }
  for(i=0;i<4;i+=1)
  {
    draw_sprite_ext(sWarningSymbol,0,304+(96*i),yGround,0.5,0.5,0,c_white,despWarn)
  }
}
