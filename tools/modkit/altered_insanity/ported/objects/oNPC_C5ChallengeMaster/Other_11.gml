if global.challengeRoom=5 //======================================== TRIAL 5 ======================================== (no jump)
    {
      if trialProg=0
      {
        if trialTime=1
        {
        instance_create(0,0,oPathManager)
        }
        if trialTime=33
        {
          var tempMplay;
          tempMplay=findMusic(2018)
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
          global.hasShoes[1]=1
          global.canDoubleJump=1
          if (path=2)
          {
            delaySpawn(114,304,oCHAOS_ShockUnit,0,1,1,0.33); 
            delaySpawn(368,304,oCHAOS_ShockUnit,0,1,1,0.33); 
          }
          delaySpawn(448,296,oAtareeter,0,1,1,0.33)
          delaySpawn(32,296,oAtareeter,0,1,1,0.33)
          delaySpawn(48,304,oHammaHammaMain,0,1,1,0.33)
          delaySpawn(432,304,oHammaHammaMain,0,1,1,0.33)
          
        }
        else if trialTime>=190
        {
          if !instance_exists(oEnemyBase)
          {
            trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=1
      {
        if trialTime=1
        {
            delaySpawn(432,304,oStealthBug,0,1,1,0.33)
            delaySpawn(48,304,oStealthBug,0,1,1,0.33)
            delaySpawn(160,304,oShieldMenace,0,1,1,0.33)
            delaySpawn(320,304,oDesertTitan,0,1,1,0.33)
              if path=2
              {
                delaySpawn(240,208,oSpinGuard,0,1,1,0.33)
              }
        }
        else if trialTime>=120
        {
          if !instance_exists(oEnemyBase)
          {
            trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=2
      {
        if trialTime=1
        {
          msgCreate(80,120,"A Helpful Whisper","Remember you can't dash through Metroid enemies",0,1,oMessagePerson,0)
          newMessage.fadingTime = 60
          delaySpawn(80,304,oMetSidehopper,0,1,1,0.33)
          delaySpawn(400,304,oMetSidehopper,0,1,1,0.33)
          
          delaySpawn(80,80,oMetReo,0,1,1,0.33)
          delaySpawn(400,80,oMetReo,0,1,1,0.33)
          
          delaySpawn(48,304,oMetCacatac,0,1,1,0.33)
          delaySpawn(432,304,oMetCacatac,0,1,1,0.33)
          
          if path=2
          {
            delaySpawn(152,232,oMetMultiviola,0,1,1,0.33)
            delaySpawn(344,200,oMetMultiviola,0,1,1,0.33)
          }
        }
        if trialTime>=180
        {
          if !instance_exists(oEnemyBase)
          {
          trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg = 3
      {
        if path=2
        {
            if trialTime=1
            {
                    msgCreate(80,120,"A Hurtful Whisper","You're on Bonkers mode, time for bad times.",0,1,oMessagePerson,0)
                    newMessage.fadingTime = 60
                    delaySpawn(120,144,oCHAOS_Rocketeer,0,1,1,0.33)
                    delaySpawn(360,144,oCHAOS_Rocketeer,0,1,1,0.33)
                    delaySpawn(64,144,oCHAOS_Sabotage,0,1,1,0.33)
                    delaySpawn(416,144,oCHAOS_Sabotage,0,1,1,0.33)
            }
        }
        else
        {
            trialTime = 181
        }
        if trialTime>=180
        {
          if !instance_exists(oEnemyBase)
          {
            global.hasShoes[1]=2
            global.canDoubleJump=2
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=6 //======================================== TRIAL 6 ======================================== (no dash)
    {
      if trialProg=0
      {
        if trialTime=1
        {
            instance_create(0,0,oPathManager)
        }
        if trialTime=32
        {
        var tempMplay;
          tempMplay=findMusic(2020)
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
          global.hasShoes[2]=1
          global.hasShoes[3]=1
          delaySpawn(96,304,oZakoSoldier,0,1,1,0.33)
          delaySpawn(384,304,oZakoSoldier,0,1,1,0.33)
          delaySpawn(64,192,oCHAOS_AirGunner,0,1,1,0.33)
          delaySpawn(416,192,oCHAOS_AirGunner,0,1,1,0.33)
          if path=2
          {
            plane = instance_create(0,0,oPlaneSpawner)
            plane.spawnDelay=90
          }
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
        else if trialTime=670
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
          if instance_number(oEnemyBase) = instance_number(oB2SpiritPlane)
          {
            trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=2
      {
        if global.trialGag = 1
        {
            if trialTime = 1
            {
                msgCreate(80,40,"Jerry","Didn't that challenge seem familiar?",0,3,oMessagePerson,0)
                newMessage.fadingTime=45
            }
            if trialTime = 50
            {
                if path=1
                {
                    msgCreate(80,40,"Claire","Yeah, I vaguely remember a challenge like this with CHAOS troop spam.",0,3,oMessagePerson,0)
                }
                else
                {
                    msgCreate(80,40,"Claire","Sort of, but I don't remember those annoying ass stealth bombers, Screw those guys!",0,3,oMessagePerson,0)
                }
                newMessage.fadingTime=60
            }
            if trialTime = 120
            {
                if path=1
                {
                    msgCreate(80,40,"Jerry","That seems pretty lazy, reusing a challenge layout, even without our dash, it wasn't too bad.",0,3,oMessagePerson,0)
                }
                else
                {
                    msgCreate(80,40,"Jerry","Yeah, those things suck, but I bet it's literally just one spawner object. Still pretty lazy tbh.",0,3,oMessagePerson,0)
                }
                newMessage.fadingTime=60
                newMessage.signSize = 3
            }
            if trialTime = 190
            {
                msgCreate(80,40,"Claire","Jerry... Why?",0,1,oMessagePerson,0)
                newMessage.fadingTime=40
            }
            if trialTime = 240
            {
                msgCreate(80,40,"Jerry","What? I mean we've just been talking, we obviously won...",0,3,oMessagePerson,0)
                newMessage.fadingTime=60
            }
            if trialTime = 295
            {
                msgCreate(80,40,"Challenge Master","FOOLISH MORTALS! YOU DARE QUESTION MY CHALLENGE? I'LL GIVE YOU SOMETHING UNIQUE!",0,3,oMessagePerson,0)
                newMessage.fadingTime=60
                newMessage.signSize=3
            }
            if trialTime = 355
            {
                global.trialGag = 0
                trialTime=0; trialProg+=1
            }
        }
        else
        {
            if trialTime = 1
            {
                msgCreate(80,40,"Jerry","Didn't that challenge seem familiar?",0,3,oMessagePerson,0)
                newMessage.fadingTime=45
            }
            if trialTime = 25
            {
                msgCreate(80,40,"Jeremy","Doesn't this conversation seem familiar? SKIP.",0,3,oMessagePerson,0)
                newMessage.fadingTime=60
                trialTime=0; trialProg+=1
            }
        }
      }
      else if trialProg=3
      {
        if trialTime = 1
        {
            delaySpawn(144,304,oFacSentry,0,1,1,0.33)
            delaySpawn(352,304,oFacSentry,0,1,1,0.33)
            delaySpawn(240,176,oFacCleaner,0,1,1,0.33)
            delaySpawn(400,144,oFacDrone,0,1,1,0.33)
            delaySpawn(80,144,oFacDrone,0,1,1,0.33)
        }
        if trialTime = 60
        {
            delaySpawn(240,176,oInjectorVirus,0,1,1,0.33)
        }
        if trialTime = 120
        {
            delaySpawn(240,176,oInjectorVirus,0,1,1,0.33)
        }
        if trialTime = 180
        {
            delaySpawn(240,176,oInjectorVirus,0,1,1,0.33)
        }
        if trialTime = 240
        {
            delaySpawn(240,176,oInjectorVirus,0,1,1,0.33)
        }
        if trialTime = 300
        {
            delaySpawn(240,176,oInjectorVirus,0,1,1,0.33)
        }
        if trialTime = 510
        {
            delaySpawn(240,176,oBloodVirus,0,1,1,0.33)
        }
        else if trialTime > 630 //end
        {
            if instance_number(oEnemyBase) = instance_number(oB2SpiritPlane)
            {
                with (oPlaneSpawner)
                {
                    instance_destroy()
                }
                trialTime=0; trialProg=0; trailStarted=3
                global.hasShoes[2]=2
                global.hasShoes[3]=2
            }
        }
      }
    }
    else if global.challengeRoom=7 //======================================== TRIAL 7 ======================================== (onslaught)
    {
      if trialProg=0 
      {
          if trialTime = 1
          {
            instance_create(0,0,oPathManager)
          }
              var tempMplay;
          tempMplay=findMusic(2019)
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
          //goomba set
          if trialTime = 30
          {
              delaySpawn(96,128,oGoomba,0,1,1,0.33)
          }
          if trialTime = 40
          {
              delaySpawn(384,128,oGoomba,0,1,1,0.33)
          }
          if trialTime = 50
          {
              delaySpawn(240,160,oGoomba,0,1,1,0.33)
          }
          if trialTime = 60
          {
              delaySpawn(192,224,oGoomba,0,1,1,0.33)
          }
          if trialTime = 70
          {
              delaySpawn(288,224,oGoomba,0,1,1,0.33)
          }
          if trialTime = 80
          {
              delaySpawn(96,256,oGoomba,0,1,1,0.33)
          }
          if trialTime = 90
          {
              delaySpawn(384,256,oGoomba,0,1,1,0.33)
          }
          //spawn pixels on bonkers only
          if trialTime = 100 and path=2
          {
              delaySpawn(48,80,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(64,80,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(80,80,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(80,96,oBlownUpPixel,0,1,1,0.33)
              
              delaySpawn(64,208,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(48,224,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(64,224,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(80,224,oBlownUpPixel,0,1,1,0.33)
              
              delaySpawn(400,64,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(400,80,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(384,80,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(384,96,oBlownUpPixel,0,1,1,0.33)
              
              delaySpawn(416,224,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(416,240,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(416,256,oBlownUpPixel,0,1,1,0.33)
              delaySpawn(416,272,oBlownUpPixel,0,1,1,0.33)
          }
          //koopa set
          if trialTime = 130
          {
              delaySpawn(96,128,oGreenParatroopa,0,1,1,0.33)
          }
          if trialTime = 140
          {
              delaySpawn(384,128,oRedParatroopa,0,1,1,0.33)
          }
          if trialTime = 150
          {
              delaySpawn(240,160,oGreenParatroopa,0,1,1,0.33)
          }
          if trialTime = 160
          {
              delaySpawn(192,224,oRedParatroopa,0,1,1,0.33)
          }
          if trialTime = 170
          {
              delaySpawn(288,224,oGreenParatroopa,0,1,1,0.33)
          }
          if trialTime = 180
          {
              delaySpawn(96,256,oRedParatroopa,0,1,1,0.33)
          }
          if trialTime = 190
          {
              delaySpawn(384,256,oGreenParatroopa,0,1,1,0.33)
          }
          
          //bros and lotuses
          if trialTime = 230
          {
              delaySpawn(96,128,oVolcanoLotus,0,1,1,0.33)
          }
          if trialTime = 240
          {
              delaySpawn(384,128,oVolcanoLotus,0,1,1,0.33)
          }
          if trialTime = 250
          {
              delaySpawn(240,160,oBoomerBro,0,1,1,0.33)
          }
          if trialTime = 260
          {
              delaySpawn(192,224,oFireBro,0,1,1,0.33)
          }
          if trialTime = 270
          {
              delaySpawn(288,224,oFireBro,0,1,1,0.33)
          }
          if trialTime = 280
          {
              delaySpawn(96,256,oHammerBro,0,1,1,0.33)
          }
          if trialTime = 290
          {
              delaySpawn(384,256,oHammerBro,0,1,1,0.33)
          }
          //spawn fake metroids on bonkers mode only
          if trialTime = 300 and path=2
          {
            delaySpawn(96,160,oFakeMetroid,0,1,1,0.33)
            delaySpawn(96,192,oFakeMetroid,0,1,1,0.33)
            delaySpawn(96,224,oFakeMetroid,0,1,1,0.33)
            delaySpawn(240,224,oFakeMetroid,0,1,1,0.33)
            delaySpawn(240,192,oFakeMetroid,0,1,1,0.33)
            delaySpawn(384,160,oFakeMetroid,0,1,1,0.33)
            delaySpawn(384,192,oFakeMetroid,0,1,1,0.33)
            delaySpawn(384,224,oFakeMetroid,0,1,1,0.33)
          }
          //zelda set
          if trialTime = 330
          {
              delaySpawn(96,128,oMegmet,0,1,1,0.33)
          }
          if trialTime = 340
          {
              delaySpawn(384,128,oMegmet,0,1,1,0.33)
          }
          if trialTime = 350
          {
              delaySpawn(240,160,oMegmet,0,1,1,0.33)
          }
          if trialTime = 360
          {
              delaySpawn(192,224,oOctorok,0,1,1,0.33)
          }
          if trialTime = 370
          {
              delaySpawn(288,224,oOctorok,0,1,1,0.33)
          }
          if trialTime = 380
          {
              delaySpawn(96,256,oOctorok,0,1,1,0.33)
          }
          if trialTime = 390
          {
              delaySpawn(384,256,oOctorok,0,1,1,0.33)
          }
          
          if trialTime = 400 and path=2
          {
            delaySpawn(96,256,oTektile,0,1,1,0.33)
            delaySpawn(240,160,oTektile,0,1,1,0.33)
            delaySpawn(384,256,oTektile,0,1,1,0.33)
          }
          //bee interlude
          if trialTime = 450
          {
              delaySpawn(240,112,oMagicalBee,0,1,1,0.33)
              delaySpawn(272,144,oMagicalBee,0,1,1,0.33)
              delaySpawn(288,176,oMagicalBee,0,1,1,0.33)
              delaySpawn(272,208,oMagicalBee,0,1,1,0.33)
              delaySpawn(240,224,oMagicalBee,0,1,1,0.33)
              delaySpawn(208,208,oMagicalBee,0,1,1,0.33)
              delaySpawn(192,176,oMagicalBee,0,1,1,0.33)
              delaySpawn(208,144,oMagicalBee,0,1,1,0.33)
              delaySpawn(240,176,oSpinGuard,0,1,1,0.33)
          }
          
          if trialTime = 535
          {
              delaySpawn(240,112,oCV_Ghost,0,1,1,0.33)
              delaySpawn(272,144,oCV_Ghost,0,1,1,0.33)
              delaySpawn(288,176,oCV_Ghost,0,1,1,0.33)
              delaySpawn(272,208,oCV_Ghost,0,1,1,0.33)
              delaySpawn(240,224,oCV_Ghost,0,1,1,0.33)
              delaySpawn(208,208,oCV_Ghost,0,1,1,0.33)
              delaySpawn(192,176,oCV_Ghost,0,1,1,0.33)
              delaySpawn(208,144,oCV_Ghost,0,1,1,0.33)
              delaySpawn(240,176,oCV_PeepingEye,0,1,1,0.33)
          }
          
          if trialTime = 630
          {
              delaySpawn(96,128,oCV_BoneSkeleton,0,1,1,0.33)
          }
          if trialTime = 640
          {
              delaySpawn(384,128,oCV_BoneSkeleton,0,1,1,0.33)
          }
          if trialTime = 650
          {
              delaySpawn(240,160,oCV_BoneSkeleton,0,1,1,0.33)
          }
          if trialTime = 660
          {
              delaySpawn(192,224,oCV_BoneSkeleton,0,1,1,0.33)
          }
          if trialTime = 670
          {
              delaySpawn(288,224,oCV_BoneSkeleton,0,1,1,0.33)
          }
          if trialTime = 680
          {
              delaySpawn(96,256,oCV_BoneSkeleton,0,1,1,0.33)
          }
          if trialTime = 690
          {
              delaySpawn(384,256,oCV_BoneSkeleton,0,1,1,0.33)
          }
          
          if trialTime = 700 and path=2
          {
            delaySpawn(384,193,oCV_SalemWitch,0,1,1,0.33)
            delaySpawn(96,192,oCV_SalemWitch,0,1,1,0.33)
          }
          if trialTime=800
          {
              delaySpawn(240,112,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=830
          {
              delaySpawn(272,144,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=860
          {
              delaySpawn(288,176,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=890
          {
              delaySpawn(272,208,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=920
          {
              delaySpawn(240,224,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=950
          {
              delaySpawn(208,208,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=980
          {
              delaySpawn(192,176,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=1010
          {
              delaySpawn(208,144,oInjectorVirus,0,1,1,0.33)
          }
          if trialTime=1130
          {
              delaySpawn(240,176,oBloodVirus,0,1,1,0.33)
          }
          if trialTime=1270
          {
              delaySpawn(240,112,oInjectorVirus,0,1,1,0.33)
              delaySpawn(272,144,oInjectorVirus,0,1,1,0.33)
              delaySpawn(288,176,oInjectorVirus,0,1,1,0.33)
              delaySpawn(272,208,oInjectorVirus,0,1,1,0.33)
              delaySpawn(240,224,oInjectorVirus,0,1,1,0.33)
              delaySpawn(208,208,oInjectorVirus,0,1,1,0.33)
              delaySpawn(192,176,oInjectorVirus,0,1,1,0.33)
              delaySpawn(208,144,oInjectorVirus,0,1,1,0.33)
              delaySpawn(240,176,oBloodVirus,0,1,1,0.33)
          }
          if trialTime >= 1400
          {
            if !instance_exists(oEnemyBase)
            {
                trialTime=0; trialProg=0; trailStarted=3
            }
          }
        }
    }
    if global.challengeRoom=8 //======================================== TRIAL 8 ======================================== (pacifist)
    {
      if trialProg=0
      {
            if trialTime=1
            {
            global.canPause=0
            instance_create(0,0,oPathManager)
              var tempMplay;
              tempMplay=findMusic(2100)
              playMusic(tempMplay,0,1)
              if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
              abilSetRemove(1)
              global.hasShoes[0]=2;
              global.hasShoes[1]=2;
              global.hasShoes[2]=2;
              global.hasShoes[3]=2;
              global.canDoubleJump=2
              delaySpawn(416,128,oLaserBall,0,1,1,0.33)
              delaySpawn(64,144,oLaserBall,0,1,1,0.33)

            }
            else if trialTime = 180
            {
              delaySpawn(162,200,oSkullBall,0,1,1,0.33)
              delaySpawn(344,184,oSkullBall,0,1,1,0.33)
            }
            else if trialTime = 360
            {
              delaySpawn(232,160,oArmoredBug,0,1,1,0.33)
            }
            else if trialTime=400 and path = 2
            {
                delaySpawn(232,160,oArmoredBug,0,1,1,0.33)
            }
            else if trialTime = 540
            {
              delaySpawn(368,96,oVolcanoLotus,0,1,1,0.33)
              delaySpawn(112,96,oVolcanoLotus,0,1,1,0.33)
            }
            else if trialTime = 720
            {
              delaySpawn(128,304,oMagicalLeaf,0,1,1,0.33)
              delaySpawn(352,304,oMagicalLeaf,0,1,1,0.33)
            }
            else if trialTime = 900
            {
              delaySpawn(240,304,oTektile,0,1,1,0.33)
            }
            else if trialTime = 1080
            {
              if path=1
              {
              delaySpawn(240,64,oInjectorVirus,0,1,1,0.33)
              }
              else
              {
              delaySpawn(240,64,oBloodVirus,0,1,1,0.33)
              }
            }
            else if trialTime = 1260
            {
              delaySpawn(96,208,oCV_SalemWitch,0,1,1,0.33)
            }
            else if trialTime = 1440
            {
              delaySpawn(416,304,oCHAOS_Robear,0,1,1,0.33)
            }
        
        if trialTime = 1680
        {
          with oEnemyBase
          {
            instance_destroy()
          }
          with oEProjectileBase
          {
            instance_destroy()
          }
          with oSalemWitchFire
          {
            instance_destroy()
          }
          msgCreate(80,120,"Jeremy","Watch out guys! Something big is coming, get ready!",0,3,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if trialTime=1740
        {
            delaySpawn(240,112,oUnbeatableBird,0,1,1,0.33)
        }
        else if trialTime=1815
        {
            with oEnemyBase
            {
                instance_destroy()
            }
            with oEProjectileBase
            {
                instance_destroy()
            }
        }
        else if trialTime = 1830
        {
          msgCreate(80,120,"Jerry","...",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
          msgCreate(80,160,"Claire","...",0,1,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if trialTime = 1900
        {
          msgCreate(80,120,"Jeremy","Don't look at me, something big definitely came. Didn't know it'd go away soon after. Good thing though, you were looking rough there.",0,3,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if trialTime = 1970
        {
          if global.activeCharacter=0 //jerry
          {
            msgCreate(80,160,"Jerry","I ain't scared of any birds, they're scared of me!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
          else
          {
            msgCreate(80,160,"Claire","He wouldn't have actually hurt me, birds like me.",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
        }
        else if trialTime = 2040
        {
        if global.activeCharacter=0 //jerry
          {
            msgCreate(80,160,"Jeremy","Yeah, I guess you scared him off, did you see that wicked pattern he was gonna do though? You would've been toast!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
          else
          {
            msgCreate(80,160,"Jeremy","I guess so, good thing too, I was picking up insane amounts of power on that bird. Hope we never run into him for real.",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
        }
        else if trialTime = 2110
        {
          if global.activeCharacter=0 //jerry
           {
            msgCreate(80,160,"Jerry","Anyway, the music stopped, did we win???",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
          else
          {
            msgCreate(80,160,"Claire","Yeah... Anyway, did I win yet?",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
        }
        else if trialTime = 2180
        {
            abilSetRemove(1)
            abilSetRemove(0)
            trialTime=0; trialProg=0; trailStarted=3
        }
      }
    }
