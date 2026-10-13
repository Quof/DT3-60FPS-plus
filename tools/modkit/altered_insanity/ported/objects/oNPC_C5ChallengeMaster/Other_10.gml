if global.challengeRoom=1 //======================================== TRIAL 1 ======================================== (double speed)
    {
      if trialProg=0
      {
        
        if trialTime=1
        {
          var tempMplay;
          tempMplay=findMusic(2023)
          playMusic(tempMplay,0,1)
          room_speed = 60; //haha oh yes
          delaySpawn(80,304,oGoomba,0,1,1,0.33)
          delaySpawn(400,304,oGoomba,0,1,1,0.33)
          instance_create(0,0,oPathManager)
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
          if path=1
          {
          delaySpawn(160,64,oCHAOS_Sabotage,0,1,1,0.33)
          //delaySpawn(304,64,oCHAOS_Sabotage,0,1,1,0.33)
          delaySpawn(400,304,oCHAOS_Sniper,0,1,1,0.33)
          delaySpawn(80,304,oCHAOS_ShockUnit,0,1,1,0.33)
          }
          else
          {
            delaySpawn(400,304,oDragonKnight,0,1,1,0.33)
            delaySpawn(80,304,oBloodTyrant,0,1,1,0.33)
          }
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase)
          {
            {trialTime=0; trialProg+=1}
          }
        }
      }
      else if trialProg=2
      {
          if trialTime = 1
          {
            if path=1
            {
                delaySpawn(432,80,oCHAOS_Rocketeer,0,1,1,0.33)
                delaySpawn(64,80,oCHAOS_Rocketeer,0,1,1,0.33)
            }
            else
            {
                delaySpawn(200,304,oMalignantOoze,0,1,1,0.33)
            }
          }
          else if trialTime>=120
            {
              if !instance_exists(oEnemyBase)
              {
                if path = 1
                {
                    trialTime=0; trialProg=0; trailStarted=3
                    room_speed = 30; //haha oh no
                }
                else
                {
                    trialTime=0; trialProg+=1
                }
              }
            }
      }
      else if trialProg=3
      {
          if trialTime = 1
          {
                delaySpawn(432,80,oCHAOS_Rocketeer,0,1,1,0.33)
                delaySpawn(64,80,oCHAOS_Rocketeer,0,1,1,0.33)
                delaySpawn(200,80, oCHAOS_Healer,0,1,1,0.33)
          }
          else if trialTime>=120
            {
              if !instance_exists(oEnemyBase)
              {
                    trialTime=0; trialProg=0; trailStarted=3
                    room_speed = 30; //haha oh no
              }
            }
      }
    }
    else if global.challengeRoom=2 //======================================== TRIAL 2 ======================================== (floor is lava)
    {
      if trialProg=0
      {
        if trialTime = 1
        {
        var tempMplay;
          tempMplay=findMusic(2021)
          
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
         //delaySpawn(48,304,oVolcanoLotus,0,1,1,0.33)
          //delaySpawn(112,304,oVolcanoLotus,0,1,1,0.33)
          //delaySpawn(176,304,oVolcanoLotus,0,1,1,0.33)
          //delaySpawn(304,304,oVolcanoLotus,0,1,1,0.33)
          //delaySpawn(368,304,oVolcanoLotus,0,1,1,0.33)
          //delaySpawn(432,304,oVolcanoLotus,0,1,1,0.33)
          //delaySpawn(80,272,oVolcanoLotus,0,1,1,0.33)
          delaySpawn(144,240,oCV_BonePillar,0,1,1,0.33)
          //delaySpawn(208,272,oVolcanoLotus,0,1,1,0.33)
          //delaySpawn(272,272,oVolcanoLotus,0,1,1,0.33)
          delaySpawn(336,240,oCV_BonePillar,0,1,1,0.33)
          //delaySpawn(400,272,oVolcanoLotus,0,1,1,0.33)
          
          //delaySpawn(48,144,oBombDropper,0,1,1,0.33)
          delaySpawn(112,112,oBombDropper,0,1,1,0.33)
          delaySpawn(176,144,oBombDropper,0,1,1,0.33)
          delaySpawn(304,144,oBombDropper,0,1,1,0.33)
          delaySpawn(368,112,oBombDropper,0,1,1,0.33)
          instance_create(0,0,oPathManager)
          //delaySpawn(432,144,oBombDropper,0,1,1,0.33)
          
          //delaySpawn(48,240,oMegmet,0,1,1,0.33)
          //delaySpawn(48,256,oMegmet,0,1,1,0.33)
          //delaySpawn(48,272,oMegmet,0,1,1,0.33)
          //delaySpawn(48,288,oMegmet,0,1,1,0.33)
          //delaySpawn(48,304,oMegmet,0,1,1,0.33)
          
          //delaySpawn(432,240,oMegmet,0,1,1,0.33)
          //delaySpawn(432,256,oMegmet,0,1,1,0.33)
          //delaySpawn(432,272,oMegmet,0,1,1,0.33)
          //delaySpawn(432,288,oMegmet,0,1,1,0.33)
          //delaySpawn(432,304,oMegmet,0,1,1,0.33)
        }
        else if trialTime=40
        {
          with oScaledTrapZone
          {
            y=y-10
          }
        }
        else if trialTime>=180
        {
            //latch crystals count as enemy, so 6 will remain
          if instance_number(oEnemyBase) = 6 {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=1
      {
         if trialTime = 1
            {
            
             delaySpawn(80,272,oSparky,0,1,1,0.33)
              //delaySpawn(144,240,oSparky,0,1,1,0.33)
              //delaySpawn(336,240,oSparky,0,1,1,0.33)
              delaySpawn(400,272,oSparky,0,1,1,0.33)
              
              delaySpawn(400,112,oLaserBall,0,1,1,0.33)
              delaySpawn(432,144,oLaserBall,0,1,1,0.33)
              delaySpawn(400,176,oLaserBall,0,1,1,0.33)
              delaySpawn(80,176,oLaserBall,0,1,1,0.33)
              delaySpawn(48,144,oLaserBall,0,1,1,0.33)
              delaySpawn(80,112,oLaserBall,0,1,1,0.33)
              if path=2
              {
              delaySpawn(128,144,oMetalGuardian,0,1,1,0.33)
              delaySpawn(368,144,oMetalGuardian,0,1,1,0.33)
              }
            }

            else if trialTime>=180
            {
                //latch crystals count as enemy, so 6 will remain
                if instance_number(oEnemyBase) = 6 
                {
                    trialTime=0; trialProg+=1
                }
            }
          }
      else if trialProg=2
      {
        if trialTime=1
        {
          delaySpawn(160,64,oCHAOS_Sabotage,0,1,1,0.33)
         delaySpawn(304,64,oCHAOS_Sabotage,0,1,1,0.33)
         if path=2
         {
             delaySpawn(240,112,oCHAOS_AirGunner,0,1,1,0.33)
             delaySpawn(240,176,oCHAOS_AirGunner,0,1,1,0.33)
         }
         //delaySpawn(240,80,oCHAOS_Sabotage,0,1,1,0.33)  
        }
        else if trialTime>=120
        {
            //latch crystals count as enemy, so 2 will remain
          if instance_number(oEnemyBase) = 6
          {
            with oScaledTrapZone {instance_destroy()}
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=3 //======================================== TRIAL 3 ======================================== (time limit)
    {
    if trialProg=0
      {
        if trialTime=1
        {
          var tempMplay;
          tempMplay=findMusic(2022)
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
          instance_create(0,0,oDeathClock)
          delaySpawn(96,304,oCHAOS_Tank,0,1,1,0.33)
          delaySpawn(384,304,oCHAOS_Tank,0,1,1,0.33)
          instance_create(0,0,oPathManager)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      if trialProg=1
      {
        if trialTime=1
        {
          delaySpawn(240,144,oCHAOS_Rocketeer,0,1,1,0.33)
          delaySpawn(224,192,oCHAOS_Healer,0,1,1,0.33)
          delaySpawn(256,192,oCHAOS_Healer,0,1,1,0.33)
           //instance_create(0,0,oPathManager)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) {
          trialTime=0; 
          if path = 1
            trialProg+=2
          else if path = 2
            trialProg+=1
          }
        }
      }
      if trialProg=2
      {
        if trialTime=1
        {
          delaySpawn(96,304,oBloodTyrant,0,1,1,0.33)
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
        }
      }
      if trialProg=3
      {
        if path=2
        {
            if trialTime=1
            {
                newEnemy=instance_create(200,100,oWaspBot) newEnemy.bActive=1; newEnemy.yDist=100
            }
            else if trialTime>=75
            {
              if !instance_exists(oEnemyBase) {trialTime=0; trialProg+=1}
            }
        }
        else
        {
            trialProg+=1
        }
      }
      if trialProg=4
      {
        if trialTime=1
        {
          if path=1
          {
            delaySpawn(80,304,oMalignantOoze,0,1,1,0.33)
          }
          delaySpawn(400,304,oMalignantOoze,0,1,1,0.33)
          if path=2
          {
            enemyBarrier=instance_create(0,0,oEnemyBarrier); enemyBarrier.image_yscale=18
            enemyBarrier=instance_create(464,0,oEnemyBarrier); enemyBarrier.image_yscale=18
          }
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase) 
          {

                trialTime=0; trialProg=0; trailStarted=3
                with oDeathClock
                {
                    instance_destroy()
                }
           
          }
        }
      }
    }
    else if global.challengeRoom=4 //======================================== TRIAL 4 ======================================== (achilles)
    {
      if trialProg=0
      {
        if trialTime = 1
        {
            instance_create(0,0,oPathManager)
        }
        else if trialTime=33
        {
        var tempMplay;
          tempMplay=findMusic(2017)
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
          global.bOneHitKillMode = true

          delaySpawn(416,304,oMegmet,0,1,1,0.33)
          delaySpawn(96,304,oMegmet,0,1,1,0.33)
          delaySpawn(416,160,oMagicalBee,0,1,1,0.33)
          delaySpawn(64,288,oMagicalBee,0,1,1,0.33)
          delaySpawn(240,160,oBombDropper,0,1,1,0.33)
          delaySpawn(64,160,oBombDropper,0,1,1,0.33)
            with oZeldaFloorSolid
            {
                atkTime = 0
                if other.path = 1
                {
                    atkDelay = (id-481007) * 20
                }
                else
                {
                    atkDelay = (id-481007) * 10
                }
                invincible=1
            }
        }
        else if trialTime>=220
        {
          if instance_number(oEnemyBase) - instance_number(oZeldaFloorTileInvincible) = 0 {trialTime=0; trialProg+=1}
        }
      }
      if trialProg=1
      {
        if trialTime=1
        {
          delaySpawn(96,192,oCV_SalemWitch,0,1,1,0.33)
          delaySpawn(368,192,oCV_SalemWitch,0,1,1,0.33)            
        }
        else if trialTime>=120
        {
            if instance_number(oEnemyBase) - instance_number(oZeldaFloorTileInvincible) = 0 {trialTime=0; trialProg+=1}
        }
      }
      if trialProg = 2
      {
        if trialTime = 1
        {
            delaySpawn(64,304,oCV_BonePillar,0,1,1,0.33) 
            delaySpawn(416,304,oCV_BonePillar,0,1,1,0.33) 
            delaySpawn(64,304,oCV_InvisibleMan,0,1,1,0.33) 
            delaySpawn(416,304,oCV_InvisibleMan,0,1,1,0.33) 
            delaySpawn(336,112,oCV_PhantomSkull,0,1,1,0.33) 
            delaySpawn(288,96,oCV_PhantomSkull,0,1,1,0.33) 
            delaySpawn(240,80,oCV_PhantomSkull,0,1,1,0.33) 
            delaySpawn(192,96,oCV_PhantomSkull,0,1,1,0.33) 
            delaySpawn(144,112,oCV_PhantomSkull,0,1,1,0.33) 
        }
        else if trialTime >= 120
        {
            if instance_number(oEnemyBase) - instance_number(oZeldaFloorTileInvincible) = 0
            {
                trialTime=0; trialProg=0; trailStarted=3
                ini_open(global.paraString[0])
                var sectionRead,tempVar;
                sectionRead="ALPHA"
                global.bOneHitKillMode=ini_read_real(sectionRead,"137c",0)
                with oZeldaFloorSolid
                {
                    instance_destroy()
                }
            }
        }
      }
    }
