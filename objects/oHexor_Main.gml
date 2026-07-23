#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
bCanDealDamage=false
image_xscale=-1

//Enemy base statistics
eName="Hexor"
eLevel=40
maxLife=1000000
life=maxLife
atkPower=12
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=8
dieEffect=0
bossProgress=0
activateBoss=0

//--------------------
if global.bossTrack=1
{
  bShowTentacles=1
  tentacleScale=1
}
else
{
  bShowTentacles=0
  tentacleScale=0
}
tentacleFrm=0

//Movement Data
movePhase=0
moveProg=0
moveTime=0
moveCycles=0
toPointX=0; toPointY=0
bMoving=0
lookDelay=0

//Attack Data
atkPhase=0
atkProg=0
atkTime=0
atkCycles=0

laserHorizTime=25
rockProg=0

swordXPos=0

//Event Data
cleverJeremy=0
noHitJeremy=0

//Misc Data
xCenter=240
yGround=288
roomSpan=240

headLeftSpawn=xCenter-roomSpan+16
headRightSpawn=xCenter+roomSpan-16
headSpawnY[0]=168
headSpawnY[1]=216
headSpawnY[2]=264

bShowChainLines=1
chainLineAlpha=0.25
chainLineColor=c_purple
chainLineWidth=1
bShowSwords=0
swordDir=0
swordDist=0
swordWave=0
swordAlpha=1

shieldProg=0
phase=0

bTwitching=0
twitchTime=irandom(120)
twitchRanX=0; twitchRanY=0

bShowHellDogParts=0
hellLF_Angle=0
hellRF_Angle=0
armAngleShift=0
armTwitchTime=0

jeremyText=""
chaoText=""
devText=""
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
    bCanTakeDamage=true
    bShowHealthBar=true
    showBossHP=instance_create(0,0,oBossLifeDisplay); showBossHP.bossID=id; showBossHP.type=0
    activateBoss=2
  }

  if bActive=true and life>0
  {
    //==================== MOVEMENT ====================
    if lookDelay=0 //Look toward the player with a slight delay
    {
      if x<oPlayer1.x and image_xscale=-1
      {
        lookDelay=15
        image_xscale=1
      }
      else if x>oPlayer1.x and image_xscale=1
      {
        lookDelay=15
        image_xscale=-1
      }
    }
    else {lookDelay-=1}

    twitchTime+=1
    if twitchTime=410 {bTwitching=1}
    else if twitchTime>=425
    {
      twitchRanX=0; twitchRanY=0
      twitchTime=irandom(120); bTwitching=0
    }

    if bTwitching=1
    {
      twitchRanX=irandom_range(-3,3)
      twitchRanY=irandom_range(-3,3)
    }

    moveTime+=1
    if movePhase=0 //First move phase
    {
      if moveTime>=120
      {
        moveProg+=1
        if moveProg=1 {toPointX=384; toPointY=176}
        else if moveProg=2 {toPointX=240; toPointY=96}
        else if moveProg=3 {toPointX=96; toPointY=176}
        else if moveProg=4 {toPointX=160; toPointY=224}
        else if moveProg=5 {toPointX=320; toPointY=224; moveProg=0}
        bMoving=1
        moveTime=0
      }

      if bMoving=1
      {
        direction=point_direction(x,y,toPointX,toPointY)
        speed=4
        if point_distance(x,y,toPointX,toPointY)<=8
        {
          x=toPointX; y=toPointY
          speed=0; bMoving=0
        }
      }
    }
    else if movePhase=1 //To center
    {
      direction=point_direction(x,y,toPointX,toPointY)
      speed=4
      if point_distance(x,y,toPointX,toPointY)<=8
      {
        x=toPointX; y=toPointY
        speed=0; bMoving=0
        movePhase=2
      }
    }
    else if movePhase=3 //To top-right corner
    {
      if moveTime=1
      {
        toPointX=408; toPointY=72
        bMoving=1
      }

      if bMoving=1
      {
        direction=point_direction(x,y,toPointX,toPointY)
        speed=4
        if point_distance(x,y,toPointX,toPointY)<=8
        {
          x=toPointX; y=toPointY
          speed=0; bMoving=0
          movePhase=4
        }
      }
    }

    if bShowHellDogParts=1
    {
      hellLF_Angle+=sin(atkTime*0.75)+armAngleShift
      hellRF_Angle-=sin(atkTime*.9)+0.5+armAngleShift

      armTwitchTime+=1
      if armTwitchTime=92 {armAngleShift=13}
      else if armTwitchTime>=94 {armAngleShift=irandom(10); armTwitchTime=0}
    }

    //==================== ATTACKS ====================
    atkTime+=1
    if atkPhase=0
    {
      if atkProg=0 //----- Orbs and heads -----
      {
        if atkTime=20
        {
          var tNewAtk;
          for(i=0;i<8;i+=1)
          {
            tNewAtk=instance_create(x,y,oHexor_OrbA); tNewAtk.orbDir=i*45; tNewAtk.atkDelay=20+(i*8); tNewAtk.type=0
          }
        }
        else if atkTime=60 //Heads
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
        }
        else if atkTime=120 //Heads
        {
          var tNewAtk;
          tNewAtk=instance_create(headRightSpawn,headSpawnY[0],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
        }
        else if atkTime=240 //Heads
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
          tNewAtk=instance_create(headRightSpawn,headSpawnY[0],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
        }
        else if atkTime=360
        {
          var tNewAtk;
          for(i=0;i<4;i+=1)
          {
            tNewAtk=instance_create(x,y,oHexor_OrbA); tNewAtk.orbDir=i*90; tNewAtk.atkDelay=20+(i*16); tNewAtk.type=1
          }
        }
        else if atkTime>=520
        {
          atkTime=0
          if lifePercent<=0.95 {atkProg=1}
        }
      }
      else if atkProg=1 //----- Lots of orbs -----
      {
        if atkTime=30
        {
          var tNewAtk;
          for(i=0;i<20;i+=1)
          {
            tNewAtk=instance_create(x,y,oHexor_OrbA); tNewAtk.orbDir=i*18; tNewAtk.atkDelay=20+(i*9); tNewAtk.type=0
          }
        }
        else if atkTime=210 //Heads
        {
          var tNewAtk;
          tNewAtk=instance_create(headRightSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
        }
        else if atkTime>=360
        {
          atkTime=0
          if lifePercent<=0.9
          {
            if lifePercent<=0.8 {atkProg=3}
            else {atkProg=2}
          }
        }
      }
      else if atkProg=2 //----- Lots of heads -----
      {
        if atkTime=30
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[1],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
        }
        else if atkTime=80
        {
          var tNewAtk;
          tNewAtk=instance_create(headRightSpawn,headSpawnY[0],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
          tNewAtk=instance_create(headRightSpawn,headSpawnY[1],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
        }
        else if atkTime=130
        {
          var tNewAtk;
          tNewAtk=instance_create(headRightSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[0],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
        }
        else if atkTime>=210
        {
          atkTime=0
          if lifePercent<=0.84 {atkProg=3}
          else {atkProg=0}
        }
      }
      else if atkProg=3 //----- Spiral lasers and heads -----
      {
        if atkTime=30
        {
          var tNewAtk;
          tNewAtk=instance_create(xCenter-128,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter+128,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(oPlayer1.x,0,oHexor_SpiralLaser)
        }
        else if atkTime=60
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
          tNewAtk=instance_create(headRightSpawn,headSpawnY[0],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
        }
        else if atkTime=90
        {
          var tNewAtk;
          tNewAtk=instance_create(xCenter-176,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter-96,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter+96,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter+176,0,oHexor_SpiralLaser)
        }
        else if atkTime=170
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
        }
        else if atkTime=200
        {
          var tNewAtk;
          tNewAtk=instance_create(xCenter-96,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter+96,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(oPlayer1.x,0,oHexor_SpiralLaser)
        }
        else if atkTime=220
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
        }
        else if atkTime=270
        {
          var tNewAtk;
          tNewAtk=instance_create(xCenter-32,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter+32,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(oPlayer1.x,0,oHexor_SpiralLaser)
        }
        else if atkTime=320
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
          tNewAtk=instance_create(headRightSpawn,headSpawnY[0],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
        }
        else if atkTime=340
        {
          var tNewAtk;
          tNewAtk=instance_create(xCenter-176,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter-96,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter+96,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(xCenter+176,0,oHexor_SpiralLaser)
          tNewAtk=instance_create(oPlayer1.x,0,oHexor_SpiralLaser)
        }
        else if atkTime>=390
        {
          atkTime=0
          if lifePercent<=0.77 {atkProg=4}
          else {atkProg=1}
        }
      }
      else if atkProg=4 //----- Spiral lasers and orbs -----
      {
        if atkTime=30 {var tNewAtk; tNewAtk=instance_create(xCenter-224,0,oHexor_SpiralLaser)} //In
        else if atkTime=45 {var tNewAtk; tNewAtk=instance_create(xCenter+224,0,oHexor_SpiralLaser)}
        else if atkTime=60 {var tNewAtk; tNewAtk=instance_create(xCenter-200,0,oHexor_SpiralLaser)}
        else if atkTime=75 {var tNewAtk; tNewAtk=instance_create(xCenter+200,0,oHexor_SpiralLaser)}
        else if atkTime=90 {var tNewAtk; tNewAtk=instance_create(xCenter-144,0,oHexor_SpiralLaser)}
        else if atkTime=105 {var tNewAtk; tNewAtk=instance_create(xCenter+144,0,oHexor_SpiralLaser)}
        else if atkTime=120 {var tNewAtk; tNewAtk=instance_create(xCenter-88,0,oHexor_SpiralLaser)}
        else if atkTime=135 {var tNewAtk; tNewAtk=instance_create(xCenter+88,0,oHexor_SpiralLaser)}
        else if atkTime=150 {var tNewAtk; tNewAtk=instance_create(xCenter-32,0,oHexor_SpiralLaser)}
        else if atkTime=165 {var tNewAtk; tNewAtk=instance_create(xCenter+32,0,oHexor_SpiralLaser)}
        else if atkTime=195 {var tNewAtk; tNewAtk=instance_create(xCenter+88,0,oHexor_SpiralLaser)} //Out
        else if atkTime=210 {var tNewAtk; tNewAtk=instance_create(xCenter-88,0,oHexor_SpiralLaser)}
        else if atkTime=225 {var tNewAtk; tNewAtk=instance_create(xCenter+144,0,oHexor_SpiralLaser)}
        else if atkTime=240 {var tNewAtk; tNewAtk=instance_create(xCenter-144,0,oHexor_SpiralLaser)}
        else if atkTime=255 {var tNewAtk; tNewAtk=instance_create(xCenter+200,0,oHexor_SpiralLaser)}
        else if atkTime=270 {var tNewAtk; tNewAtk=instance_create(xCenter-200,0,oHexor_SpiralLaser)}
        else if atkTime=285 {var tNewAtk; tNewAtk=instance_create(xCenter+224,0,oHexor_SpiralLaser)}
        else if atkTime=300 {var tNewAtk; tNewAtk=instance_create(xCenter-224,0,oHexor_SpiralLaser)}

        if atkTime=100
        {
          var tNewAtk;
          for(i=0;i<16;i+=1)
          {
            tNewAtk=instance_create(x,y,oHexor_OrbA); tNewAtk.orbDir=i*22.5; tNewAtk.atkDelay=20+(i*10); tNewAtk.type=0
          }
        }
        else if atkTime=210
        {
          var tNewAtk;
          tNewAtk=instance_create(headLeftSpawn,headSpawnY[2],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime
        }
        else if atkTime>=370
        {
          atkTime=0
          if lifePercent<=0.7 {atkProg=5}
          else {atkProg=1}
        }
      }
      else if atkProg=5 //----- Hex breaks the lines -----
      {
        if atkTime=30
        {
          chainLineColor=c_red; chainLineWidth=3
          toPointX=xCenter; toPointY=headSpawnY[0]
          speed=0; bMoving=1; movePhase=1; moveTime=0
        }
        else if atkTime>=90 and atkTime<=135
        {
          if chainLineWidth=3 {chainLineWidth=5}
          else {chainLineWidth=3}
        }
        else if atkTime>=136
        {
          bShowChainLines=0
          playSound(global.snd_LightballSpread,0,0.95,20000+random(1000))
          var tNewAtk,tEffect;
          for(i=0;i<72;i+=1)
          {
            tNewAtk=instance_create(x,y,oHexor_ShotA); tNewAtk.direction=i*5; tNewAtk.atkDelay=120; tNewAtk.bulletSpeed=4
          }
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sEfEnergyRip; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5; tEffect.image_alpha=0.4
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
          atkTime=0; atkProg=6
        }
      }
      else if atkProg=6 //----- Stay in the top-right -----
      {
        if atkTime=30
        {
          msgCreate(60,80,"Hexor","Still alive I see.",0,0,oMessagePerson,0)
          newMessage.fadingTime=50
        }
        else if atkTime=50 {moveTime=0; movePhase=3}
        else if atkTime=100
        {
          var tNewAtk;
          for(i=0;i<80;i+=1)
          {
            tNewAtk=instance_create(x,y,oHexor_OrbA); tNewAtk.orbDir=i*4.5; tNewAtk.atkDelay=20+(i*8); tNewAtk.type=0
          }
        }

        if atkTime=230 or atkTime=350 //Heads
        {
          var tNewAtk;
          tNewAtk=instance_create(headRightSpawn,headSpawnY[0],oHexor_ShroudHead); tNewAtk.atkDelay=laserHorizTime; tNewAtk.image_xscale=-1
        }

        if atkTime>=140 and atkTime<=200 and cleverJeremy=0 //Player breaks most of the orbs before they stop
        {
          if instance_number(oHexor_OrbA)<=50
          {
            msgCreate(60,80,"Hexor","Well aren't you just the clever one, Jeremy.",0,1,oMessagePerson,0)
            newMessage.fadingTime=80
            cleverJeremy=1
          }
        }

        if atkTime=145 or atkTime=290 or atkTime=435 //Full circle spread shot
        {
          playSound(global.snd_LightballSpread,0,0.95,20000+random(1000))
          var tNewAtk,tEffect;
          for(i=0;i<72;i+=1)
          {
            tNewAtk=instance_create(x,y,oHexor_ShotA); tNewAtk.direction=i*5; tNewAtk.atkDelay=120; tNewAtk.bulletSpeed=4
          }
          tEffect=instance_create(x,y,oEffect)
          tEffect.sprite_index=sEfEnergyRip; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5; tEffect.image_alpha=0.4
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }

        if cleverJeremy=1 //If player broke most of the orbs
        {
          if atkTime=500
          {
            msgCreate(60,80,"Hexor","Great, you ruined that attack for me.",0,1,oMessagePerson,0)
            newMessage.fadingTime=70
          }
          else if atkTime=570
          {
            msgCreate(60,80,"Jeremy","Not like it was that hard. Besides, I'd seen it before.",0,1,oMessagePerson,0)
            newMessage.fadingTime=80
          }
        }

        if (atkTime>=980) or (instance_number(oHexor_OrbA)=0 and atkTime>=600)
        {
          atkTime=0; atkProg=7
        }
      }
      else if atkProg=7 //----- Dialogue -----
      {
        if atkTime=30
        {
          if oPlayer1.life=oPlayer1.maxLife //No damage taken
          {
            noHitJeremy=1
          }
          else
          {
            oPlayer1.life=oPlayer1.maxLife
          }
          msgCreate(60,80,"Jeremy","Nothing you do is working too well.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if atkTime=100
        {
          msgCreate(60,80,"Hexor","Clearly. So I'll have to try something else.",0,1,oMessagePerson,0)
          newMessage.fadingTime=80
        }
        else if atkTime=180
        {
          msgCreate(60,80,"Hexor","I'll need to try something better.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if atkTime>=190
        {
          shieldProg=1000
          for(i=0;i<6;i+=1)
          {
            resType[i]=3
          }
          atkTime=0; atkProg=8
        }
      }
      else if atkProg=8 //----- Hexor uses blades -----
      {
        if atkTime=80 //Top-right
        {
          var tDemonBlade;
          for(i=0;i<7;i+=1)
          {
            tDemonBlade=instance_create(x,y-16,oHexor_DemonBlade)
            tDemonBlade.type=0; tDemonBlade.moveTime=i*8; tDemonBlade.moveSpd=8; tDemonBlade.direction=180
          }
        }
        else if atkTime>=83 and atkTime<=120 //Go down
        {
          y+=8
          if y>=headSpawnY[2]
          {
            y=headSpawnY[2]
            atkTime=121
          }
        }
        else if atkTime=140 or atkTime=180 //From right
        {
          var tDemonBlade;
          tDemonBlade=instance_create(x+32,y,oHexor_DemonBlade)
          tDemonBlade.type=1; tDemonBlade.moveSpd=7; tDemonBlade.direction=180; tDemonBlade.image_angle=180
        }
        else if atkTime=181
        {
          var tHexPart;
          for(i=0;i<12;i+=1)
          {
            tHexPart=instance_create(x+random_range(-6,6),y+random_range(-16,16),oEf_HexorPart)
            tHexPart.partDelay=i*4
          }
          x=72; y=72
          for(i=0;i<12;i+=1)
          {
            tHexPart=instance_create(x+random_range(-6,6),y+random_range(-16,16),oEf_HexorPart)
            tHexPart.partDelay=i*4
          }
        }
        else if atkTime=200 //Top-left
        {
          var tDemonBlade;
          for(i=0;i<7;i+=1)
          {
            tDemonBlade=instance_create(x,y-16,oHexor_DemonBlade)
            tDemonBlade.type=0; tDemonBlade.moveTime=i*8; tDemonBlade.moveSpd=8
          }
        }
        else if atkTime>=203 and atkTime<=240 //Go down
        {
          y+=8
          if y>=headSpawnY[2]
          {
            y=headSpawnY[2]
            atkTime=241
          }
        }
        else if atkTime=260 or atkTime=300 //From left
        {
          var tDemonBlade;
          tDemonBlade=instance_create(x-32,y,oHexor_DemonBlade)
          tDemonBlade.type=1; tDemonBlade.moveSpd=7
        }
        else if atkTime=301
        {
          var tHexPart;
          for(i=0;i<12;i+=1)
          {
            tHexPart=instance_create(x+random_range(-6,6),y+random_range(-16,16),oEf_HexorPart)
            tHexPart.partDelay=i*4
          }
          x=408; y=72
          for(i=0;i<12;i+=1)
          {
            tHexPart=instance_create(x+random_range(-6,6),y+random_range(-16,16),oEf_HexorPart)
            tHexPart.partDelay=i*4
          }
        }
        else if atkTime>=320
        {
          atkCycles+=1
          if atkCycles>=3
          {
            if noHitJeremy=1
            {
              if oPlayer1.life=oPlayer1.maxLife {noHitJeremy=3} //No damage taken
            }
            else
            {
              if oPlayer1.life=oPlayer1.maxLife {noHitJeremy=2}
            }
            atkTime=0; atkProg=9
          }
          else {atkTime=79}
        }
      }
      else if atkProg=9 //----- Hexor talks to Jeremy -----
      {
        if atkTime=60
        {
          msgCreate(60,80,"Hexor","Still alive...",0,0,oMessagePerson,0)
          newMessage.fadingTime=60
        }
        else if atkTime=120
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=1
          }
          shieldProg=600
          if noHitJeremy=0 //Got hit during both segments
          {
            msgCreate(60,80,"Jeremy","I recovered my HP just before so it wasn't a big deal.",0,1,oMessagePerson,0)
          }
          else if noHitJeremy=1 //Didn't get hit during first segment, but did on the second
          {
            msgCreate(60,80,"Jeremy","I didn't get hit before your sword spam, so I had plenty of HP to face tank.",0,2,oMessagePerson,0)
          }
          else if noHitJeremy=2 //Got hit during first segment, but not on the second
          {
            msgCreate(60,80,"Jeremy","I didn't get hit at all on the sword spam, it wasn't that bad.",0,1,oMessagePerson,0)
          }
          else if noHitJeremy=3 //Didn't get hit during either segment
          {
            msgCreate(60,80,"Jeremy","I haven't gotten hit by anything you've thrown at me, you're gonna have to try harder.",0,2,oMessagePerson,0)
          }
          newMessage.fadingTime=120
        }
        else if atkTime=240
        {
          maxLife/=4; life=round(life/4)
          msgCreate(60,80,"Hexor","Sure, then I'll try something else.",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
        }
        else if atkTime>=330
        {
          atkTime=0; atkProg=10
        }
      }
      else if atkProg=10 //----- Circle sword spam with some rocks -----
      {
        if atkTime=20
        {
          bShowSwords=1
          shieldProg=1000
          for(i=0;i<6;i+=1)
          {
            resType[i]=3
          }
        }
        
        if atkTime>=40 and atkTime mod 63=0
        {
          var tDemonBlade,tBladeDir;
          tBladeDir=point_direction(x,y-16,oPlayer1.x,oPlayer1.y-28)
          tDemonBlade=instance_create(x,y-16,oHexor_DemonBlade)
          tDemonBlade.type=1; tDemonBlade.moveSpd=4; tDemonBlade.direction=tBladeDir; tDemonBlade.image_angle=tBladeDir
        }
        
        if atkTime>=80 and atkTime mod 170=0
        {
          var tBigRock;
          tBigRock=instance_create(oPlayer1.x,-64,oHexor_Rock)
          tBigRock.type=0
        }
        
        if lifePercent<=0.1 and atkTime>=90
        {
          for(i=0;i<6;i+=1)
          {
            resType[i]=1
          }
          shieldProg=600
          atkTime=0; atkProg=11
        }
      }
      else if atkProg=11 //----- Before final attack -----
      {
        if atkTime=20
        {
          msgCreate(60,80,"Hexor","Fine, time for my final attack.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if atkTime>=24 and atkTime<=99
        {
          swordDist+=4
          swordAlpha-=0.03
          if swordAlpha<=0
          {
            atkTime=100
          }
        }
        else if atkTime=110
        {
          msgCreate(60,80,"Jeremy","I'm sure it'll be unimpressive, but hey, maybe you can wow me.",0,2,oMessagePerson,0)
          newMessage.fadingTime=120
        }
        else if atkTime>=210
        {
          shieldProg=1000
          for(i=0;i<6;i+=1)
          {
            resType[i]=3
          }
          maxLife*=2; life=round(life*2)
          atkTime=0; atkProg=12
        }
      }
      else if atkProg=12 //----- Final attack ----- rockProg
      {
        if atkTime>=1 and atkTime<=99
        {
          if y>=headSpawnY[1]
          {
            y=headSpawnY[1]
            var tBigRock;
            tBigRock=instance_create(room_width+64,headSpawnY[2]-32,oHexor_Rock)
            tBigRock.type=1; tBigRock.moveSpd=4; tBigRock.direction=180
            atkTime=100
          }
        }
        else if atkTime=210
        {
          msgCreate(60,80,"Jeremy","Your attacks are becoming more and more pathetic. Getting tired?",0,2,oMessagePerson,0)
          newMessage.fadingTime=120
        }
        else if atkTime=330
        {
          msgCreate(60,80,"Hexor","You just haven't been paying attention.",0,1,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        else if atkTime=400
        {
          msgCreate(60,80,"Jeremy","Whatever, we're almost done here anyway.",0,2,oMessagePerson,0)
          newMessage.fadingTime=70
        }
        
        if atkTime>=90
        {
          if atkTime mod 90=0
          {
            var tBigRock;
            if rockProg=0
            {
              tBigRock=instance_create(room_width+64,headSpawnY[2]-32,oHexor_Rock)
              tBigRock.type=1; tBigRock.moveSpd=4; tBigRock.direction=180
            }
          }
        }
      }
    }
  }
  else if life<=0 //End of fight?
  {
    if atkProg<=20 //Hexor defeated?
    {
      if global.bBossGallery=1
      {
        bossRoomTally(62)
        global.newMapX=2456; global.newMapY=224; room_goto(rBossGallery)
      }
      else
      {
        global.bCanSave=0
        global.bCanForceGO=0
        with oHexor_Rock {instance_destroy()}
        atkTime=0; atkProg=21
      }
    }
    else if atkProg=21 //Short prep
    {
      atkTime+=1
      if atkTime=60
      {
        msgCreate(60,80,"Hexor","Jeremy...",0,0,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if atkTime=130
      {
        msgCreate(60,80,"Hexor","YOU HAVEN'T WON!",0,0,oMessagePerson,0)
        newMessage.fadingTime=50
      }
      else if atkTime>=140
      {
        global.bCanGameOver=0
        atkTime=0; atkProg=22
      }
    }
    else if atkProg=22 //Attack until player HP is 0
    {
      atkTime+=1
      if atkTime mod 17=0
      {
        rockProg+=1
        var tBigRock,tDir;
        if rockProg=1 //Top
        {
          tBigRock=instance_create(random_range(-16,room_width+16),-64,oHexor_Rock)
          tBigRock.type=2; tBigRock.moveSpd=4
        }
        else if rockProg=2 //Left
        {
          tBigRock=instance_create(-64,random_range(-16,room_height+16),oHexor_Rock)
          tBigRock.type=2; tBigRock.moveSpd=4
        }
        else if rockProg=3 //Right
        {
          tBigRock=instance_create(room_width+64,random_range(-16,room_height+16),oHexor_Rock)
          tBigRock.type=2; tBigRock.moveSpd=4
          rockProg=0
        }
      }
      
      if oPlayer1.life<=0 //Till player is out of HP
      {
        global.canPause=0
        global.optShowDamage=2
        global.optEnemyHP=2
        global.optShowHUD=2
        global.optShowChainMeter=0
        global.optShowScore=0
        global.optShowMapHeader=0
        global.optDeathCounter=0
        global.hasShoes[0]=1; global.hasShoes[1]=1
        global.jeremyCanAtk=0
        oPlayer1.bCanTakeDamage=false
        atkTime=0; atkProg=31
      }
    }
    else if atkProg=31 //Rocks
    {
      atkTime+=1
      if atkTime mod 7=0
      {
        tBigRock=instance_create(random_range(-16,room_width+16),-64,oHexor_Rock)
        tBigRock.type=3; tBigRock.moveSpd=6+random(1)
      }
      if atkTime>=100 {atkTime=0; atkProg=32}
    }
    else if atkProg=32 //Hexor speaks
    {
      atkTime+=1
      if atkTime=90
      {
        oEvCh21MainA.fadeColor=c_black
        msgCreate(60,80,"Hexor","Did you really think...",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if atkTime>=121 and atkTime<=170
      {
        oEvCh21MainA.fadeAlpha+=0.02
      }
      else if atkTime=180
      {
        stopAllMusic()
        oPlayer1.facing=oPlayer1.RIGHT; oPlayer1.image_xscale=1
        msgCreate(60,80,"Hexor","...that you could change anything?",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if atkTime=320 //Fake credits
      {
        instance_create(0,0,oEvCh21_FakeCredits)
      }
    }
    else if atkProg=33 //Jeremy retaliates
    {
      atkTime+=1
      if atkTime=1
      {
        msgCreate(60,80,"Jeremy","That's why I'm here.",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if atkTime=70
      {
        msgCreate(60,80,"Hexor","You're really not going to give up.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if atkTime=150
      {
        msgCreate(60,80,"Jeremy","I promised I would return. I don't intend to break that promise.",0,2,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if atkTime>=200 and atkTime<=240
      {
        var tEffect;
        for(i=0;i<2;i+=1)
        {
          tEffect=instance_create(oPlayer1.x+random_range(-12,12),oPlayer1.y-random(52),oEffect)
          tEffect.sprite_index=sDustCloud; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.9
          tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        }
        if atkTime=220
        {
          global.activeCharacter=4
        }
      }
      else if atkTime>=300
      {
        global.canPause=1
        global.hasShoes[0]=2; global.hasShoes[1]=2; global.hasShoes[2]=2
        global.jeremyCanAtk=1
        oPlayer1.life=1
        var tempMplay;
        tempMplay=findMusic(1025)
        playMusic(tempMplay,0,0)
        var tFlash;
        tFlash=instance_create(0,0,oScreenFlash); tFlash.fadeSpeed=0.2
        global.currentBoss=""
        global.bossTrack=1000
        instance_create(320,224,oHexor_Final)
        instance_destroy()
      }
    }
  }
  
  if shieldProg=0 and lifePercent<=0.75
  {
    if oPlayer1.hitCombo>=75
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=1
      }
      msgCreate(60,80,"Hex","Lets put a stop to that combo.",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
      shieldProg=1
    }
    else {shieldProg=500}
  }
  else if shieldProg>=1 and shieldProg<=499
  {
    shieldProg+=1
    if shieldProg>=200
    {
      for(i=0;i<6;i+=1)
      {
        resType[i]=3
      }
      shieldProg=500
    }
  }
  else if shieldProg=500 and lifePercent<=0.5 and atkProg<=7
  {
    for(i=0;i<6;i+=1)
    {
      resType[i]=1
    }
    var tHexPart;
    for(i=0;i<12;i+=1)
    {
      tHexPart=instance_create(x+random_range(-6,6),y+random_range(-16,16),oEf_HexorPart)
      tHexPart.partDelay=i*4
    }
    x=408; y=72
    for(i=0;i<12;i+=1)
    {
      tHexPart=instance_create(x+random_range(-6,6),y+random_range(-16,16),oEf_HexorPart)
      tHexPart.partDelay=i*4
    }
    shieldProg=600
  }
  
  enemyStepEvent()
}
else
{
  speed=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bShowChainLines=1
{
  draw_set_alpha(chainLineAlpha)
  draw_set_color(chainLineColor)
  draw_line_width(0,0,x+twitchRanX,y+twitchRanY,chainLineWidth)
  draw_line_width(room_width,0,x+twitchRanX,y+twitchRanY,chainLineWidth)
  draw_line_width(0,room_height,x+twitchRanX,y+twitchRanY,chainLineWidth)
  draw_line_width(room_width,room_height,x+twitchRanX,y+twitchRanY,chainLineWidth)
  draw_line_width(room_width/2,0,x+twitchRanX,y+twitchRanY,chainLineWidth)
  draw_line_width(room_width/2,room_height,x+twitchRanX,y+twitchRanY,chainLineWidth)
  draw_line_width(0,room_height/2,x+twitchRanX,y+twitchRanY,chainLineWidth)
  draw_line_width(room_width,room_height/2,x+twitchRanX,y+twitchRanY,chainLineWidth)
}

if bShowTentacles=1
{
  tentacleFrm+=0.07
  draw_sprite_ext(sHexor_TentaclesA,tentacleFrm,x+twitchRanX-image_xscale,y+twitchRanY,tentacleScale*image_xscale,tentacleScale,image_angle,c_purple,image_alpha)
}

//Draw Hex
draw_sprite_ext(sprite_index,image_index,x+twitchRanX,y+twitchRanY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if bShowHellDogParts=1
{
  draw_sprite_ext(sHexor_HellD_Head,0,x+twitchRanX,y+twitchRanY-13,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

  draw_sprite_ext(sHexor_HellD_LShoulder,0,x+twitchRanX-(9*image_xscale),y+twitchRanY+3,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHexor_HellD_LForearm,0,x+twitchRanX-(19*image_xscale),y+twitchRanY+13,image_xscale,image_yscale,hellLF_Angle,image_blend,image_alpha)

  draw_sprite_ext(sHexor_HellD_RShoulder,0,x+twitchRanX+(11*image_xscale),y+twitchRanY-2,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sHexor_HellD_RForearm,0,x+twitchRanX+(25*image_xscale),y+twitchRanY+28,image_xscale,image_yscale,hellRF_Angle,image_blend,image_alpha)
}

//Draw Swords
if bShowSwords=1
{
  swordWave+=0.2
  swordDist+=sin(swordWave)
  swordDir+=5.7
  for(i=0;i<8;i+=1)
  {
    draw_sprite_ext(sHexor_DemonBlade,0,x+lengthdir_x(52+swordDist,swordDir+random_range(-9,9)+(i*45)),y+lengthdir_y(52+swordDist,swordDir+random_range(-9,9)+(i*45)),image_xscale,image_yscale,swordDir-90+(i*45),c_white,swordAlpha)
  }
}

//Draw Shield
if (shieldProg>=1 and shieldProg<=499) or (shieldProg=600)
{
  phase+=0.2
  draw_sprite_wave_fixed(sHexor_Shield,0,x,y,1,12,3,phase)
}
