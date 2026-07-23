#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
eName="Aqua Serpent"
eLevel=8
maxLife=3500
life=maxLife
atkPower=5
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
dieEffect=0
bossProgress=0
activateBoss=0
moveBehavior=1
floorSeq=0

moveSpd=4
moveSide=1
movePath=1
moveProg=-10
moveDir=0

spdChg=4

bWaterRise=1
waterAltSpd=-2
doubleBack=0

bBombOnly=1

deathAnim=0

jeremyText="This is all sorts of bad, but unfortunately I can't give you much info on it right now. Whoever that was is blocking me out of this thing's behavior data. All I can tell you at this time is the sprite is from Castlevania. Meh, mixed sprite usage is nothing new. Chao shouldn't be locked out."
chaoText="The serpent cycles through 3 attack patterns. The first, it goes overhead, no direct attack to you, get some hits in. The second, it does a wave pattern through the field. The third, it will stop and fire 5 energy shots out of its mouth. There's some obfuscated data, so I know there's more than just this."
devText="This boss fight presented some nifty issues during implementation, but it's fun to figure out how to fix those issues or circumvent them in some way. Many boss encounters in this have taken me longer simply because I'm trying a lot of new things. Since DT is also about experimentation, I feel I should always be doing this."

for(i=0;i<20;i+=1)
{
  bodyPart[i]=instance_create(x,y,oAquaSer_Body)
  bodyPart[i].bodySeg=i
  bodyPart[i].depth=depth+i+1
}
roomBorderTop=-416
roomBorderBottom=room_height+416
roomBorderLeft=-224
roomBorderRight=1088
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
    //---------- Movement ----------
    if direction>=90 and direction<=269
      image_xscale=-1
    else
      image_xscale=1

    moveProg+=1
    if movePath=1 //----- Move Path: Arc over platform, from one end to other
    {
      if moveProg=1 //Setup, choose direction
      {
        moveSpd=spdChg
        moveDir=90
        var tYPosTemp; tYPosTemp=396
        y=tYPosTemp; oAquaSer_Body.y=tYPosTemp
        if moveSide=1 {x=640; oAquaSer_Body.x=640}
        else {x=208; oAquaSer_Body.x=208}
      }
      else if moveProg>=2 and moveProg<=999 //Arc
      {
        direction=moveDir; speed=moveSpd
        if moveSide=1
          moveDir+=(0.6+(moveSpd/8))
        else
          moveDir-=(0.6+(moveSpd/8))

        if moveProg>100 and y>room_height+32
          moveProg=1000
      }
      else if moveProg>=1000 //End
      {
        direction=270; speed=moveSpd;
        if y>roomBorderBottom
        {
          moveProg=0; moveSide*=-1; movePath+=1
          if floorSeq=1
            floorSeq+=1
        }
      }
    }
    else if movePath=2 //----- Move Path: Wave across screen
    {
      if moveProg=1 //Setup, choose direction
      {
        moveSpd=spdChg
        y=196; oAquaSer_Body.y=196
        moveDir=45; waveMo=0; tTemp=0
        if moveSpd>=1 and moveSpd<=3
          {waveSpd=0.1; waveMax=2}
        else if moveSpd>=3.1 and moveSpd<=5
          {waveSpd=0.2; waveMax=4}
        else if moveSpd>=5.1 and moveSpd<=7
          {waveSpd=0.5; waveMax=6.5}
        else if moveSpd>=7.1
          {waveSpd=0.8; waveMax=8}

        var tXPosTemp;
        if moveSide=1 {var tXPosTemp; tXPosTemp=728}
        else {var tXPosTemp; tXPosTemp=136}
        x=tXPosTemp; oAquaSer_Body.x=tXPosTemp
      }
      else if moveProg>=2 //Wave across
      {
        if moveSide=1 //Left
          hspeed=-(moveSpd-abs(tTemp/3))
        else
          hspeed=moveSpd-abs(tTemp/3)
        vspeed=tTemp

        if waveMo=0 //Wave down
        {
          tTemp+=waveSpd
          if tTemp>waveMax
            waveMo=1
        }
        else if waveMo=1 //Wave up
        {
          tTemp-=waveSpd
          if tTemp<-waveMax
            waveMo=0
        }

        if x>=roomBorderRight or x<=roomBorderLeft //End
        {
          moveProg=0; moveSide*=-1; movePath+=1
          if floorSeq=1
            floorSeq+=1
        }
      }
    }
    else if movePath=3 //----- Move Path: Across top and fire down
    {
      if moveProg=1 //Setup, choose direction
      {
        moveSpd=spdChg
        var tYPosTemp; tYPosTemp=112
        y=tYPosTemp; oAquaSer_Body.y=tYPosTemp

        var tXPosTemp;
        if moveSide=1 {var tXPosTemp; tXPosTemp=704; moveDir=180}
        else {var tXPosTemp; tXPosTemp=112; moveDir=0}
        x=tXPosTemp; oAquaSer_Body.x=tXPosTemp
      }
      else if moveProg>=2 and moveProg<=999 //Glide across
      {
        speed=moveSpd; direction=moveDir
        if moveSide=1 //Left
        {
          moveDir+=0.1
          if x<=480 {moveProg=2000}
        }
        else //Right
        {
          moveDir-=0.1
          if x>=384 {moveProg=2000}
        }
      }
      else if moveProg=2001 //Stop
      {
        speed=0
        moveBehavior=0
        sprite_index=sAquaSer_HeadC
      }
      else if moveProg=2025 //Fire
      {
        playSound(global.snd_RidleyFire,0,1,14000)
        var tFire,tDir;
        tDir=player_sprite_center()
        tDir-=40
        for(i=0;i<5;i+=1)
        {
          tFire=instance_create(x,y,oPassBullet)
          tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
          tFire.image_xscale=2.5; tFire.image_yscale=2.5
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          tDir+=20
        }
      }
      else if moveProg>=2050 and moveProg<=2499 //Continue across, find x
      {
        if moveProg=2050 {moveBehavior=1; sprite_index=sAquaSer_HeadA}

        speed=moveSpd; direction=moveDir
        if moveSide=1 //Left
        {
          moveDir+=0.2
          if x<=304 {sprite_index=sAquaSer_HeadC; moveProg=3000}
        }
        else //Right
        {
          moveDir-=0.2
          if x>=560 {sprite_index=sAquaSer_HeadC; moveProg=3000}
        }
      }
      else if moveProg>=3001 and moveProg<=3499 //Continue across, fire
      {
        speed=moveSpd; direction=moveDir

        if moveProg=3021
        {
          playSound(global.snd_RidleyFire,0,1,18000)
          var tFire,tDir;
          tDir=player_sprite_center()
          tFire=instance_create(x,y,oPassBullet)
          tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
          tFire.image_xscale=3; tFire.image_yscale=3
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          sprite_index=sAquaSer_HeadA
        }

        if moveSide=1 {moveDir+=0.2}
        else {moveDir-=0.2}

        if x>=roomBorderRight or x<=roomBorderLeft //End
        {
          moveProg=0; moveSide*=-1; movePath=1
          if floorSeq=1 {floorSeq+=1}
        }
      }
    }
    else if movePath=4 //----- Move Path: Swim across bottom and fire water shots up
    {
      if moveProg=1 //Setup, choose direction
      {
        moveSpd=6
        var tYPosTemp; tYPosTemp=304
        y=tYPosTemp; oAquaSer_Body.y=tYPosTemp
        tTemp=0

        var tXPosTemp;
        if moveSide=1 {var tXPosTemp; tXPosTemp=704; moveDir=180}
        else {var tXPosTemp; tXPosTemp=112; moveDir=0}
        x=tXPosTemp; oAquaSer_Body.x=tXPosTemp
      }
      else if moveProg>=2 and moveProg<=999 //Swim across
      {
        speed=moveSpd; direction=moveDir
        if moveSide=1 //----- Left -----
        {
          moveDir+=0.1
          if x<=432 and tTemp=0
          {
            bodyPart[0].fireTime=bodyPart[0].fireDelay+39
            bodyPart[19].fireTime=bodyPart[19].fireDelay+39
            tTemp+=1
          }

          if x<=272 and tTemp=1
          {
            var tWFire;
            for(i=0;i<6;i+=1)
            {
              playSound(global.snd_Splash,0,1,10000)
              tWFire=instance_create(312+(i*48),y,oAquaSer_WaterShot)
              if i mod 2=0 {tWFire.bulletSpeed=3}
              else {tWFire.bulletSpeed=1}
            }
            tTemp+=1
          }
        }
        else //----- Right -----
        {
          moveDir-=0.1
          if x>=432 and tTemp=0
          {
            bodyPart[0].fireTime=bodyPart[0].fireDelay+39
            bodyPart[19].fireTime=bodyPart[19].fireDelay+39
            tTemp+=1
          }

          if x>=592 and tTemp=1
          {
            var tWFire;
            for(i=0;i<6;i+=1)
            {
              playSound(global.snd_Splash,0,1,10000)
              tWFire=instance_create(312+(i*48),y,oAquaSer_WaterShot)
              if i mod 2=0 {tWFire.bulletSpeed=1}
              else {tWFire.bulletSpeed=3}
            }
            tTemp+=1
          }
        }

        if x>=roomBorderRight or x<=roomBorderLeft //End
        {
          moveProg=0; moveSide*=-1; movePath+=1; doubleBack+=1
          if doubleBack>=6
          {
            doubleBack=0
            movePath=4
          }
        }
      }
    }
    else if movePath=5 //----- Move Path: Arc around, 2 random water shots
    {
      if moveProg=1 //Setup, choose direction
      {
        moveSpd=6
        var tYPosTemp; tYPosTemp=288+random(16)
        y=tYPosTemp; oAquaSer_Body.y=tYPosTemp
        tTemp=0
        for(i=0;i<20;i+=1)
        {
          bodyPart[i].fireTime-=30
        }

        var tXPosTemp;
        if moveSide=1 {var tXPosTemp; tXPosTemp=704; moveDir=180}
        else {var tXPosTemp; tXPosTemp=112; moveDir=0}
        x=tXPosTemp; oAquaSer_Body.x=tXPosTemp
      }
      else if moveProg>=2 and moveProg<=999 //Swim across
      {
        speed=moveSpd; direction=moveDir
        if moveSide=1 //----- Left -----
        {
          if x<=272
          {
            var tWFire,tRShotA,tRShotB;
            tRShotA=0; tRShotB=0
            while(tRShotA=tRShotB)
            {
              tRShotA=choose(312,360,408,456,504,552)
              tRShotB=choose(312,360,408,456,504,552)
            }
            playSound(global.snd_Splash,0,1,10000)
            tWFire=instance_create(tRShotA,y,oAquaSer_WaterShot)
            tWFire.bulletSpeed=2
            tWFire=instance_create(tRShotB,y,oAquaSer_WaterShot)
            tWFire.bulletSpeed=2
            moveProg=1000
          }
        }
        else //----- Right -----
        {
          if x>=560
          {
            var tWFire,tRShotA,tRShotB;
            tRShotA=0; tRShotB=0
            while(tRShotA=tRShotB)
            {
              tRShotA=choose(312,360,408,456,504,552)
              tRShotB=choose(312,360,408,456,504,552)
            }
            playSound(global.snd_Splash,0,1,10000)
            tWFire=instance_create(tRShotA,y,oAquaSer_WaterShot)
            tWFire.bulletSpeed=1.6
            tWFire=instance_create(tRShotB,y,oAquaSer_WaterShot)
            tWFire.bulletSpeed=1.6
            moveProg=1000
          }
        }
      }
      else if moveProg>=1001 and moveProg<=1999 //Arc around
      {
        speed=moveSpd; direction=moveDir
        tTemp+=1
        if tTemp=20
        {
          for(i=0;i<20;i+=1)
          {
            bodyPart[i].fireTime-=150
          }
          for(i=0;i<20;i+=4)
          {
            bodyPart[i].fireTime=bodyPart[i].fireDelay+39
          }
        }

        if moveSide=1 //----- From left -----
        {
          moveDir-=3.1
          if moveDir<=5 {moveProg=2000}
        }
        else //----- From right -----
        {
          moveDir+=3.1
          if moveDir>=180 {moveProg=2000}
        }
      }
      else if moveProg>=2001 and moveProg<=2999 //Glide Across
      {
        speed=moveSpd; direction=moveDir
        if x>=roomBorderRight or x<=roomBorderLeft //End
        {
          moveProg=0; movePath+=1; doubleBack+=1
        }
      }
    }
    else if movePath=6 //----- Move Path: From side, shoot big shot, then arc under with 2 random water shots
    {
      if moveProg=1 //Setup, choose direction
      {
        moveSpd=8
        var tYPosTemp; tYPosTemp=176+random(16)
        y=tYPosTemp; oAquaSer_Body.y=tYPosTemp
        tTemp=0

        var tXPosTemp;
        if moveSide=1 {var tXPosTemp; tXPosTemp=704; moveDir=180}
        else {var tXPosTemp; tXPosTemp=112; moveDir=0}
        x=tXPosTemp; oAquaSer_Body.x=tXPosTemp
      }
      else if moveProg>=2 and moveProg<=999 //Swim across and stop
      {
        speed=moveSpd; direction=moveDir
        if moveSide=1 //----- Left -----
        {
          if x<=576
          {
            sprite_index=sAquaSer_HeadB
            speed=0
            moveProg=1000
          }
        }
        else //----- Right -----
        {
          if x>=288
          {
            sprite_index=sAquaSer_HeadB
            speed=0
            moveProg=1000
          }
        }
      }
      else if moveProg=1030 //Fire shot
      {
        sprite_index=sAquaSer_HeadA
        playSound(global.snd_RidleyFire,0,1,14000)
        var tFire,tDir;
        tDir=player_sprite_center()
        tDir-=20
        for(i=0;i<3;i+=1)
        {
          tFire=instance_create(x,y,oPassBullet)
          tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
          tFire.image_xscale=2.5; tFire.image_yscale=2.5
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
          tDir+=20
        }
      }
      else if moveProg>=1051 and moveProg<=1999 //Arc under
      {
        speed=moveSpd; direction=moveDir
        if moveProg>=1051 and moveProg<=1059
        {
          if moveSide=1 //Left
            moveDir+=10
          else //Right
            moveDir-=10
        }
        else if moveProg>=1063 and moveProg<=1071
        {
          if moveSide=1 //Left
            moveDir-=10
          else //Right
            moveDir+=10
        }
        else if moveProg=1081
        {
          var tWFire,tRShotA,tRShotB;
          tRShotA=0; tRShotB=0
          if moveSide=1 //Left
          {
            while(tRShotA=tRShotB)
            {
              tRShotA=choose(408,456,504,552)
              tRShotB=choose(408,456,504,552)
            }
          }
          else //Right
          {
            while(tRShotA=tRShotB)
            {
              tRShotA=choose(312,360,408,456)
              tRShotB=choose(312,360,408,456)
            }
          }
          playSound(global.snd_Splash,0,1,10000)
          tWFire=instance_create(tRShotA,y,oAquaSer_WaterShot)
          tWFire.bulletSpeed=1.6
          tWFire=instance_create(tRShotB,y,oAquaSer_WaterShot)
          tWFire.bulletSpeed=1.6

          playSound(global.snd_RidleyFire,0,1,18000)
          var tFire,tDir;
          tDir=player_sprite_center()
          tFire=instance_create(x,y,oPassBullet)
          tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
          tFire.image_xscale=3; tFire.image_yscale=3
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        }
        else if moveProg>=1083 and moveProg<=1091
        {
          if moveSide=1 //Left
            moveDir-=10
          else //Right
            moveDir+=10
        }
        else if moveProg>=1095 and moveProg<=1103
        {
          if moveSide=1 //Left
            moveDir+=10
          else //Right
            moveDir-=10
        }
        else if moveProg=1105
        {
          playSound(global.snd_RidleyFire,0,1,18000)
          var tFire,tDir;
          tDir=player_sprite_center()
          tFire=instance_create(x,y,oPassBullet)
          tFire.direction=tDir; tFire.sprite_index=sWolfHeadShot
          tFire.image_xscale=3; tFire.image_yscale=3
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        }

        if x>=roomBorderRight or x<=roomBorderLeft //End
        {
          moveProg=0; moveSide*=-1; movePath=4; doubleBack+=1
        }
      }
    }

    //Floor movement
    if floorSeq>=2 and floorSeq<=3
    {
      if floorSeq=2
      {
        moveProg=-120
        movePath=4
        oWaterVolume.targetWLevel=208
        with oZeldaBreakPot {instance_destroy()}
        for(i=0;i<6;i+=1)
        {
          instance_create(288+(i*48),room_height,oWaterFloatPlatform)
        }

        var tEffect;
        for(i=0;i<22;i+=1)
        {
          tEffect=instance_create(304+(i*12),272,oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.15+random(0.15)
          tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(304,280+(i*12),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.15+random(0.15)
          tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          tEffect=instance_create(560,280+(i*12),oEffect)
          tEffect.sprite_index=sMMSmokeCloud; tEffect.image_speed=0.15+random(0.15)
          tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        (159052).yVel=1
        floorSeq=3
      }
      tile_layer_shift(999999,0,1)
      if !instance_exists((159052))
      {
        jeremyText="There we go, I've got access again! I've deciphered the extra bits of data on this thing. At this point, as you can see, it has changed its attack patterns. It still cycles through 3 though. The one you need to be cautious about are the 6 water shots from below. Especially when it doubles back with that."
        chaoText="There's more to this than what Jeremy found too. It has access to the water levels. It will most likely start messing with that when it starts to feel threatened."
        tile_layer_delete(999999)
        floorSeq=4
      }
    }

    //Water movement
    if bossProgress=4
    {
      if bWaterRise=1
      {
        waterAltSpd+=0.1
        if waterAltSpd>=1.8
          bWaterRise=0
      }
      else
      {
        waterAltSpd-=0.1
        if waterAltSpd<=-1.8
          bWaterRise=1
      }
      oWaterVolume.y+=waterAltSpd
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.83 and lifePercent>=0.66 and bossProgress=0
    {
      spdChg=6
      bossProgress+=1
    }
    else if lifePercent<=0.65 and lifePercent>=0.51 and bossProgress=1
    {
      oWaterVolume.targetWLevel=256
      spdChg=8
      bossProgress+=1
    }
    else if lifePercent<=0.5 and lifePercent>=0.26 and bossProgress=2
    {
      spdChg=6
      floorSeq=1
      bossProgress+=1
    }
    else if lifePercent<=0.25 and lifePercent>=0 and bossProgress=3
    {
      oWaterVolume.bSelfControl=0
      bossProgress+=1
    }
  }
  else if life<=0 //Defeat animation
  {
    moveBehavior=0
    speed=0
    oAquaSer_Body.image_blend=c_white
    oAquaSer_Body.bCanDealDamage=false
    deathAnim+=1
    if deathAnim=1
    {
      if bBombOnly=1 //Achievement
      {
        var tCheckAchieve;
        tCheckAchieve=string_char_at(global.tokenRecognitions,41)
        if tCheckAchieve="0"
        {
          var tAchievement;
          tAchievement=instance_create(0,0,oAchievementNotice)
          tAchievement.myAchievement="Aqua Bomb Serpent"; tAchievement.checkNum=41
        }
      }
      with oPassBullet {instance_destroy()}
      partDestroy=19
    }
    else if deathAnim>=2 and deathAnim<=999
    {
      if deathAnim mod 4=0
      {
        with bodyPart[partDestroy]
        {
          playSound(global.snd_HardHit1,0,0.95,1)
          var tEffect;
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sRobotExplosion
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          instance_destroy()
        }
        partDestroy-=1
        if partDestroy=-1
          deathAnim=1000
      }
    }
    else if deathAnim>=1001 and deathAnim<=1054
    {
      if oGame.time mod 2=0
      {
        var tEffect;
        tEffect=instance_create((x-sprite_width/2)+random(sprite_width),(y-sprite_height/2)+random(sprite_height),oEffect)
        tEffect.sprite_index=sSamusSMissileHit
        tEffect.image_speed=0.5; tEffect.image_xscale=0.5; tEffect.image_yscale=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if deathAnim>=1055
    {
      if global.bBossGallery=1
      {
        bossRoomTally(7)
        global.newMapX=1608; global.newMapY=1344; room_goto(rBossGallery)
      }
      else {instance_destroy()}
    }
  }
  enemyStepEvent()
}
else {speed=0}
#define Other_25
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.weaponTag!=2 {bBombOnly=0}
