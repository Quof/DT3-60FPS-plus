#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
resetKeyCodes()

if global.modeDark=1
{
  instance_create(0,0,oSurfLightAll)
}
ditherCounter=0

room_speed=global.gameFrameRate
instance_create(0,0,oScreenCutIn)
//if !instance_exists(oGameCamera) {myCamera=instance_create(x,y,oGameCamera)}

//set character in proper position on new map
if room!=rLink2_EnRoad and room!=rLink2_EnGrass and room!=rLink2_EnDesert and room!=rLink2_EnForest
{
  x=global.newMapX
  y=global.newMapY
  view_xview[0]=x-240
  view_yview[0]=y-176
  if view_xview[0]<0 {view_xview[0]=0}
  else if view_xview[0]>room_width-480 {view_xview[0]=room_width-480}

  if view_yview[0]<0 {view_yview[0]=0}
  else if view_yview[0]>room_height-352 {view_yview[0]=room_height-352}
}
y+=1
//set initial values
bPlayable=true //whether the character is playable
parent="player"
charEnemyCreateEvent()
characterCreateEvent()
image_speed=idleAnimSpeed
chargeFrame=0
equipValA=0
equipValB=0
if global.activeCharacter=1 {sprite_index=sClaireIdle}
if x>room_width/2 {image_xscale=-1; facing=LEFT}

//variables pertaining to the character's status and inventory
maxLife=global.pMaxLife
life=global.pLife

currentMoney=global.pMoney

//used if ammo runs out
arrowRecharge=0
missileRecharge=0

//extra flags
modDashRecharge=0
dashNumThisMap=0 //number of times the player has dashed this map
waterTime=0
chargeSoundCheck=0 //tracks the charging up sound
extraBulletCheck=0 //track for The Executive

//set bottles
for(i=0;i<3;i+=1)
{
  pBottles[i]=string_char_at(global.extraItems,i+1)
}

if global.gameOver=true
{
  //var tempMplay;
  //tempMplay=findMusic(global.currentMusic)
  //playMusic(tempMplay,0,0)
  global.gameOver=false
}

global.levelTimeSecond=0
global.levelTimeFrameCount=0

//reset block
global.stJGame_C[0]=1000

global.genEnemyAward=10 //reset generated enemy awards

if global.awesomePoints>=12345678
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitions,7)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNotice)
    tAchievement.myAchievement="You Are Awesome"; tAchievement.checkNum=7
  }
}
if global.recBirdsSeen>=11111
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,10)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNoticeSS)
    tAchievement.myAchievement="Ornithology Major"; tAchievement.checkNum=10
  }
}

morphMode=11 //reset morph mode
global.desertHeat=1500
waveOfAwesomeScale=3

bKeepPlayerOnScreen=1
view_visible[1]=0
view_object[1]=oPlayerIdle

view_hborder[1]=120 //60
view_vborder[1]=88 //44

view_wview[1]=240
view_hview[1]=176

view_wport[1]=120
view_hport[1]=88
view_xport[1]=359
view_yport[1]=1

if global.gameProgress>=4930 and global.gameProgress<=4940 //Just after Subconscious Filter
{
  oIdentifier.bCanScan=0; oIdentifier.deactivate=1
  instance_create(0,0,oEvCh19WorldEv)
}

if (global.activeCharacter=0 and global.wearingHatJ=9) or (global.activeCharacter=1 and global.wearingHatC=9) {global.recBirdsSeen+=1}

deathConvoTime=0; deathConvoType=0
alarm[0]=1
alarm[1]=12
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///VARIOUS CHECKS
//Set if the player can wall jump
if global.location=29 or global.location=91 or global.location=104 {bCanWallJump=1}

if global.location=49 //Gate 5 jump upgrades
{
  if global.metJumpUpgrade=1 {initialJumpAcc=-7.8; jumpTimeTotal=28}
  else if global.metJumpUpgrade=2 {initialJumpAcc=-9.4; jumpTimeTotal=35}
}

//Set the player in morph mode at map start
if room=rMain_48 {if global.newMapX>2736 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rMain_75 {if global.newMapX<128 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rSamus5_Lv2_R {if global.newMapX>352 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacA {if global.newMapX<128 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacB {if global.newMapY>272 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacC {if global.newMapY>272 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rWepFacD {if global.newMapX>512 and global.newMapY>272 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}
else if room=rLowFacQ {if global.newMapX<512 {charSwitcher(1); global.activeAbility[1]=2; scrMorphMode()}}

//Other checks
if room=rVault_22 {bKeepPlayerOnScreen=0}

//Teleports
if global.bBossGallery=0
{
  if global.location=7 and global.gameProgress>=510 {global.mapTeleport=31}
  else if global.location=10 and global.gameProgress>=910 {global.mapTeleport=32}
  else if global.location=15 and global.gameProgress>=1520 {global.mapTeleport=33}
  else if global.location=29 and global.gameProgress>=1990 {global.mapTeleport=34}
  else if global.location=49 and global.gameProgress>=3070 {global.mapTeleport=35}
  else if global.location=58 and global.gameProgress>=3870 {global.mapTeleport=36}

  if global.location=24 and global.gameProgress>=1710 {global.mapTeleport=24}
  else if global.location=90 and global.gameProgress>=4800 {global.mapTeleport=25}
  else if global.location=93 and global.gameProgress>=5050 {global.mapTeleport=26}
  else if global.location=59 and global.gameProgress>=4200 {global.mapTeleport=27}
}
else
{
  global.hudMega_BusterEn[0]=32
  global.hudMega_ShotIceEn[0]=32
  global.hudMega_GravityEn[0]=32
}

//Display header text
if global.charScan[0]=1 and global.charScan[1]=1 and global.optShowMapHeader=1 and global.checkForDeath=0 and global.location!=99
{
  instance_create(0,0,oDisplayHeaderText)
}
global.checkForDeath=0
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///RESTART MESSAGES
//============================== Situational restart messages to the player from the characters ==============================
//-------------------- Non-Gate --------------------
if room=rExtGateE_4 and global.rmDeaths=4
{
  for(i=0;i<2;i+=1)
  {
    for(ii=0;ii<7;ii+=1)
    {
      msgCreate(-32+(i*259),-16+(54*ii),"Jerry","Since you've killed me a lot. I figured I'd help your growing death count by doing this!",0,2,oMessagePerson,0)
      newMessage.fadingTime=160
    }
  }
}
//-------------------- Gate 1 --------------------
if room=rMario1_CCc and global.rmDeaths=3
{
  messToPlayerChk=string_char_at(global.heartPiece,6)
  if messToPlayerChk="0"
  {
    msgCreate(0,0,"Jerry","Hey bruh, could you... oh I don't know... stop getting us killed over and over for the heart piece.",0,2,oMessagePerson,0)
    newMessage.fadingTime=160
  }
}
else if room=rExtGateA_2
{
  if global.rmDeaths=4
  {
    msgCreate(0,0,"Claire","Okay stop, hold on a moment there... Have you any clue about what's at the bottom of that pit?",0,2,oMessagePerson,0)
    newMessage.fadingTime=150
  }
  else if global.rmDeaths=5
  {
    msgCreate(0,0,"Claire","I'll give you a clue. It's bottomless.",0,1,oMessagePerson,0)
    newMessage.fadingTime=120
  }
  else if global.rmDeaths=6
  {
    msgCreate(0,0,"Claire","Forever falling until you summon me back here to do it again.",0,1,oMessagePerson,0)
    newMessage.fadingTime=140
  }
  else if global.rmDeaths=7
  {
    msgCreate(0,0,"Claire","I'm going to cry. Not because you keep making the same mistake, but because every time you fail, I wonder if it's the last attempt you'll make, because... that's when I fall forever.",0,3,oMessagePerson,0)
    newMessage.fadingTime=230
  }
  else if global.rmDeaths=8
  {
    msgCreate(0,0,"Claire","There's one good thing about this... you didn't stop.",0,1,oMessagePerson,0)
    newMessage.fadingTime=130
  }
  else if global.rmDeaths=9
  {
    msgCreate(0,0,"Claire","Are you doing this on purpose now?",0,1,oMessagePerson,0)
    newMessage.fadingTime=120
  }
  else if global.rmDeaths=10
  {
    msgCreate(0,0,"Jerry","I know that in your failing attempts, you could have been playing as me, which would make some of that kinda weird... I was just being lazy. Also this is the last message in this string of deaths. We're done, you can do this, bro.",0,3,oMessagePerson,0)
    newMessage.fadingTime=270
  }
}
//-------------------- Gate 2 --------------------
if room=rExtGateB_3 and global.rmDeaths=3
{
  msgCreate(0,0,"Jerry","I don't blame you for your deaths here. That said, it would be very appreciated if you'd stop dying to spikes and fireballs... they hurt.",0,2,oMessagePerson,0)
  newMessage.fadingTime=180
}
//-------------------- Gate 3 --------------------
if room=rBelmont3_1A and global.gameProgress<=1170 and global.rmDeaths=1
{
  msgCreate(0,0,"Claire","You getting me killed here is all sorts of sad and special.",0,2,oMessagePerson,0)
  newMessage.fadingTime=140
}
else if room=rBelmont3_2D and global.gameProgress<=1230 and global.rmDeaths=2
{
  msgCreate(0,0,"Claire","I'd really really appreciate it if you'd quit running me into axes and Medusa Heads.",0,2,oMessagePerson,0)
  newMessage.fadingTime=160
}
else if room=rBelmont3_3D and global.gameProgress<=1270 and global.rmDeaths=3
{
  msgCreate(0,0,"Claire","I get that you're probably getting frustrated, but remember that it's not you that's getting her back repeatedly impaled.",0,2,oMessagePerson,0)
  newMessage.fadingTime=170
}
else if room=rBelmont3_4F and global.gameProgress<=1370 and global.rmDeaths=3
{
  msgCreate(0,0,"Claire","I get it. You really like how this map looks and you love throwing me into spikes, ghosts, and fireballs. It's just... can we stop with that now?",0,3,oMessagePerson,0)
  newMessage.fadingTime=190
}
else if room=rBelmont3_5D and global.gameProgress<=1370 and global.rmDeaths=3
{
  msgCreate(0,0,"Claire","Dude... or dudette... Those bottomless pits... that... just... NO MORE! I don't want to fall down there anymore!",0,2,oMessagePerson,0)
  newMessage.fadingTime=230
}
else if room=rBelmont3_6E and global.gameProgress<=1460 and global.rmDeaths=3
{
  msgCreate(0,0,"Claire","I feel like a pin cushion right now.",0,1,oMessagePerson,0)
  newMessage.fadingTime=120
}
else if room=rExtGateC_3 and global.rmDeaths=3
{
  msgCreate(0,0,"Claire","Let me give you a hand with that.",0,1,oMessagePerson,0)
  newMessage.fadingTime=100
  deathConvoType=2
}
else if room=rExtGateC_4 and global.rmDeaths=3
{
  msgCreate(0,0,"Claire","Beyond a shadow of a doubt.",0,1,oMessagePerson,0)
  newMessage.fadingTime=100
  deathConvoType=3
}
//-------------------- Gate 4 --------------------
if room=rMega4_IntroC and global.rmDeaths=2
{
  msgCreate(0,0,"Jerry","I am the best pancake!",0,1,oMessagePerson,0)
  newMessage.fadingTime=120
}
else if room=rMega4_OstrichD and global.rmDeaths=3
{
  msgCreate(0,0,"Jerry","You must really like Macs, because you like crashing a lot.",0,2,oMessagePerson,0)
  newMessage.fadingTime=140
  deathConvoType=1
}
else if room=rMega4_ToxicJungleC and global.rmDeaths=3
{
  msgCreate(0,0,"Jerry","AHHHHHH!! WHYYYYYYY!!",0,1,oMessagePerson,0)
  newMessage.fadingTime=120
}
else if room=rMega4_SigmaA3 and global.rmDeaths=3
{
  msgCreate(0,0,"Jerry","Siiiiiiiiiiiiiiiiiiiiiigh. Electric walls...",0,1,oMessagePerson,0)
  newMessage.fadingTime=110
}
else if room=rMega4_SigmaA4 and global.rmDeaths=3
{
  msgCreate(0,0,"Jerry","I'm less of a fan of those lasers than you are.",0,1,oMessagePerson,0)
  newMessage.fadingTime=140
}
else if room=rMega4_SigmaB2 and global.rmDeaths=4
{
  msgCreate(0,0,"Jerry","Ignore the Game Over messages man, you can do this... I'm only saying this so that maybe it'll encourage you to do better because lasers and electric floors are painful!",0,3,oMessagePerson,0)
  newMessage.fadingTime=220
}
else if room=rExtGateD_4 and global.rmDeaths=3
{
  msgCreate(0,0,"Jerry","I like the part where you face slammed me into that... again and again.",0,2,oMessagePerson,0)
  newMessage.fadingTime=150
}
//-------------------- Gate 5 --------------------
else if room=rExtGateF_4 and global.rmDeaths=3
{
  msgCreate(0,0,"Claire","Burning passions... not in the heart, but through the back.",0,1,oMessagePerson,0)
  newMessage.fadingTime=150
}
//-------------------- Gate 6 --------------------
if room=rGame6_EarthI and global.gameProgress<=3470 and global.rmDeaths=4
{
  msgCreate(0,0,"Claire","Spike, pitfall. Spike, pitfall. It never ends.",0,1,oMessagePerson,0)
  newMessage.fadingTime=140
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
ditherCounter+=1

if global.cutscene=true
{
  if global.activeCharacter=4 {charJeremyStepEvent()}
  else if global.activeCharacter=5 {}
  else {characterStepEvent()}
}
//---------- Health and spirit percent ----------
lifePercent=life/maxLife

//---------- Check max life ----------
if life>maxLife
  life=maxLife

//---------- Death ----------
if life<=0
{
  if global.bCanGameOver=1
  {
    if global.BTB_HelmetHead=1 //Helmet Head EX final game over
    {
      if !instance_exists(oHelmetHeadEX_GameOver)
      {
        stopLoopingSounds()
        gameOver=instance_create(0,0,oHelmetHeadEX_GameOver)
      }
    }
    else //Normal game over
    {
      if !instance_exists(oGameOver)
      {
        stopLoopingSounds()
        gameOver=instance_create(0,0,oGameOver)
      }
    }
  }
}

if global.gamePaused=false and global.bShooter=0
{
  //---------- Ability recharge rates ----------
  if global.activeCharacter=0
  {
    if global.activeAbility[0]=1 //Link Set ----------
    {
      playerAbilRecover(2); playerAbilRecover(3); playerAbilRecover(4)
      equipValA=0
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=20
        {
          equipValA=20
          break;
        }
      }

      if global.hudLink_Arrows[0]<global.hudLink_Arrows[1]
      {
        var tArrowPercent;
        tArrowPercent=round(global.hudLink_Arrows[0]/global.hudLink_Arrows[1])*100
        if tArrowPercent>95 {tArrowPercent=95}
        else if tArrowPercent<40 {tArrowPercent=40}
        arrowRecharge+=1
        if arrowRecharge>=tArrowPercent+arrowDelay
        {
          arrowRecharge=0
          if arrowDelay>0
          {
            arrowDelay-=5
            if arrowDelay<0 {arrowDelay=0}
          }
          global.hudLink_Arrows[0]+=1
        }
      }

      if global.hudLink_BombEn[0]<120-round(global.skillTree[1]*7.5)-equipValA
        global.hudLink_BombEn[0]+=1
      else if global.hudLink_BombEn[0]>120-round(global.skillTree[1]*7.5)-equipValA
        global.hudLink_BombEn[0]=120-round(global.skillTree[1]*7.5)-equipValA
    }
    else if global.activeAbility[0]=2 //Mega Man Set ----------
    {
      playerAbilRecover(1); playerAbilRecover(2); playerAbilRecover(4)
      if global.hudMega_BusterEn[0]<32
      {
        if oGame.time mod 15-global.skillTree[28]=0
          global.hudMega_BusterEn[0]+=1
      }
      if global.hudMega_ShotIceEn[0]<32
      {
        if oGame.time mod 36-round(global.skillTree[28]*1.67)=0
          global.hudMega_ShotIceEn[0]+=1
      }
      if global.hudMega_GravityEn[0]<32
      {
        if oGame.time mod 40-(global.skillTree[28]*2)=0
          global.hudMega_GravityEn[0]+=1
      }
    }
    else if global.activeAbility[0]=3 //Game Set ----------
    {
      if global.hudGame_WeaponEn[0]<global.hudGame_WeaponEn[1]
      {
        var tWeaponRegen;
        if attackState=ACT_BLOCK {tWeaponRegen=5}
        else if global.stJGame_C[0]<0 {tWeaponRegen=4}
        else {tWeaponRegen=3}
        if oGame.time mod tWeaponRegen=0 {global.hudGame_WeaponEn[0]+=1}
      }
      else if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1]
        global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

      lastGuardTime+=1
      if global.stJGame_C[0]>2000 //super mode
      {
        global.stJGame_C[0]-=20
        if global.stJGame_C[0]<=4000 {global.stJGame_C[0]=1000}
      }
      if attackState!=ACT_BLOCK //shield
      {
        if global.stJGame_C[0]>0 and global.stJGame_C[0]<1000 //normal
        {
          if global.location=76 {global.stJGame_C[0]+=6+(global.skillTree[9]*0.25)}
          else {global.stJGame_C[0]+=5+(global.skillTree[9]*0.25)}
          if global.stJGame_C[0]>1000 {global.stJGame_C[0]=1000}
        }
        else if global.stJGame_C[0]<0{global.stJGame_C[0]+=5.25} //broken
      }
      if global.stJGame_C[0]>-200 and global.stJGame_C[0]<=0 //Overload shield
      {
        global.recShieldBroken+=1
        global.stJGame_C[0]=-2000
      }
      else if global.stJGame_C[0]>-1000 and global.stJGame_C[0]<-800 {global.stJGame_C[0]=1000} //Recover shield
    }
  }
  else if global.activeCharacter=1
  {
    if global.activeAbility[1]=1 //Belmont Set ----------
    {
      playerAbilRecover(1); playerAbilRecover(3); playerAbilRecover(4)
      if global.hudBelmont_WeaponEn[0]<global.hudBelmont_WeaponEn[1]
      {
        equipValA=0
        for(i=0;i<3;i+=1)
        {
          if global.equipClaire[i]=8
          {
            equipValA=3
            break;
          }
        }
        if global.bNightmareMode=0
        {
          if oGame.time mod (21-(global.skillTree[2]*3)-equipValA)=0
            global.hudBelmont_WeaponEn[0]+=1
        }
        else
        {
          if oGame.time mod 15=0
            global.hudBelmont_WeaponEn[0]+=1
        }
      }
    }
    else if global.activeAbility[1]=2 //Samus Set ----------
    {
      playerAbilRecover(1); playerAbilRecover(2); playerAbilRecover(3)
      if global.hudSamus_CannonEn[0]>0
      {
        var tCannonChargeMod;
        if busterLastShotTime>=0 and busterLastShotTime<=20 {tCannonChargeMod=6}
        else if busterLastShotTime>=21 and busterLastShotTime<=50 {tCannonChargeMod=5}
        else if busterLastShotTime>=51 and busterLastShotTime<=80 {tCannonChargeMod=4}
        else if busterLastShotTime>=81 {tCannonChargeMod=2}

        if oGame.time mod tCannonChargeMod=0 {global.hudSamus_CannonEn[0]-=10}
      }

      if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]
      {
        var tMissilePercent;
        tMissilePercent=round(global.hudSamus_Missiles[0]/global.hudSamus_Missiles[1])*100
        if tMissilePercent>95 {tMissilePercent=95}
        else if tMissilePercent<40 {tMissilePercent=40}
        missileRecharge+=1
        if missileRecharge>=tMissilePercent+missileDelay
        {
          missileRecharge=0
          if missileDelay>0
          {
            missileDelay-=5
            if missileDelay<0 {missileDelay=0}
          }
          global.hudSamus_Missiles[0]+=1
        }
      }
    }
    else if global.activeAbility[1]=3 //Game Set ----------
    {
      if global.hudGame_WeaponEn[0]<global.hudGame_WeaponEn[1]
      {
        var tWeaponRegen;
        if attackState=ACT_BLOCK {tWeaponRegen=5}
        else if global.stJGame_C[0]<0 {tWeaponRegen=4}
        else {tWeaponRegen=3}
        if oGame.time mod tWeaponRegen=0 {global.hudGame_WeaponEn[0]+=1}
      }
      else if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1]
        global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

      lastGuardTime+=1
      if global.stJGame_C[0]>2000 //super mode
      {
        global.stJGame_C[0]-=62
        if global.stJGame_C[0]<=4000 {global.stJGame_C[0]=1000}
      }
      if attackState!=ACT_BLOCK //shield
      {
        if global.stJGame_C[0]>0 and global.stJGame_C[0]<1000 //normal
        {
          if global.location=76 {global.stJGame_C[0]+=6+(global.skillTree[9]*0.25)}
          else {global.stJGame_C[0]+=5+(global.skillTree[9]*0.25)}
          if global.stJGame_C[0]>1000 {global.stJGame_C[0]=1000}
        }
        else if global.stJGame_C[0]<0 {global.stJGame_C[0]+=5.25} //broken
      }
      if global.stJGame_C[0]>-200 and global.stJGame_C[0]<=0 //Overload shield
      {
        global.recShieldBroken+=1
        global.stJGame_C[0]=-2000
      }
      else if global.stJGame_C[0]>-1000 and global.stJGame_C[0]<-800 {global.stJGame_C[0]=1000} //Recover shield
    }
  }

  if global.activeCharacter=4 {charJeremyStepEvent()}
  else {characterStepEvent()}
  //---------- Find distance moved ----------
  if platformCharacterIs(ON_GROUND)
    global.recDistFoot+=abs(xVel)
  else if platformCharacterIs(IN_AIR)
    global.recDistAir+=abs(xVel)

  //---------- Keep player inside room ----------
  if y>room_height+64
  {
    global.recFallenOffLevel+=1
    life-=maxLife
  }
  else if y<-32 {yVel=4}

  if global.partySplit=0 //No split party
  {
    if bKeepPlayerOnScreen=0 //Can only go off the left side of the screen
    {
      if x<0
      {
        xVel=0
        x=0
      }
      else if x>view_xview[0]+view_wview[0]
      {
        xVel=0
        x=view_xview[0]+view_wview[0]
      }
    }
    else //Can't go off either side of the screen
    {
      if x<view_xview[0]
      {
        xVel=0
        x=view_xview[0]
      }
      else if x>view_xview[0]+view_wview[0]
      {
        xVel=0
        x=view_xview[0]+view_wview[0]
      }
    }
  }
  else //In split party - Keep player inside map
  {
    if x<0
    {
      xVel=0
      x=0
    }
    else if x>room_width
    {
      xVel=0
      x=room_width
    }
  }
  
  //---------- Level time (per map) ----------
  global.levelTimeFrameCount+=1
  if global.levelTimeFrameCount>=30
  {
    global.levelTimeSecond+=1
    global.levelTimeFrameCount=0
  }
  
  //---------- Underwater Air Time ----------
  var tBreathHC;
  if state=DUCKING {tBreathHC=-14}
  else if state=RUNNING
  {
    if global.activeCharacter=0 {tBreathHC=-9}
    else {tBreathHC=4}
  }
  else {tBreathHC=4}
  
  if isCollisionWaterTop(tBreathHC) //Head underwater
  {
    bubbleTime-=1
    if bubbleTime<=0
    {
      var newBubble,bubbleCount;
      newBubble=instance_create(x,y-36,oPlayerAirBubble)
      bubbleTime=irandom_range(10,70)
      bubbleCount=instance_number(oPlayerAirBubble)
      if bubbleCount>global.recMaxBubbles {global.recMaxBubbles=bubbleCount}
    }
    
    waterTime+=1
    if waterTime>=30 //Water time track
    {
      global.recTimeUnderWater+=1
      waterTime=0
    }
    
    global.pCurrBreath-=1
    if global.pCurrBreath<=0
    {
      global.recDrowned+=1
      life-=maxLife
    }
  }
  else
  {
    global.pCurrBreath+=8
    if global.pCurrBreath>global.pBreathMax {global.pCurrBreath=global.pBreathMax}
  }
  
  //---------- Starman time ----------
  if starmanTime>0
  {
    image_blend=make_color_rgb(random(255),random(255),random(255))
    var tEfAI,tEfStar;
    for(i=0;i<4;i+=1)
    {
      tEfStar=instance_create((x-(sprite_width/2))+random(sprite_width),(y-sprite_height+3)+random(sprite_height-6),oEffect)
      if i<=1 {tEfStar.sprite_index=sMMshotgunIceEffect}
      else {tEfStar.sprite_index=sBelmontWepEffect}
      tEfStar.image_speed=0.2+random(0.2)
      tEfStar.image_blend=make_color_rgb(random(200)+55,random(200)+55,random(200)+55)
      tEfStar.image_alpha=0.4+random(0.6); tEfStar.ySpd=-1-random(3)
      tEfStar.newBlend=-1; tEfStar.followID=-1; tEfStar.decay=-100; tEfStar.xSpd=0
    }
    tEfAI=instance_create(x,y,oPlayerAfterImage)
    tEfAI.imageColor=image_blend
    starmanTime-=1
    if starmanTime>=1 and starmanTime<=40
    {
      var tEfStar;
      for(i=0;i<4;i+=1)
      {
        tEfStar=instance_create(x,y-26,oEffect)
        if i<=1 {tEfStar.sprite_index=sMMshotgunIceEffect}
        else {tEfStar.sprite_index=sBelmontWepEffect}
        tEfStar.image_speed=0.1+random(0.1)
        tEfStar.image_blend=make_color_rgb(random(200)+55,random(200)+55,random(200)+55)
        tEfStar.image_alpha=0.8+random(0.2); tEfStar.xSpd=random_range(-8,8); tEfStar.ySpd=random_range(-8,8)
        tEfStar.newBlend=-1; tEfStar.followID=-1; tEfStar.decay=-100
      }
    }
    else if starmanTime=0
    {
      stopAllMusic()
      var tempMplay;
      tempMplay=findMusic(global.currentMusic)
      playMusic(tempMplay,0,0)
      image_blend=c_white
    }
  }
  
  //---------- Dash invulnerability time ----------
  if dashInvulnerabilityTime>0
  {
    instance_create(x,y,oPlayerAfterImage)
    dashInvulnerabilityTime-=1
    
    if dashInvulnerabilityTime>=40 //Achievement
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,42)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Dash Dance"; tAchievement.checkNum=42
      }
    }
  }
  
  //---------- Dash recovery ----------
  if dashEnergy<dashMeterMax //and walljumpTime=0
  {
    if dashRecHalt=0
    {
      if global.challengeRoom>0 {dashEnergy+=round(dashRecovery/2)}
      else {dashEnergy+=dashRecovery+modDashRecharge}
    }
    else {dashRecHalt-=1}
    
    if global.optDashWarn=1 and (global.hasShoes[2]=2 or global.hasShoes[3]=2) //Low dash warning
    {
      if dashWarnSound=0 and dashEnergy<2000 //Ready the sound (For low dash warning)
      {
        playSound(global.snd_DashWarn,0,1,1)
        dashWarnSound=1
      }
      
      /*if dashWarnSound>=1 and dashWarnSound<=20 //Repeat sound
      {
        dashWarnSound+=1
        if dashWarnSound=10 {playSound(global.snd_DashWarn,0,1,1)}
        else if dashWarnSound=19 {playSound(global.snd_DashWarn,0,1,1)}
      }*/
      
      if dashWarnSound=1 and dashEnergy>=2000 //Dash ready sound
      {
        playSound(global.snd_DashWarn,0,1,11025)
        dashWarnSound=0
      }
    }
  }
  else {dashEnergy=dashMeterMax}
  
  //---------- X-Buster/Weapon last shot time ----------
  busterLastShotTime+=1
  specialLastShotTime+=1
  
  //---------- Nightmare mode only ability checks ----------
  if swordWaveCheck>0
  {
    swordWaveCheck-=1
    if swordWaveCheck=55 {swordWaveCheck=0}
  }
  if daggerSpamCheck>0
  {
    daggerSpamCheck-=1
    if daggerSpamCheck=60 {daggerSpamCheck=0}
  }
  if powerBombCheck>0 {powerBombCheck-=1}
  
  //---------- Idle time ----------
  if xVel=0 and yVel=0
  {
    idleTime+=1
    if idleTime=9000 and global.location!=108
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,3)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Did You Go Eat"; tAchievement.checkNum=3
      }
    }
    if idleTime>global.recLongestIdle {global.recLongestIdle=idleTime}
  }
  
  if room=rExtGateD_6 //Elpizo boss fight
  {
    if instance_exists(oElpizo)
    {
      if place_meeting(x,y,oNightmareEffect)
      {
        if oElpizo.specTime<oElpizo.specMax
        {
          if oElpizo.timeMod=1 {oElpizo.specTime+=5}
          else {oElpizo.specTime+=10}
        }
      }
    }
  }
  
  //---------- Death convos ----------
  if deathConvoType>0
  {
    deathConvoTime+=1
    if deathConvoType=1 //Map: G4 - Ostrich D
    {
      if deathConvoTime=120
      {
        msgCreate(0,0,"Jeremy","Jerry, if you're going to break the 4th wall, at least do it right.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if deathConvoTime=260
      {
        msgCreate(0,0,"Jerry","HEY!!... Okay...",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
    else if deathConvoType=2 //Map: Nightmare C3
    {
      if deathConvoTime=100
      {
        msgCreate(0,0,"Jerry","Ugh, Claire. That pun was painful, ESPECIALLY for me.",0,2,oMessagePerson,0)
        newMessage.fadingTime=140
      }
    }
    else if deathConvoType=3 //Map: Nightmare C4
    {
      if deathConvoTime=100
      {
        msgCreate(0,0,"Jerry","... ... ... ... ... ... ... ...",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
  }
  
  //Player trail
  if global.optPlayerTrail=1 and global.location!=108 and global.gameProgress<=5340 {instance_create(x,returnPlayerYCenter(),oEfPlayerTrail)}
  
  if (oKeyCodesHighFPS.kCodePressed[11]=1) //Reset map in Boss Gallery
  {
    if (global.bBossGallery=1 and room!=rBossGallery) or (room=rWarshipZ_E3)
    {
      playSound(global.snd_Retry,0,1,1)
      scrFullStatRestore()
      global.recRetryBossRoom+=1
      global.gamePaused=false; global.gameOver=false
      room_restart()
    }
  }
}
else if global.bShooter=1
{
  //---------- Flash time after taking damage in Dragoon ----------
  if bCanTakeHit=false
  {
    damageTime-=1
    if image_alpha=0.75 {image_alpha=0.25}
    else {image_alpha=0.75}
    if damageTime<=0
    {
      image_alpha=1
      bCanTakeHit=true
      bTakingDamage=false
    }
  }
}

if global.location=108
{
  if room=rExtGateH_1
  {
    if oPlayer1.x>=1008 and oPlayer1.x<=1264 {setCollisionBounds(-7,-8,7,-1)}
    else {setCollisionBounds(-7,-40,7,-1)}
  }
  else if room=rExtGateH_2
  {
    if oPlayer1.x>=960 and oPlayer1.x<=1184 {setCollisionBounds(-7,-8,7,-1)}
    else {setCollisionBounds(-7,-40,7,-1)}
  }
}

if extraBulletCheck>0 {extraBulletCheck-=1}

if swapCheck=1 //wait 1 frame before moving objects around in split party maps
{
  var tPrevX,tPrevY;
  tPrevX=x; tPrevY=y
  x=oPlayerIdle.x; y=oPlayerIdle.y
  oPlayerIdle.x=tPrevX; oPlayerIdle.y=tPrevY
  swapCheck=0
}

//Jeremy Mech tracking
if mechFireRate>0 {mechFireRate-=1} //Reset Jeremy's Mech firerate
if mechShieldUses<2
{
  mechShieldRecover+=1
  if mechShieldRecover>=160
  {
    mechShieldUses+=1
    mechShieldRecover=0
  }
}
if mechMissileUses<2
{
  mechMissileRecover+=1
  if mechMissileRecover>=80
  {
    mechMissileUses+=1
    mechMissileRecover=0
  }
}
if mechLaserEnergy<mechLaserMax {mechLaserEnergy+=1}
#define Mouse_50
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMouseMove=1
{
  x=oIdentifier.x
  y=oIdentifier.y
}
#define Mouse_54
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.debugMenu=1
{
  var tDisX,tDisY,debugMenu;
  tDisX=display_mouse_get_x()
  tDisY=display_mouse_get_y()
  debugMenu=show_menu_pos(tDisX,tDisY,"[0] Change Game Progress|[1] Change Max Life...|[2] Change Internetz|[3] Teleport...|[4] Kill All|[5] Pause/Unpause|[6] Room Speed|[7] Enable all abilities|[8] Activate Mouse Movement",-1)

  if debugMenu=0 //==================== CHANGE GAME PROGRESS ====================
    global.gameProgress=get_integer("Change Game Progress",global.gameProgress)
  else if debugMenu=1 //==================== CHANGE MAX   LIFE... ====================
  {
    var status;
    status=show_menu_pos(tDisX,tDisY,"[0] Change Max Life",-1)
    if status=0
    {
      var valueChange;
      valueChange=get_integer("Change Max Life",maxLife)
      maxLife=valueChange
      fullhealth=show_question("Restore Health?")
      if fullhealth=true
        life=maxLife
      if life>maxLife
        life=maxLife
    }
  }
  else if debugMenu=2 //==================== CHANGE INTERNETZ ====================
  {
    currentMoney=get_integer("Change Internetz",currentMoney)
  }
  else if debugMenu=3 //==================== TELEPORT ====================
  {
    var teleport;
    teleport=show_menu_pos(tDisX,tDisY,"[0] X/Y Position|[1] Change Rooms",-1)
    if teleport=0
    {
      var xCoord,yCoord;
      xCoord=get_integer("Enter target x coordinate.",x)
      yCoord=get_integer("Enter target y coordinate.",y)
      x=xCoord
      y=yCoord
    }
    else if teleport=1
    {
      teleport=get_integer("Teleport - 0 for cancel#Note: Will crash the game if roomID does not exist.",room)
      if teleport!=0
      {
        var xCoord,yCoord;
        xCoord=get_integer("Enter target x coordinate.",0)
        yCoord=get_integer("Enter target y coordinate.",0)
        global.newMapX=xCoord
        global.newMapY=yCoord
        writeToPlayerGlobals()
        room_goto(teleport)
      }
    }
  }
  else if debugMenu=4 //==================== KILL ALL ====================
  {
    var destroy;
    destroy=show_question("This will destroy all objects that extend the oEnemyBase object. Kill?")
    if destroy=true
      with oEnemyBase
        instance_destroy()
  }
  else if debugMenu=5 //==================== PAUSE/UNPAUSE ====================
  {
    if global.gamePaused=0
      global.gamePaused=1
    else
      global.gamePaused=0
  }
  else if debugMenu=6 //==================== ROOM SPEED ====================
  {
    global.gameFrameRate=get_integer("Change Room Speed.",global.gameFrameRate)
    room_speed=global.gameFrameRate
  }
  else if debugMenu=7 //==================== ENABLE ALL ABILITIES ====================
  {
    var enable;
    enable=show_question("This will enable all player abilities. Proceed?")
    if enable=true
    {
      global.metJumpUpgrade=2
      for(i=0;i<4;i+=1)
      {
        global.hasShoes[i]=2
      }
      global.canCharSwap=2
      global.canDoubleJump=2
      for(i=0;i<7;i+=1)
      {
        global.hasAbilToken[i]=8
      }
      global.hasAbilToken[3]=5
      global.hasBoostedXCharge=1
      global.hasAbilToken[0]=2
      if global.activeAbility[0]=0
        global.activeAbility[0]=1
      if global.activeAbility[1]=0
        global.activeAbility[1]=1
    }
  }
  else if debugMenu=8 //==================== ACTIVATE MOUSE MOVEMENT ====================
  {
    if global.debugMouseMove=0
      global.debugMouseMove=1
    else
      global.debugMouseMove=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/

var __y;
__y = 100
draw_set_font(fnt_PauseMenuText)
draw_text_color(view_xview[0],view_yview[0]+__y+1,string(xVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+2,view_yview[0]+__y+1,string(xVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y,string(xVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+2,string(xVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+1,string(xVel), c_black,c_black,c_black,c_black,255)
__y += 24
draw_text_color(view_xview[0],view_yview[0]+__y+1,string(yVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+2,view_yview[0]+__y+1,string(yVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y,string(yVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+2,string(yVel), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+1,string(yVel), c_black,c_black,c_black,c_black,255)
__y += 24
draw_text_color(view_xview[0],view_yview[0]+__y+1,string(x), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+2,view_yview[0]+__y+1,string(x), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y,string(x), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+2,string(x), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+1,string(x), c_black,c_black,c_black,c_black,255)
__y += 24
draw_text_color(view_xview[0],view_yview[0]+__y+1,string(y), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+2,view_yview[0]+__y+1,string(y), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y,string(y), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+2,string(y), c_white,c_white,c_white,c_white,255)
draw_text_color(view_xview[0]+1,view_yview[0]+__y+1,string(y), c_black,c_black,c_black,c_black,255)
__y += 24
draw_text_color(view_xview[0]+1,view_yview[0]+__y+1,string(joystick_count()), c_black,c_black,c_black,c_black,255)



if global.location=40 or global.location=105
{
  if instance_exists(oColorIndControl)
  {
    var tMyZoneColorGlow;
    tMyZoneColorGlow=c_white
    if oColorIndControl.currentColor=1 {tMyZoneColorGlow=c_red}
    else if oColorIndControl.currentColor=2 {tMyZoneColorGlow=c_blue}
    else if oColorIndControl.currentColor=3 {tMyZoneColorGlow=c_green}
    else if oColorIndControl.currentColor=4 {tMyZoneColorGlow=c_yellow}
    draw_set_blend_mode(bm_add)
    draw_set_alpha(0.3)
    draw_circle_color(x,y-(sprite_height/2),24,tMyZoneColorGlow,c_black,false)
    draw_set_blend_mode(bm_normal)
  }
}
draw_set_alpha(1)
if attackState=ACT_IN_BIKE {draw_sprite_ext(sJerryOnBike,bikeAnimFrm,x-8,y-19,image_xscale,1,0,image_blend,image_alpha)}
characterDrawEvent()

//Display hat (Only if both Jeremy and Chao are around)
if (global.wearingHatJ>0 or global.wearingHatC>0) and global.charScan[0]=1 and global.charScan[1]=1
{
  characterCheckHat()
  hatOnHead=sNull
  if global.activeCharacter=0
  {
    if global.wearingHatJ=1 {hatOnHead=sDLC_Hat_01}
    else if global.wearingHatJ=2 {hatOnHead=sDLC_Hat_02}
    else if global.wearingHatJ=3 {hatOnHead=sDLC_Hat_03}
    else if global.wearingHatJ=4 {hatOnHead=sDLC_Hat_04}
    else if global.wearingHatJ=5 {hatOnHead=sDLC_Hat_05}
    else if global.wearingHatJ=6 {hatOnHead=sDLC_Hat_06}
    else if global.wearingHatJ=7 {hatOnHead=sDLC_Hat_07}
    else if global.wearingHatJ=8 {hatOnHead=sDLC_Hat_08}
    else if global.wearingHatJ=9 {hatOnHead=sDLC_Hat_09}
    else if global.wearingHatJ=10 {hatOnHead=sDLC_Hat_10}
    else if global.wearingHatJ=11 {hatOnHead=sDLC_Hat_11}
    else if global.wearingHatJ=12 {hatOnHead=sDLC_Hat_12}
    else if global.wearingHatJ=13 {hatOnHead=sDLC_Hat_13}
    else if global.wearingHatJ=14 {hatOnHead=sDLC_Hat_14}
    else if global.wearingHatJ=15 {hatOnHead=sDLC_Hat_15}
    else {hatOnHead=sNull}
  }
  else if global.activeCharacter=1
  {
    if global.wearingHatC=1 {hatOnHead=sDLC_Hat_01}
    else if global.wearingHatC=2 {hatOnHead=sDLC_Hat_02}
    else if global.wearingHatC=3 {hatOnHead=sDLC_Hat_03}
    else if global.wearingHatC=4 {hatOnHead=sDLC_Hat_04}
    else if global.wearingHatC=5 {hatOnHead=sDLC_Hat_05}
    else if global.wearingHatC=6 {hatOnHead=sDLC_Hat_06}
    else if global.wearingHatC=7 {hatOnHead=sDLC_Hat_07}
    else if global.wearingHatC=8 {hatOnHead=sDLC_Hat_08}
    else if global.wearingHatC=9 {hatOnHead=sDLC_Hat_09}
    else if global.wearingHatC=10 {hatOnHead=sDLC_Hat_10}
    else if global.wearingHatC=11 {hatOnHead=sDLC_Hat_11}
    else if global.wearingHatC=12 {hatOnHead=sDLC_Hat_12}
    else if global.wearingHatC=13 {hatOnHead=sDLC_Hat_13}
    else if global.wearingHatC=14 {hatOnHead=sDLC_Hat_14}
    else if global.wearingHatC=15 {hatOnHead=sDLC_Hat_15}
    else {hatOnHead=sNull}
  }
  draw_sprite_ext(hatOnHead,0,x+(hatDisplayX*image_xscale),y+hatDisplayY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}

if attackCharge>5
{
  if oGame.time mod 2=0
    chargeFrame+=1
  draw_sprite_ext(sMMcharging,chargeFrame,x,y-24,1+(attackCharge/100),1+(attackCharge/100),0,c_white,image_alpha)
}
if specAttackChargeA>5
{
  if oGame.time mod 2=0
    chargeFrame+=1
  draw_sprite_ext(sMMcharging,chargeFrame,x,y-24,1+(specAttackChargeA/100),1+(specAttackChargeA/100),0,c_teal,image_alpha)
}
if specAttackChargeB>5
{
  if oGame.time mod 2=0
    chargeFrame+=1
  draw_sprite_ext(sMMcharging,chargeFrame,x,y-24,1+(specAttackChargeB/100),1+(specAttackChargeB/100),0,c_teal,image_alpha)
}

if global.partySplit=1 //Show where other character is when standing still (split party only)
{
  if room!=rBubbleTowerA7 and room!=rWarshipQ
  {
    if global.optSplitWindow>1
    {
      if idleTime>=global.optSplitWindow and global.optSplitWindow>0 and global.gamePaused=0
      {
        view_visible[1]=1
        draw_set_alpha(1)
        draw_set_color(c_black)
        draw_rectangle(view_xview[0]+358,view_yview[0],view_xview[0]+479,view_yview[0]+89,1)
      }
      else {view_visible[1]=0}
    }
    else if global.optSplitWindow=1 //Always on
    {
      view_visible[1]=1
      draw_set_alpha(1)
      draw_set_color(c_black)
      draw_rectangle(view_xview[0]+358,view_yview[0],view_xview[0]+479,view_yview[0]+89,1)
    }
    else {view_visible[1]=0}
  }
}

if attackState=ACT_MORPHBALL //Show when character is in precision mode with Morph Ball
{
  if kActB
  {
    if oGame.time mod 3=0
    {
      if morphMode=11 {morphMode=10}
      else {morphMode=11}
    }
    draw_set_alpha(0.5)
    draw_set_color(c_yellow)
    draw_circle(x,y-8,morphMode,1)
  }
}

//Testing things
/*
draw_set_color(c_black)
draw_set_alpha(0.5)
draw_rectangle(x+collisionBoundsOffsetLeftX,y+collisionBoundsOffsetTopY,x+collisionBoundsOffsetRightX,y+collisionBoundsOffsetBottomY,0)

draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(fnt_EnemyName)
draw_set_halign(fa_left)

draw_text(view_xview[0]+48,view_yview[0]+96,string("Window X: ") +string(window_get_x()))
draw_text(view_xview[0]+48,view_yview[0]+112,string("Window Y: ") +string(window_get_y()))
draw_text(view_xview[0]+48,view_yview[0]+128,string("W_Mouse X: ") +string(window_mouse_get_x()))
draw_text(view_xview[0]+48,view_yview[0]+144,string("W_Mouse Y: ") +string(window_mouse_get_y()))
draw_text(view_xview[0]+48,view_yview[0]+160,string("Display X: ") +string(display_get_width()))
draw_text(view_xview[0]+48,view_yview[0]+176,string("Display Y: ") +string(display_get_height()))

draw_text(view_xview[0]+48,view_yview[0]+96,string("Double Tap Time: ") +string(doubleTapTime))
draw_text(view_xview[0]+48,view_yview[0]+112,string("Attack State: ") +string(attackState))
draw_text(view_xview[0]+48,view_yview[0]+128,string("Down Pressed: ") +string(kDownPressed))
