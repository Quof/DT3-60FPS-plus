#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1
bShowHealthBar=false
oHUD.dragoonBossCheck=1
oHUD.enemyCheckID=id
bActive=1

//Enemy base statistics
eName="Fortress Skyguard"
eLevel=38
maxLife=1300
life=maxLife
atkPower=12
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
weaponGive=300
bossProgress=0
activateBoss=0
myLives=1

moveBehavior=0
moveProg=0
otherUse=0
atkTimeA=100; atkDirA=0; atkExtA=0; atkStuffA=0
atkTimeB=0; atkDirB=0; atkExtB=20; atkStuffB=0
atkTimeC=0; atkDirC=0; atkExtC=0; atkStuffC=0

deathAnim=0

segmentProg=0
segmentTime=0
segSideGunX=-17
segSideGunY=-16
segFrontGuardX=0
segFrontGuardY=0
segFrontGunX=0
segFrontGunY=32
segWingsX=0
segWingsY=0
segWingsAngle=0

jeremyText="This thing cannot be eaten, sadly. As for its attack patterns, it seems to be borrowing heavily from bullet hell games."
chaoText="I've got nothing to share on this thing since it has no data to look at for your eating ability."
devText="N/A"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  event_inherited()
  if bActive=true and life>0
  {
    if moveBehavior=0
    {
      x-=4
      if x<=384 {moveBehavior=2}
    }
    else if moveBehavior=2
    {
      if myLives=1 //======================================== PHASE 1 ========================================
      {
        atkTimeA+=1
        if atkTimeA mod 130=0 //Flower bullet
        {
          var tAtk,tDir;
          tDir=0
          for(i=0;i<8;i+=1)
          {
            tAtk=instance_create(x,y,oFSFlowerBullet)
            tAtk.atkPower=atkPower; tAtk.decayTime=89; tAtk.bulletSpeed=4; tAtk.bulletCMod=3; tAtk.direction=atkDirA+tDir
            if i=0 {tAtk.bulletBlend=c_white}
            else if i=1 {tAtk.bulletBlend=make_color_rgb(190,255,255)}
            else if i=2 {tAtk.bulletBlend=make_color_rgb(255,190,255)}
            else if i=3 {tAtk.bulletBlend=make_color_rgb(255,255,190)}
            else if i=4 {tAtk.bulletBlend=make_color_rgb(190,190,255)}
            else if i=5 {tAtk.bulletBlend=make_color_rgb(255,190,190)}
            else if i=6 {tAtk.bulletBlend=make_color_rgb(190,255,190)}
            else if i=7 {tAtk.bulletBlend=make_color_rgb(190,190,190)}
            tDir+=360/8
          }
          atkDirA+=10
        }

        atkTimeB+=1
        if atkTimeB mod 30=0 //Standard bullet
        {
          var tAtk,tDir;
          tDir=0
          for(i=0;i<atkExtB;i+=1)
          {
            tAtk=instance_create(x,y,oPassBullet)
            tAtk.sprite_index=sFSSmallBullet; tAtk.atkPower=atkPower; tAtk.bulletSpeed=2
            tAtk.decayTime=-100; tAtk.direction=atkDirB+tDir
            tDir+=360/atkExtB
          }
          atkDirB+=12
        }
      }
      else if myLives=2 //======================================== PHASE 2 ========================================
      {
        atkTimeA+=1
        if atkTimeA mod atkStuffA=0 //Plasma bullet
        {
          var tAtk;
          tAtk=instance_create(x+14,y-90,oPassBullet)
          tAtk.sprite_index=sFSPlasmaShot; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4
          tAtk.decayTime=-100; tAtk.direction=atkDirA; tAtk.image_angle=atkDirA; tAtk.image_speed=0.33
          tAtk=instance_create(x+14,y+108,oPassBullet)
          tAtk.sprite_index=sFSPlasmaShot; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4
          tAtk.decayTime=-100; tAtk.direction=atkDirA; tAtk.image_angle=atkDirA; tAtk.image_speed=0.33

          if atkExtA=0
          {
            atkDirA+=otherUse
            if atkDirA=210 {atkExtA=1}
          }
          else
          {
            atkDirA-=otherUse
            if atkDirA=150 {atkExtA=0}
          }
        }

        atkTimeB+=1
        if atkTimeB mod 90=0 //Missile
        {
          var tAtk;
          tAtk=instance_create(x+7,y-49,oFSMissile)
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=50; tAtk.bulletBlend=make_color_rgb(140,255,255)
          tAtk.direction=170; tAtk.image_angle=170; tAtk.bulletCMod=4
          tAtk=instance_create(x+7,y+49,oFSMissile)
          tAtk.atkPower=atkPower; tAtk.bulletSpeed=8; tAtk.decayTime=50; tAtk.bulletBlend=make_color_rgb(255,255,140)
          tAtk.direction=190; tAtk.image_angle=190; tAtk.bulletCMod=4
        }

        atkTimeC+=1
        if atkTimeC mod atkExtC=0 //Standard bullet
        {
          var tAtk,tDir;
          tDir=point_direction(x,y,oPlayer1.x,oPlayer1.y)
          tDir-=30
          for(i=0;i<7;i+=1)
          {
            tAtk=instance_create(x,y,oPassBullet)
            tAtk.sprite_index=sFSSmallBullet; tAtk.atkPower=atkPower; tAtk.bulletSpeed=3
            tAtk.decayTime=-100; tAtk.direction=tDir
            tDir+=10
          }
        }
      }
      else if myLives=3 //======================================== PHASE 3 ========================================
      {
        atkTimeA+=1
        if atkTimeA mod 140=0 //Flower bullet
        {
          var tAtk,tDir;
          tDir=0
          for(i=0;i<8;i+=1)
          {
            tAtk=instance_create(x,y,oFSFlowerBullet)
            tAtk.atkPower=atkPower; tAtk.decayTime=55; tAtk.bulletSpeed=8; tAtk.bulletCMod=2; tAtk.direction=atkDirA+tDir
            if i=0 {tAtk.bulletBlend=c_white}
            else if i=1 {tAtk.bulletBlend=make_color_rgb(190,255,255)}
            else if i=2 {tAtk.bulletBlend=make_color_rgb(255,190,255)}
            else if i=3 {tAtk.bulletBlend=make_color_rgb(255,255,190)}
            else if i=4 {tAtk.bulletBlend=make_color_rgb(190,190,255)}
            else if i=5 {tAtk.bulletBlend=make_color_rgb(255,190,190)}
            else if i=6 {tAtk.bulletBlend=make_color_rgb(190,255,190)}
            else if i=7 {tAtk.bulletBlend=make_color_rgb(190,190,190)}
            tDir+=360/8
          }
          atkDirA+=10
        }

        atkTimeB+=1
        if atkTimeB mod atkExtB=0 //Flower curve bullet
        {
          var tAtk;
          for(i=0;i<8;i+=1)
          {
            tAtk=instance_create(x-39,y,oFSFlowerCurve)
            tAtk.atkPower=atkPower; tAtk.decayTime=88; tAtk.bulletSpeed=4; tAtk.bulletCMod=2; tAtk.direction=atkDirB+(i*45)
            tAtk.decayTime=90; tAtk.bulletTurn=4; tAtk.bulletBlend=make_color_rgb(150,160,170)
          }
          atkDirB+=10
        }
      }
      else if myLives=4 //======================================== PHASE 4 ========================================
      {
        /*atkTimeA+=1
        if atkTimeA mod atkExtA=0 //Plasma bullet
        {
          var tAtk,tDir;
          tDir=point_direction(x-39,y,oPlayer1.x,oPlayer1.y)
          tAtk=instance_create(x-79,y-32,oPassBullet)
          tAtk.sprite_index=sFSPlasmaShot; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4
          tAtk.decayTime=-100; tAtk.direction=tDir; tAtk.image_angle=tDir; tAtk.image_speed=0.33
          tAtk=instance_create(x-79,y+32,oPassBullet)
          tAtk.sprite_index=sFSPlasmaShot; tAtk.atkPower=atkPower; tAtk.bulletSpeed=4
          tAtk.decayTime=-100; tAtk.direction=tDir; tAtk.image_angle=tDir; tAtk.image_speed=0.33
        }

        atkTimeB+=1
        if atkTimeB mod atkExtB=0 //Missiles
        {
          var tAtk;
          tAtk=instance_create(x+53,y-31,oCW_SpinMissile)
          tAtk.sprite_index=sFSSpinMissile; tAtk.image_speed=0.33; tAtk.atkPower=atkPower; tAtk.turnDir=5
          tAtk=instance_create(x+53,y+31,oCW_SpinMissile)
          tAtk.sprite_index=sFSSpinMissile; tAtk.image_speed=0.33; tAtk.atkPower=atkPower; tAtk.turnDir=-5
        }*/

        atkTimeC+=1
        if atkTimeC mod atkExtC=0 //Flower Spread bullet
        {
          var tAtk,tDir;
          for(i=0;i<3;i+=1)
          {
            tDir=point_direction(x+6,y-99,oPlayer1.x,oPlayer1.y)
            tAtk=instance_create(x+6,y-99,oFSFlowerSpread)
            tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.startDir=tDir; tAtk.bulletCMod=5; tAtk.image_speed=0.33
            tAtk.decayTime=105; tAtk.direction=165+(i*15); tAtk.image_angle=165+(i*15)
            if i=0 {tAtk.bulletBlend=make_color_rgb(190,255,255)}
            else if i=1 {tAtk.bulletBlend=make_color_rgb(255,190,255)}
            else if i=2 {tAtk.bulletBlend=make_color_rgb(255,255,190)}
            tDir=point_direction(x+6,y+99,oPlayer1.x,oPlayer1.y)
            tAtk=instance_create(x+6,y+99,oFSFlowerSpread)
            tAtk.atkPower=atkPower; tAtk.bulletSpeed=4; tAtk.startDir=tDir; tAtk.bulletCMod=5; tAtk.image_speed=0.33
            tAtk.decayTime=105; tAtk.direction=165+(i*15); tAtk.image_angle=165+(i*15); tAtk.bulletBlend=c_white
            if i=0 {tAtk.bulletBlend=make_color_rgb(190,190,255)}
            else if i=1 {tAtk.bulletBlend=make_color_rgb(255,190,190)}
            else if i=2 {tAtk.bulletBlend=make_color_rgb(190,255,190)}
          }
        }
      }
    }

    //---------- Set/animate ship segments ----------
    if segmentProg=0
    {
      if myLives=2 {segmentProg+=1}
    }
    else if segmentProg=1
    {
      segSideGunY+=1
      if segSideGunY>=47  {bCanTakeDamage=1; moveBehavior=2; segmentProg+=1}
    }
    else if segmentProg=2
    {
      if myLives=3 {segmentProg+=1}
    }
    else if segmentProg=3
    {
      if segFrontGuardX<27 {segFrontGuardX+=1}
      if segFrontGuardY<15 {segFrontGuardY+=1}

      if segFrontGuardX>=27 {segmentProg+=1}
    }
    else if segmentProg=4
    {
      segFrontGunX+=1
      if segFrontGunX>=46 {bCanTakeDamage=1; moveBehavior=2; segmentProg+=1}
    }
    else if segmentProg=5
    {
      if myLives=4 {segmentProg+=1}
    }
    else if segmentProg=6
    {
      segWingsX+=1
      if segWingsY<26 {segWingsY+=1}

      if segWingsX>=40 {segmentProg+=1}
    }
    else if segmentProg=7
    {
      segWingsAngle+=1
      if segWingsAngle>=28 {bCanTakeDamage=1; moveBehavior=2; segmentProg+=1}
    }

    //---------- Boss Difficulty Curve ----------
    if myLives=1
    {
      if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0 {atkExtB=26; bossProgress+=1}
      else if lifePercent<=0.5 and lifePercent>=0.11 and bossProgress=1 {atkExtB=32; bossProgress+=1}
      else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=2
      {
        with oEProjectileBase
        {
          var tEffect;
          tEffect=instance_create(x,y,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sWitchFire; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          instance_destroy()
        }
        myLives+=1
        maxLife=1300; life=maxLife
        otherUse=10
        atkTimeA=0; atkDirA=150; atkExtA=0; atkStuffA=20
        atkTimeB=0; atkDirB=0; atkExtB=0; atkStuffB=0
        atkTimeC=0; atkDirC=0; atkExtC=50; atkStuffC=0
        moveBehavior=1; bCanTakeDamage=0
        bossProgress=0
      }
    }
    else if myLives=2
    {
      if lifePercent<=0.75 and lifePercent>=0.11 and bossProgress=0
      {
        atkStuffA=14; atkExtC=35; otherUse=5
        bossProgress+=1
      }
      else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=1
      {
        with oEProjectileBase
        {
          var tEffect;
          tEffect=instance_create(x,y,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sWitchFire; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          instance_destroy()
        }
        myLives+=1
        maxLife=1500; life=maxLife
        otherUse=0
        atkTimeA=0; atkDirA=0; atkExtA=0; atkStuffA=0
        atkTimeB=90; atkDirB=0; atkExtB=120; atkStuffB=0
        atkTimeC=0; atkDirC=0; atkExtC=0; atkStuffC=0
        moveBehavior=1; bCanTakeDamage=0
        bossProgress=0
      }
    }
    else if myLives=3
    {
      if lifePercent<=0.75 and lifePercent>=0.51 and bossProgress=0
      {
        if atkTimeB>30 {atkTimeB-=30}
        atkExtB=90
        bossProgress+=1
      }
      else if lifePercent<=0.5 and lifePercent>=0.11 and bossProgress=1
      {
        if atkTimeB>30 {atkTimeB-=30}
        atkExtB=60
        bossProgress+=1
      }
      else if lifePercent<=0.1 and lifePercent>=0 and bossProgress=2
      {
        with oEProjectileBase
        {
          var tEffect;
          tEffect=instance_create(x,y,oEffectB)
          tEffect.type=3; tEffect.sprite_index=sWitchFire; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
          tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
          instance_destroy()
        }
        myLives+=1
        maxLife=1800; life=maxLife
        otherUse=0
        atkTimeA=0; atkDirA=0; atkExtA=80; atkStuffA=0
        atkTimeB=0; atkDirB=0; atkExtB=50; atkStuffB=0
        atkTimeC=120; atkDirC=0; atkExtC=210; atkStuffC=0

        moveBehavior=1; bCanTakeDamage=0
        bossProgress=0
      }
    }
    else if myLives=4
    {
      if lifePercent<=0.5 and lifePercent>=0 and bossProgress=0
      {
        if atkExtC>60 {atkExtC-=60}
        atkExtC=150
        bossProgress+=1
      }
    }
  }
  else if life<=0 //Defeat animation
  {
    with oEProjectileBase
    {
      var tEffect;
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sWitchFire; tEffect.newBlend=-1; tEffect.fadeSpd=0.1
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      instance_destroy()
    }
    oHUD.dragoonBossCheck=0
    oPlayer1.life=oPlayer1.maxLife
    instance_destroy()
  }
  enemyStepEvent()
}
else {path_speed=0; speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sSkyguard_SideGun,image_index,x-segSideGunX,y-segSideGunY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sSkyguard_SideGun,image_index,x-segSideGunX,y+segSideGunY,image_xscale,-image_yscale,image_angle,image_blend,image_alpha)

draw_sprite_ext(sSkyguard_FrontGun,image_index,x-segFrontGunX,y-segFrontGunY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sSkyguard_FrontGun,image_index,x-segFrontGunX,y+segFrontGunY,image_xscale,-image_yscale,image_angle,image_blend,image_alpha)

draw_sprite_ext(sSkyguard_FrontGuard,image_index,x-segFrontGuardX,y-segFrontGuardY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sSkyguard_FrontGuard,image_index,x-segFrontGuardX,y+segFrontGuardY,image_xscale,-image_yscale,image_angle,image_blend,image_alpha)

draw_sprite_ext(sSkyguard_Wings,image_index,x-8+segWingsX,y-segWingsY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sSkyguard_Wings,image_index,x-8+segWingsX,y+segWingsY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sSkyguard_Wings,image_index,x-8+segWingsX,y-segWingsY,image_xscale,image_yscale,image_angle+segWingsAngle,image_blend,image_alpha)
draw_sprite_ext(sSkyguard_Wings,image_index,x-8+segWingsX,y+segWingsY,image_xscale,image_yscale,image_angle-segWingsAngle,image_blend,image_alpha)
draw_sprite_ext(sSkyguard_Wings,image_index,x+segWingsX,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
