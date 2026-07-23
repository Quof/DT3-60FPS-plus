#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
image_speed=0
bCanDealDamage=0
bDamageFlash=0

//Place Chao's starting point
//window_set_fullscreen(0)
//window_center()
window_mouse_set(window_get_width()*0.75,window_get_height()*0.5)
oIdentifier.x=mouse_x; oIdentifier.y=mouse_y

//Enemy base statistics
eName="Virus Parasite"
eLevel=40
maxLife=10500
life=maxLife
atkPower=12
stunResist=50
affiliation=9
bIsBoss=true
bNoBonus=true
bCenterDamageNotice=1
dieEffect=0
dieSound=0
bossProgress=0
activateBoss=0

fightSeq=0
fightTime=0

bAtkSpot=0
atkSpotTime=130
atkSpotSeq=1

bBulletSwirl=0
bulletSwirlPush=1 //Positive for clockwise, negative for counter-clockwise
bulletSwirlTime=0
bulletSwirlAmt=3 //Amount of bullet streams in the swirl
bulletSwirlModA=10 //Swirl bullet frequency
bulletSwirlModB=30 //Aimed bullet frequency
bBulletSwirlInc=0 //Turn this on/off auto
bulletSwirlIncTime=0

bExplosionLine=1
explosionLineTime=580
explosionLineDelay=600

bAimedShotSpread=0
aimedShotSpreadTime=0
aimedShotSpreadDelay=150
aimedShotWarn=0

bAimedCircle=0
aimedCircleTime=0
aimedCircleDelay=50
aimedCircleAmt=12 //Amount of bullets in circle

bLineLaser=0 //This attack turns itself off
lineLaserTime=0
lineLaserDuration=450
lineLaserSpd=2

bBigLaser=0
bigLaserTime=0
bigLaserWarn=0

flameAct=0 //Do things to the flames (Yeah, it's worded like that, now stop reading the comments here)
flames[0]=instance_create(204,24,oVP_RoomFire)
flames[1]=instance_create(228,24,oVP_RoomFire)
flames[2]=instance_create(252,24,oVP_RoomFire)
flames[3]=instance_create(276,24,oVP_RoomFire)

flames[4]=instance_create(204,360,oVP_RoomFire)
flames[5]=instance_create(228,360,oVP_RoomFire)
flames[6]=instance_create(252,360,oVP_RoomFire)
flames[7]=instance_create(276,360,oVP_RoomFire)

deathAnim=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
window_mouse_set(window_get_width()*0.75,window_get_height()*0.5)
oIdentifier.x=mouse_x; oIdentifier.y=mouse_y
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
    jeremyText="This thing will go through various high density bullet phases that you'll have to figure out how to navigate. I'm seeing that you can graze the bullets that will allow you to deal more damage. Might be a good idea to use that whenever you can."
    chaoText="Being so close to the parasite is messing up my movement in here. I can only go so fast while in this place. Its first phase is pretty slow so it looks like I can use that moment to figure out my new speed."
    devText="ZephyrBurst is currently out having a snack."
    activateBoss=2
  }

  if life>0
  {
    if fightSeq=0 //---------- Fight intro ----------
    {
      fightTime+=1
      if fightTime=60 {bAimedShotSpread=1}
      else if fightTime=80 {bAtkSpot=1}
    }
    else if fightSeq=1 //Open pod
    {
      fightTime+=1
      if fightTime=40 {image_index=1}
      else if fightTime=44 {image_index=2}
      else if fightTime=48 {image_index=3}
      else if fightTime=52 {image_index=4}
      else if fightTime=56 {image_index=5}
      else if fightTime=60 {image_index=6}
      else if fightTime=64 {image_index=7}
      else if fightTime=68 {image_index=8}
      else if fightTime=80 {sprite_index=sVirusPara_Open; image_speed=0.2}
      else if fightTime=95
      {
        bAtkSpot=1
        bBulletSwirl=1
        bulletSwirlAmt=7
        bulletSwirlModA=10
        bulletSwirlModB=30
      }
    }
    else if fightSeq=2 //---------- First line laser ----------
    {
      fightTime+=1
      if fightTime=30 {bAtkSpot=1}
      else if fightTime=60 {bLineLaser=1}
      else if fightTime=110
      {
        bAimedCircle=1
        bBulletSwirl=1
        bulletSwirlAmt=4
        bulletSwirlModA=26
        bulletSwirlModB=75
      }
      else if fightTime=110+lineLaserDuration
      {
        aimedCircleAmt=15
        bAimedShotSpread=1
        bulletSwirlAmt=5
        bulletSwirlModA=21
        bulletSwirlModB=70
      }
    }
    else if fightSeq=3 //---------- Dense aimed circle ----------
    {
      fightTime+=1
      if fightTime=40
      {
        bAimedCircle=1
        aimedCircleDelay=8
        aimedCircleAmt=10
      }
      else if fightTime=80 {bAtkSpot=1}
      else if fightTime=140 {bAimedShotSpread=1}
    }
    else if fightSeq=4 //---------- Chao must go off-screen ----------
    {
      fightTime+=1
      if fightTime=10 {bAimedShotSpread=0}
      else if fightTime=50
      {
        bExplosionLine=1
        explosionLineTime=explosionLineDelay-10
      }
      else if fightTime=170 {bBigLaser=1}
      else if fightTime=200
      {
        bExplosionLine=0
        bAimedShotSpread=1
        aimedShotSpreadTime=aimedShotSpreadDelay-10
      }
      else if fightTime=220
      {
        bBulletSwirl=1
        bulletSwirlAmt=6
        bulletSwirlModA=5
        bulletSwirlModB=100000000
        bBulletSwirlInc=1
      }
      else if fightTime=280 {bAtkSpot=1}
      else if fightTime=330 {bAimedShotSpread=0}
      else if fightTime=370
      {
        bExplosionLine=1
        explosionLineTime=explosionLineDelay-10
      }
      else if fightTime=500
      {
        bExplosionLine=0
        bAimedShotSpread=1
        aimedShotSpreadTime=aimedShotSpreadDelay-10
      }
      else if fightTime>=600 {fightTime=0}
    }
    else if fightSeq=5 //---------- Final ----------
    {
      fightTime+=1
      if fightTime=1 {with oVP_Explosion {instance_destroy()}}
      else if fightTime=50 {bBulletSwirl=0}
      else if fightTime=70
      {
        bExplosionLine=1
        explosionLineTime=explosionLineDelay-1
      }
      else if fightTime=100 {bExplosionLine=0}
      else if fightTime=110
      {
        bAimedCircle=1
        aimedCircleDelay=1
        aimedCircleAmt=30
      }
      else if fightTime=111 {bAimedCircle=0}
      else if fightTime=150
      {
        bAimedShotSpread=1
        aimedShotSpreadTime=aimedShotSpreadDelay-1
        var tNewAtkSpot;
        tNewAtkSpot=instance_create(240,48,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        tNewAtkSpot=instance_create(240,288,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
      }
      else if fightTime=210 {bAimedShotSpread=0}
      else if fightTime=260 {bAimedCircle=1}
      else if fightTime=261 {bAimedCircle=0}
      else if fightTime=270
      {
        bExplosionLine=1
        explosionLineTime=explosionLineDelay-1
      }
      else if fightTime=300 {bExplosionLine=0}
      else if fightTime=370
      {
        tNewAtkSpot=instance_create(48,176,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        tNewAtkSpot=instance_create(432,176,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
      }
      else if fightTime=380 {bAimedCircle=1}
      else if fightTime=381 {bAimedCircle=0}
      else if fightTime=400 {bLineLaser=1}
      else if fightTime=420
      {
        bAimedShotSpread=1
        aimedShotSpreadTime=aimedShotSpreadDelay-1
      }
      else if fightTime=480 {bAimedShotSpread=0}
      else if fightTime=490 {bAimedCircle=1}
      else if fightTime=491 {bAimedCircle=0}
      else if fightTime=550
      {
        bExplosionLine=1
        explosionLineTime=explosionLineDelay-1
      }
      else if fightTime=580 {bExplosionLine=0}
      else if fightTime=650
      {
        bAimedShotSpread=1
        aimedShotSpreadTime=aimedShotSpreadDelay-1
      }
      else if fightTime=670
      {
        aimedShotSpreadTime=aimedShotSpreadDelay-1
        var tNewAtkSpot;
        tNewAtkSpot=instance_create(240,48,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        tNewAtkSpot=instance_create(240,288,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
      }
      else if fightTime=730
      {
        bAimedShotSpread=0
        bBulletSwirl=1
        bulletSwirlAmt=8
        bulletSwirlModA=14
        bulletSwirlModB=100000000
      }
      else if fightTime>=870 {fightTime=0}
    }

    //========== ATK SPOT ==========
    if bAtkSpot=1
    {
      atkSpotTime+=1
      if atkSpotTime=190
      {
        var tNewAtkSpot;
        if atkSpotSeq=1
        {
          tNewAtkSpot=instance_create(144,64,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
          tNewAtkSpot=instance_create(368,256,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        }
        else if atkSpotSeq=2
        {
          tNewAtkSpot=instance_create(96,256,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
          tNewAtkSpot=instance_create(320,64,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        }
        else if atkSpotSeq=3
        {
          tNewAtkSpot=instance_create(96,80,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
          tNewAtkSpot=instance_create(320,272,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        }
        else if atkSpotSeq=4
        {
          tNewAtkSpot=instance_create(96,256,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
          tNewAtkSpot=instance_create(368,80,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        }
        else if atkSpotSeq=5
        {
          tNewAtkSpot=instance_create(80,176,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
          tNewAtkSpot=instance_create(400,176,oVP_AtkSpot); tNewAtkSpot.image_blend=c_green
        }
        atkSpotSeq+=1
        if atkSpotSeq=6 {atkSpotSeq=1}
        atkSpotTime=0
      }
    }

    //========== ATTACK LIST ==========
    if bBulletSwirlInc=1
    {
      bulletSwirlIncTime+=1
      if bulletSwirlIncTime mod 10=0
      {
        if bBulletSwirl=0 {bBulletSwirl=1}
        else {bBulletSwirl=0}
      }
    }

    if bBulletSwirl=1 //----- ATTACK: BULLET SWIRL -----
    {
      bulletSwirlTime+=bulletSwirlPush
      if bulletSwirlTime mod bulletSwirlModA=0
      {
        var tNewAtk;
        for(i=0;i<bulletSwirlAmt;i+=1)
        {
          tNewAtk=instance_create(x,y,oVP_Bullet)
          tNewAtk.bulletSpeed=3; tNewAtk.direction=(bulletSwirlTime*3)+(i*(360/bulletSwirlAmt)); tNewAtk.depth=29
        }
      }
      if bulletSwirlTime mod bulletSwirlModB=0
      {
        var tNewAtk;
        tNewAtk=instance_create(x,y,oVP_Bullet)
        tNewAtk.bulletSpeed=4; tNewAtk.direction=find_chao_dir(); tNewAtk.depth=27
        tNewAtk.image_blend=make_color_rgb(255,160,160)
      }
    }
    if bExplosionLine=1 //----- ATTACK: EXPLOSION LINE -----
    {
      explosionLineTime+=1
      if explosionLineTime=explosionLineDelay
      {
        for(i=0;i<room_width;i+=32)
        {
          for(ii=0;ii<room_height;ii+=64)
          {
            var tNewAtk;
            tNewAtk=instance_create(16+i,16+ii,oVP_Explosion)
          }
        }
      }
      else if explosionLineTime=explosionLineDelay+20
      {
        for(i=0;i<room_width;i+=64)
        {
          for(ii=0;ii<room_height;ii+=32)
          {
            var tNewAtk;
            tNewAtk=instance_create(16+i,16+ii,oVP_Explosion)
          }
        }
        explosionLineTime=0
      }
    }
    if bAimedShotSpread=1 //----- ATTACK: AIMED SHOT SPREAD -----
    {
      aimedShotSpreadTime+=1
      if aimedShotSpreadTime=aimedShotSpreadDelay {aimedShotWarn=48}
      else if aimedShotSpreadTime>=aimedShotSpreadDelay+1 and aimedShotSpreadTime<=aimedShotSpreadDelay+24 {aimedShotWarn-=2}
      else if aimedShotSpreadTime=aimedShotSpreadDelay+25 {playerDir=find_chao_dir()}
      else if aimedShotSpreadTime>=aimedShotSpreadDelay+26 and aimedShotSpreadTime<=aimedShotSpreadDelay+46 and aimedShotSpreadTime mod 4=0
      {
        var tNewAtk,tDir;
        tDir=playerDir-15
        for(i=0;i<3;i+=1)
        {
          tNewAtk=instance_create(x,y,oVP_Bullet)
          tNewAtk.bulletSpeed=4; tNewAtk.direction=tDir
          tNewAtk.image_blend=make_color_rgb(160,255,160)
          tDir+=15
        }
      }
      else if aimedShotSpreadTime>=aimedShotSpreadDelay+50 {aimedShotSpreadTime=0}
    }
    if bLineLaser=1 //----- ATTACK: LINE LASER (Turns itself off) -----
    {
      lineLaserTime+=1
      if lineLaserTime=1
      {
        var tNewAtk;
        for(i=0;i<4;i+=1)
        {
          tNewAtk=instance_create(x,y,oVP_LineLaser)
          tNewAtk.spinSpd=lineLaserSpd; tNewAtk.image_angle=i*90
        }
      }
      else if lineLaserTime>=lineLaserDuration
      {
        with oVP_LineLaser {laserProg=1}
        lineLaserTime=0; bLineLaser=0
      }
    }
    if bAimedCircle=1 //----- ATTACK: AIMED CIRCLE -----
    {
      aimedCircleTime+=1
      if aimedCircleTime>=aimedCircleDelay
      {
        var tNewAtk,tDir;
        tDir=find_chao_dir()
        for(i=0;i<aimedCircleAmt;i+=1)
        {
          tNewAtk=instance_create(x,y,oVP_Bullet)
          tNewAtk.bulletSpeed=2; tNewAtk.direction=tDir
          tNewAtk.image_blend=make_color_rgb(150,255,255); tNewAtk.depth=28
          tDir+=360/aimedCircleAmt
        }
        aimedCircleTime=0
      }
    }

    //----- ATTACK: BIG LASER -----
    if bBigLaser=1
    {
      bigLaserTime+=1
      if bigLaserTime>=1 and bigLaserTime<=15 {bigLaserWarn+=0.04}
      if bigLaserTime=40
      {
        bigLaserWarn=0
        var tNewAtk;
        tNewAtk=instance_create(0,16,oVP_BigLaser)
      }
      else if bigLaserTime=80 {flameAct=100}
      else if bigLaserTime=240 {flameAct=200}
      else if bigLaserTime>=250 {bigLaserTime=0; bBigLaser=0}
    }

    //----- Flame actions -----
    if flameAct>=100 and flameAct<=199 //Fade out
    {
      flameAct+=1
      if flameAct>=101 and flameAct<=120
      {
        for(i=0;i<8;i+=1)
        {
          flames[i].image_alpha-=0.05
        }
      }
      else if flameAct>=125 {flameAct=0}
    }
    else if flameAct>=200 and flameAct<=299 //Fade in
    {
      flameAct+=1
      if flameAct>=201 and flameAct<=220
      {
        for(i=0;i<8;i+=1)
        {
          flames[i].image_alpha+=0.05
        }
      }
      else if flameAct>=225 {flameAct=0}
    }
  }

  //---------- Boss Difficulty Curve ----------
  if lifePercent<=0.96 and bossProgress=0
  {
    bExplosionLine=0; explosionLineTime=500
    bAimedShotSpread=0; aimedShotSpreadTime=50; aimedShotWarn=0
    bBulletSwirl=1
    bossProgress+=1
  }
  else if lifePercent<=0.92 and bossProgress=1
  {
    bAimedShotSpread=1
    bossProgress+=1
  }
  else if lifePercent<=0.84 and bossProgress=2
  {
    bAimedShotSpread=0; aimedShotSpreadTime=50; aimedShotWarn=0
    bBulletSwirl=0; bulletSwirlTime=0
    bAtkSpot=0; atkSpotTime=80; with oVP_AtkSpot {decayTime=0}
    fightSeq=1; fightTime=0
    bossProgress+=1
  }
  else if lifePercent<=0.70 and bossProgress=3
  {
    bBulletSwirl=0; bulletSwirlTime=0
    bAtkSpot=0; atkSpotTime=80; with oVP_AtkSpot {decayTime=0}
    fightSeq=2; fightTime=0
    bossProgress+=1
  }
  else if lifePercent<=0.57 and bossProgress=4
  {
    bAimedShotSpread=0; aimedShotSpreadTime=50; aimedShotWarn=0
    bBulletSwirl=0; bulletSwirlTime=0
    bAimedCircle=0; aimedCircleTime=20
    bLineLaser=0; lineLaserTime=0; with oVP_LineLaser {laserProg=1}
    bAtkSpot=0; atkSpotTime=80; with oVP_AtkSpot {decayTime=0}
    fightSeq=3; fightTime=0
    bossProgress+=1
  }
  else if lifePercent<=0.43 and bossProgress=5
  {
    bAimedShotSpread=0; aimedShotSpreadTime=50; aimedShotWarn=0
    bBulletSwirl=0; bulletSwirlTime=0
    bAimedCircle=0; aimedCircleTime=20
    bAtkSpot=0; atkSpotTime=80; with oVP_AtkSpot {decayTime=0}
    fightSeq=4; fightTime=0
    bossProgress+=1
  }
  else if lifePercent<=0.21 and bossProgress=6
  {
    bAimedShotSpread=0; aimedShotSpreadTime=40; aimedShotWarn=0
    bBulletSwirl=0; bulletSwirlTime=0; bBulletSwirlInc=0
    bAimedCircle=0; aimedCircleTime=20
    bBigLaser=0; bigLaserTime=0; bigLaserWarn=0; with oVP_BigLaser {instance_destroy()}
    bAtkSpot=0; atkSpotTime=80; with oVP_AtkSpot {decayTime=0}
    flameAct=0
    for(i=0;i<8;i+=1)
    {
      flames[i].image_alpha=0.75
    }
    fightSeq=5; fightTime=0
    bossProgress+=1
  }
  enemyStepEvent()

  if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      with oEProjectileBase {instance_destroy()}
      with oVP_RoomFire {instance_destroy()}
      with oVP_AtkSpot {instance_destroy()}
      bigLaserWarn=0
    }
    else if deathAnim>=2 and deathAnim<=60
    {
      if deathAnim mod 5=0
      {
        var tFFScl,tEffect;
        tFFScl=random(0.25)
        for(i=0;i<8;i+=1)
        {
          tEffect=instance_create(x+random_range(-40,40),y+random_range(-40,40),oEffectB)
          tEffect.type=3; tEffect.sprite_index=sAbom_ParaShot; tEffect.direction=i*45; tEffect.image_angle=i*45
          tEffect.image_xscale=0.75+tFFScl; tEffect.image_yscale=0.75+tFFScl; tEffect.newBlend=-1; tEffect.speed=5
          tEffect.fadeSpd=0.075; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
        }
      }
    }
    else if deathAnim>=61
    {
      if global.bBossGallery=1
      {
        bossRoomTally(61)
        global.newMapX=2312; global.newMapY=224; room_goto(rBossGallery)
      }
      else
      {
        var tEffect;
        for(i=0;i<32;i+=1)
        {
          tEffect=instance_create(x,y,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sAbom_ParaShot; tEffect.direction=i*11.25; tEffect.image_angle=i*11.25; tEffect.speed=4
          tEffect.fadeSpd=0.04; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.newBlend=-1
        }
        oEvCh21MainA.sceneProgress=1
        instance_destroy()
      }
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if bigLaserWarn>0
{
  draw_set_alpha(bigLaserWarn)
  draw_set_color(c_white)
  draw_rectangle(0,0,room_width,48,0)
}
if aimedShotWarn>0
{
  draw_set_alpha(1)
  draw_set_color(make_color_rgb(190,255,190))
  draw_circle(x,y,aimedShotWarn,1)
}
