/*if room=rDDLC_PlatHUB and global.gamePaused=false
{
    if oDSign.bChecked=1 and sceneProgress=0 {sceneProgress=1}
    if sceneProgress=1 and (oPlayer1.y>158 or (oPlayer1.x>=576 and oPlayer1.y>=112))
    {
        for (i=0;i<room_width;i+=16)
        {
            for(j=0;j<room_height;j+=16)
            {
                instance_create(i,j,oDSSR)
            }
        }
        sceneProgress=2
    }
}
else if room=rHexPlat33 and global.gamePaused=false
{
    if 359<oPlayer1.x and oPlayer1.x<409 and 127<oPlayer1.y and oPlayer1.y<181 and sceneProgress mod 2=0 {sceneProgress+=1}
    else if 223<oPlayer1.x and oPlayer1.x<273 and 207<oPlayer1.y and oPlayer1.y<261 and sceneProgress mod 4<2 {sceneProgress+=2}
    else if 223<oPlayer1.x and oPlayer1.x<273 and 367<oPlayer1.y and oPlayer1.y<421 and sceneProgress mod 8<4 {sceneProgress+=4}
    else if 495<oPlayer1.x and oPlayer1.x<545 and 207<oPlayer1.y and oPlayer1.y<261 and sceneProgress mod 16<8 {sceneProgress+=8}
    else if 495<oPlayer1.x and oPlayer1.x<545 and 367<oPlayer1.y and oPlayer1.y<421 and sceneProgress mod 32<16 {sceneProgress+=16}
    else if 359<oPlayer1.x and oPlayer1.x<409 and 463<oPlayer1.y and oPlayer1.y<517 and sceneProgress mod 64<32 {sceneProgress+=32}
    else if sceneProgress=63
    {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        var helper;
        helper=instance_create(384,304,oDGreenHexRing)
        helper.spinSpd=0; helper.image_angle=90
        with oExit
        {
            y=288
            arrowX=x+8
            arrowY=y-24
            bShowArrow=true
        }
        sceneProgress+=64
    }
}
else if room=rHexPlat42
{
    if sceneProgress=0
    {
        var hexIt;
        scf=1
        for(i=0;i<10;i+=1)
        {
            hexIt=instance_create(544,288,oDHexRing)
            hexIt.spinSpd=-1.2
            hexIt.changeDelay=0
            hexIt.moveSpd=0
            hexIt.image_angle=0
            hexIt.image_xscale=scf
            hexIt.image_yscale=scf
            scf*=1.2
        }
        sceneProgress=1
    }
}
else */if room=rHexPlat4 and global.gamePaused=false
{
    //sceneDelay+=1
    sceneDelay+=1*gDeltaTime //60fps change: per frame
    if sceneDelay=40
    {
        sceneDelay=0
        counter+=2
        if counter>5 {counter-=5}
        instance_create(1696,80*counter,oDHexTunnel)
    }
    with oDHexTunnel
    {
        if x<-80 {instance_destroy()}
    }
}
else if room=rYellowRide and global.gamePaused=false
{
    with oDYellowHexTunnel
    {
        if myGrapplePoint.bGrappled=0 {x=oPlayer1.x; y=oPlayer1.y-40}
    }
    with oStaticSpikeRed
    {
        x=oPlayer1.x-8
    }
    if koopaRings=0 and global.newMapX<500
    {
        with oRedParatroopa
        {
            var ringy;
            ringy=instance_create(x,y,oDFollowRing)
            ringy.bFollow=1; ringy.idFollow=id
            ringy.image_xscale=0.75; ringy.image_yscale=0.75
        }
        koopaRings=1
    }
    if oPlayer1.x>5280 and sceneProgress=0
    {
        for(i=0;i<room_height;i+=16) {instance_create(5248,i,oDSSR)}
        oVaultDemon.activateBoss=1
        sceneProgress=1
    }
    else if sceneProgress=1 and !instance_exists(oVaultDemon)
    {
        with oExit {x-=200}
        sceneProgress=2
    }
}
else if false //room=rGreenRide and global.gamePaused=false
{
    with oDGreenHexRing
    {
        x=oPlayer1.x
        y=oPlayer1.y-24
    }
    if !instance_exists(oDDD) and sceneProgress=0
    {
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        with (479350)
        {
            //y=oPlayer1.y-32
            x+=200
        }
        sceneProgress=1
    }
}
else if false //room=rClassicRide and global.gamePaused=false
{
    if oPlayer1.x>1680 and sceneProgress=0
    {
        sceneProgress=1
    }
    else if sceneProgress=1 and !instance_exists(oCHAOS_Rocketeer)
    {
        with oDMarioBreakBlock {instance_destroy()}
        sceneProgress=2
    }
}
else if room=rHexPlat52 and global.gamePaused=false //----- [Unskippable] Enemy Trap -----
{
    if sceneProgress=6
    {
        //too lazy to change the loops
    }
    else if sceneProgress=0
    {
        var enemyCounter;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=9//neg end result?
        sceneProgress+=1
    }
    else if sceneProgress=1
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      if sceneDelay=10
      {
        delaySpawn(room_width/2,room_height/2,oDDD,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=2 and oEnemyRemain.enemyCount<=8
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      if sceneDelay=10
      {
        delaySpawn(176,432,oCV_AxeKnight,2,1,1,0.33)
        delaySpawn(592,432,oCV_AxeKnight,2,1,1,0.33)
      }
      else if sceneDelay=100
      {
        delaySpawn(256,0,oCV_SwordKnight,2,1,1,0.5)
        delaySpawn(480,0,oCV_SwordKnight,2,1,1,0.5)
        sceneDelay=0; sceneProgress+=1
      }
      //else if sceneDelay=55 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and oEnemyRemain.enemyCount<=4
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      if sceneDelay=10
      {
        delaySpawn(800,192,oVolcanoLotus,2,1,1,0.33)
        delaySpawn(80,176,oVolcanoLotus,2,1,1,0.33)
        delaySpawn(176,432,oVolcanoLotus,2,1,1,0.33)
        delaySpawn(592,432,oVolcanoLotus,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
      //else if sceneDelay=55 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=4 and oEnemyRemain.enemyCount<=0
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      if sceneDelay=10
      {
        delaySpawn(400,432,oTentacleSpider,2,1,1,0.33)
        delaySpawn(208,336,oArmoredBug,2,1,1,0.33)
        delaySpawn(528,208,oArmoredBug,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
      //else if sceneDelay=55 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=5
    {
      if oEnemyRemain.enemyCount<=-3
      {
        with oEnemyRemain {instance_destroy()}
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        //instance_create(432,432,oHealingPost)
        with oExit {y-=160}
        sceneProgress+=1
      }
    }
}
else if false //room=rHexPlat54 and global.gamePaused=false //----- [Unskippable] Enemy Trap -----
{
    if sceneProgress=5
    {
        //too lazy to change the loops
    }
    else if sceneProgress=0
    {
        var enemyCounter;
        enemyCounter=instance_create(0,0,oEnemyRemain)
        enemyCounter.enemyCount=12
        sceneProgress+=1
    }
    else if sceneProgress=1
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      if sceneDelay=30
      {
        delaySpawn(war1,wary,oHammerBro,2,1,1,0.33)
        delaySpawn(war2,wary,oFireBro,2,1,1,0.33)
        delaySpawn(war3,wary,oBoomerBro,2,1,1,0.33)
        delaySpawn(war4,wary,oHammerBro,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
      //else if sceneDelay=125 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and oEnemyRemain.enemyCount<=8
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      if sceneDelay=30
      {
        delaySpawn(war1,wary,oFireBro,2,1,1,0.33)
        delaySpawn(war2,wary,oBoomerBro,2,1,1,0.33)
        delaySpawn(war3,wary,oHammerBro,2,1,1,0.33)
        delaySpawn(war4,wary,oFireBro,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
      //else if sceneDelay=75 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 and oEnemyRemain.enemyCount<=4
    {
      //sceneDelay+=1
      sceneDelay+=1*gDeltaTime //60fps change: per frame
      if sceneDelay=30
      {
        delaySpawn(war1,wary,oBoomerBro,2,1,1,0.33)
        delaySpawn(war2,wary,oHammerBro,2,1,1,0.33)
        delaySpawn(war3,wary,oFireBro,2,1,1,0.33)
        delaySpawn(war4,wary,oBoomerBro,2,1,1,0.33)
        sceneDelay=0; sceneProgress+=1
      }
      //else if sceneDelay=75 {sceneDelay=0; sceneProgress+=1}
    }
    /*else if sceneProgress=4 and oEnemyRemain.enemyCount<=1
    {
      sceneDelay+=1
      if sceneDelay=10
      {
        delaySpawn(576,wary,oBloodTyrant,2,1,1,0.1)
        sceneDelay=0; sceneProgress+=1
      }
      //else if sceneDelay=55 {sceneDelay=0; sceneProgress+=1}
    }*/
    else if sceneProgress=4// and !instance_exists(oBloodTyrant)
    {
      if oEnemyRemain.enemyCount<=0
      {
        with oEnemyRemain {instance_destroy()}
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash)
        tFlash.fadeSpeed=0.2
        with oExit {y-=240}
        sceneProgress+=1
      }
    }
}
else if (room=rJSwitch or room=rDoubleSplit or room=rDoubleSplit2) and global.gamePaused=false
{
    if sceneDelay=8
    {
        with oBlackSolid
        {
            if checkFlag=1
            {
                var red;
                red=instance_create(x,y,oInstaRed)
                red.image_xscale=image_xscale; red.image_yscale=image_yscale
                instance_destroy()
            }
        }
        with oInstaRed
        {
            if checkFlag=1
            {
                var black;
                black=instance_create(x,y,oBlackSolid)
                black.image_xscale=image_xscale; black.image_yscale=image_yscale
                instance_destroy()
            }
        }
        sceneDelay=0
    }
}
else if false //room=rBlackWhite2 and global.gamePaused=false
{
    if sceneProgress=0 and oPlayer1.x>136 and oPlayer1.x<480
    {
        for(i=0;i<385;i+=16)
        {
            instance_create(112,i,oDSSR)
            instance_create(496,i,oDSSR)
        }
        sceneProgress=1   
    }
    else if sceneProgress=1
    {
        //sceneDelay+=1
        sceneDelay+=1*gDeltaTime //60fps change: per frame
        if sceneDelay=1
        {
            delaySpawn(96,384,oOctorok,0,1,1,.5)
            delaySpawn(512,384,oOctorok,0,1,1,.5)
            delaySpawn(80,384,oOctorok,0,1,1,.33)
            delaySpawn(528,384,oOctorok,0,1,1,.33)
            delaySpawn(64,384,oOctorok,0,1,1,.2)
            delaySpawn(544,384,oOctorok,0,1,1,.2)
        }
        /*else if sceneDelay=90
        {
            delaySpawn(96,384,oOctorok,0,1,1,.5)
            delaySpawn(512,384,oOctorok,0,1,1,.5)
            delaySpawn(80,384,oOctorok,0,1,1,.33)
            delaySpawn(528,384,oOctorok,0,1,1,.33)
            var Pill;
            Pill=instance_create(40,136,oCV_BonePillar)
            Pill.image_angle=315
            Pill=instance_create(568,136,oCV_BonePillar)
            Pill.image_angle=45
        }*/
        else if sceneDelay=210
        {
            delaySpawn(96,384,oOctorok,0,1,1,.33)
            delaySpawn(512,384,oOctorok,0,1,1,.33)
            delaySpawn(80,400,oMegaTortoise,0,1,1,.5)
            delaySpawn(544,400,oMegaTortoise,0,1,1,.5)
        }
        else if sceneDelay=285
        {
            sceneDelay=0
            sceneProgress=2
        }
    }
    else if sceneProgress=2
    {
        if !instance_exists(oOctorok) and !instance_exists(oCV_BonePillar) and !instance_exists(oMegaTortoise)
        {
            with oDSSR {instance_destroy()}
            sceneProgress=3
        }
    }
    if sceneProgress mod 3=0 and oPlayer1.x>640 and oPlayer1.x<1120
    {
        var Bar;
        Bar=instance_create(608,0,oEnemyBarrier)
        Bar.image_yscale=25
        Bar=instance_create(1136,0,oEnemyBarrier)
        Bar.image_yscale=25
        delaySpawn(992,400,oDragonKnight,0,1,1,.33)
        sceneProgress=4
    }
    else if sceneProgress=4
    {
        //sceneDelay+=1
        sceneDelay+=1*gDeltaTime //60fps change: per frame
        if sceneDelay=75
        {
            sceneDelay=0
            sceneProgress=5
        }
    }
    else if sceneProgress=5 and !instance_exists(oDragonKnight)
    {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=7
    }
    if sceneProgress mod 7=0 and oPlayer1.x>1264 and oPlayer1.x<1440
    {
        var Bar;
        Bar=instance_create(1248,0,oEnemyBarrier)
        Bar.image_yscale=25
        Bar=instance_create(1456,0,oEnemyBarrier)
        Bar.image_yscale=25
        delaySpawn(1408,400,oMalignantOoze,0,1,1,.33)
        sceneProgress=8
    }
    else if sceneProgress=8
    {
        //sceneDelay+=1
        sceneDelay+=1*gDeltaTime //60fps change: per frame
        if sceneDelay=75
        {
            sceneDelay=0
            sceneProgress=9
        }
    }
    else if sceneProgress=9 and !instance_exists(oMalignantOoze)
    {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=10
    }
    if sceneProgress mod 10=0 and oPlayer1.x>1600 and oPlayer1.x<2000
    {
        var Bar;
        Bar=instance_create(1568,0,oEnemyBarrier)
        Bar.image_yscale=19
        Bar=instance_create(2000,0,oEnemyBarrier)
        Bar.image_yscale=19
        delaySpawn(1872,304,oBloodTyrant,0,1,1,.33)
        sceneProgress=11
    }
    else if sceneProgress=11
    {
        //sceneDelay+=1
        sceneDelay+=1*gDeltaTime //60fps change: per frame
        if sceneDelay=75
        {
            sceneDelay=0
            sceneProgress=12
        }
    }
    else if sceneProgress=12 and !instance_exists(oBloodTyrant)
    {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress=13
    }
}
/*else if room=rReckoningTwo and global.gamePaused=false
{
    if sceneProgress=0 and !instance_exists(oDDD)
    {
        with oMovingPlatform {if x>1800 {xDir=2.5; xVel=2.5; shiftTime=0}}
        sceneProgress=1
    }
}*/
if room=rJSwitch and global.gamePaused=false
{
    if oPlayer1.x>1456 and oPlayer1.x<1904 and sceneProgress=0
    {
        sceneProgress=1
    }
    else if sceneProgress=1
    {
        //lazyDelay+=1
        lazyDelay+=1*gDeltaTime //60fps change: per frame
        if lazyDelay=1
        {
            var bar;
            bar=instance_create(1280,0,oEnemyBarrier)
            bar.image_yscale=60
            bar=instance_create(1936,0,oEnemyBarrier)
            bar.image_yscale=60
        }
        else if lazyDelay=5
        {
            // infected hitscan dude
            delaySpawn(1520,448,oFacDrone,0,1,1,.33)
            delaySpawn(1520,448,oInjectorVirus,0,1,1,.33)
        }
        else if lazyDelay=35
        {
            //vault dude
            delaySpawn(1616,248,oVaultShadow,0,1,1,.33)
        }
        else if lazyDelay=150
        {
            instance_create(1712,320,oCHAOS_Rocketeer)
        }
        else if lazyDelay>=160 {lazyDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 and !instance_exists(oCHAOS_Rocketeer)
    {
        with oEnemyBarrier {instance_destroy()}
        sceneProgress+=1
    }
}
/*else if room=rDoubleSplit and global.gamePaused=false
{
}
else if room=rDoubleSplit2 and global.gamePaused=false
{
}*/
/*if room=rREXa and global.gamePaused=false
{
    if sceneProgress=0
    {
        charDialogue=0
        convo=0
        sceneProgress+=1
    }
    if charDialogue=0 and oPlayer1.x>=100
    {
      msgCreate(0,0,"Jerry","This smells like a boss to me. Can't say I approve of the pointless corridor though.",0,2,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue+=1
    }
    else if charDialogue=1 {convo+=1;if convo>=90 {charDialogue+=1; convo=0}}
    else if charDialogue=2
    {
      msgCreate(0,0,"Jeremy","You're right, there's a boss at the end of this. Care to guess what it is? Not that I'm going to tell you, but you know, just for fun.",0,2,oMessagePerson,0)
      newMessage.fadingTime=120; charDialogue+=1
    }
    //else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
}
else if room=rREXb and global.gamePaused=false
{
    if sceneProgress=0
    {
        charDialogue=0
        convo=0
        sceneProgress+=1
    }
    if charDialogue=0 and oPlayer1.x>=100
    {
      msgCreate(0,0,"Jerry","You think I'm scared? Another round of sparring with Warmaster would be fun, and Shroudler is already dead. I am untouchable.",0,2,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue+=1
    }
    else if charDialogue=1 {convo+=1;if convo>=90 {charDialogue+=1; convo=0}}
    else if charDialogue=2
    {
      msgCreate(0,0,"Claire","You just had to go and jinx it. I really hope it's Shroudler now.",0,2,oMessagePerson,0)
      newMessage.fadingTime=90; charDialogue+=1
    }
    //else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
}
else if room=rREXc and global.gamePaused=false
{
    if sceneProgress=0
    {
        charDialogue=0
        convo=0
        sceneProgress+=1
    }
    if charDialogue=0 and oPlayer1.x>=100
    {
      msgCreate(0,0,"Jerry","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    else if charDialogue=1 {convo+=1;if convo>=45 {charDialogue+=1; convo=0}}
    else if charDialogue=2
    {
      msgCreate(0,0,"Claire","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    else if charDialogue=3 {convo+=1;if convo>=45 {charDialogue+=1; convo=0}}
    else if charDialogue=4
    {
      msgCreate(0,0,"Jeremy","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    else if charDialogue=5 {convo+=1;if convo>=45 {charDialogue+=1; convo=0}}
    else if charDialogue=6
    {
      msgCreate(0,0,"Chao","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    //else if charDialogue=7 {convo+=1;if convo>=90 {charDialogue+=1; convo=0}}
    //if charDialogue=0 and oPlayer1.x>=100
    {
      msgCreate(0,0,"Jerry","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    else if charDialogue=1 and oPlayer1.x>=400
    {
      msgCreate(0,0,"Claire","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    else if charDialogue=2 and oPlayer1.x>=700
    {
      msgCreate(0,0,"Jeremy","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    else if charDialogue=3 and oPlayer1.x>=1000
    {
      msgCreate(0,0,"Chao","...",0,1,oMessagePerson,0)
      newMessage.fadingTime=30; charDialogue+=1
    }
    //else if charDialogue=1 {convo+=1;if convo>=80 {charDialogue+=1; convo=0}}
    else if charDialogue=2
    {
      msgCreate(0,0,"Jeremy","You're right, there's a boss at the end of this. Care to guess what it is? Not that I'm going to tell you, but you know, just for fun.",0,1,oMessagePerson,0)
      newMessage.fadingTime=100; charDialogue+=1
    }
    //else if charDialogue[0]=3 {convo[0]+=1;if convo[0]>=100 {charDialogue[0]+=1; convo[0]=0}}
}
else if room=rREX and global.gamePaused=false
{
    if sceneProgress=0
    {
      oREX.activateBoss=1
      global.currentBoss="REX"
      global.bossTrack=1
      viewFix=instance_create(256,224,oMisc)
      viewFix.type=0
      viewFix.sprite_index=sNull
      view_object[0]=viewFix
      sceneProgress=1
    }
    else if sceneProgress=2  //gotten from killing REX
    {
        sceneDelay+=1
        if global.hexMain=5 {global.hexMain=6}
        global.currentBoss=""
        global.bossTrack=0
        global.newMapX=224; global.newMapY=464; room_goto(rDDLC_PlatHUB)
    }
}*/
