///RETRY MAP
playSound(global.snd_Retry,0,1,1)
//Minimum life
/*
if global.pMaxLife>=12 and global.pMaxLife<=16 {if global.pLife<12 {global.pLife=12}} //(3-4) 3
else if global.pMaxLife>=20 and global.pMaxLife<=24 {if global.pLife<16 {global.pLife=16}} //(5-6) 4
else if global.pMaxLife=28 {if global.pLife<20 {global.pLife=20}} //(7) 5
else if global.pMaxLife=32 {if global.pLife<24 {global.pLife=24}} //(8) 6
else if global.pMaxLife>=36 and global.pMaxLife<=40 {if global.pLife<28 {global.pLife=28}} //(9-10) 7
else if global.pMaxLife=44 {if global.pLife<32 {global.pLife=32}} //(11) 8
else if global.pMaxLife=48 {if global.pLife<36 {global.pLife=36}} //(12) 9
else if global.pMaxLife>=52 and global.pMaxLife<=56 {if global.pLife<40 {global.pLife=40}} //(13-14) 10
else if global.pMaxLife=60 {if global.pLife<44 {global.pLife=44}} //(15) 11
else if global.pMaxLife=64 {if global.pLife<48 {global.pLife=48}} //(16) 12
else if global.pMaxLife>=68 and global.pMaxLife<=72 {if global.pLife<52 {global.pLife=52}} //(17-18) 13
else if global.pMaxLife=76 {if global.pLife<56 {global.pLife=56}} //(19) 14
else if global.pMaxLife=80 {if global.pLife<60 {global.pLife=60}} //(20) 15

if true and global.pLife<max(floor(floor(global.pMaxLife/4)*0.75),3)*4 //spsphealth
{                       //spsp: start life min is 3/4 (rounded down) of max health
    //global.pLife=max(floor(floor(global.pMaxLife/4)*0.75),3)*4
}*/
//spsp ns andrew's respawn health
global.pLife=global.pMaxLife
//if room=rDEX {global.pLife=global.pMaxLife} //full health for each phase of DEX upon death //spsp
//^not needed
//full heal change (added): with the Full Heal After Death dipswitch, retrying from the checkpoint refills all of the
//player's life instead of the minimum above (about 75%)
if global.fullHealAfterDeath=true {global.pLife=global.pMaxLife}
//Ammo
global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]

//Boss specific respawns
global.gamePaused=false; global.gameOver=false

if global.bBossGallery=1
{
  if global.currentBoss=""
  {
    room_restart()
  }
  else {event_user(1)}
}
else //Not in boss gallery
{
  if room=rWarshipZ_E3 //Fedex
  {
    global.bossTrack=0
    global.newMapX=888
    global.newMapY=448
    room_goto(rBT_HUB)
  }
  else if room=rBT_HelmetheadEX //Helmethead EX
  {
    global.bossTrack=0
    global.newMapX=1016
    global.newMapY=448
    room_goto(rBT_HUB)
  }
  else if scrModHook("gameOverRetry",0,0)=1 {} //mods change (added): a mod's own place to retry from (it goes there and returns 1)
  else
  {
    if global.bossTrack=102 //TD -> Central City
    {
      global.bossTrack=0
      global.newMapX=1200
      global.newMapY=288
      room_goto(rCCity_NorthA)
    }
    else if global.bossTrack=110 //Dragoon -> Castle Balcony
    {
      global.bShooter=0
      global.bossTrack=0
      global.newMapX=864
      global.newMapY=320
      room_goto(rMC_N)
    }
    else
    {
      if global.bossTrack<1000 {global.bossTrack=0}

      if global.currentBoss="Army Eye"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=176; global.newMapY=304; room_goto(rBubbleTowerA6)
      }
      else if global.currentBoss="Storm Eagle"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=4544; global.newMapY=176; room_goto(rMega4_StormD)
      }
      else if global.currentBoss="Overdrive Ostrich"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=8656; global.newMapY=272; room_goto(rMega4_OstrichD)
      }
      else if global.currentBoss="Gravity Beetle"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=3824; global.newMapY=592; room_goto(rMega4_ToxicJungleD)
      }
      else if global.currentBoss="Bospider"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=3744; global.newMapY=224; room_goto(rMega4_SigmaA4)
      }
      else if global.currentBoss="Bit"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=48; global.newMapY=288; room_goto(rMega4_SigmaB2)
      }
      else if global.currentBoss="Byte"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=48; global.newMapY=3008; room_goto(rMega4_SigmaB4)
      }
      else if global.currentBoss="Bit & Byte"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=1168; global.newMapY=288; room_goto(rMega4_SigmaB7)
      }
      else if global.currentBoss="Sigma" or global.currentBoss="Sigma Epsilon"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=2736; global.newMapY=288; room_goto(rMega4_SigmaC4)
      }
      else if global.currentBoss="Parasitic Seed"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=272; global.newMapY=208; room_goto(rPttT_06)
      }
      else if global.currentBoss="Virus Parasite"
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=400; global.newMapY=216; room_goto(rAbomE)
      }
      else if global.currentBoss="Distorted Abomination" //spsp ns
      {
        global.rmDeaths=0
        global.currentBoss=""
        global.newMapX=480; global.newMapY=624; room_goto(rMain_76)
      }
      else
      {
        global.currentBoss=""
        if global.location=49 //Gate 5 retry spawn
        {
          global.pLife=global.pMaxLife
          global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
          global.bCanSave=true
          global.newMapX=global.metCheckpoint[1]
          global.newMapY=global.metCheckpoint[2]
          room_goto(global.metCheckpoint[0])
        }
        else if room=rWarshipZ_EscapeA or room=rWarshipZ_EscapeB or room=rWarshipZ_EscapeC or room=rWarshipZ_EscapeD //Final segment
        {
          global.forceTime=3600
          global.newMapX=1392
          global.newMapY=256
          room_goto(rWarshipZ_EscapeA)
        }
        else //Normal retry spawn
        {
          room_restart()
        }
      }
    }
  }
}
