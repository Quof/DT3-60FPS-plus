#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
splitGoalCheck=0
if room=rBT_ZeroB
{
  mapEventProg=0
  mapEventTime=0
  rayTiming=0
  for(i=0;i<3;i+=1)
  {
    rayTrap[i]=instance_create(152,248+(i*16),oRayTrapSensor)

    rayTrap[i].xOffset=432; rayTrap[i].yOffset=0
    rayTrap[i].sensorTime=0; rayTrap[i].timeToON=1000000; rayTrap[i].timeToOFF=1000000
  }
}
else if room=rBT_ZeroC
{
  mapEventProg=0
  mapEventTime=0
}
else if room=rBT_ZeroD
{
  mapEventProg=0
  mapEventTime=0
  lowerEnemyAppear=0
  claireDoor=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  if room=rBT_ZeroB
  {
    //----- Ray Trap Timing -----
    rayTiming+=1
    if rayTiming=1
    {
      rayTrap[0].bSensorActive=1
      rayTrap[1].bSensorActive=1
      rayTrap[2].bSensorActive=0
    }
    else if rayTiming=90
    {
      rayTrap[1].bSensorActive=0
    }
    else if rayTiming=120
    {
      rayTrap[0].bSensorActive=0
    }
    else if rayTiming=135
    {
      rayTrap[2].bSensorActive=1
    }
    else if rayTiming=137
    {
      rayTrap[2].bSensorActive=0
    }
    else if rayTiming=160 {rayTiming=0}

    //----- Room Progress -----
    if mapEventProg=0
    {
      if oPlayer1.x<=368 and oPlayer1.y<=304 //Spawn Drill Waying
      {
        var tNewEnemy,tEnemyBarrier;
        tNewEnemy=instance_create(168,272,oDrillWaying); tNewEnemy.drillMax=5
        tEnemyBarrier=instance_create(128,224,oEnemyBarrier); tEnemyBarrier.image_yscale=4
        tEnemyBarrier=instance_create(592,224,oEnemyBarrier); tEnemyBarrier.image_yscale=4
        for(i=0;i<6;i+=1)
        {
          myRayTrapLeft[i]=instance_create(144,224+(i*16),oRayTrap)
          myRayTrapRight[i]=instance_create(592,224+(i*16),oRayTrap)
        }
        mapEventProg+=1
      }
    }
    else if mapEventProg=1
    {
      mapEventTime+=1
      if mapEventTime>=5
      {
        if !instance_exists(oDrillWaying)
        {
          tNewEnemy=instance_create(568,272,oDrillWaying); tNewEnemy.drillMax=5
          mapEventTime=0; mapEventProg+=1
        }
      }
    }
    else if mapEventProg=2
    {
      mapEventTime+=1
      if mapEventTime>=5
      {
        if !instance_exists(oDrillWaying)
        {
          with oEnemyBarrier {instance_destroy()}
          for(i=0;i<6;i+=1)
          {
            with myRayTrapLeft[i] {instance_destroy()}
            with myRayTrapRight[i] {instance_destroy()}
          }
          mapEventTime=0; mapEventProg+=1
        }
      }
    }
  }
  else if room=rBT_ZeroC
  {
    if mapEventProg=0
    {
      if oPlayer1.x>=880 and oPlayer1.y<=120
      {
        var tNewEnemy,tEnemyBarrier;
        delaySpawn(768,112,oMegaTortoise,2,1,1,0.33)
        delaySpawn(992,112,oMegaTortoise,2,1,1,0.33)
        tNewEnemy=instance_create(880,16,oCrablaster); tNewEnemy.newName="Two Left Feet"
        tEnemyBarrier=instance_create(720,48,oEnemyBarrier); tEnemyBarrier.image_yscale=4
        tEnemyBarrier=instance_create(1024,48,oEnemyBarrier); tEnemyBarrier.image_yscale=4
        mapEventProg+=1
      }
    }
    else if mapEventProg=1
    {
      mapEventTime+=1
      if mapEventTime>=70
      {
        if !instance_exists(oMegaTortoise)
        {
          with oEnemyBarrier {instance_destroy()}
          mapEventTime=0; mapEventProg+=1
        }
      }
    }
  }
  else if room=rBT_ZeroD
  {
    if mapEventProg=0
    {
      if oPlayer1.x>=1512 and oPlayer1.y>=192 and oPlayer1.y<=344
      {
        var enemyCounter,enemyBarrier;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=3
        enemyBarrier=instance_create(1440,208,oEnemyBarrier); enemyBarrier.image_yscale=8
        enemyBarrier=instance_create(1776,208,oEnemyBarrier); enemyBarrier.image_yscale=8
        delaySpawn(1504,208,oCrablaster,2,1,1,0.33)
        delaySpawn(1728,208,oCrablaster,2,1,1,0.33)
        delaySpawn(1616,336,oHammaHammaMain,2,1,1,0.33)
        tNewEnemy=instance_create(1576,320,oDrillWaying); tNewEnemy.drillMax=8
        tNewEnemy=instance_create(1656,320,oDrillWaying); tNewEnemy.drillMax=8
        mapEventProg+=1
      }
    }
    else if mapEventProg=1
    {
      mapEventTime+=1
      if mapEventTime>=70
      {
        if oEnemyRemain.enemyCount<=0
        {
          with oEnemyRemain {instance_destroy()}
          with oEnemyBarrier {instance_destroy()}
          mapEventTime=0; mapEventProg+=1
        }
      }
    }

    if lowerEnemyAppear=0 //After Jerry hits all the time switches
    {
      if !instance_exists(oTimeSwBarrier)
      {
        instance_create(224,592,oMegaTortoise)
        instance_create(336,688,oMegaTortoise)
        instance_create(704,688,oMegaTortoise)
        instance_create(400,688,oHammaHammaMain)
        instance_create(640,688,oHammaHammaMain)
        lowerEnemyAppear=1
      }
    }

    if claireDoor=0 //Trap Claire in lower path
    {
      if oPlayer1.x>=1312 and oPlayer1.y>=432
      {
        myDoor=instance_create(1264,432,oEventBarrier)
        myDoor.progCheck=9999990
        claireDoor=1
      }
    }
  }
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if splitGoalCheck=0
{
  if room=rBT_ZeroC
  {
    if (469266).isActive=1 and (469267).isActive=1
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      with oEventBarrier {instance_destroy()}
      splitGoalCheck=1
    }
  }
  else if room=rBT_ZeroD
  {
    if (469269).isActive=1 and (469270).isActive=1
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.fadeSpeed=0.2
      with oEventBarrier {instance_destroy()}
      splitGoalCheck=1
    }
  }
}
