if global.challengeRoom=9 //======================================== TRIAL 9 ======================================== (floor is lava no dash)
    {
        
    if trialProg=0
      {
        if trialTime = 1
        {
        var tempMplay;
          tempMplay=findMusic(2209)
          global.hasShoes[2]=1
          global.hasShoes[3]=1
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
        
          delaySpawn(240,304,oCHAOS_Robear,0,1,1,0.33)
          delaySpawn(64,48,oArmoredBug,0,1,1,0.33)
          delaySpawn(416,48,oArmoredBug,0,1,1,0.33)
          
          instance_create(0,0,oPathManager)
         
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
          if instance_number(oEnemyBase) = instance_number(oMagicalBat) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=1
        {
                if trialTime = 1
                {  
                  delaySpawn(240,288,oGlitchyPixels,0,1,1,0.33)
                  delaySpawn(240,32,oGlitchyPixels,0,1,1,0.33)
                  if path = 1
                  {
                      delaySpawn(432,160,oGlitchyPixels,0,1,1,0.33)
                      delaySpawn(48,160,oGlitchyPixels,0,1,1,0.33)
                  }
                }
                else if trialTime>=141
                {
                    if instance_number(oEnemyBase) = instance_number(oMagicalBat)
                    {
                        trialTime=0; trialProg+=1
                    }
                }
            }
      else if trialProg=2
      {
        if path=2
        {
            if trialTime=1
            {
              delaySpawn(240,304,oCHAOS_SpiderDrone,0,1,1,0.33)
              delaySpawn(48,32,oBloodVirus,0,1,1,0.33)
              delaySpawn(432,32,oBloodVirus,0,1,1,0.33)
            }
            else if trialTime>=120
            {
              if instance_number(oEnemyBase) = instance_number(oMagicalBat)
              {
                trialTime=0; trialProg+=1
              }
            }
        }
        else
        {
            trialTime=0; trialProg+=1
        }
      }
      else if trialProg=3
      {
        if trialTime=1
        {
            msgCreate(80,280,"Jeremy","Woah, get to the left quick! Something big is coming!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
        }
        if trialTime=30
        {
          delaySpawn(400,160,oFortressSkyguard,0,1,1,0.33)
         
        }
        else if trialTime>=120
        {
          if instance_number(oEnemyBase) = instance_number(oMagicalBat)
          {
            with oScaledTrapZone {instance_destroy()}
            global.hasShoes[2]=2
                global.hasShoes[3]=2
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=10 //======================================== TRIAL 10 ======================================== (BEST DAMN FRANCHISE)
    {
        //immediately die if a mario enemy dies
        if instance_number(oEMarioBase) + instance_number(oSpinyBeetle) < marioFriends
        {
            tGOMess=instance_create(0,0,oSituationalGO_Message)
            if trialProg!=3
            {
                tGOMess.type=3
            }
            else
            {
                if trialTime < 220 and instance_number(oWingedMelon) mod 2 = 1
                {
                    tGOMess.type=4
                }
                else if trialTime > 335 and instance_number(oStarman) = 0
                {
                    tGOMess.type=5
                }
                else
                {
                    tGOMess.type=3
                }
            }
            marioDeath=true
            oPlayer1.life-=oPlayer1.maxLife
        }
    if trialProg=0
      {
        if trialTime = 1
        {
        var tempMplay;
          tempMplay=findMusic(2210)
          playMusic(tempMplay,0,1)
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
        delaySpawn(128,304,oGoomba ,0,1,1,0.33)
          delaySpawn(352,304,oGoomba ,0,1,1,0.33)
          
          
          instance_create(0,0,oPathManager)
         
        }
        else if trialTime = 50
        {
          if path=1
          {
              delaySpawn(128,304,oBloodTyrant,0,1,1,0.33)
              delaySpawn(352,304,oBloodTyrant,0,1,1,0.33)
          }
          else
          {
            delaySpawn(240,304,oMalignantOoze,0,1,1,0.33)
          }
          marioFriends+=2
        }
        else if trialTime>=180
        {
          if instance_number(oEnemyBase) = instance_number(oEMarioBase) {trialTime=0; trialProg+=1}
        }
      }
      else if trialProg=1
        {

            if trialTime = 1
            {  
              delaySpawn(144,304,oGreenParatroopa  ,0,1,1,0.33)
              delaySpawn(336,304,oGreenParatroopa  ,0,1,1,0.33)
            }
            if trialTime = 50
            {  
              marioFriends+=2
              delaySpawn(128,304,oRushRoader,0,1,1,0.33)
              delaySpawn(352,304,oRushRoader,0,1,1,0.33)
              if path=2
              {
                delaySpawn(240,304,oMegaTortoise,0,1,1,0.33)
              }
            }
            else if trialTime>=120
            {
                if instance_number(oEnemyBase) = marioFriends
                {
                    trialTime=0; trialProg+=1
                }
            }

        }
      else if trialProg=2
      {
      if trialTime = 1
            {  
              delaySpawn(144,240,oToady ,0,1,1,0.33)
              delaySpawn(336,240,oToady ,0,1,1,0.33)
              delaySpawn(144,144,oToady ,0,1,1,0.33)
              delaySpawn(336,144,oToady ,0,1,1,0.33)
              delaySpawn(240,192,oToady ,0,1,1,0.33)
              if path = 2
              {
                delaySpawn(240,64,oLakitu ,0,1,1,0.33)
              }
            }
        if trialTime=50
        {
        marioFriends+=5
        if path = 2
        {
            marioFriends+=1
        }
      
          delaySpawn(144,160,oSpinGuard,0,1,1,0.33)
          delaySpawn(336,160,oSpinGuard,0,1,1,0.33)
          if path = 2
          {
              delaySpawn(128,304,oSprongySpring,0,1,1,0.33)
              delaySpawn(352,304,oSprongySpring,0,1,1,0.33)
          }
        }
        else if trialTime>=120
        {
          if instance_number(oEnemyBase) = marioFriends
          {
            trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=3 //aka the ultimate jebait :^)
      {
        if trialTime=1
        {
          delaySpawn(240,288,oWingedMelon ,0,1,1,0.33)
          delaySpawn(240,160,oWingedMelon ,0,1,1,0.33)
          
         
        }
        else if trialTime = 50
        {
            marioFriends+=2
            delaySpawn(112,224,oWingedMelon ,0,1,1,0.33)
          delaySpawn(368,224,oWingedMelon ,0,1,1,0.33)
        }
        else if trialTime = 100
        {
            marioFriends+=2
        }
        else if trialTime = 220
        {
          if global.activeCharacter=0 //jerry
           {
            msgCreate(40,80,"Jerry","Oh no, I refuse to be baited into losing this far in. Those melons are Mario enemies too!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
          else
          {
            msgCreate(40,80,"Claire","I remember seeing these watermelons were tagged as Mario, not falling for it!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
        }
        else if trialTime = 285
        {           
          delaySpawn(368,304,oStarman ,0,1,1,0.33)
        }
        else if trialTime = 335
        {
            if global.activeCharacter=0 //jerry
           {
            msgCreate(40,80,"Jerry","A starman is usually cool, but I'm so not getting this one, just end this already!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
          else
          {
            msgCreate(40,80,"Claire","Nope, I don't need it, Stay away from me starman!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
          }
        }
        else if trialTime = 450
        {
            //spawn the giga huge wave
            delaySpawn(240,224,oUnbeatableBird,0,1,1,0.33)
        }
        else if trialTime = 460
        {
            msgCreate(40,80,"Jeremy","ARE YOU SURE YOU DON'T NEED THAT?",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
        }
        else if trialTime = 690
        {
            msgCreate(40,80,"Jeremy","Just hold out until the star effect wears off, you're almost there!",0,3,oMessagePerson,0)
            newMessage.fadingTime=60
        }
        else if trialTime>=690
        {
          if instance_number(oEnemyBase) = marioFriends and oPlayer1.starmanTime <= 0
          {
            with oEnemyBase
            {
                instance_destroy();
            }
            marioFriends=0
            trialTime=0; trialProg=0; trailStarted=3
          }
        }
      }
    }
    else if global.challengeRoom=11 //======================================== TRIAL 11 ======================================== (waterlogged)
    {
        
    if trialProg=0
      {
        if trialTime = 1
        {
        //start music
        var tempMplay;
          tempMplay=findMusic(2211)
          
         
          playMusic(tempMplay,0,1)
          
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
        //set up gimmick here
          water = instance_create(0,0,oWaterVolume)
          water.image_xscale=room_width
          water.image_yscale=room_height
          //spawn some enemies
          delaySpawn(80,304,oWB_SeaBlob,0,1,1,0.33)
          delaySpawn(400,304,oWB_SeaBlob,0,1,1,0.33)
          
          if path = 2
          {
              delaySpawn(112,176,oMetSkultera,0,1,1,0.33)
              delaySpawn(368,176,oMetSkultera,0,1,1,0.33)
          }
          
          delaySpawn(80,176,oSkullFish,0,1,1,0.33)
          delaySpawn(400,176,oSkullFish,0,1,1,0.33)
          
          delaySpawn(240,144,oMetEvir,0,1,1,0.33)
          
          delaySpawn(240,64,oAquaticDemon,0,1,1,0.33)
          instance_create(0,0,oPathManager)
         
        }
        else if trialTime>=180
        {
        //change number to appropriate amount if enemies will be left over
          if instance_number(oEnemyBase) = 0 
          {
          //end wave
          trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=1
        {

            if trialTime = 1
            {  
            //spawn some enemies
              delaySpawn(64,144,oWallCancer,0,1,1,0.33)
              delaySpawn(240,16,oCrablaster,0,1,1,0.33)
              
              delaySpawn(384,48,oBombDropper ,0,1,1,0.33)
              delaySpawn(96,48,oBombDropper ,0,1,1,0.33)
              
              delaySpawn(80,304,oEggBot,0,1,1,0.33)
              delaySpawn(400,304,oEggBot,0,1,1,0.33)
          
              delaySpawn(240,32,oSpinGuard,0,1,1,0.33)
            }
            else if trialTime>=120
            {
                //change number to appropriate amount if enemies will be left over
                if instance_number(oEnemyBase) = 0
                {
                //end wave
                    trialTime=0; trialProg+=1
                }
            }
        }
      else if trialProg=2
      {
        if trialTime=1
        {
          //spawn some enemies
          instance_create(400,288,oBigAbubble)
              instance_create(80,288,oBigAbubble)
          delaySpawn(112,192,oPT_LavaBeast,0,1,1,0.33)
          delaySpawn(368,192,oPT_LavaBeast,0,1,1,0.33)
          if path = 2
          {
              delaySpawn(192,96,oPT_FireEye,0,1,1,0.33)
              delaySpawn(288,96,oPT_FireEye,0,1,1,0.33)
          }
        }
        else if trialTime>=120
        {
        //change number to appropriate amount if enemies will be left over
          if instance_number(oEnemyBase) = 0
          {
            //end wave
            trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=3
      {
        if trialTime=1
        {
          //spawn some enemies
          delaySpawn(240,224,oPT_FlameElemental,0,1,1,0.33)
        }
        else if trialTime>=120
        {
        //change number to appropriate amount if enemies will be left over
          if instance_number(oEnemyBase) = 0
          {
            
            //tear down gimmick and kill remaining enemies
            if path=1
            {
                with oWaterVolume
                {
                    instance_destroy()
                }
            }
            //end wave
            trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=4
      {
        if trialTime=1
        {
            //final joke wave, spawn a bunch of fish after the water is gone (become unjoke on Bonkers ,monkas kill the fish quickly!)
            //spawn some enemies
            delaySpawn(80,48,oMetSkultera,0,1,1,0.33)
            delaySpawn(80,80,oMetSkultera,0,1,1,0.33)
            delaySpawn(80,112,oMetSkultera,0,1,1,0.33)
            delaySpawn(80,144,oMetSkultera,0,1,1,0.33)
            delaySpawn(80,176,oMetSkultera,0,1,1,0.33)
            delaySpawn(80,208,oMetSkultera,0,1,1,0.33)
            delaySpawn(80,240,oMetSkultera,0,1,1,0.33)
            delaySpawn(80,272,oMetSkultera,0,1,1,0.33)
            
            delaySpawn(400,48,oMetSkultera,0,1,1,0.33)
            delaySpawn(400,80,oMetSkultera,0,1,1,0.33)
            delaySpawn(400,112,oMetSkultera,0,1,1,0.33)
            delaySpawn(400,144,oMetSkultera,0,1,1,0.33)
            delaySpawn(400,176,oMetSkultera,0,1,1,0.33)
            delaySpawn(400,208,oMetSkultera,0,1,1,0.33)
            delaySpawn(400,240,oMetSkultera,0,1,1,0.33)
            delaySpawn(400,272,oMetSkultera,0,1,1,0.33)
        }
        else if trialTime>=120
        {
            //change number to appropriate amount if enemies will be left over
          if instance_number(oEnemyBase) = 0
          {
            //end challenge
            trialTime=0; trialProg=0; trailStarted=3
            
          }
        }
      }
    }
    else if global.challengeRoom=12 //======================================== TRIAL 12 ======================================== ? blocks
    {
        
    if trialProg=0
      {
        if trialTime = 1
        {
        //start music
        var tempMplay;
          tempMplay=findMusic(2212)
          
         
          playMusic(tempMplay,0,1)
          
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
        //set up gimmick here
        abilSetRemove(1)
              global.hasShoes[0]=2;
              global.hasShoes[1]=2;
              global.hasShoes[2]=2;
              global.hasShoes[3]=2;
              global.canDoubleJump=2
              global.hasAbilToken[0]=2
          //spawn some enemies
          delaySpawn(144,96,oMetGeemer,0,1,1,0.33)
          delaySpawn(144,192,oMetGeemer,0,1,1,0.33)
          delaySpawn(144,288,oMetGeemer,0,1,1,0.33)
          delaySpawn(320,48,oMetGeemer,0,1,1,0.33)
          delaySpawn(320,144,oMetGeemer,0,1,1,0.33)
          delaySpawn(320,288,oMetGeemer,0,1,1,0.33)
          instance_create(0,0,oPathManager)
         
        }
        else if trialTime>=180
        {
        //change number to appropriate amount if enemies will be left over
          if instance_number(oEnemyBase) = 0 
          {
          //end wave
          trialTime=0; trialProg+=1
          }
        }
      }
      else if trialProg=1
        {

            if trialTime = 1
            {  
            //spawn some 
              delaySpawn(368,96,oMetReo,0,1,1,0.33)
              delaySpawn(112,32,oMetReo,0,1,1,0.33)
              //delaySpawn(112,144,oMetReo,0,1,1,0.33)
            }
            else if trialTime>=270
            {
                //change number to appropriate amount if enemies will be left over
                if instance_number(oEnemyBase) = 0
                {
                //end wave
                    trialTime=0; trialProg+=1
                }
            }
        }
      else if trialProg=2
      {
        if trialTime=1
        {
          //spawn some enemies
          delaySpawn(80,288,oInjectorVirus,0,1,1,0.33)
              
              delaySpawn(80,32,oInjectorVirus,0,1,1,0.33)
              
              if path = 2
              {
                  delaySpawn(232,160,oArmoredBug,0,1,1,0.33)
                  delaySpawn(400,288,oInjectorVirus,0,1,1,0.33)
                  delaySpawn(400,32,oInjectorVirus,0,1,1,0.33)
              }
        }
        else if trialTime>=120
        {
        //change number to appropriate amount if enemies will be left over
          if instance_number(oEnemyBase) = 0
          {
            //end wave
            trialTime=0; trialProg=0; trailStarted=3
                abilSetRemove(1)
                abilSetRemove(0)
          }
        }
      }
    }
