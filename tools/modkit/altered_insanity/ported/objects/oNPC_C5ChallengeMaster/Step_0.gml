//THIS IS COUSINOER5'S VERY OWN CHALLENGE AREA, we'll make it fun
if global.gamePaused=false
{
  if trailStarted=1 //Fade out Challenge Master and slight wait
  {
    //trialTime+=1
    if trialTime=0 {trialTime=1-gDeltaTime} //60fps change (added): 1 on the first frame, as at 30fps
    trialTime+=1*gDeltaTime //60fps change
    //if trialTime>=1 and trialTime<=10 {image_alpha-=0.1}
    if trialTime>=1 and trialTime<11 {image_alpha-=0.1*gDeltaTime} //60fps change: 0.1 a tick for ticks 1 to 10 (<11: the frames after 10 belong to tick 10)
    else if trialTime>=55 {trialTime=0; trailStarted=2}
  }
  else if trailStarted=2 //The trial
  {
    //trialTime+=1
    if trialTime=0 {trialTime=1-gDeltaTime} //60fps change (added): 1 on the first frame, as at 30fps (the trials' events check trialTime=1)
    trialTime+=1*gDeltaTime //60fps change
    if (global.challengeRoom >= 1 and global.challengeRoom <= 4)
    {
        event_user(0);
    }
    if (global.challengeRoom >= 5 and global.challengeRoom <= 8)
    {
        event_user(1);
    }
    if (global.challengeRoom >= 9 and global.challengeRoom <= 12)
    {
        event_user(2);
    }
    else if global.challengeRoom=13 //======================================== TRIAL 13 ======================================== (Color Zone Challenge)
    {
        
    if trialProg=0
      {
        if trialTime = 1
        {
        //start music
        var tempMplay;
          tempMplay=findMusic(2021)
          
         
          playMusic(tempMplay,0,1)
          
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
        //set up gimmick here
        colorControl=instance_create(0,0,oColorIndControl)
        colorControl.warnDelay=120
        
        colorZoneRed=instance_create(208,160, oColorZone)
        colorZoneRed.zoneColor=1
        colorZoneRed.image_xscale=64
        colorZoneRed.image_yscale=64
        colorZoneRed.moveSpd=0
        colorZoneRed.moveDelay=0
        
        colorZoneBlue=instance_create(64,96, oColorZone)
        colorZoneBlue.zoneColor=2
        colorZoneBlue.image_xscale=64
        colorZoneBlue.image_yscale=64
        colorZoneBlue.moveSpd=0
        colorZoneBlue.moveDelay=0
       
        colorZoneGreen=instance_create(208,32, oColorZone)
        colorZoneGreen.zoneColor=3
        colorZoneGreen.image_xscale=64
        colorZoneGreen.image_yscale=64
        colorZoneGreen.moveSpd=0
        colorZoneGreen.moveDelay=0
        
        colorZoneYellow=instance_create(352,96, oColorZone)
        colorZoneYellow.zoneColor=4
        colorZoneYellow.image_xscale=64
        colorZoneYellow.image_yscale=64
        colorZoneYellow.moveSpd=0
        colorZoneYellow.moveDelay=0
        
          //spawn some enemies

          instance_create(0,0,oPathManager)
         
        }
        else if trialTime = 10
        {
            createEnemy(224,192,oVaultOrb,2,1,1); newEnemy.colorSet=1
        }
        else if trialTime = 20
        {
            createEnemy(224,160,oVaultOrb,2,1,1); newEnemy.colorSet=2
        }
        else if trialTime = 30
        {
            createEnemy(256,192,oVaultOrb,2,1,1); newEnemy.colorSet=3
        }
        else if trialTime = 40
        {
            createEnemy(256,160,oVaultOrb,2,1,1); newEnemy.colorSet=4
        }
        else if trialTime = 50
        {
            createEnemy(80,128,oVaultOrb,2,1,1); newEnemy.colorSet=1
        }
        else if trialTime = 60
        {
            createEnemy(80,96,oVaultOrb,2,1,1); newEnemy.colorSet=2
        }
        else if trialTime = 70
        {
            createEnemy(112,128,oVaultOrb,2,1,1); newEnemy.colorSet=3
        }
        else if trialTime = 80
        {
            createEnemy(112,96,oVaultOrb,2,1,1); newEnemy.colorSet=4
        }
        else if trialTime = 90
        {
            createEnemy(224,64,oVaultOrb,2,1,1); newEnemy.colorSet=1
        }
        else if trialTime = 100
        {
            createEnemy(224,32,oVaultOrb,2,1,1); newEnemy.colorSet=2
        }
        else if trialTime = 110
        {
            createEnemy(256,64,oVaultOrb,2,1,1); newEnemy.colorSet=3
        }
        else if trialTime = 120
        {
            createEnemy(256,32,oVaultOrb,2,1,1); newEnemy.colorSet=4
        }
        else if trialTime = 130
        {
            createEnemy(368,128,oVaultOrb,2,1,1); newEnemy.colorSet=1
        }
        else if trialTime = 140
        {
            createEnemy(368,96,oVaultOrb,2,1,1); newEnemy.colorSet=2
        }
        else if trialTime = 150
        {
            createEnemy(400,128,oVaultOrb,2,1,1); newEnemy.colorSet=3
        }
        else if trialTime = 160
        {
            createEnemy(400,96,oVaultOrb,2,1,1); newEnemy.colorSet=4
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
              delaySpawn(240,96,oGlitchyPixels,0,1,1,0.33)
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
          delaySpawn(432,32,oBloodVirus,0,1,1,0.33)
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
            delaySpawn(48,32,oBloodVirus,0,1,1,0.33)
        }
        else if trialTime>=120
        {
            //change number to appropriate amount if enemies will be left over
          if instance_number(oEnemyBase) = 0
          {
            //end challenge
            trialTime=0; trialProg=0; trailStarted=3
            //tear down gimmick and kill remaining enemies
          }
        }
      }
    }
    else if global.challengeRoom=14 //======================================== TRIAL 14 ======================================== (SOLVE MY MAZE)
    {
        
    if trialProg=0
      {
        if trialTime = 1
        {
        //start music
        var tempMplay;
          tempMplay=findMusic(2214)
          instance_create(0,0,oDeathClock)
         
          playMusic(tempMplay,0,1)
          
          if global.modeSpeed=1
            SS_SetSoundFreq(tempMplay,88200)
        //set up gimmick here
          instance_create(0,0,oDeathClock)
        
          //create doors
          door1 = instance_create(432, 592, oEventBarrier)
          door1.spriteChange = 5
          door1.image_yscale=1
          door1.progCheck = 99999999
          
          door2 = instance_create(680, 656, oEventBarrier)
          door2.spriteChange = 5
          door2.image_yscale=1.75
          door2.progCheck = 99999999
          
          door3 = instance_create(1344, 672, oEventBarrier)
          door3.spriteChange = 5
          door3.image_yscale=1
          door3.progCheck = 99999999
          
          door4 = instance_create(912, 16, oEventBarrier)
          door4.spriteChange = 5
          door4.image_yscale=1
          door4.image_xscale=2
          door4.progCheck = 99999999
          
          //delete the training ring manager
          with oC5RingManager { instance_destroy() }
          
          //create the first ring manager
          manager = instance_create(0,0,oC5RingManager)
          manager.ringMax = 23
          manager.doorID = door1
          manager.index=1
          
          //instance_create(0,0,oPathManager)
         
        }
        else if trialTime>=10
        {
        //change number to appropriate amount if enemies will be left over
          if instance_number(oC5RingManager) = 0 
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
                  //create the next ring manager
                  manager = instance_create(0,0,oC5RingManager)
                  manager.ringMax = 49
                  manager.doorID = door2
                  manager.index=2
            }
            else if trialTime>=10
            {
                //change number to appropriate amount if enemies will be left over
                if instance_number(oC5RingManager) = 0
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
          //create the next ring manager
                  manager = instance_create(0,0,oC5RingManager)
                  manager.ringMax = 55
                  manager.doorID = door3
                  manager.index=3
        }
        else if trialTime>=120
        {
        //change number to appropriate amount if enemies will be left over
          if instance_number(oC5RingManager) = 0
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
            //create the next ring manager
                  manager = instance_create(0,0,oC5RingManager)
                  manager.ringMax = 31
                  manager.doorID = door4
                  manager.index=4
        }
        else if trialTime>=120
        {
            //change number to appropriate amount if enemies will be left over
          if instance_number(oC5RingManager) = 0
          {
            //end challenge
            trialTime=0; trialProg=0; trailStarted=3
            //tear down gimmick and kill remaining enemies
            with oDeathClock
                {
                    instance_destroy()
                }
          }
        }
      }
    }
  }//put new challenges above this bracket
  else if trailStarted=3 //Trial completed
  {
    //trialTime+=1
    if trialTime=0 {trialTime=1-gDeltaTime} //60fps change (added): 1 on the first frame, as at 30fps
    trialTime+=1*gDeltaTime //60fps change
    if trialTime=1
    {
      var tNewString;
      tNewString=string_delete(global.c5Trials,global.challengeRoom,1)
      tNewString=string_insert(string(path),tNewString,global.challengeRoom)
      global.c5Trials=tNewString
      trialCheck="1"
      oPlayer1.life=oPlayer1.maxLife
      //do the trial check
      var baseTrialsPassed;
      baseTrialsPassed = true;
      for (i=1; i<=8; i+=1)
      {
        if (string_char_at(global.c5Trials,i) = "0")
        {
            baseTrialsPassed = false;
        }
      }
      
      if baseTrialsPassed = true and global.cousinoer5Progress < 666
      {
        msgCreate(80,120,"Challenge Master","You have done well to complete all 8 trials, go outside and the way will become clear.",0,2,oMessagePerson,0)
        global.cousinoer5Progress = 666;
      }
      else if global.cousinoer5Progress < 666
      {
        if path=1
        {
          msgCreate(80,120,"Challenge Master","Congratulations on completing this trial, however more trials await you.",0,1,oMessagePerson,0)
        }
        else
        {
          msgCreate(80,120,"Challenge Master","Congratulations on completing this trial, however more trials await you.",0,1,oMessagePerson,0)
        }
      }
      else
      {
        if path=1
        {
          msgCreate(80,120,"Challenge Master","Good job.",0,1,oMessagePerson,0)
        }
        else
        {
          msgCreate(80,120,"Challenge Master","You've completed a very hard challenge, great job!",0,1,oMessagePerson,0)
        }
      }
      newMessage.fadingTime=70

    }
    
    //if trialTime>=1 and trialTime<=10 {image_alpha+=0.1}
    if trialTime>=1 and trialTime<11 {image_alpha+=0.1*gDeltaTime} //60fps change: 0.1 a tick for ticks 1 to 10 (<11: the frames after 10 belong to tick 10)
    else if trialTime=60
    {
      global.canCharSwap=2
      oExit.y-=room_height
      trailStarted=0
    }
  }
}
