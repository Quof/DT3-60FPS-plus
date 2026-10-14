sceneProgress=0
sceneDelay=0
if global.newMapX=366 and room=rSerasFunhouse  //marriage
{
    /*var tBossTitle,tempMplay;
    tBossTitle=instance_create(0,0,oBossNameDisplay)
    tBossTitle.bossName="Sera and Icemaster"
    tBossTitle.bossTitle="They make a nice match!"*/
    tempMplay=findMusic(821)//change
    playMusic(tempMplay,0,0)
    boss=instance_create(416,224,oSera)
    boss.activateBoss=1
    instance_create(192,288,oCHAOS_Warmaster_Fixed)
    global.currentBoss="SeraAndIcemaster"
    global.bossTrack=1
}
if global.newMapX=367 and room=rSerasFunhouse   //yuri
{
    /*var tBossTitle,tempMplay;
    tBossTitle=instance_create(0,0,oBossNameDisplay)
    tBossTitle.bossName="Sera times two!"
    tBossTitle.bossTitle="Moogy will be all over this"*/
    tempMplay=findMusic(821)//change
    playMusic(tempMplay,0,0)
    boss=instance_create(416,224,oSera)
    boss.activateBoss=1
    boss=instance_create(192,224,oSeraTsu)
    boss.activateBoss=1
    global.currentBoss="SeraTwincest"
    global.bossTrack=1
}
if global.newMapX=368 and room=rSerasFunhouse   //mindbreak
{
    /*var tBossTitle,tempMplay;
    tBossTitle=instance_create(0,0,oBossNameDisplay)
    tBossTitle.bossName="S(era)EX"
    tBossTitle.bossTitle="Corrupted Defense Bot"*/
    tempMplay=findMusic(821)//change
    playMusic(tempMplay,0,0)
    boss=instance_create(416,224,oSeraV)
    boss.activateBoss=1
    global.currentBoss="SeraEX"
    global.bossTrack=1
}
    
/*
else if sceneProgress=4
      {
        var tBossTitle,tempMplay;
        tBossTitle=instance_create(0,0,oBossNameDisplay)
        tBossTitle.bossName="Sera"
        tBossTitle.bossTitle="Infected Defense Bot"
        tempMplay=findMusic(821)
        playMusic(tempMplay,0,0)
        boss=instance_create(416,224,oSera)
        boss.activateBoss=1
        global.currentBoss="Sera"
        global.bossTrack=1
      }
    }
    else if global.bossTrack=1
    {
      if sceneProgress=1 //End Boss
      {
        global.bossTrack=2
        sceneProgress=0
      }
    }
    else if global.bossTrack=2
    {
      if sceneProgress=0
      {
        var tFullHeartDrop,tempMplay;
        tFullHeartDrop=instance_create(368,128,oHealthPickup)
        tFullHeartDrop.sprite_index=sFullHealthPickup
        global.gamePaused=false
        global.currentBoss=""
        global.bossTrack=0
      }
    }
*/
