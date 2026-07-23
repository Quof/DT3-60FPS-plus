#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2
trailStarted=0
trialTime=0
trialProg=0
trialCheck=0
exCheck=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
trialCheck=string_char_at(global.trialMasterQuest,global.challengeRoom)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if trailStarted=1 //Fade out Challenge Master and slight wait
  {
    trialTime+=1
    if trialTime>=1 and trialTime<=10 {image_alpha-=0.1}
    else if trialTime>=55 {trialTime=0; trailStarted=2}
  }
  else if trailStarted=2 //The trial
  {
    trialTime+=1
    if global.challengeRoom=1 //======================================== TRIAL 1 ========================================
    {
      if trialProg=0
      {
        if trialTime=1
        {
          delaySpawn(96,304,oBloodTyrant,0,1,1,0.33)
          delaySpawn(384,304,oBloodTyrant,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=1
      {
        if trialTime=1
        {
          delaySpawn(240,304,oBloodTyrant,0,1,1,0.33)
          delaySpawn(96,192,oMetalGuardian,0,1,1,0.33)
          delaySpawn(384,192,oMetalGuardian,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase)
          {
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=2 //======================================== TRIAL 2 ========================================
    {
      if trialProg=0
      {
        if trialTime=1
        {
          delaySpawn(96,304,oDragonKnight,0,1,1,0.33)
          delaySpawn(384,304,oBloodTyrant,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=1
      {
        if trialTime=1
        {
          delaySpawn(240,112,oSpinGuard,0,1,1,0.33)
          delaySpawn(96,304,oBloodTyrant,0,1,1,0.33)
          delaySpawn(384,304,oDragonKnight,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase)
          {
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=3 //======================================== TRIAL 3 ========================================
    {
      if trialProg=0
      {
        if trialTime=1
        {
          delaySpawn(48,80,oSpinGuard,0,1,1,0.33)
          delaySpawn(432,80,oSpinGuard,0,1,1,0.33)
          delaySpawn(80,288,oSpinGuard,0,1,1,0.33)
          delaySpawn(400,288,oSpinGuard,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=1
      {
        if trialTime=1
        {
          delaySpawn(176,96,oMagicalBee,0,1,1,0.33)
          delaySpawn(304,96,oMagicalBee,0,1,1,0.33)
          delaySpawn(176,304,oMagicalBee,0,1,1,0.33)
          delaySpawn(304,304,oMagicalBee,0,1,1,0.33)
          delaySpawn(48,176,oMagicalBee,0,1,1,0.33)
          delaySpawn(432,176,oMagicalBee,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=2
      {
        if trialTime=1
        {
          delaySpawn(64,96,oCV_PhantomSkull,0,1,1,0.33)
          delaySpawn(240,96,oCV_PhantomSkull,0,1,1,0.33)
          delaySpawn(416,96,oCV_PhantomSkull,0,1,1,0.33)
          delaySpawn(64,272,oCV_PhantomSkull,0,1,1,0.33)
          delaySpawn(240,272,oCV_PhantomSkull,0,1,1,0.33)
          delaySpawn(416,272,oCV_PhantomSkull,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase)
          {
            if exCheck=0 {trialTime=0; trialProg+=1}
            else
            {
              tile_layer_delete(999998)
              with oScaledTrapZone {instance_destroy()}
              trialTime=0; trialProg=0; trailStarted=3
            }
          }
        }
      }
      else if trialProg=3
      {
        if trialTime>=1 and trialTime<=48
        {
          tile_layer_shift(999998,0,-1)
          oScaledTrapZone.y-=1
        }
        else if trialTime>=55
        {
          exCheck=1
          trialTime=0; trialProg=0
        }
      }
    }
    else if global.challengeRoom=4 //======================================== TRIAL 4 ========================================
    {
      if trialProg=0
      {
        if trialTime=1
        {
          delaySpawn(80,304,oWB_SilverKnight,0,1,1,0.33)
          delaySpawn(400,304,oWB_SilverKnight,0,1,1,0.33)
          delaySpawn(240,208,oWB_SilverKnight,0,1,1,0.33)
        }
        else if trialTime=120
        {
          if instance_number(oEnemyBase)<=2
          {
            delaySpawn(144,208,oWB_SilverKnight,0,1,1,0.33)
            delaySpawn(336,208,oWB_SilverKnight,0,1,1,0.33)
            trialTime=130
          }
          else {trialTime=110}
        }
        else if trialTime=210
        {
          if instance_number(oEnemyBase)<=3
          {
            delaySpawn(240,208,oWB_Scorpion,0,1,1,0.33)
            delaySpawn(240,304,oWB_Scorpion,0,1,1,0.33)
            trialTime=220
          }
          else {trialTime=200}
        }
        else if trialTime=290
        {
          if instance_number(oEnemyBase)<=4
          {
            delaySpawn(80,144,oWB_BigBat,0,1,1,0.33)
            delaySpawn(240,288,oWB_BigBat,0,1,1,0.33)
            delaySpawn(400,144,oWB_BigBat,0,1,1,0.33)
            trialTime=300
          }
          else {trialTime=280}
        }
        else if trialTime=380
        {
          if instance_number(oEnemyBase)<=4
          {
            delaySpawn(80,304,oWB_Crab,0,1,1,0.33)
            delaySpawn(400,304,oWB_Crab,0,1,1,0.33)
            delaySpawn(144,208,oWB_Crab,0,1,1,0.33)
            delaySpawn(336,208,oWB_Crab,0,1,1,0.33)
            trialTime=390
          }
          else {trialTime=370}
        }
        else if trialTime=470
        {
          if instance_number(oEnemyBase)<=5
          {
            delaySpawn(80,304,oWB_SilverKnight,0,1,1,0.33)
            delaySpawn(400,304,oWB_SilverKnight,0,1,1,0.33)
            delaySpawn(144,208,oWB_SilverKnight,0,1,1,0.33)
            delaySpawn(336,208,oWB_SilverKnight,0,1,1,0.33)
            delaySpawn(240,288,oWB_BigBat,0,1,1,0.33)
            trialTime=0; trialProg+=1
          }
          else {trialTime=460}
        }
      }
      else if trialProg=1
      {
        if trialTime>=90
        {
          if !instance_exists(oEnemyBase)
          {
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=5 //======================================== TRIAL 5 ========================================
    {
      if trialProg=0
      {
        if trialTime=1
        {
          delaySpawn(144,304,oShieldMenace,0,1,1,0.33)
          delaySpawn(336,304,oShieldMenace,0,1,1,0.33)
          delaySpawn(240,208,oDesertTitan,0,1,1,0.33)
        }
        else if trialTime=120
        {
          if instance_number(oEnemyBase)<=2
          {
            delaySpawn(80,128,oArmoredBug,0,1,1,0.33)
            delaySpawn(400,128,oArmoredBug,0,1,1,0.33)
            trialTime=130
          }
          else {trialTime=110}
        }
        else if trialTime=210
        {
          if instance_number(oEnemyBase)<=2
          {
            delaySpawn(176,208,oTentacleSpider,0,1,1,0.33)
            delaySpawn(304,208,oTentacleSpider,0,1,1,0.33)
            trialTime=220
          }
          else {trialTime=200}
        }
        else if trialTime=290
        {
          if instance_number(oEnemyBase)<=3
          {
            delaySpawn(176,208,oDesertTitan,0,1,1,0.33)
            delaySpawn(304,208,oDesertTitan,0,1,1,0.33)
            trialTime=300
          }
          else {trialTime=280}
        }
        else if trialTime=380
        {
          if instance_number(oEnemyBase)<=4
          {
            delaySpawn(80,128,oArmoredBug,0,1,1,0.33)
            delaySpawn(400,128,oArmoredBug,0,1,1,0.33)
            delaySpawn(240,304,oShieldMenace,0,1,1,0.33)
            trialTime=0; trialProg+=1
          }
          else {trialTime=370}
        }
      }
      else if trialProg=1
      {
        if trialTime>=90
        {
          if !instance_exists(oEnemyBase)
          {
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=6 //======================================== TRIAL 6 ========================================
    {
      if trialProg=0
      {
        if trialTime=1
        {
          delaySpawn(96,304,oZakoSoldier,0,1,1,0.33)
          delaySpawn(384,304,oZakoSoldier,0,1,1,0.33)
          delaySpawn(64,192,oCHAOS_AirGunner,0,1,1,0.33)
          delaySpawn(416,192,oCHAOS_AirGunner,0,1,1,0.33)
        }
        else if trialTime=90
        {
          delaySpawn(48,304,oZakoBomber,0,1,1,0.33)
          delaySpawn(432,304,oZakoBomber,0,1,1,0.33)
        }
        else if trialTime=160
        {
          delaySpawn(64,304,oBikeSoldier,0,1,1,0.33)
        }
        else if trialTime=220
        {
          delaySpawn(96,192,oCHAOS_AirGunner,0,1,1,0.33)
          delaySpawn(240,192,oCHAOS_AirGunner,0,1,1,0.33)
          delaySpawn(384,192,oCHAOS_AirGunner,0,1,1,0.33)
        }
        else if trialTime=300
        {
          delaySpawn(48,304,oZakoBomber,0,1,1,0.33)
          delaySpawn(432,304,oZakoBomber,0,1,1,0.33)
          delaySpawn(240,304,oZakoSoldier,0,1,1,0.33)
        }
        else if trialTime=370
        {
          delaySpawn(96,304,oZakoSoldier,0,1,1,0.33)
          delaySpawn(384,304,oZakoSoldier,0,1,1,0.33)
          delaySpawn(64,192,oCHAOS_AirGunner,0,1,1,0.33)
          delaySpawn(416,192,oCHAOS_AirGunner,0,1,1,0.33)
        }
        else if trialTime=430
        {
          delaySpawn(416,304,oBikeSoldier,0,1,1,0.33)
        }
        else if trialTime=480
        {
          delaySpawn(128,304,oZakoBomber,0,1,1,0.33)
          delaySpawn(352,304,oZakoBomber,0,1,1,0.33)
        }
        else if trialTime=540
        {
          delaySpawn(96,192,oCHAOS_AirGunner,0,1,1,0.33)
          delaySpawn(240,192,oCHAOS_AirGunner,0,1,1,0.33)
          delaySpawn(384,192,oCHAOS_AirGunner,0,1,1,0.33)
        }
        else if trialTime=620
        {
          delaySpawn(64,304,oBikeSoldier,0,1,1,0.33)
          delaySpawn(416,304,oBikeSoldier,0,1,1,0.33)
        }
        else if trialTime>=670
        {
          delaySpawn(240,304,oZakoBomber,0,1,1,0.33)
          delaySpawn(240,192,oCHAOS_AirGunner,0,1,1,0.33)
          trialTime=0; trialProg+=1
        }
      }
      else if trialProg=1
      {
        if trialTime>=90
        {
          if !instance_exists(oEnemyBase)
          {
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=7 //======================================== TRIAL 7 ========================================
    {
      if trialProg=0 //Mario Set
      {
        if trialTime=1
        {
          delaySpawn(480,272,oGoomba,0,1,1,0.33)
          delaySpawn(560,272,oGoomba,0,1,1,0.33)
          delaySpawn(688,272,oGoomba,0,1,1,0.33)
          delaySpawn(768,272,oGoomba,0,1,1,0.33)
        }
        else if trialTime=80
        {
          if instance_number(oEnemyBase)<=2
          {
            delaySpawn(464,176,oFireBro,0,1,1,0.33)
            delaySpawn(784,176,oFireBro,0,1,1,0.33)
            trialTime=90
          }
          else {trialTime=70}
        }
        else if trialTime=160
        {
          if instance_number(oEnemyBase)<=2
          {
            delaySpawn(544,208,oHammerBro,0,1,1,0.33)
            delaySpawn(704,208,oHammerBro,0,1,1,0.33)
            trialTime=170
          }
          else {trialTime=150}
        }
        else if trialTime=210
        {
          delaySpawn(624,112,oLakitu,0,1,1,0.33)
        }
        else if trialTime=270
        {
          delaySpawn(544,144,oGreenParatroopa,0,1,1,0.33)
          delaySpawn(704,144,oGreenParatroopa,0,1,1,0.33)
        }
        else if trialTime>=350
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=1 //Link Set
      {
        if trialTime=1
        {
          delaySpawn(464,176,oMegmet,0,1,1,0.33)
          delaySpawn(784,176,oMegmet,0,1,1,0.33)
          delaySpawn(544,208,oMegmet,0,1,1,0.33)
          delaySpawn(704,208,oMegmet,0,1,1,0.33)
        }
        else if trialTime=80
        {
          if instance_number(oEnemyBase)<=2
          {
            delaySpawn(480,272,oDoomknocker,0,1,1,0.33)
            delaySpawn(768,272,oHammerThrower,0,1,1,0.33)
            trialTime=90
          }
          else {trialTime=70}
        }
        else if trialTime=170
        {
          delaySpawn(624,272,oChuchu,0,1,1,0.33)
        }
        else if trialTime=220
        {
          if instance_number(oEnemyBase)<=3
          {
            delaySpawn(784,176,oFirebird,0,1,1,0.33)
            delaySpawn(544,192,oTektile,0,1,1,0.33)
            trialTime=230
          }
          else {trialTime=210}
        }
        else if trialTime=290
        {
          delaySpawn(560,272,oOctorok,0,1,1,0.33)
          delaySpawn(688,272,oOctorok,0,1,1,0.33)
        }
        else if trialTime>=360
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=2 //Castlevania Set
      {
        if trialTime=1
        {
          delaySpawn(464,176,oCV_BonePillar,0,1,1,0.33)
          delaySpawn(784,176,oCV_BonePillar,0,1,1,0.33)
          delaySpawn(544,208,oCV_BonePillar,0,1,1,0.33)
          delaySpawn(704,208,oCV_BonePillar,0,1,1,0.33)
        }
        else if trialTime=60
        {
          delaySpawn(480,272,oCV_PantherSkeleton,0,1,1,0.33)
          delaySpawn(768,272,oCV_PantherSkeleton,0,1,1,0.33)
        }
        else if trialTime=130
        {
          if instance_number(oEnemyBase)<=3
          {
            delaySpawn(480,112,oCV_Ghost,0,1,1,0.33)
            delaySpawn(688,112,oCV_Ghost,0,1,1,0.33)
            trialTime=140
          }
          else {trialTime=120}
        }
        else if trialTime=190
        {
          if instance_number(oEnemyBase)<=3
          {
            delaySpawn(544,176,oCV_SalemWitch,0,1,1,0.33)
            delaySpawn(704,176,oCV_SalemWitch,0,1,1,0.33)
            trialTime=200
          }
          else {trialTime=180}
        }
        else if trialTime=250
        {
          if instance_number(oEnemyBase)<=3
          {
            delaySpawn(624,272,oCV_AxeKnight,0,1,1,0.33)
            trialTime=260
          }
          else {trialTime=240}
        }
        else if trialTime=320
        {
          delaySpawn(624,112,oCV_PeepingEye,0,1,1,0.33)
        }
        else if trialTime>=370
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=3 //Mega Man Set
      {
        if trialTime=1
        {
          delaySpawn(544,208,oHammaHammaMain,0,1,1,0.33)
          delaySpawn(704,208,oHammaHammaMain,0,1,1,0.33)
        }
        else if trialTime=70
        {
          delaySpawn(544,112,oSineFaller,0,1,1,0.33)
          delaySpawn(704,112,oSineFaller,0,1,1,0.33)
        }
        else if trialTime=160
        {
          delaySpawn(560,272,oNotorBanger,0,1,1,0.33)
          delaySpawn(688,272,oNotorBanger,0,1,1,0.33)
        }
        else if trialTime=230
        {
          if instance_number(oEnemyBase)<=3
          {
            delaySpawn(624,272,oMegaTortoise,0,1,1,0.33)
            trialTime=240
          }
          else {trialTime=220}
        }
        else if trialTime=300
        {
          delaySpawn(480,272,oWalkBlaster,0,1,1,0.33)
          delaySpawn(768,272,oWalkBlaster,0,1,1,0.33)
        }
        else if trialTime=350
        {
          delaySpawn(464,176,oNotorBanger,0,1,1,0.33)
        }
        else if trialTime>=420
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=4 //Samus Set
      {
        if trialTime=1
        {
          delaySpawn(544,272,oMetCacatac,0,1,1,0.33)
          delaySpawn(704,272,oMetCacatac,0,1,1,0.33)
        }
        else if trialTime=80
        {
          delaySpawn(624,272,oMetCacatac,0,1,1,0.33)
        }
        else if trialTime=150
        {
          delaySpawn(464,176,oMetSmallSidehopper,0,1,1,0.33)
          delaySpawn(784,176,oMetSmallSidehopper,0,1,1,0.33)
        }
        else if trialTime=200
        {
          if instance_number(oEnemyBase)<=2
          {
            delaySpawn(624,272,oMetCacatac,0,1,1,0.33)
            trialTime=210
          }
          else {trialTime=190}
        }
        else if trialTime=150
        {
          delaySpawn(544,208,oMetSidehopper,0,1,1,0.33)
          delaySpawn(704,208,oMetSidehopper,0,1,1,0.33)
        }
        else if trialTime>=220
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=5
      {
        if trialTime>=10
        {
          if !instance_exists(oEnemyBase)
          {
            with oEnemyBarrier {instance_destroy()}
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
  }
  else if trailStarted=3 //Trial completed
  {
    trialTime+=1
    if trialTime=1
    {
      oPlayer1.life=oPlayer1.maxLife
      msgCreate(80,120,"Challenge Master","Congratulations on completing my trial.#HAVE A REWARD!!",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
      var tNewString;
      tNewString=string_delete(global.trialMasterQuest,global.challengeRoom,1)
      tNewString=string_insert("1",tNewString,global.challengeRoom)
      global.trialMasterQuest=tNewString
      trialCheck="1"
    }

    if trialTime>=1 and trialTime<=10 {image_alpha+=0.1}
    else if trialTime>=20
    {
      if global.challengeRoom=1
      {
        if instance_exists(oHeartPiece) {oHeartPiece.y-=room_height}
      }
      else if global.challengeRoom=2
      {
        if instance_exists(oArrowQuiver) {oArrowQuiver.y-=room_height}
      }
      else if global.challengeRoom=3
      {
        if instance_exists(oMissilePack) {oMissilePack.y-=room_height}
      }
      else if global.challengeRoom=4
      {
        if instance_exists(oWalletBoost) {oWalletBoost.y-=room_height}
      }
      else if global.challengeRoom=5 or global.challengeRoom=6
      {
        if instance_exists(oAPBoost) {oAPBoost.y-=room_height}
      }
      else if global.challengeRoom=7
      {
        if global.bNightmareMode=0
        {
          if instance_exists(oItemFinderPickup) {oItemFinderPickup.y-=room_height}
        }
        else
        {
          var tHeartContainer;
          tHeartContainer=instance_create(352,136,oHeartContainer)
          tHeartContainer.objectNum=7
        }
      }
      global.canCharSwap=2
      if global.challengeRoom!=7 {oExit.y-=room_height}
      trailStarted=0
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false and trailStarted=0
{
  global.recPeopleTalkNum+=1
  if x<=oPlayer1.x {image_xscale=1}
  else {image_xscale=-1}

  var tCurseCheck;
  tCurseCheck=0
  for(i=0;i<3;i+=1)
  {
    if global.activeCharacter=0
    {
      if global.equipJerry[i]=10 {tCurseCheck+=1}
      else if global.equipJerry[i]=11 {tCurseCheck+=1}
      else if global.equipJerry[i]=12 {tCurseCheck+=1}
    }
    else
    {
      if global.equipClaire[i]=10 {tCurseCheck+=1}
      else if global.equipClaire[i]=11 {tCurseCheck+=1}
      else if global.equipClaire[i]=12 {tCurseCheck+=1}
    }
  }

  if trialCheck="0"
  {
    if room=rCCity_SGrove //Final cursed arena
    {
      var tChkChall,tQuickChk;
      tChkChall=0
      for(i=0;i<7;i+=1)
      {
        tQuickChk=string_char_at(global.trialMasterQuest,i+1)
        if tQuickChk="1" {tChkChall+=1}
      }

      if tChkChall>=5
      {
        if tCurseCheck=3 //Have Gear Equip
        {
          msgCreate(80,120,"Challenge Master","You are ready.#FOR A VERY LONG FIGHT!!",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
          global.canCharSwap=1
          enemyBarrier=instance_create(432,-16,oEnemyBarrier); enemyBarrier.image_yscale=10
          trailStarted=1
        }
        else //Need Cursed Gear
        {
          msgCreate(80,120,"Challenge Master","Only one who is cursed may attempt my trials.#RETURN WHEN YOU ARE TRULY READY!!",0,2,oMessagePerson,0)
          newMessage.fadingTime=90
        }
      }
      else //Need Other challenges complete
      {
        msgCreate(80,120,"Challenge Master","You are not worthy of this.#RETURN TO ME WHEN YOU HAVE COMPLETED AT LEAST 5 OF MY OTHER CHALLENGES!!",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
      }
    }
    else //Other arenas
    {
      if tCurseCheck=3 //Have Gear Equip
      {
        msgCreate(80,120,"Challenge Master","You who are cursed.#YOU ARE READY FOR MY TRIAL!!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
        global.canCharSwap=1
        oExit.y+=room_height
        trailStarted=1
      }
      else //Need Cursed Gear
      {
        msgCreate(80,120,"Challenge Master","Only one who is cursed may attempt my trials.#RETURN WHEN YOU ARE TRULY READY!!",0,2,oMessagePerson,0)
        newMessage.fadingTime=80
      }
    }
  }
  else //Trial completed
  {
    msgCreate(80,120,"Challenge Master","You have already completed this trial.#BE GONE FROM MY SIGHT!!",0,1,oMessagePerson,0)
    newMessage.fadingTime=70
  }
}
