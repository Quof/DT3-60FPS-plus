#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

if room=rGame6_ParaIslandA {indexCheck=string_char_at(global.kiEnergy,27)}
else if room=rGame6_ParaIslandB {indexCheck=string_char_at(global.kiEnergy,28)}
else if room=rGame6_ParaIslandC {indexCheck=string_char_at(global.kiEnergy,29)}
else if room=rGame6_ParaIslandD {indexCheck=string_char_at(global.kiEnergy,30)}
else if room=rGame6_WaterCaveA
{
  bWaterRise=0
  waterAltSpd=0
  waterTime=0
  indexCheck=string_char_at(global.kiEnergy,34)
}
else if room=rGame6_WaterCaveD {indexCheck=string_char_at(global.kiEnergy,37)}
else if room=rGame6_MonsterIsle
{
  spawnTime=360
  spawnDelay=720
}
else if room=rGame6_CoDM {platformCheck=0}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rGame6_EarthA
  {
    if global.gameProgress<=3450 //Don't go here yet
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=184
      {
        msgCreate(0,0,"Jeremy","Let's leave this place alone for now. I'm sure we'll return eventually.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_FireB and global.gameProgress=3500 //Flame Elemental Attack 1
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1184
      {
        var tFESpawn;
        tFESpawn=instance_create(1392,room_height+48,oG6_FireCaveFEAtk)
        tFESpawn.moveSpd=7; tFESpawn.direction=92
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=1888
      {
        var tFESpawn;
        tFESpawn=instance_create(2160,room_height+48,oG6_FireCaveFEAtk)
        tFESpawn.moveSpd=7; tFESpawn.direction=92
        sceneProgress+=1
      }
    }
    else if sceneProgress=2
    {
      if oPlayer1.x>=2784
      {
        var tFESpawn;
        tFESpawn=instance_create(3056,room_height+48,oG6_FireCaveFEAtk)
        tFESpawn.moveSpd=7; tFESpawn.direction=92
        sceneProgress+=1
      }
    }
  }
  else if room=rGame6_FireC and global.gameProgress=3501 //Flame Elemental Attack 2
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=592
      {
        var tFESpawn;
        tFESpawn=instance_create(832,room_height+48,oG6_FireCaveFEAtk)
        tFESpawn.moveSpd=7; tFESpawn.direction=92
        sceneProgress+=1
      }
    }
    else if sceneProgress=1
    {
      if oPlayer1.x>=1024
      {
        var tFESpawn;
        tFESpawn=instance_create(1264,room_height+48,oG6_FireCaveFEAtk)
        tFESpawn.moveSpd=7; tFESpawn.direction=92
        sceneProgress+=1
      }
    }
  }
  else if room=rGame6_FireD and global.gameProgress=3502 //Flame Elemental Attack 3
  {
    if sceneProgress=0
    {
      if oPlayer1.x>=1536
      {
        var tFESpawn;
        tFESpawn=instance_create(1760,room_height+48,oG6_FireCaveFEAtk)
        tFESpawn.moveSpd=7; tFESpawn.direction=92
        sceneProgress+=1
      }
    }
  }
  else if room=rGame6_WaterA
  {
    if global.gameProgress<=3545 //Don't go here yet
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=144
      {
        msgCreate(0,0,"Jeremy","Let's leave this place alone for now.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_CoMA
  {
    if global.gameProgress<=3589 //Don't go here yet
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=176
      {
        msgCreate(0,0,"Jeremy","I don't think there's anything useful here, let's head to the nearby town.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_WindE
  {
    if global.gameProgress<=3610 //Lava Beast doesn't make sense here
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and instance_exists(oPT_LavaBeast) {convo[0]+=1;if convo[0]>=20 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=1
      {
        msgCreate(0,0,"Jerry","Now that just makes no sense at all.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_ParaIslandA
  {
    if indexCheck="0"
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=192 {convo[0]+=1;if convo[0]>=20 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=1
      {
        msgCreate(0,0,"Jerry","This looks confusing. Did someone just throw down some tiles and call it a day?",0,2,oMessagePerson,0)
        newMessage.fadingTime=130; charDialogue[0]+=1
      }
      else if charDialogue[0]=2 {convo[0]+=1;if convo[0]>=130 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=3
      {
        msgCreate(0,0,"Claire","It does look really bad.",0,0,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
      else if charDialogue[0]=4 {convo[0]+=1;if convo[0]>=60 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=5 and oPlayer1.x>=1120
      {
        msgCreate(0,0,"Jerry","The enemies are lame too.",0,0,oMessagePerson,0)
        newMessage.fadingTime=60; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_ParaIslandB
  {
    if indexCheck="0"
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and instance_exists(oRollingBoulder) {convo[0]+=1;if convo[0]>=20 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=1
      {
        msgCreate(0,0,"Jerry","Now we have those annoying boulders too.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80; charDialogue[0]+=1
      }
      else if charDialogue[0]=2 {convo[0]+=1;if convo[0]>=80 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=3 and oPlayer1.x>=512
      {
        msgCreate(0,0,"Jerry","And bad looking platforms!",0,1,oMessagePerson,0)
        newMessage.fadingTime=70; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_ParaIslandC
  {
    if indexCheck="0"
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 {convo[0]+=1;if convo[0]>=40 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=1
      {
        msgCreate(0,0,"Jerry","Eww, what? I just hate this place completely. The tiling sucks!",0,1,oMessagePerson,0)
        newMessage.fadingTime=130; charDialogue[0]+=1
      }
      else if charDialogue[0]=2 {convo[0]+=1;if convo[0]>=130 {charDialogue[0]+=1; convo[0]=0}}
      else if charDialogue[0]=3
      {
        msgCreate(0,0,"Claire","Looks like it's another work in progress.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_ParaIslandD
  {
    if indexCheck="0"
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=480
        {
          global.tempAction[0]=42
          var enemyCounter,enemyBarrier;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=11
          enemyBarrier=instance_create(304,-64,oEnemyBarrier); enemyBarrier.image_yscale=16
          enemyBarrier=instance_create(640,-64,oEnemyBarrier); enemyBarrier.image_yscale=16
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          global.tempAction[1]=0
          delaySpawn(352,224,oPT_TestEnemy,2,1,1,0.33)
          delaySpawn(608,224,oPT_TestEnemy,2,1,1,0.33)
        }
        else if sceneDelay>=20
        {
          if oEnemyRemain.enemyCount<=10 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          global.tempAction[1]=1
          delaySpawn(352,224,oPT_TestEnemy,2,1,1,0.33)
          delaySpawn(608,96,oPT_TestEnemy,2,1,1,0.33)
        }
        else if sceneDelay=160
        {
          global.tempAction[1]=2
          delaySpawn(608,224,oPT_TestEnemy,2,1,1,0.33)
          delaySpawn(352,96,oPT_TestEnemy,2,1,1,0.33)
        }
        else if sceneDelay>=170
        {
          if oEnemyRemain.enemyCount<=7 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          global.tempAction[1]=3
          delaySpawn(480,160,oPT_TestEnemy,2,1,1,0.33)
        }
        else if sceneDelay=160
        {
          global.tempAction[1]=4
          delaySpawn(352,160,oPT_TestEnemy,2,1,1,0.33)
          delaySpawn(608,160,oPT_TestEnemy,2,1,1,0.33)
        }
        else if sceneDelay>=170
        {
          if oEnemyRemain.enemyCount<=3 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=4
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          global.tempAction[1]=5
          delaySpawn(352,96,oPT_TestEnemy,2,1,1,0.33)
          delaySpawn(608,96,oPT_TestEnemy,2,1,1,0.33)
        }
        else if sceneDelay>=20
        {
          if oEnemyRemain.enemyCount<=0
          {
            with oEnemyBarrier {instance_destroy()}
            with oEnemyRemain {instance_destroy()}
            sceneDelay=0; sceneProgress=10
          }
        }
      }
    }
  }
  else if room=rGame6_WaterCaveA
  {
    //Water level
    waterTime+=1
    if waterTime>=60
    {
      if bWaterRise=1
      {
        waterAltSpd=2
        if oWaterVolume.y>=288 {waterTime=0; waterAltSpd=0; bWaterRise=0}
      }
      else
      {
        waterAltSpd=-2
        if oWaterVolume.y<=128 {waterTime=0; waterAltSpd=0; bWaterRise=1}
      }
    }
    oWaterVolume.y+=waterAltSpd
    
    if indexCheck="0"
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=1328
        {
          global.tempAction[0]=44
          var enemyCounter,enemyBarrier;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=3
          enemyBarrier=instance_create(1136,112,oEnemyBarrier); enemyBarrier.image_yscale=8
          enemyBarrier=instance_create(1536,144,oEnemyBarrier); enemyBarrier.image_yscale=4
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(1424,160,oPT_FireEye,2,1,1,0.33)
        }
        else if sceneDelay=60
        {
          delaySpawn(1232,160,oPT_FireEye,2,1,1,0.33)
        }
        else if sceneDelay=200
        {
          delaySpawn(1328,160,oPT_FireEye,2,1,1,0.33)
        }
        else if sceneDelay>=170
        {
          if oEnemyRemain.enemyCount<=0
          {
            with oEnemyBarrier {instance_destroy()}
            with oEnemyRemain {instance_destroy()}
            sceneDelay=0; sceneProgress=10
          }
        }
      }
    }
  }
  else if room=rGame6_WaterCaveB //Water level
  {
    if oWaterVolume.y>oPlayer1.y-14 {oWaterVolume.y-=1}
    else if oWaterVolume.y<oPlayer1.y-18 {oWaterVolume.y+=2}
  }
  else if room=rGame6_WaterCaveD
  {
    if indexCheck="0"
    {
      if sceneProgress=0
      {
        if oPlayer1.x>=416
        {
          global.tempAction[0]=47
          var enemyCounter,enemyBarrier;
          enemyCounter=instance_create(0,0,oEnemyRemain)
          enemyCounter.enemyCount=4
          enemyBarrier=instance_create(304,208,oEnemyBarrier); enemyBarrier.image_yscale=6
          enemyBarrier=instance_create(512,208,oEnemyBarrier); enemyBarrier.image_yscale=6
          sceneProgress+=1
        }
      }
      else if sceneProgress=1
      {
        oWaterVolume.y-=4
        sceneDelay+=1
        if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
      }
      else if sceneProgress=2
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(352,304,oPT_Skeleton,2,1,1,0.33)
        }
        else if sceneDelay=50
        {
          delaySpawn(464,304,oPT_Skeleton,2,1,1,0.33)
        }
        else if sceneDelay>=60
        {
          if oEnemyRemain.enemyCount<=2 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=3
      {
        sceneDelay+=1
        if sceneDelay=10
        {
          delaySpawn(368,176,oPT_IceSpirit,2,1,1,0.33)
        }
        else if sceneDelay=50
        {
          delaySpawn(464,176,oPT_FireEye,2,1,1,0.33)
        }
        else if sceneDelay>=60
        {
          if oEnemyRemain.enemyCount<=0 {sceneDelay=0; sceneProgress+=1}
        }
      }
      else if sceneProgress=4
      {
        oWaterVolume.y+=4
        sceneDelay+=1
        if sceneDelay>=40
        {
          with oEnemyBarrier {instance_destroy()}
          with oEnemyRemain {instance_destroy()}
          sceneDelay=0; sceneProgress=10
        }
      }
    }
  }
  else if room=rGame6_MonsterIsle
  {
    spawnTime+=1
    if spawnTime>=spawnDelay
    {
      global.tempAction[0]=91+irandom(8)
      var tRanSpawn,tSpawned;
      tRanSpawn=irandom_range(1,5)
      if tRanSpawn=1 {tSpawned=oPT_Slime}
      else if tRanSpawn=2 {tSpawned=oPT_Skeleton}
      else if tRanSpawn=3 {tSpawned=oPT_FireEye}
      else if tRanSpawn=4 {tSpawned=oPT_LavaBeast}
      else if tRanSpawn=5 {tSpawned=oPT_IceSpirit}
      delaySpawn(irandom_range(32,room_width-32),irandom_range(32,room_height-64),tSpawned,0,1,1,0.33)
      spawnTime=0
    }
  }
  else if room=rGame6_CoDM
  {
    if platformCheck=0
    {
      if (342292).x>=1904
      {
        with (342292)
        {
          if checkScreenArea(x,y,64)=1 {playSound(global.snd_BombExplode,0,0.98,1)}
          tEffect=instance_create(x+32,y+8,oEffect)
          tEffect.sprite_index=sShipExplosion; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_speed=0.5
          tEffect.image_xscale=1.75; tEffect.image_yscale=1.75; tEffect.image_alpha=0.9
          instance_destroy()
        }
        platformCheck=1
      }
    }
  }
  else if room=rGame6_CoDO
  {
    if global.gameProgress<=3820 //Two low level enemies
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
        if oPlayer1.x>=512 {charDialogue[0]=10}
      }
      if charDialogue[0]=0 and oPlayer1.x>=1056 and oPlayer1.x<=1088
      {
        msgCreate(0,0,"Jeremy","There's two level 1 enemies coming up that you'll need to chain jump off of.",0,2,oMessagePerson,0)
        newMessage.fadingTime=110; charDialogue[0]+=1
      }
    }
  }
  else if room=rGame6_CoDR
  {
    if global.gameProgress<=3850 //Wonky room
    {
      if sceneProgress=0
      {
        for (i=0;i<=1;i+=1)
        {
          charDialogue[i]=0
          convo[i]=0
        }
        sceneProgress+=1
      }
      if charDialogue[0]=0 and oPlayer1.x>=864
      {
        msgCreate(0,0,"Jeremy","Oh wow, looks like this either wasn't finished, or someone was angry...",0,2,oMessagePerson,0)
        newMessage.fadingTime=110; charDialogue[0]+=1
      }
    }
  }
}
