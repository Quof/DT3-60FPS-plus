//(Distorted rewrote most of this event: this is its version, made to work at 60/120fps the way DT3+'s version of the
//original is)
if global.gamePaused=false
{
    if activateBoss=1
    {
        oGlobalEvent.enemyCount=1
        bActive=true
        bShowHealthBar=true
        showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
        activateBoss=2
    }

    if bActive=true and life>0
    {
        if timeTillReHit>0 //Set after dealing damage to Cackletta and keeps the player from falling on her again and taking damage
        {
            //timeTillReHit-=1
            timeTillReHit-=1*gDeltaTime //60fps change: scaled
            if timeTillReHit=0 {bCanDealDamage=true}
        }

        //atkTime+=1
        atkTime+=1*gDeltaTime //60fps change: per frame (it lands on the whole numbers the checks below look for)
        if atkSequence=0 //---------- Attack: Lightning 1 ----------
        {
            if atkTime=1
            {
                if bossProgress=0
                {
                    lightAmt+=2
                    lightWarn-=9
                    lightDecay+=5
                    fireAmt+=2
                    repeatAction=0
                }
                else if bossProgress=1
                {
                    teleAmt+=2
                    atkSequence=2
                    repeatAction=0
                    atkTime=9
                }
                else if bossProgress=2 {atkSequence=8}
                else if bossProgress=3 {atkSequence=9}
            }

            if atkTime=25 {sprite_index=sCacklettaArmSwing}
            else if atkTime=29
            {
                sprite_index=sCacklettaWings
                atkTime+=(bossProgress+2)*3
            }
            else if atkTime=40
            {
                var tAtkLight,tExLightSpan,tAtkAmt;
                tAtkAmt=lightAmt
                if life=1
                    tAtkAmt+=1
                for(i=0;i<tAtkAmt;i+=1)
                {
                    if i=0
                        tAtkLight=instance_create(oPlayer1.x,yGround,oCackLightning)
                    else
                    {
                        tExLightSpan=(xCenter-roomSpan)+random(roomSpan*2)
                        tAtkLight=instance_create(tExLightSpan,yGround,oCackLightning)
                    }
                    tAtkLight.type=i
                    tAtkLight.warnTime=lightWarn
                    tAtkLight.decay=lightDecay
                }
                atkTime+=(bossProgress+2)*3
            }
            else if atkTime=55
            {
                sprite_index=sCacklettaIdle
                atkTime+=(bossProgress+2)*7
            }
            else if atkTime=80 {atkSequence+=1; atkTime=0}
        }
        else if atkSequence=1 //---------- Attack: Fire 1 ----------
        {
            if atkTime=5 {sprite_index=sCacklettaArmSwing}
            else if atkTime=9
            {
                sprite_index=sCacklettaWings
                playSound(global.snd_Fireball,0,0.99,1)
                var tFire;
                for(i=0;i<8;i+=1)
                {
                    tFire=instance_create(x,y-24-random(sprite_height-24),oPassBullet)
                    //if i<3 {tFire.direction=0}
                    //else {tFire.direction=180}
                    if i<3 {tFire._direction=0} //60fps change: DT3+'s oPassBullet moves by its own _direction
                    else {tFire._direction=180} //60fps change
                    tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                    tFire.bulletSpeed=10+random(2); tFire.decayTime=-100
                }
            atkTime+=(bossProgress+2)*4
            }
            else if atkTime=40
            {
                sprite_index=sCacklettaIdle
                var tFire;
                for(i=0;i<fireAmt;i+=1)
                {
                    if i<fireAmt/2
                    {
                        tFire=instance_create(xCenter-roomSpan-68,yGround-8-(i*16),oPassBullet)
                        //tFire.direction=0
                        tFire._direction=0 //60fps change
                    }
                    else
                    {
                        tFire=instance_create(xCenter+roomSpan+68,yGround-8-(i*16),oPassBullet)
                        //tFire.direction=180
                        tFire._direction=180 //60fps change
                    }
                    tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                    tFire.bulletSpeed=1+fireAmt; tFire.decayTime=150
                }
                atkTime+=(bossProgress+2)*5
            }
            else if atkTime=60
            {
                if bossProgress+2=0 {atkSequence=100}
                else if bossProgress+2=1 {atkSequence+=1}
                else if bossProgress+2=2
                {
                    repeatAction+=1
                    if repeatAction=2
                    {
                        repeatAction=0
                        atkSequence+=1
                    }
                }
                atkTime=0
            }
        }
        else if atkSequence=2 //---------- Attack: Lightning 2 ----------
        {
            if atkTime=10 {sprite_index=sCacklettaArmSwing}
            else if atkTime=14
            {
                sprite_index=sCacklettaWings
                atkTime+=(bossProgress+2)*5
            }
            else if atkTime=40
            {
                var tAtkLight,tExLightSpan;
                for(i=0;i<lightAmt;i+=1)
                {
                    if i=0
                        tAtkLight=instance_create(oPlayer1.x,yGround,oCackLightning)
                    else
                    {
                        tExLightSpan=(xCenter-roomSpan)+random(roomSpan*2)
                        tAtkLight=instance_create(tExLightSpan,yGround,oCackLightning)
                    }
                    tAtkLight.type=i
                    tAtkLight.warnTime=lightWarn
                    tAtkLight.decay=lightDecay
                }
                atkTime+=(bossProgress+2)*4
            }
            else if atkTime=60
            {
                repeatAction+=1
                if repeatAction=(bossProgress+2)*2
                {
                    sprite_index=sCacklettaIdle
                    repeatAction=0
                    atkSequence+=2 // skip fire rain
                }
                atkTime=0
            }
        }
        else if atkSequence=4 //---------- Attack: Teleport Lightning ----------
        {
            if atkTime=1 //Choose new location
            {
                newLoc=lightTeleX[currentTele]
                currentTele+=1
                if currentTele>=5 {currentTele=0}
                if life=1 {atkTime+=5} //(one-off skip ahead, so not scaled)
            }
            else if atkTime>=20 and atkTime<=90 //Go to new location
            {
                var tMoveSpd;
                if life=1 {tMoveSpd=16}
                else {tMoveSpd=8}
                //if x<newLoc {x+=tMoveSpd}
                //else {x-=tMoveSpd}
                if x<newLoc {x+=tMoveSpd*gDeltaTime; if gDeltaTime!=1 and x>newLoc {x=newLoc}} //60fps change (DT3+'s): per frame, stopping exactly on newLoc above 30fps
                else {x-=tMoveSpd*gDeltaTime; if gDeltaTime!=1 and x<newLoc {x=newLoc}} //60fps change (see above)

                if oGame.time mod (1/gDeltaTime)=0 { //60fps change (DT3+'s): one afterimage per 30fps tick
                var tAfterI;
                tAfterI=instance_create(x,y,oEnemyAfterImage)
                tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index
                tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
                tAfterI.imageFade=0.15; ; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
                tAfterI.depth=depth+0.1; //(DT3+'s)
                } //60fps change (added)

                if x=newLoc {atkTime=100}
            }
            else if atkTime=102 //Anim start (And fire from side on bottom)
            {
                sprite_index=sCacklettaArmSwing
                if halfTimeFloorFire mod 2=0
                {
                    floorFireSide+=1
                    if floorFireSide mod 2=0
                    {
                        tFire=instance_create(xCenter-roomSpan-68,yGround-8,oPassBullet)
                        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                        tFire.bulletSpeed=5; tFire.decayTime=150
                    }
                    else
                    {
                        tFire=instance_create(xCenter+roomSpan+68,yGround-8,oPassBullet)
                        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                        //tFire.bulletSpeed=5; tFire.decayTime=150; tFire.direction=180
                        tFire.bulletSpeed=5; tFire.decayTime=150; tFire._direction=180 //60fps change
                    }
                }
            }
            else if atkTime=106 //Use lightning
            {
                sprite_index=sCacklettaWings
                var tAtkLight;
                tAtkLight=instance_create(oPlayer1.x,yGround,oCackLightning)
                tAtkLight.type=0; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
                if repeatAction mod 2=0
                {
                    var tAtkLight;
                    tAtkLight=instance_create(x,yGround,oCackLightning)
                    tAtkLight.type=1; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
                }
                else
                {
                    var tAtkLight;
                    tAtkLight=instance_create(x-24,yGround,oCackLightning)
                    tAtkLight.type=1; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
                    tAtkLight=instance_create(x+24,yGround,oCackLightning)
                    tAtkLight.type=1; tAtkLight.warnTime=lightWarn+3; tAtkLight.decay=lightDecay-3
                }
            }
            else if atkTime=112 //Repeat
            {
                sprite_index=sCacklettaIdle
                halfTimeFloorFire+=1
                repeatAction+=1
                if repeatAction=teleAmt
                {
                    repeatAction=0
                    newLoc=xCenter
                    atkTime=115
                }
                else {atkTime=0}
            }
            else if atkTime>=120 and atkTime<=190 //Go to middle
            {
                var tMoveSpd;
                if life=1 {tMoveSpd=16}
                else {tMoveSpd=8}
                //if x<newLoc {x+=tMoveSpd}
                //else {x-=tMoveSpd}
                if x<newLoc {x+=tMoveSpd*gDeltaTime; if gDeltaTime!=1 and x>newLoc {x=newLoc}} //60fps change (DT3+'s): per frame, stopping exactly on newLoc above 30fps
                else {x-=tMoveSpd*gDeltaTime; if gDeltaTime!=1 and x<newLoc {x=newLoc}} //60fps change (see above)

                if oGame.time mod (1/gDeltaTime)=0 { //60fps change (DT3+'s): one afterimage per 30fps tick
                var tAfterI;
                tAfterI=instance_create(x,y,oEnemyAfterImage)
                tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index
                tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0
                tAfterI.imageFade=0.15; ; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
                tAfterI.depth=depth+0.1; //(DT3+'s)
                } //60fps change (added)

                if x=newLoc
                {
                    if life=1 {halfTimeFloorFire=1; floorFireSide=0; atkSequence+=1}
                    else {atkSequence=100}
                    atkTime=0
                }
            }
        }
        else if atkSequence=5 //---------- Attack: Platform Lightning ----------
        {
            if atkTime=20 {sprite_index=sCacklettaLaugh}
            else if atkTime=25 //Choose location
            {
                locA=0; locAnum=0
                locB=0; locBnum=0
                if repeatAction=0 {locA=296; locAnum=4} //1
                else if repeatAction=1 {locA=424; locAnum=6} //2
                else if repeatAction=2 {locA=584; locAnum=4} //3
                else if repeatAction=3 {locA=296; locAnum=4; locB=424; locBnum=6} //1,2
                else if repeatAction=4 {locA=296; locAnum=4; locB=584; locBnum=4} //1,3
                else if repeatAction=5 {locA=424; locAnum=6; locB=584; locBnum=4} //2,3
                else if repeatAction=6 {locA=296; locAnum=4; locB=584; locBnum=4} //1,3
                else if repeatAction=7 {locA=424; locAnum=6; locB=584; locBnum=4} //2,3
                else if repeatAction=8 {locA=296; locAnum=4; locB=424; locBnum=6} //1,2
            }
            else if atkTime=30 //Use lightning
            {
                var tAtkLight;
                for(i=0;i<locAnum;i+=1)
                {
                    tAtkLight=instance_create(locA+(i*16),yGround,oCackLightning)
                    tAtkLight.type=i; tAtkLight.warnTime=lightWarn+30; tAtkLight.decay=lightDecay-5
                }
                for(i=0;i<locBnum;i+=1)
                {
                    tAtkLight=instance_create(locB+(i*16),yGround,oCackLightning)
                    tAtkLight.type=1; tAtkLight.warnTime=lightWarn+30; tAtkLight.decay=lightDecay-5
                }
            }
            else if atkTime=60 //Fire from side on bottom
            {
                if halfTimeFloorFire mod 2=0
                {
                    floorFireSide+=1
                    if floorFireSide mod 2=0
                    {
                        for(i=0;i<2;i+=1)
                        {
                        tFire=instance_create(xCenter-roomSpan-68,yGround-8-(i*20),oPassBullet)
                        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                        tFire.bulletSpeed=5; tFire.decayTime=150
                        }
                    }
                    else
                    {
                        for(i=0;i<2;i+=1)
                        {
                            tFire=instance_create(xCenter+roomSpan+68,yGround-8-(i*20),oPassBullet)
                            tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                            //tFire.bulletSpeed=5; tFire.decayTime=150; tFire.direction=180
                            tFire.bulletSpeed=5; tFire.decayTime=150; tFire._direction=180 //60fps change
                        }
                    }
                }
                halfTimeFloorFire+=1
                repeatAction+=1
                if repeatAction=9
                {
                    halfTimeFloorFire=1; floorFireSide=0
                    repeatAction=0
                    atkSequence=100
                }
                atkTime=0
            }
        }
        else if atkSequence=8 //---------- Attack: Vajra of Perfect Buddhism ----------
        {
            if atkTime=15 {sprite_index=sCacklettaArmSwing}
            else if atkTime=19 {sprite_index=sCacklettaWings}
            else if atkTime=20 //warning signs & bats on delaySpawn
            {
                var watchout;
                watchout=instance_create(464,256,oEfWarningPopup)
                watchout.warnMax=30
                watchout.image_xscale=0.5; watchout.image_yscale=0.5
                delaySpawn(x-vajraFar,vajraLow,oMagicalBat,0,1,1,0.5)
                delaySpawn(x+vajraFar,vajraLow,oMagicalBat,0,1,1,0.5)
                delaySpawn(x-vajraClose,vajraHigh,oMagicalBat,0,1,1,0.5)
                delaySpawn(x+vajraClose,vajraHigh,oMagicalBat,0,1,1,0.5)
                delaySpawn(x,112,oMagicalBat,0,1,1,0.5)
            }
            else if atkTime=50 //spawn lasers (two) with sound //middle is x,y-24 // angles 90 and 270, yscale=2, handlasers
            {
                playSound(global.snd_Shock,0,0.9,1)
                laserUp=instance_create(x,y-24,oFNHandLaser)
                laserUp.atkPower=4; laserUp.image_angle=90; laserUp.image_yscale=3
                laserDown=instance_create(x,y-24,oFNHandLaser)
                laserDown.atkPower=4; laserDown.image_angle=270; laserDown.image_yscale=3
                if oPlayer1.x>x {laserDir=-1} // makes sure to immediately chase the player off the bottom platform
            }
            else if atkTime>50 and atkTime<=970
            {
                //rotation with more if blocks
                //(60fps change: each turn below is per frame, times gDeltaTime)
                if atkTime<=200
                {
                    laserUp.image_angle-=laserDir*2*sin(((atkTime-50)/150)*pi/4)*gDeltaTime
                    laserDown.image_angle-=laserDir*2*sin(((atkTime-50)/150)*pi/4)*gDeltaTime
                } // roughly 112.58 degrees so far
                else if atkTime<=360
                {
                    laserUp.image_angle-=laserDir*2*gDeltaTime
                    laserDown.image_angle-=laserDir*2*gDeltaTime
                } // one 180 plus two times 70, the next "cooldown" brings it to roughly vertical
                else if atkTime<=510{
                    laserUp.image_angle-=laserDir*2*(sin(((511-atkTime)/150)*pi/4))*gDeltaTime
                    laserDown.image_angle-=laserDir*2*(sin(((511-atkTime)/150)*pi/4))*gDeltaTime
                } // back to zero "speed"
                else if atkTime<=660{
                    laserUp.image_angle+=laserDir*2*sin(((atkTime-510)/150)*pi/4)*gDeltaTime
                    laserDown.image_angle+=laserDir*2*sin(((atkTime-510)/150)*pi/4)*gDeltaTime
                }
                else if atkTime<=820{
                    laserUp.image_angle+=laserDir*2*gDeltaTime
                    laserDown.image_angle+=laserDir*2*gDeltaTime
                }
                else if atkTime<=920{
                    laserUp.image_angle+=laserDir*2*gDeltaTime
                    laserDown.image_angle+=laserDir*2*gDeltaTime
                }
                //else if atkTime<=970 {laserUp.image_angle+=laserDir*2*(1-sin(((atkTime-970)/150)*pi/4)); laserDown.image_angle+=laserDir*2*(1-sin(((atkTime-970)/150)*pi/4))}
            }
            if atkTime>860 and atkTime<=920
            {
                //laserUp.image_yscale-=0.05
                //laserDown.image_yscale-=0.05
                laserUp.image_yscale-=0.05*gDeltaTime //60fps change: per frame
                laserDown.image_yscale-=0.05*gDeltaTime //60fps change: per frame
            }
            else if atkTime=921
            {
                with laserUp {instance_destroy()}
                with laserDown {instance_destroy()}
            }
            else if atkTime=951
            {
                with oMagicalBat
                {
                    var death;
                    death=instance_create(x,y+8,oCackLightning)
                    death.type=oCackletta.deathC
                    death.warnTime=oCackletta.lightWarn
                    death.decay=oCackletta.lightDecay
                    oCackletta.deathC+=1
                }
            }
            else if atkTime=980
            {
                with oMagicalBat
                {
                    var poof;
                    poof=instance_create(x,y,oEffect)
                    poof.sprite_index=sMMSmokeCloud
                    poof.image_speed=0.2; poof.image_xscale=1.5; poof.image_yscale=1.5
                    poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=0; poof.ySpd=0
                    instance_destroy()
                }
                atkSequence=100; atkTime=0
            }
        }
        else if atkSequence=9 //---------- Attack: Fun with Bats ----------
        {
            if atkTime=15 {sprite_index=sCacklettaArmSwing}
            else if atkTime=19 {sprite_index=sCacklettaWings}
            else if atkTime=20
            {
                for(i=2;i<7;i+=1)
                {
                    delaySpawn(x-i*phaseLastDist,phaseLastLow,oMagicalBat,0,1,1,0.33)
                    delaySpawn(x+i*phaseLastDist,phaseLastLow,oMagicalBat,0,1,1,0.33)
                }
            }
            else if atkTime=50 // warning signs on ground level
            {
                sprite_index=sCacklettaLaugh
                for(i=0;i<3;i+=1)
                {
                    for(j=0;j<4;j+=1)
                    {
                        var poof;
                        poof=instance_create(x-16+i*16,y-j*16,oEffect)
                        poof.sprite_index=sMMSmokeCloud
                        poof.image_speed=0.2; poof.image_xscale=1.5; poof.image_yscale=1.5
                        poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=1-random(2); poof.ySpd=1-random(2)
                    }
                }
                bCanDealDamage=false
                image_alpha=0.25
                var watchout;
                for(i=0;i<3;i+=1)
                {
                    watchout=instance_create(x-32+i*32,256,oEfWarningPopup)
                    watchout.warnMax=30
                    watchout.image_xscale=0.5; watchout.image_yscale=0.5
                }
            }
            else if atkTime=80
            {
                // spikes, last bat
                delaySpawn(x,phaseLastLow,oMagicalBat,0,1,1,0.67)
                delaySpawn(x-phaseLastDist,phaseLastLow,oMagicalBat,0,1,1,0.67)
                delaySpawn(x+phaseLastDist,phaseLastLow,oMagicalBat,0,1,1,0.67)
                for(i=0;i<8;i+=1)
                {
                    delaySpawn(400+i*16,256,oMarioSpikeFloor,0,1,1,1)
                }
            }
            // rain lasts until 270
            else if atkTime>240 and atkTime<=840
            {
                if atkTime mod 50 = 0 // aimed things
                {
                    var tFire;
                    tFire=instance_create(oPlayer1.x,-4,oPassBullet)
                    //tFire.direction=270; tFire.sprite_index=sBowserFire1
                    tFire._direction=270; tFire.sprite_index=sBowserFire1 //60fps change
                    tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                    tFire.bulletSpeed=4; tFire.decayTime=150
                }
                else if (atkTime mod 50 = 20) or (atkTime mod 50 = 40)
                {
                    var tFire;
                    tFire=instance_create(xCenter+laserDir*(roomSpan+68),oPlayer1.y-12,oPassBullet)
                    //tFire.direction=90*(1+laserDir); tFire.sprite_index=sBowserFire1
                    tFire._direction=90*(1+laserDir); tFire.sprite_index=sBowserFire1 //60fps change
                    tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                    tFire.bulletSpeed=4; tFire.decayTime=150

                    laserDir*=-1
                }
            }
            else if atkTime>841 and atkTime<=840+wallTime*6
            {
                if atkTime mod 40 = 0 // aimed lightning
                {
                    var aimL;
                    aimL=instance_create(oPlayer1.x,yGround,oCackLightning)
                    aimL.type=0
                    aimL.warnTime=lightWarn
                    aimL.decay=lightDecay
                }
                // walls; 3 from the right, then three from the left, alternating up and down, starting down
                //(60fps change: _direction for direction below, which DT3+'s oPassBullet moves by)
                if atkTime=840+wallTime or atkTime=840+3*wallTime
                {
                    var tFire;
                    for(i=0;i<5;i+=1)
                    {
                        tFire=instance_create(xCenter+roomSpan+68,yGround-8-(i*20),oPassBullet)
                        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                        tFire.bulletSpeed=wallSpeed; tFire.decayTime=150
                        tFire._direction=180
                    }
                }
                else if atkTime=840+2*wallTime
                {
                    var tFire;
                    for(i=5;i<10;i+=1)
                    {
                        tFire=instance_create(xCenter+roomSpan+68,yGround-8-(i*20),oPassBullet)
                        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                        tFire.bulletSpeed=wallSpeed; tFire.decayTime=150
                        tFire._direction=180
                    }
                }
                else if atkTime=840+4*wallTime or atkTime=840+6*wallTime
                {
                    var tFire;
                    for(i=5;i<10;i+=1)
                    {
                        tFire=instance_create(xCenter-roomSpan-68,yGround-8-(i*20),oPassBullet)
                        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                        tFire.bulletSpeed=wallSpeed; tFire.decayTime=150
                        tFire._direction=0
                    }
                }
                else if atkTime=840+5*wallTime
                {
                    var tFire;
                    for(i=0;i<5;i+=1)
                    {
                        tFire=instance_create(xCenter-roomSpan-68,yGround-8-(i*20),oPassBullet)
                        tFire.sprite_index=sBowserFire1; tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                        tFire.bulletSpeed=wallSpeed; tFire.decayTime=150
                        tFire._direction=0
                    }
                }
            }
            else if atkTime=840+wallTime*6+61
            {
                sprite_index=sCacklettaIdle
                var watchout;
                watchout=instance_create(x,y-48,oEfWarningPopup)
                watchout.warnMax=60
                with oMagicalBat
                {
                    if abs(x-oCackletta.x)<50   // five middle bats
                    {
                        var death;
                        death=instance_create(x,y+8,oCackLightning)
                        death.type=oCackletta.deathC
                        death.warnTime=oCackletta.lightWarn
                        death.decay=oCackletta.lightDecay
                        oCackletta.deathC+=1
                    }
                }
                deathC=0
            }
            else if atkTime=840+wallTime*6+91
            {
                with oMagicalBat
                {
                    if abs(x-oCackletta.x)<50   // five middle bats
                    {
                        var poof;
                        poof=instance_create(x,y,oEffect)
                        poof.sprite_index=sMMSmokeCloud
                        poof.image_speed=0.2; poof.image_xscale=1.5; poof.image_yscale=1.5
                        poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=0; poof.ySpd=0
                        instance_destroy()
                    }
                }
                with oMarioSpikeFloor // kill spikes with smoke
                {
                    var poof;
                    poof=instance_create(x,y,oEffect)
                    poof.sprite_index=sMMSmokeCloud
                    poof.image_speed=0.2; poof.image_xscale=1.5; poof.image_yscale=1.5
                    poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=0; poof.ySpd=0
                    instance_destroy()
                }
            }
            else if atkTime=840+wallTime*6+121  // Cackletta reappears
            {
                for(i=0;i<3;i+=1)
                {
                    for(j=0;j<4;j+=1)
                    {
                        var poof;
                        poof=instance_create(x-16+i*16,y-j*16,oEffect)
                        poof.sprite_index=sMMSmokeCloud
                        poof.image_speed=0.2; poof.image_xscale=1.5; poof.image_yscale=1.5
                        poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=1-random(2); poof.ySpd=1-random(2)
                    }
                }
                image_alpha=1
                bCanDealDamage=true
            }
            else if atkTime=840+wallTime*6+181
            {
                sprite_index=sCacklettaArmSwing
            }
            else if atkTime=840+wallTime*6+185
            {
                sprite_index=sCacklettaWings
                deathC=0
                with oMagicalBat
                {
                    var death;
                    death=instance_create(x,y+8,oCackLightning)
                    death.type=oCackletta.deathC
                    death.warnTime=oCackletta.lightWarn
                    death.decay=oCackletta.lightDecay
                    oCackletta.deathC+=1
                }
            }
            else if atkTime=840+wallTime*6+215
            {
                sprite_index=sCacklettaIdle
                with oMagicalBat
                {
                    var poof;
                    poof=instance_create(x,y,oEffect)
                    poof.sprite_index=sMMSmokeCloud
                    poof.image_speed=0.2; poof.image_xscale=1.5; poof.image_yscale=1.5
                    poof.newBlend=-1; poof.followID=-1; poof.decay=-100; poof.xSpd=0; poof.ySpd=0
                    instance_destroy()
                }
            }
            else if atkTime>840+wallTime*6+245
            {
                atkTime=0
                atkSequence=100
            }
        }
        else if atkSequence=100 //---------- Summon bats and bring out phone ----------
        {
            if atkTime=25
            {
                sprite_index=sCacklettaArmSwing
                myBats=4
            }
            else if atkTime=29
            {
                sprite_index=sCacklettaWings
                var tBat;
                for(i=0;i<8;i+=1)
                {
                    tBat=instance_create(x,y-(sprite_height/2),oCackBat)
                    tBat.type=0; tBat.xSpd=random_range(-2.5,2.5); tBat.ySpd=random(1)
                }
            }
            else if atkTime=60
            {
                sprite_index=sCacklettaPhone1; image_index=0
                bCanTakeDamage=true
            }
            else if atkTime>=61
            {
                if image_index>=3.6
                {
                    sprite_index=sCacklettaPhone2; image_index=0
                    atkSequence+=1
                    atkTime=0
                }
            }
        }
        else if atkSequence=101 //---------- Use phone and spawn bats from side ----------
        {
            if atkTime=15
            {
                var tBat;
                for(i=0;i<4;i+=1)
                {
                    if i<=1 //left
                    {
                        tBat=instance_create(xCenter-roomSpan-68,yGround-32-random(32),oCackBat)
                        tBat.xSpd=2+i
                    }
                    else //right
                    {
                        tBat=instance_create(xCenter+roomSpan+68,yGround-32-random(32),oCackBat)
                        tBat.xSpd=-2-i
                    }
                    tBat.type=1
                }
                atkTime+=bossProgress*15
            }
            else if atkTime=150
            {
                sprite_index=sCacklettaIdle
                bCanTakeDamage=false
                atkSequence=0; atkTime=0
            }
        }

        if (bossProgress=1 and atkSequence=4) or (bossProgress=3 and atkSequence=9 and atkTime>=80) //---------- Attack: Fire 2 ----------
        {
            if atkTime=5 {} //sprite_index=sCacklettaArmSwing}
            else if atkTime=9
            {
                //sprite_index=sCacklettaWings
                playSound(global.snd_Fireball,0,0.99,1)
                var tFire;
                for(i=0;i<16;i+=1)
                {
                    tFire=instance_create(x,y-24-random(sprite_height-24),oPassBullet)
                    //if i mod 2=0 {tFire.direction=42+i}
                    //else {tFire.direction=138-i}
                    if i mod 2=0 {tFire._direction=42+i} //60fps change
                    else {tFire._direction=138-i} //60fps change
                    tFire.sprite_index=sBowserFire1
                    tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                    tFire.bulletSpeed=6+random(3); tFire.decayTime=-100
                }
                //atkTime+=bossProgress*3
            }
            else if atkTime=35 {} //sprite_index=sCacklettaLaugh}
            else if atkTime>=40 and atkTime<=150+(bossProgress*40)
            {
                if atkTime mod (8+4*(bossProgress-1))=0
                {
                    playSound(global.snd_Fireball,0,0.98,1)
                    var tFire,tRanX;
                    tRanX=(xCenter-roomSpan+16)+random(roomSpan*2-32)
                    tFire=instance_create(tRanX,-4,oPassBullet)
                    //tFire.direction=260+random(20); tFire.sprite_index=sBowserFire1
                    tFire._direction=260+random(20); tFire.sprite_index=sBowserFire1 //60fps change
                    tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                    tFire.bulletSpeed=1+(fireAmt*1.25); tFire.decayTime=150

                    tFire=instance_create(oPlayer1.x,-4,oPassBullet)
                    //tFire.direction=270; tFire.sprite_index=sBowserFire1
                    tFire._direction=270; tFire.sprite_index=sBowserFire1 //60fps change
                    tFire.atkPower=atkPower; tFire.damageType="ELEMENTAL"
                    tFire.bulletSpeed=4; tFire.decayTime=150
                }
            }
            /*else if atkTime=160+(bossProgress*40)
            {
                sprite_index=sCacklettaIdle
                atkTime+=bossProgress*2
            }
            else if atkTime>=170+(bossProgress*40)
            {
                if bossProgress=1 {atkSequence=100}
                else if bossProgress=2 {atkSequence+=1}
                atkTime=0
            }*/
        }


        //Floor movement
        if floorSeq>=1 and floorSeq<=2
        {
            if floorSeq=1
            {
                var tEffect;
                for(i=0;i<8;i+=1) // moved to the walls
                {
                    tEffect=instance_create(344-48,280+(i*12),oEffect)
                    tEffect.sprite_index=sMMSmokeCloud
                    tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
                    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

                    tEffect=instance_create(584+48,280+(i*12),oEffect)
                    tEffect.sprite_index=sMMSmokeCloud
                    tEffect.image_speed=0.15+random(0.15); tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
                    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
                }
                (132430).yVel=1
                floorSeq=2
            }
            //tile_layer_shift(999999,0,1)
            if gDeltaDoTicks tile_layer_shift(999999,0,1) //60fps change (DT3+'s): 1px per 30fps tick
            if !instance_exists((132430))
            {
                oMarioLava.depth=10
                tile_layer_depth(1000010,10)
                tile_layer_delete(999999)
                floorSeq=3
            }
        }

        //---------- Boss Difficulty Curve ----------
        if bossProgress=0 and life=3
        {
            bossProgress+=1
            //floorSeq=1?
        }
        else if bossProgress=1 and life=2
        {
            bossProgress+=1
            floorSeq=1
        }
        else if bossProgress=2 and life=1
        {
            bossProgress+=1
        }
    }
    else if life<=0 //Defeat animation
    {
        //atkTime+=1
        atkTime+=1*gDeltaTime //60fps change: per frame
        if atkSequence=0 //Fall to the floor
        {
            if atkTime mod 5=0
            {
                var tEffect;
                for(i=0;i<6;i+=1)
                {
                    tEffect=instance_create(x-12+random(24),bbox_bottom-4-random(sprite_height-8),oKillEffect)
                    tEffect.speed=5; tEffect.direction=random(360); tEffect.friction=0.1+random(0.3)
                    tEffect.fadeAlpha=0.04+random(0.02); tEffect.imageRot=random_range(-5,5)
                }
            }
            //if y<yGround {y+=1}
            if y<yGround and gDeltaDoTicks {y+=1} //60fps change (DT3+'s): 1px per 30fps tick

            if atkTime>=105 {atkTime=0; atkSequence+=1}
        }
        else if atkSequence=1 //Slight wait
        {
            if atkTime>=30 {atkSequence+=1}
        }
        else if atkSequence=2 //Fade away
        {
            if atkTime mod 2=0
            {
                var tEffect;
                for(i=0;i<5;i+=1)
                {
                    tEffect=instance_create(bbox_left+random(sprite_width),bbox_bottom+1+random(4),oKillEffect)
                    tEffect.speed=6; tEffect.direction=80+random(20)
                    tEffect.friction=0.2+random(0.6); tEffect.image_xscale=0.3+random(0.2); tEffect.image_yscale=0.3+random(0.2)
                    tEffect.image_blend=make_color_rgb(173,73,222); tEffect.fadeAlpha=0.04+random(0.04)
                    tEffect.imageRot=0
                }
            }
            //hLineEffect+=0.25
            hLineEffect+=0.25*gDeltaTime //60fps change: per frame
            if hLineEffect>=29 {atkTime=0; atkSequence+=1}
        }
        else if atkSequence=3 //Slight wait
        {
            if atkTime>=30 {atkSequence+=1}
        }
        else if atkSequence=4
        {
            if global.bBossGallery=1
            {
                bossRoomTally(1)
                global.newMapX=408; global.newMapY=1376; room_goto(rBossGallery)
            }
            else {instance_destroy()}
        }
    }
    enemyStepEvent()
}
