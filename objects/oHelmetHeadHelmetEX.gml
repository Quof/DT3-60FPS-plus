#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanDealDamage=0

//Enemy base statistics
eName="Helmet Head Helmet EX"
maxLife=5000
life=maxLife
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
stunResist=50
affiliation=2
bIsBoss=true
bNoBonus=true
hitSound=global.snd_EnemyHitZelda

moveProg=0
moveTime=0
moveDir=0

bAimedShot=0
aimedShotTime=0
aimedShotAmt=0
aimedShotAngle=0
aimedShotX=0
aimedShotY=0

atkTime=0
bossProg=0
extraBullet=0
extraShotAngle=0
bArcExtraBullet=0
tinyArcDown=0

myBarrier=0
alphaUp=1
lineAlpha=0.4
waterFrm=0
circleRad=0

jeremyText="Stop scanning every tiny thing!"
chaoText="I agree with Jeremy, stop scanning everything!"
devText="Wahfuu, stop scanning everything."
extraInfo="Completely immune to damage while shield is active."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
{
  shotDir=350
  dirChange=-0.5
}
else if type=2
{
  shotDir=190
  dirChange=0.5
}

shotTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  waterFrm+=0.33
  //---------- Movement ----------
  if bossProg=0 //Standard movement
  {
    if moveProg=0
    {
      x+=xSpd
      if xSpd>0
        xSpd-=0.1
      if xSpd<0
        xSpd+=0.1
      y-=3
      if y<=yGround
      {
        y=yGround
        bAimedShot=1
        moveProg=1
      }
    }
    else if moveProg=1
    {
      y+=sin(oGame.time/2.5)
      if moveTime<moveThres
      {
        if x<oPlayer1.x {image_xscale=1}
        else {image_xscale=-1}
      }

      moveTime+=1
      if moveTime>=moveThres and moveTime<=moveThres+15
      {
        image_speed=0.2
        if image_xscale=1
          x+=1.5
        else
          x-=1.5
      }
      else if moveTime>=moveThres+16
      {
        image_speed=0
        image_index=0
        xVel=0
        moveTime=0
      }
    }
  }
  else if bossProg=1 //Move to corners
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    if type=1
    {
      if x<128 {x+=8; image_xscale=1}
      else {x-=8; image_xscale=-1}
      if point_distance(x,0,128,0)<9
      {
        var tEffect;
        tEffect=instance_create(x,y-4,oEffect)
        tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        x=128; y=144; atkTime=0; bossProg=2
      }
    }
    else if type=2
    {
      if x<352 {x+=8; image_xscale=1}
      else {x-=8; image_xscale=-1}
      if point_distance(x,0,352,0)<9
      {
        var tEffect;
        tEffect=instance_create(x,y-4,oEffect)
        tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        x=352; y=144; atkTime=0; bossProg=2
      }
    }
  }
  else if bossProg=3 //Move to corners
  {
    if x<oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    atkTime+=1
    if atkTime=1
    {
      var tEffect;
      tEffect=instance_create(x,y-4,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
      tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if atkTime>=15 and atkTime mod 2=0
    {
      playSound(global.snd_HardHit2,0,0.92,33000)
      var tFire;
      tFire=instance_create(x,y-4,oPassBullet)
      tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=8; tFire.decayTime=-100
      tFire.direction=shotDir
    }

    //Shot sequence
    shotTime+=1
    if shotTime=30 {aimedShotTime=0; bAimedShot=1}
    else if shotTime>=61 and shotTime<=80
    {
      shotDir+=dirChange
    }
    if circleRad>0 {circleRad-=1}

    if type=1 //Left
    {
      if shotTime=130 {circleRad=60}
      else if shotTime=190
      {
        extraShotAngle=player_sprite_center()
        extraBullet=1
      }
    }
    else if type=2 //Right
    {
      if shotTime=180 {circleRad=60}
      else if shotTime=240
      {
        extraShotAngle=player_sprite_center()
        extraBullet=1
      }
    }

    if extraBullet=1
    {
      if atkTime mod 2=0
      {
        var tFire;
        tFire=instance_create(x,y-4,oPassBullet)
        tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=8; tFire.decayTime=-100
        tFire.direction=extraShotAngle
      }
      if bArcExtraBullet=1
      {
        if type=1 {extraShotAngle-=1}
        else if type=2 {extraShotAngle+=1}
      }
    }

    if tinyArcDown>=100 and tinyArcDown<=110
    {
      tinyArcDown+=1
      shotDir+=dirChange
    }
  }
  else if bossProg=4 //Move to lower sides
  {
    if type=1
    {
      if x<48 {x+=4; image_xscale=1}
      else {x-=4; image_xscale=-1}
      if point_distance(x,0,128,0)<5
      {
        var tEffect;
        tEffect=instance_create(x,y-4,oEffect)
        tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        x=48; y=252; atkTime=0; shotDir=0; bossProg=5
      }
    }
    else if type=2
    {
      if x<424 {x+=4; image_xscale=1}
      else {x-=4; image_xscale=-1}
      if point_distance(x,0,352,0)<5
      {
        var tEffect;
        tEffect=instance_create(x,y-4,oEffect)
        tEffect.sprite_index=sCWM_Ef_AtkPulse; tEffect.followID=-1; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tEffect.image_xscale=1.25; tEffect.image_yscale=1.25
        x=424; y=232; atkTime=0; shotDir=180; bossProg=5
      }
    }
  }
  else if bossProg=5 //Keep player from jumping
  {
    atkTime+=1
    if atkTime=30
    {
      var tEffect;
      tEffect=instance_create(x,y-4,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
      tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if atkTime>=45 and atkTime mod 2=0
    {
      playSound(global.snd_HardHit2,0,0.92,33000)
      var tFire;
      tFire=instance_create(x,y-4,oPassBullet)
      tFire.sprite_index=sWolfHeadShot; tFire.atkPower=atkPower; tFire.bulletSpeed=8; tFire.decayTime=-100
      tFire.direction=shotDir
    }
  }
  else if bossProg=6 //Move to final position
  {
    if type=1 //Bottom
    {
      if y>154 {y-=2}
      if point_distance(0,y,0,154)<3
      {
        y=154
        bossProg+=1
      }
    }
    else if type=2 //Top
    {
      if x>240 {x-=2}
      if y>108 {y-=2}
      if point_distance(x,y,240,108)<3
      {
        x=240; y=108
        bossProg+=1
      }
    }
  }
  else if bossProg=7 //Shoot at player
  {
    if type=1 //Bottom
    {
      if moveDir=0
      {
        x+=1
        if x>348
        {
          image_xscale=-1
          moveDir=1
        }
      }
      else if moveDir=1
      {
        x-=1
        if x<136
        {
          image_xscale=1
          moveDir=0
        }
      }

      aimedShotTime+=1
      if aimedShotTime>=aimedAtkDelay
      {
        if aimedShotAmt=0
        {
          aimedShotX=x
          aimedShotY=y
        }

        if aimedShotTime mod 3=0
        {
          var tFire;
          tFire=instance_create(aimedShotX,aimedShotY-4,oPassBullet)
          tFire.direction=270; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=3; tFire.decayTime=-100

          aimedShotAmt+=1
          if aimedShotAmt>=5
          {
            aimedShotAmt=0
            aimedShotTime=0
          }
        }
      }
    }
    else if type=2 //Top
    {
      aimedShotTime+=1
      if aimedShotTime>=aimedAtkDelay
      {
        if aimedShotAmt=0
        {
          aimedShotAngle=player_sprite_center()
        }

        if aimedShotTime mod 3=0
        {
          var tFire;
          tFire=instance_create(x,y-4,oPassBullet)
          tFire.direction=aimedShotAngle; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=3; tFire.decayTime=-100

          aimedShotAmt+=1
          if aimedShotAmt>=5
          {
            aimedShotAmt=0
            aimedShotTime=0
          }
        }
      }
    }
  }
  else if bossProg=8
  {
    if type=1 //Bottom
    {
      if y<208 {y+=2}
      if point_distance(0,y,0,208)<3
      {
        y=208
        bossProg+=1
      }
      if life<4000 {life=maxLife}
    }
    else if type=2 //Top
    {
      if myBarrier=1
      {
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        myBarrier=0
      }
    }
  }
  else if bossProg=9
  {
    if type=1 //Bottom
    {
      if moveDir=0
      {
        x+=1
        if x>348
        {
          image_xscale=-1
          moveDir=1
        }
      }
      else if moveDir=1
      {
        x-=1
        if x<136
        {
          image_xscale=1
          moveDir=0
        }
      }
    }
  }
  else if bossProg=10 //Last attack
  {
    if type=1 //Bottom
    {
      aimedShotTime+=1
      if aimedShotTime mod 3=0
      {
        var tFire;
        for(i=0;i<2;i+=1)
        {
          tFire=instance_create(x,y-4,oPassBullet)
          tFire.direction=i*180; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
        }
      }
    }
    else if type=2 //Top
    {
      aimedShotTime+=1
      if aimedShotTime>=aimedAtkDelay
      {
        if aimedShotAmt=0
        {
          aimedShotAngle=player_sprite_center()
        }

        if aimedShotTime mod 3=0
        {
          var tFire;
          tFire=instance_create(x,y-4,oPassBullet)
          tFire.direction=aimedShotAngle; tFire.sprite_index=sWolfHeadShot
          tFire.atkPower=atkPower; tFire.bulletSpeed=3; tFire.decayTime=-100

          aimedShotAmt+=1
          if aimedShotAmt>=5
          {
            aimedShotAmt=0
            aimedShotTime=0
          }
        }
      }
    }
  }

  if bAimedShot=1 //---------- Attack: Bullet toward player ----------
  {
    aimedShotTime+=1
    if aimedShotTime=aimedAtkDelay
    {
      var tEffect;
      tEffect=instance_create(x,y-4,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5
      tEffect.followID=id; tEffect.xFollow=0; tEffect.yFollow=-4
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    else if aimedShotTime>=aimedAtkDelay+15
    {
      playSound(global.snd_HardHit3,0,0.97,27000)
      var tFire;
      tFire=instance_create(x,y-4,oPassBullet)
      tFire.direction=player_sprite_center(); tFire.sprite_index=sWolfHeadShot
      tFire.atkPower=atkPower; tFire.bulletSpeed=5; tFire.decayTime=-100
      aimedShotTime=0
    }
  }

  if alphaUp=1
  {
    lineAlpha+=0.01
    if lineAlpha>=0.6 {alphaUp=0}
  }
  else
  {
    lineAlpha-=0.01
    if lineAlpha<=0.4 {alphaUp=1}
  }

  if myBarrier=1 //Remove barrier from Helmet Head after enough damage is taken
  {
    if oHelmetHeadEX.bossProgress>=0 and oHelmetHeadEX.bossProgress<=3
    {
      if life<=4400
      {
        life=maxLife
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        myBarrier=0
      }
    }
    else if oHelmetHeadEX.bossProgress=4
    {
      if life<=4600
      {
        life=maxLife
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        extraBullet=0
        bArcExtraBullet=0
        tinyArcDown=100
        myBarrier=0
      }
    }
    else if oHelmetHeadEX.bossProgress=11
    {
      if life<=4400
      {
        life=maxLife
        for(i=0;i<6;i+=1)
        {
          resType[i]=1
        }
        myBarrier=0
      }
    }
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if myBarrier=0 {draw_sprite_ext(sWaterBarrier,waterFrm,x,y-6,0.5,0.5,0,c_white,0.4)}
else if myBarrier=1 //Link to Helmet Head
{
  draw_set_alpha(lineAlpha)
  draw_set_color(c_red)
  draw_line(x,y-6,oHelmetHeadEX.x,oHelmetHeadEX.y-16)
}

if circleRad>0
{
  draw_set_alpha(0.6)
  draw_set_color(c_green)
  draw_circle(x,y-4,circleRad,1)
}
