if explainMenu=0 //Show explain menu during first TD battle
{
  if sceneProgress=0
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay>=10
    {
      if global.gameProgress<=3890
      {
        var tMyRules;
        tMyRules=instance_create(0,0,oTD_ExplainMenu)
        tMyRules.type=1
        sceneDelay=0; sceneProgress+=1
      }
      else
      {
        global.gamePaused=false
        explainMenu=1
        sceneDelay=0; sceneProgress=0
      }
    }
  }
}
else if explainMenu=1 //TD sequences
{
  if global.gamePaused=false
  {
    if TD_Difficulty=1 and false //------------------------------ First story TD Battle ------------------------------ //spsp orig
    {
    }
    else if TD_Difficulty=1 and true //spsp              1ST DEFENSE
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
        swarmSpawn.enemyType=oBloodVirus; swarmSpawn.enemyLevel=1
        swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=6; swarmSpawn.myDir=-1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oDragonKnight; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=56; swarmSpawn.spawnMax=12; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oWB_SilverKnight; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=56; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1664,416,oTD_EnemySpawner)
          swarmSpawn.enemyType=oWB_BigBat; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=16; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1216,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oNotorBanger; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=10; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1664,416,oTD_EnemySpawner)
          swarmSpawn.enemyType=oLakitu; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=16; swarmSpawn.myDir=180
          swarmSpawn=instance_create(1776,528,oTD_EnemySpawner)
          swarmSpawn.enemyType=oWB_Crab; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=150; swarmSpawn.spawnMax=2; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1968,240,oTD_EnemySpawner)
          swarmSpawn.enemyType=oFlyingGMWonderbird; swarmSpawn.enemyLevel=1
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1*gDeltaTime
          if sceneDelay=10
          {
            if global.gameProgress=3880 {global.gameProgress=3890}
            else {sceneDelay=0; explainMenu=2}
          }
        }
      }
    }
    else if TD_Difficulty=2 and false //------------------------------ Second story TD Battle ------------------------------ //spsp orig
    {
    }
    else if TD_Difficulty=2 and true //------------------------------ Second story TD Battle spsp
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        for (i=1; i<11; i+=1)
      {
            for (j=1; j<6; j+=1)
        {
                var letsgo;
                letsgo=instance_create(i*100,j*100,oCHAOS_Rocketeer)
                //letsgo.bActive=1
        }
      }
        sceneProgress=10
      }
      else if sceneProgress=10 //Level 2 complete
      {
        if !instance_exists(oCHAOS_Assault)
        {
          sceneDelay+=1*gDeltaTime
          if sceneDelay=10
          {
            if global.gameProgress=3900 {global.gameProgress=3910}
            else {sceneDelay=0; explainMenu=2}
          }
        }
      }
    }
    else if TD_Difficulty=3 and false //------------------------------ Optional 1 ------------------------------ //spsp orig
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=16; swarmSpawn.myDir=1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=68; swarmSpawn.spawnMax=16; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=48; swarmSpawn.spawnMax=18; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=64; swarmSpawn.spawnMax=16; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=30; swarmSpawn.spawnMax=10; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=12; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=35; swarmSpawn.spawnMax=14; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1680,464,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=4; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_BeastTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=3; swarmSpawn.myDir=1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=12; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1680,464,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=12; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=12; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=45; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1440,224,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=12; swarmSpawn.myDir=1
          swarmSpawn=instance_create(1712,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=55; swarmSpawn.spawnMax=12; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=18; swarmSpawn.spawnMax=55; swarmSpawn.myDir=1
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(448,160,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_BeastTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=5; swarmSpawn.myDir=1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 3 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1*gDeltaTime
          if sceneDelay=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=3 {global.gameOptTowerDef=4}
            sceneDelay=0; explainMenu=2
          }
        }
      }
    }
    else if TD_Difficulty=3 and true //spsp TD 3--------------------------------/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/-/
    {
        //sceneDelay+=1
        sceneDelay+=1*gDeltaTime //60fps change: per frame
        if sceneProgress=0
        {
            /*if sceneDelay=75
            {
                devli+=1
                delaySpawn(oPlayer1.x+100*sin(devli),oPlayer1.y+100*cos(devli),oWB_BigBat,0,1,1,0.33)
                sceneCount+=1
                sceneDelay=0
            }
            if sceneCount=10
            {
                sceneCount=0; sceneDelay=0; sceneProgress+=1
                devli=0
                event_user(0)
            }*/
            if sceneDelay>=10 and !instance_exists(oDGoomba)
            {
                sceneProgress+=1; sceneDelay=0
            }
            else if sceneDelay>30 {sceneDelay=0}
        }
        /*else if sceneProgress=1 and !instance_exists(oWB_BigBat) and sceneDelay>60 {sceneDelay=0; sceneProgress+=1}
        else if sceneProgress=2
        {
            event_user(0)
            for(i=0;i<3;i+=1)
            {
                delaySpawn(oPlayer1.x+160,oPlayer1.y-80+i*80,oCHAOS_AirGunner,0,1,1,0.33)
                delaySpawn(oPlayer1.x-160,oPlayer1.y-80+i*80,oCHAOS_AirGunner,0,1,1,0.33)
                delaySpawn(oPlayerIdle.x+160,oPlayerIdle.y-80+i*80,oCHAOS_AirGunner,0,1,1,0.33)
                delaySpawn(oPlayerIdle.x-160,oPlayerIdle.y-80+i*80,oCHAOS_AirGunner,0,1,1,0.33)
            }
            sceneCount=0; sceneDelay=0; sceneProgress+=1
        }
        else if sceneProgress=3
        {
            if sceneDelay>=120 and !instance_exists(oCHAOS_AirGunner)
            {
                sceneDelay=0; sceneProgress+=1
                event_user(0)
            }
            else if sceneDelay>50000 {sceneDelay=120}
        }
        else if sceneProgress=4
        {
            if sceneDelay=30
            {
                devli+=1
                delaySpawn(oPlayer1.x+80*sin(devli),oPlayer1.y+80*cos(devli),oFakeMetroid,0,1,1,0.33)
                sceneCount+=1
                sceneDelay=0
                if sceneCount mod 10=0 and sceneCount>0
                {
                    delaySpawn(oPlayer1.x-120,oPlayer1.y-120,oMetMetroid,0,1,1,0.33)
                    sceneDelay=-30
                    if sceneCount=20 {devli=0; sceneCount=0; sceneDelay=0; sceneProgress+=1}
                }
            }
        }*/
        else if sceneProgress=1 //Level 3 complete
        {
            if !instance_exists(oFakeMetroid) and !instance_exists(oMetMetroid)
            {
                if sceneDelay>=45 and global.gameOver=false
                {
                    if global.gameOptTowerDef=3 {global.gameOptTowerDef=4}
                    sceneDelay=0; explainMenu=2
                }
                else if sceneDelay>60 {sceneDelay=40}
            }
        }
    }
    else if TD_Difficulty=4 and false //------------------------------ Optional 2 ------------------------------ //spsp orig
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=12; swarmSpawn.myDir=1
        swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=2
        swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=12; swarmSpawn.myDir=-1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=2
          swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=84; swarmSpawn.spawnMax=14; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=20; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=72; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=14; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=14; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=160; swarmSpawn.spawnMax=3; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=160; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=58; swarmSpawn.spawnMax=26; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=58; swarmSpawn.spawnMax=26; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=120; swarmSpawn.spawnMax=22; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=120; swarmSpawn.spawnMax=22; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=25; swarmSpawn.spawnMax=65; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=25; swarmSpawn.spawnMax=65; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=20; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=76; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=210; swarmSpawn.spawnMax=4; swarmSpawn.myDir=1
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=210; swarmSpawn.spawnMax=4; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 4 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1*gDeltaTime
          if sceneDelay=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=4 {global.gameOptTowerDef=5}
            sceneDelay=0; explainMenu=2
          }
        }
      }
    }
    else if TD_Difficulty=4 and true //spsp ------------------------------ Optional 2 -------------------------
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      /*if sceneDelay mod 390=0
      {
        delaySpawn(384,624,oInjectorVirus,0,1,1,0.5)
      }
      if sceneProgress=0 //Wave 1
      {
        if sceneDelay>9999 {sceneDelay=0}
        event_user(0)
        swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
        swarmSpawn.enemyType=oGreenParatroopa; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=15
        swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
        swarmSpawn.enemyType=oGreenParatroopa; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=15
        sceneProgress+=1; sceneDelay=0
      }
      else if sceneProgress=1 //Wave 2
      {
        if sceneDelay>9999 {sceneDelay=0}
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(120,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oStealthBug; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=6
          swarmSpawn=instance_create(632,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oStealthBug; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=6
          sceneProgress+=1; sceneDelay=0
        }
      }*/
      if sceneProgress=0 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner)
        {
          if sceneDelay=5 {event_user(0); sceneDelay=0; sceneProgress+=1}
          /*if sceneDelay=60
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,80,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,80,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=75
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,160,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,160,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=90
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,240,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,240,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=105
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,320,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,320,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=120
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,400,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,400,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=135
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,480,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,480,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=150
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,560,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,560,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=165
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,640,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,640,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=180
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,720,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,720,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=195
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,800,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,800,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=210
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,880,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,880,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=225
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,960,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,960,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=240
          {
            for(i=0;i<5;i+=1)
            {
                delaySpawn(64+64*i,1024,oGoomba,0,1,1,0.33)
                delaySpawn(432+64*i,1024,oGoomba,0,1,1,0.33)
            }
          }
          else if sceneDelay=270
          {
            sceneDelay=0; sceneProgress+=1
          }*/
        }
      }
      else if sceneProgress=1 //Level 4 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oDUselessData)
        {
          with oTrapBase {instance_destroy()} //spsp ns
          if sceneDelay=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=4 {global.gameOptTowerDef=5}
            sceneDelay=0; explainMenu=2
          }
          else if sceneDelay>10 {sceneDelay=0}
        }
      }
    }
    else if TD_Difficulty=5 and false //------------------------------ Optional 3 ------------------------------ //spsp orig
    {
      if sceneProgress=0 //Wave 1
      {
        event_user(0)
        swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=55; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
        swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
        swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
        swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
        sceneProgress+=1
      }
      else if sceneProgress=1 //Wave 2
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=3
          swarmSpawn.spawnFreq=65; swarmSpawn.spawnMax=20; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=2 //Wave 3
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=65; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_SteamBomb; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=3 //Wave 4
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=70; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=4
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=4 //Wave 5
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=180; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_DozerTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=180; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=5 //Wave 6
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1664,176,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=24; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_GorillaTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=70; swarmSpawn.spawnMax=16; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=90; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=6 //Wave 7
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=45; swarmSpawn.spawnMax=32; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=80; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=7 //Wave 8
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_AdvanceTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=12; swarmSpawn.spawnMax=100; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=70; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=8 //Wave 9
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_CrabTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=25; swarmSpawn.spawnMax=50; swarmSpawn.myDir=-1
          swarmSpawn=instance_create(1792,112,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_Helicopter; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=60; swarmSpawn.spawnMax=20; swarmSpawn.myDir=180
          sceneProgress+=1
        }
      }
      else if sceneProgress=9 //Wave 10
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          event_user(0)
          swarmSpawn=instance_create(1904,352,oTD_EnemySpawner)
          swarmSpawn.enemyType=oTDE_BeastTank; swarmSpawn.enemyLevel=5
          swarmSpawn.spawnFreq=50; swarmSpawn.spawnMax=3; swarmSpawn.myDir=-1
          sceneProgress+=1
        }
      }
      else if sceneProgress=10 //Level 5 complete
      {
        if !instance_exists(oTD_EnemySpawner) and !instance_exists(oEnemyBase)
        {
          sceneDelay+=1*gDeltaTime
          if sceneDelay=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=5 {global.gameOptTowerDef=6}
            sceneDelay=0; explainMenu=2
          }
        }
      }
    }
    else if TD_Difficulty=5 and true //spsp ------------------------------ Optional 2 -------------------------
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame (the mod 6 check is on whole ticks, so it still hits once each)
      if sceneDelay mod 6=0 and oPlayer1.x>=544
      {
        delaySpawn(oPlayer1.x,oPlayer1.y-16,oDSSR,0,1,1,0.6)
        sceneDelay=1
      }
      if sceneProgress=0 and !instance_exists(oDUselessData)
      {
        sceneProgress=10; sceneDelay=0
      }
      else if sceneProgress=10 //Level 5 complete
      {
        if !instance_exists(oTD_EnemySpawner)
        {
          //sceneDelay+=1
          sceneDelay+=1*gDeltaTime //60fps change: per frame
          if sceneDelay>=5 and global.gameOver=false
          {
            if global.gameOptTowerDef=5 {global.gameOptTowerDef=6}
            sceneDelay=0; explainMenu=2
          }
        }
      }
    }
  }
}
else if explainMenu=2 //End during non-story battles or refights
{
  if global.gamePaused=false
  {
    sceneDelay+=1*gDeltaTime
    if sceneDelay=10
    {
      msgCreate(0,0,"Jeremy","Nice job there. I'll teleport you back to Central City.",0,2,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if sceneDelay>=80
    {
      global.activeAbility[0]=1
      global.activeAbility[1]=1
      global.newMapX=1200
      global.newMapY=288
      writeToPlayerGlobals()
      room_goto(rCCity_NorthA)
    }
  }
}
