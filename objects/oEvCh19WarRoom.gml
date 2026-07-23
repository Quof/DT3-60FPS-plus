#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0

bModPlayerAirDash=0
bCountEnemies=0
bCanSpawnHeroes=0
spawnGameHero[0]=280
spawnGameHero[1]=180
spawnGameHero[2]=130
spawnGameHero[3]=170
spawnGameHero[4]=330
spawnGameHero[5]=140
spawnGameHero[6]=90

if global.newMapX>=512 {sceneProgress=8}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rDiscoD //----- War room -----
  {
    if sceneProgress=0 //Barriers
    {
      if oPlayer1.x>=928
      {
        var tBarrier;
        tBarrier=instance_create(176,128,oEnemyBarrier); tBarrier.image_yscale=10
        tBarrier=instance_create(4480,192,oEnemyBarrier); tBarrier.image_yscale=6
        if global.gameProgress=4620 {sceneProgress+=1}
        else {sceneProgress=2}
      }
    }
    else if sceneProgress=1 //First wave
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        var tEnemy;
        tEnemy=instance_create(752,-32,oCHAOS_Rocketeer); tEnemy.bActive=1
        tEnemy=instance_create(1104,-32,oCHAOS_Rocketeer); tEnemy.bActive=1
      }
      else if sceneDelay=130
      {
        var tEnemy;
        tEnemy=instance_create(oPlayer1.x-160,-32,oCHAOS_Rocketeer); tEnemy.bActive=1
        tEnemy=instance_create(oPlayer1.x+160,-32,oCHAOS_Rocketeer); tEnemy.bActive=1
      }
      else if sceneDelay=210
      {
        bCanSpawnHeroes=1
      }
      else if sceneDelay=250
      {
        var tempMplay;
        tempMplay=findMusic(28)
        playMusic(tempMplay,0,0)
      }
      else if sceneDelay=370
      {
        var tEnemy;
        tEnemy=instance_create(oPlayer1.x,-32,oCHAOS_Rocketeer); tEnemy.bActive=1
      }
      else if sceneDelay=480
      {
        msgCreate(0,0,"Jeremy","That was scary for a moment!",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=550
      {
        msgCreate(0,0,"Jerry","I wasn't quite expecting that one.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if sceneDelay>=610
      {
        if instance_number(oEnemyBase)=0
        {
          bCanSpawnHeroes=0
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=2 //First big set and player gains more dash regen
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        if global.gameProgress=4620
        {
          msgCreate(0,0,"Jeremy","Hex is about to throw a lot more at you, but with their help, you've got this.",0,2,oMessagePerson,0)
          newMessage.fadingTime=150
        }
      }
      else if sceneDelay=150
      {
        bCanSpawnHeroes=1
        for(i=0;i<12;i+=1)
        {
          delaySpawn(1200+(48*i),64+(8*i),oCHAOS_AirGunner,0,1,1,0.33)
        }
      }
      else if sceneDelay=200
      {
        var enemyCounter;
        instance_create(0,0,oEnemyRemain)
        oEnemyRemain.enemyCount=instance_number(oEnemyBase)
        bCountEnemies=1
      }
      else if sceneDelay=350
      {
        delaySpawn(384,288,oMegaTortoise,0,1,0,0.33)
        delaySpawn(1152,256,oMegaTortoise,0,1,0,0.33)
        delaySpawn(1696,288,oMegaTortoise,0,1,0,0.33)
        delaySpawn(2112,160,oMegaTortoise,0,1,0,0.33)
        delaySpawn(2768,224,oMegaTortoise,0,1,0,0.33)
        delaySpawn(3408,288,oMegaTortoise,0,1,0,0.33)
        delaySpawn(4144,288,oMegaTortoise,0,1,0,0.33)
      }
      else if sceneDelay=380
      {
        oPlayer1.modDashRecharge=30
        if global.gameProgress=4620
        {
          msgCreate(0,0,"Jeremy","There we go, sped up your dash recovery.",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
        }
      }
      else if sceneDelay=440
      {
        for(i=0;i<42;i+=1)
        {
          delaySpawn(320+(48*i),32,oGoomba,0,1,1,0.33)
        }
      }
      else if sceneDelay=510
      {
        for(i=0;i<3;i+=1)
        {
          delaySpawn(736,48+(64*i),oSpinGuard,0,1,0,0.33)
          delaySpawn(1904,48+(64*i),oSpinGuard,0,1,0,0.33)
          delaySpawn(2032,48+(64*i),oSpinGuard,0,1,0,0.33)
          delaySpawn(2576,48+(64*i),oSpinGuard,0,1,0,0.33)
          delaySpawn(3408,48+(64*i),oSpinGuard,0,1,0,0.33)
          delaySpawn(4064,48+(64*i),oSpinGuard,0,1,0,0.33)
        }
      }
      else if sceneDelay=590
      {
        for(i=0;i<3;i+=1)
        {
          delaySpawn(832+(64*i),288,oChuchu,0,1,0,0.33)
          delaySpawn(2160+(64*i),288,oChuchu,0,1,0,0.33)
          delaySpawn(3456+(64*i),288,oChuchu,0,1,0,0.33)
        }
      }
      else if sceneDelay>=650
      {
        if instance_number(oEnemyBase)<40
        {
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=3 //Second set and player gains higher jump and more dash regen
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        oPlayer1.initialJumpAcc=-7.7
        oPlayer1.doubleJumpAcc=-6.6
        oPlayer1.jumpTimeTotal=30
        oPlayer1.modDashRecharge=45
        if global.gameProgress=4620
        {
          msgCreate(0,0,"Jeremy","Sped up your dash even more and you can jump higher!",0,1,oMessagePerson,0)
          newMessage.fadingTime=110
        }
      }
      else if sceneDelay=80
      {
        delaySpawn(1824,160,oWB_SilverKnight,0,1,0,0.33)
        delaySpawn(2112,160,oWB_SilverKnight,0,1,0,0.33)
        delaySpawn(2368,192,oWB_SilverKnight,0,1,0,0.33)
        delaySpawn(3264,128,oWB_SilverKnight,0,1,0,0.33)
        delaySpawn(3520,160,oWB_SilverKnight,0,1,0,0.33)
        delaySpawn(3712,176,oWB_SilverKnight,0,1,0,0.33)
      }
      else if sceneDelay=190
      {
        for(i=0;i<3;i+=1)
        {
          delaySpawn(480+(32*i),80+(32*i),oMetalGuardian,0,1,0,0.33)
          delaySpawn(1600+(32*i),48+(32*i),oMetalGuardian,0,1,0,0.33)
          delaySpawn(2848+(32*i),48+(32*i),oMetalGuardian,0,1,0,0.33)
          delaySpawn(3984-(32*i),48+(32*i),oMetalGuardian,0,1,0,0.33)
        }
      }
      else if sceneDelay=450
      {
        for(i=0;i<3;i+=1)
        {
          delaySpawn(1232+(64*i),224,oStealthBug,0,1,0,0.33)
          delaySpawn(2304+(64*i),288,oShieldMenace,0,1,0,0.33)
          delaySpawn(3392+(64*i),288,oDesertTitan,0,1,0,0.33)
        }
      }
      else if sceneDelay=750
      {
        for(i=0;i<16;i+=1)
        {
          delaySpawn(320+(128*i),32,oPlayfulPenguin,0,1,1,0.33)
        }
      }
      else if sceneDelay=840
      {
        delaySpawn(752,256,oKeeperOfTheShell,0,1,0,0.33)
        delaySpawn(1776,160,oKeeperOfTheShell,0,1,0,0.33)
        delaySpawn(2160,160,oKeeperOfTheShell,0,1,0,0.33)
        delaySpawn(3856,256,oKeeperOfTheShell,0,1,0,0.33)
      }
      else if sceneDelay>=890
      {
        if instance_number(oEnemyBase)<30
        {
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=4 //Third set and player gains infinite air-dashing and dash energy
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        bModPlayerAirDash=1
        oPlayer1.modDashRecharge=1000
        if global.gameProgress=4620
        {
          msgCreate(0,0,"Jeremy","Aaaaand better. Infinite air dashes and nearly infinite dash energy!",0,1,oMessagePerson,0)
          newMessage.fadingTime=120
        }
      }
      else if sceneDelay=170
      {
        delaySpawn(384,288,oZakoSoldier,0,1,0,0.33)
        delaySpawn(1152,256,oZakoSoldier,0,1,0,0.33)
        delaySpawn(1696,288,oZakoSoldier,0,1,0,0.33)
        delaySpawn(2112,160,oZakoSoldier,0,1,0,0.33)
        delaySpawn(2768,224,oZakoSoldier,0,1,0,0.33)
        delaySpawn(3408,288,oZakoSoldier,0,1,0,0.33)
        delaySpawn(4144,288,oZakoSoldier,0,1,0,0.33)
      }
      else if sceneDelay=350
      {
        for(i=0;i<3;i+=1)
        {
          delaySpawn(832+(64*i),288,oZakoBomber,0,1,0,0.33)
          delaySpawn(2160+(64*i),288,oZakoBomber,0,1,0,0.33)
          delaySpawn(3456+(64*i),288,oZakoBomber,0,1,0,0.33)
        }
      }
      else if sceneDelay=610
      {
        for(i=0;i<16;i+=1)
        {
          delaySpawn(320+(128*i),32,oZakoCannonfodder,0,1,1,0.33)
        }
      }
      else if sceneDelay>=660
      {
        if instance_number(oEnemyBase)<30
        {
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=5 //Fourth set
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        bModPlayerAirDash=1
        oPlayer1.modDashRecharge=1000
        if global.gameProgress=4620
        {
          msgCreate(0,0,"Jeremy","Careful, CHAOS is coming in full force!",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
      }
      else if sceneDelay=110
      {
        for(i=0;i<24;i+=1)
        {
          delaySpawn(320+(80*i),32+(4*i),oCHAOS_AirGunner,0,1,1,0.33)
        }
      }
      else if sceneDelay=500
      {
        delaySpawn(928,288,oCHAOS_Tank,0,1,0,0.33)
        delaySpawn(1968,288,oCHAOS_Tank,0,1,0,0.33)
        delaySpawn(3456,288,oCHAOS_Tank,0,1,0,0.33)
      }
      else if sceneDelay=800
      {
        delaySpawn(400,288,oZakoSoldier,0,1,0,0.33)
        delaySpawn(1168,256,oZakoSoldier,0,1,0,0.33)
        delaySpawn(1712,288,oZakoSoldier,0,1,0,0.33)
        delaySpawn(2128,160,oZakoSoldier,0,1,0,0.33)
        delaySpawn(2784,224,oZakoSoldier,0,1,0,0.33)
        delaySpawn(3424,288,oZakoSoldier,0,1,0,0.33)
        delaySpawn(4160,288,oZakoSoldier,0,1,0,0.33)
      }
      else if sceneDelay=1170
      {
        for(i=0;i<16;i+=1)
        {
          delaySpawn(320+(128*i),0,oCHAOS_Sabotage,0,1,1,0.33)
        }
      }
      else if sceneDelay>=1220
      {
        if instance_number(oEnemyBase)<30
        {
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=6 //Fifth set
    {
      sceneDelay+=1
      if sceneDelay=30
      {
        delaySpawn(1424,224,oCHAOS_Tank,0,1,0,0.33)
      }
      else if sceneDelay=150 {var tEnemy; tEnemy=instance_create(oPlayer1.x,-32,oCHAOS_Rocketeer); tEnemy.bActive=1}
      else if sceneDelay=200 {var tEnemy; tEnemy=instance_create(oPlayer1.x,-32,oCHAOS_Rocketeer); tEnemy.bActive=1}
      else if sceneDelay=250 {var tEnemy; tEnemy=instance_create(oPlayer1.x,-32,oCHAOS_Rocketeer); tEnemy.bActive=1}
      else if sceneDelay=300 {var tEnemy; tEnemy=instance_create(oPlayer1.x,-32,oCHAOS_Rocketeer); tEnemy.bActive=1}
      else if sceneDelay=830
      {
        delaySpawn(944,64,oFlyingGMWonderbird,0,1,0,0.33)
        delaySpawn(2096,64,oFlyingGMWonderbird,0,1,0,0.33)
        delaySpawn(3440,64,oFlyingGMWonderbird,0,1,0,0.33)
      }
      else if sceneDelay=930 {var tEnemy; tEnemy=instance_create(oPlayer1.x,64,oFlyingGMWonderbird); tEnemy.bActive=1}
      else if sceneDelay=1150 {var tEnemy; tEnemy=instance_create(oPlayer1.x,64,oFlyingGMWonderbird); tEnemy.bActive=1}
      else if sceneDelay=1470
      {
        delaySpawn(368,288,oCHAOS_ShockUnit,0,1,0,0.33)
        delaySpawn(1136,256,oCHAOS_ShockUnit,0,1,0,0.33)
        delaySpawn(1680,288,oCHAOS_ShockUnit,0,1,0,0.33)
        delaySpawn(2096,160,oCHAOS_ShockUnit,0,1,0,0.33)
        delaySpawn(2752,224,oCHAOS_ShockUnit,0,1,0,0.33)
        delaySpawn(3392,288,oCHAOS_ShockUnit,0,1,0,0.33)
        delaySpawn(4128,288,oCHAOS_ShockUnit,0,1,0,0.33)
      }
      else if sceneDelay>=1570
      {
        if instance_number(oEnemyBase)<=3
        {
          bCanSpawnHeroes=0
          bCountEnemies=0
          with oEnemyRemain {instance_destroy()}
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=7 //End
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        if global.gameProgress>=4630 {sceneDelay=235}
      }
      if sceneDelay=30
      {
        msgCreate(0,0,"Jeremy","HA, they all got scared! No more should be showing up. Sorry I couldn't edit much this time.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if sceneDelay=150
      {
        msgCreate(0,0,"Jerry","It's no biggie. All those bots followed us.",0,2,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=240
      {
        msgCreate(0,0,"Jeremy","Just finish the ones there and keep going. Kirby isn't very far now it seems.",0,2,oMessagePerson,0)
        newMessage.fadingTime=160
      }
      else if sceneDelay>=280
      {
        if global.gameProgress=4620 {global.gameProgress=4630}
        with oEnemyBarrier {instance_destroy()}
        sceneDelay=0; sceneProgress+=1
      }
    }
  }

  if bCanSpawnHeroes=1 //---------- Spawn Heroes ----------
  {
    for(i=0;i<7;i+=1)
    {
      spawnGameHero[i]+=1
    }

    if spawnGameHero[0]>=280 //Arthur
    {
      var myNPC;
      myNPC=instance_create(-64,-64,oWarRoomNPC)
      myNPC.type=1
      spawnGameHero[0]=0
    }
    else if spawnGameHero[1]>=210 //Battletoad
    {
      var myNPC;
      myNPC=instance_create(-64,-64,oWarRoomNPC)
      myNPC.type=2
      spawnGameHero[1]=0
    }
    else if spawnGameHero[2]>=190 //Firebrand
    {
      var myNPC;
      myNPC=instance_create(-64,-64,oWarRoomNPC)
      myNPC.type=3
      spawnGameHero[2]=0
    }
    else if spawnGameHero[3]>=250 //Goemon
    {
      var myNPC;
      myNPC=instance_create(-64,-64,oWarRoomNPC)
      myNPC.type=4
      spawnGameHero[3]=0
    }
    else if spawnGameHero[4]>=340 //Ristar
    {
      var myNPC;
      myNPC=instance_create(-64,-64,oWarRoomNPC)
      myNPC.type=5
      spawnGameHero[4]=0
    }
    else if spawnGameHero[5]>=260 //Sparkster
    {
      var myNPC;
      myNPC=instance_create(-64,-64,oWarRoomNPC)
      myNPC.type=6
      spawnGameHero[5]=0
    }
    else if spawnGameHero[6]>=290 //The Master (Actraiser)
    {
      var myNPC;
      myNPC=instance_create(-64,-64,oWarRoomNPC)
      myNPC.type=7
      spawnGameHero[6]=0
    }
  }
  if bCountEnemies=1 {oEnemyRemain.enemyCount=instance_number(oEnemyBase)}
  if bModPlayerAirDash=1 {oPlayer1.canAirDash=1}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
