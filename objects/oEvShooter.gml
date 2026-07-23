#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
enemyCount=-1
fadeColor=c_white
fadeAlpha=0
spawnX=room_width+32
spawnY1=83
spawnY2=121
spawnY3=159
spawnY4=198
spawnY5=236
spawnY6=275
spawnY7=313

asteroidX=room_width+64
asteroidY1=108
asteroidY2=198
asteroidY3=288

otherTimeA=0
changeBackground=0
astProg=0

global.levelTimeSecond=10

sceneProgress=global.newMapX
if sceneProgress>=11 {global.shooterDifficulty=2}
if sceneProgress<=3
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterA; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.image_xscale=1.38; backFollow.image_yscale=1.38
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
else if sceneProgress>=4 and sceneProgress<=7
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterB; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.image_xscale=1.38; backFollow.image_yscale=1.38
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
else if sceneProgress>=8 and sceneProgress<=11
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterC; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.image_xscale=1.58; backFollow.image_yscale=1.58
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
else if sceneProgress>=12
{
  backFollow=instance_create(0,0,oBackgroundFollow)
  backFollow.type=1
  backFollow.backSet=backShooterD; backFollow.xMoveScale=0.6; backFollow.yMoveScale=1
  backFollow.depth=1499999; backFollow.xScrollSpeed=-1
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room=rDragoonMapA //----- [] Dragoon Sequence -----
  {
    if sceneProgress=0 //25 seconds
    {
      sceneDelay+=1
      if sceneDelay=60
      {
        instance_create(spawnX,spawnY2,oC_Spinner)
        instance_create(spawnX,spawnY6,oC_Sparker)
      }
      else if sceneDelay=180
      {
        instance_create(spawnX,spawnY2-24,oC_Sparker)
        instance_create(spawnX,spawnY6+24,oC_Spinner)
      }
      else if sceneDelay=300 {instance_create(spawnX,spawnY4,oC_DopeyBot)}
      else if sceneDelay=360
      {
        instance_create(spawnX,spawnY2-24,oC_DopeyBot)
        instance_create(spawnX,spawnY6+24,oC_DopeyBot)
      }
      else if sceneDelay=520 {instance_create(spawnX,spawnY1,oC_Butterdroid)}
      else if sceneDelay=550 {instance_create(spawnX,spawnY2,oC_Butterdroid)}
      else if sceneDelay=580 {instance_create(spawnX,spawnY3,oC_Butterdroid)}
      else if sceneDelay=640 {instance_create(spawnX,spawnY7,oC_Butterdroid)}
      else if sceneDelay=670 {instance_create(spawnX,spawnY6,oC_Butterdroid)}
      else if sceneDelay=700 {instance_create(spawnX,spawnY5,oC_Butterdroid)}
      else if sceneDelay=760 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=1 //27 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="1-2"}
      if sceneDelay=60
      {
        instance_create(spawnX,spawnY2,oC_RevenantDrone)
        instance_create(spawnX,spawnY6,oC_RevenantDrone)
      }
      else if sceneDelay=210 {instance_create(spawnX,spawnY4,oC_RocketTurtle)}
      else if sceneDelay=320 {instance_create(spawnX,spawnY3,oC_Butterdroid)}
      else if sceneDelay=350 {instance_create(spawnX,spawnY4,oC_Butterdroid)}
      else if sceneDelay=380 {instance_create(spawnX,spawnY5,oC_Butterdroid)}
      else if sceneDelay=480
      {
        instance_create(spawnX,spawnY2,oC_Spinner)
        instance_create(spawnX,spawnY6,oC_Spinner)
      }
      else if sceneDelay=610
      {
        instance_create(spawnX,spawnY2,oC_Sparker)
        instance_create(spawnX,spawnY6,oC_Sparker)
      }
      else if sceneDelay=680
      {
        instance_create(spawnX,spawnY3,oC_Butterdroid)
        instance_create(spawnX,spawnY5,oC_Butterdroid)
      }
      else if sceneDelay=770 {instance_create(spawnX,spawnY4,oC_DopeyBot)}
      else if sceneDelay=830 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=2 //22 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="1-3"}
      if sceneDelay=40 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=1; tAst.direction=180}
      else if sceneDelay=80 {instance_create(spawnX,spawnY6,oC_SpikeRotater)}
      else if sceneDelay=220 {instance_create(spawnX,spawnY6,oC_Butterdroid)}
      else if sceneDelay=240 {instance_create(spawnX,spawnY5,oC_Butterdroid)}
      else if sceneDelay=260 {instance_create(spawnX,spawnY7,oC_Butterdroid)}
      else if sceneDelay=350 { var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=1; tAst.direction=180}
      else if sceneDelay=390 {instance_create(spawnX,spawnY2,oC_SpikeRotater)}
      else if sceneDelay=450 {instance_create(spawnX,spawnY2,oC_RocketTurtle)}
      else if sceneDelay=530 {instance_create(spawnX,spawnY1,oC_Butterdroid)}
      else if sceneDelay=580 {instance_create(spawnX,spawnY3,oC_Butterdroid)}
      else if sceneDelay=610 {instance_create(spawnX,spawnY5,oC_RoboChicken)}
      else if sceneDelay=660 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=3 //27 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="1-4"}
      if sceneDelay=40 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=1; tAst.direction=180}
      else if sceneDelay=80
      {
        instance_create(spawnX,spawnY2,oC_RevenantDrone)
        instance_create(spawnX,spawnY6,oC_SpikeRotater)
      }
      else if sceneDelay=190
      {
        instance_create(spawnX,spawnY3,oC_Butterdroid)
        instance_create(spawnX,spawnY5,oC_Butterdroid)
      }
      else if sceneDelay=340
      {
        instance_create(spawnX,spawnY1,oC_RoboChicken)
        instance_create(spawnX,spawnY7,oC_RoboChicken)
      }
      else if sceneDelay=420
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=1; tAst.direction=180
        tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=1; tAst.direction=180
      }
      else if sceneDelay=470 {instance_create(spawnX,spawnY4,oC_SpikeRotater)}
      else if sceneDelay=590 {instance_create(spawnX,spawnY2,oC_Spinner)}
      else if sceneDelay=640 {instance_create(spawnX,spawnY3,oC_Butterdroid)}
      else if sceneDelay=660 {instance_create(spawnX,spawnY5,oC_Butterdroid)}
      else if sceneDelay>=810
      {
        changeBackground+=1
        if changeBackground=1
        {
          backCloud=instance_create(0,0,oBackgroundFollow)
          backCloud.type=1
          backCloud.backSet=backShooterCloudMist; backCloud.xMoveScale=0.6; backCloud.yMoveScale=1
          backCloud.image_xscale=1.38; backCloud.image_yscale=1.38; backCloud.image_alpha=0
          backCloud.depth=1400000; backCloud.xScrollSpeed=-8
        }
        if changeBackground>=1 and changeBackground<=20 {backCloud.image_alpha+=0.05}
        else if changeBackground=21 {backFollow.backSet=backShooterB}
        else if changeBackground>=41 and changeBackground<=60 {backCloud.image_alpha-=0.05}
        else if changeBackground>=61
        {
          with backCloud {instance_destroy()}
          changeBackground=0; sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=4 //30 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="1-5"}
      if sceneDelay=60 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180}
      else if sceneDelay=120 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180}
      else if sceneDelay=170 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180}
      else if sceneDelay=200 {var tAst; tAst=instance_create(asteroidX,asteroidY2-24,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5}
      else if sceneDelay=220
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180
        tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180
      }
      else if sceneDelay=280 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=180}
      else if sceneDelay=310 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=180}
      else if sceneDelay=325
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=8; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5
        tAst=instance_create(asteroidX+48,asteroidY2-48,oDragAsteroid); tAst.bulletSpeed=8; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5
        tAst=instance_create(asteroidX+80,asteroidY2+48,oDragAsteroid); tAst.bulletSpeed=8; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5
      }
      else if sceneDelay=340 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=180}
      else if sceneDelay=360 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=180}
      else if sceneDelay=380 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=180} //Tight squeeze
      else if sceneDelay=400 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=180}
      else if sceneDelay=440 {var tAst; tAst=instance_create(asteroidX+48,asteroidY1+24,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180; tAst.image_xscale=1.5; tAst.image_yscale=1.5}
      else if sceneDelay=500 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5}
      else if sceneDelay=520 {var tAst; tAst=instance_create(asteroidX+48,asteroidY3-24,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180; tAst.image_xscale=1.5; tAst.image_yscale=1.5}
      else if sceneDelay=580
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5
        tAst=instance_create(asteroidX+48,asteroidY1+48,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5
      }
      else if sceneDelay=600 {var tAst; tAst=instance_create(asteroidX+48,asteroidY1+24,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180; tAst.image_xscale=1.5; tAst.image_yscale=1.5}
      else if sceneDelay=900
      {
        instance_create(0,0,oCheckpointNotice)
        if global.shooterProgress<1 {global.shooterProgress=1}
        global.newMapX=5
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=5 //Hex Worm Boss
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="1-X"}
      if sceneDelay=50
      {
        instance_create(512,80,oHexWorm)
      }
      else if sceneDelay>=60
      {
        if !instance_exists(oHexWorm)
        {
          instance_create(0,0,oCheckpointNotice)
          if global.shooterProgress<2 {global.shooterProgress=2}
          global.newMapX=6
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=6 //23 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="2-1"}
      if sceneDelay=50
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180
        tAst=instance_create(asteroidX+256,asteroidY2,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180
        tAst=instance_create(asteroidX+512,asteroidY3,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180
        tAst=instance_create(asteroidX+768,asteroidY2,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180
      }
      else if sceneDelay=60 {instance_create(spawnX,spawnY5,oC_Spinner)}
      else if sceneDelay=90 {instance_create(spawnX,spawnY7,oC_DopeyBot)}
      else if sceneDelay=180 {instance_create(spawnX,spawnY1,oC_DopeyBot)}
      else if sceneDelay=260 {instance_create(spawnX,spawnY2,oC_Bloominator)}
      else if sceneDelay=400
      {
        instance_create(spawnX,spawnY2,oC_Butterdroid)
        instance_create(spawnX,spawnY3,oC_Butterdroid)
        instance_create(spawnX,spawnY4,oC_Butterdroid)
        instance_create(spawnX,spawnY5,oC_Butterdroid)
        instance_create(spawnX,spawnY6,oC_Butterdroid)
      }
      else if sceneDelay=550 {instance_create(spawnX,spawnY4,oC_DopeyBot)}
      else if sceneDelay=600 {instance_create(spawnX,spawnY6,oC_DopeyBot)}
      else if sceneDelay=700 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=7 //25 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="2-2"}
      if sceneDelay=50 {var tAst; tAst=instance_create(asteroidX+112,asteroidY2,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=1.8; tAst.image_yscale=1.8}
      else if sceneDelay=100 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=3; tAst.direction=180}
      else if sceneDelay=120 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=3; tAst.direction=180}
      else if sceneDelay=150 {instance_create(spawnX,spawnY2,oC_Bloominator)}
      else if sceneDelay=180 {instance_create(spawnX,spawnY6,oC_Bloominator)}
      else if sceneDelay=260 {instance_create(spawnX,spawnY3,oC_SpikeRotater)}
      else if sceneDelay=290 {instance_create(spawnX,spawnY3,oC_SpikeRotater)}
      else if sceneDelay=420
      {
        instance_create(spawnX,spawnY2,oC_Sparker)
        instance_create(spawnX,spawnY4,oC_Sparker)
        instance_create(spawnX,spawnY6,oC_Sparker)
      }
      else if sceneDelay=550 {instance_create(spawnX,spawnY3,oC_RocketTurtle)}
      else if sceneDelay=580 {instance_create(spawnX,spawnY5,oC_RocketTurtle)}
      else if sceneDelay>=750
      {
        changeBackground+=1
        if changeBackground=1
        {
          backCloud=instance_create(0,0,oBackgroundFollow)
          backCloud.type=1
          backCloud.backSet=backShooterCloudMist; backCloud.xMoveScale=0.6; backCloud.yMoveScale=1
          backCloud.image_xscale=1.38; backCloud.image_yscale=1.38; backCloud.image_alpha=0
          backCloud.depth=1400000; backCloud.xScrollSpeed=-8
        }
        if changeBackground>=1 and changeBackground<=20 {backCloud.image_alpha+=0.05}
        else if changeBackground=21 {backFollow.backSet=backShooterC; backFollow.image_xscale=1.58; backFollow.image_yscale=1.58}
        else if changeBackground>=41 and changeBackground<=60 {backCloud.image_alpha-=0.05}
        else if changeBackground>=61
        {
          with backCloud {instance_destroy()}
          changeBackground=0; sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=8 //23 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="2-3"}
      if sceneDelay=50 {instance_create(spawnX,spawnY3,oC_RocketTurtle)}
      else if sceneDelay=100 {instance_create(spawnX,spawnY4,oC_RoboChicken)}
      else if sceneDelay=130 {instance_create(spawnX,spawnY6,oC_RevenantDrone)}
      else if sceneDelay=210 {instance_create(spawnX,spawnY2,oC_RocketTurtle)}
      else if sceneDelay=290 {instance_create(spawnX,spawnY5,oC_Bloominator)}
      else if sceneDelay=320
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY1-56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
        tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
        tAst=instance_create(asteroidX,asteroidY1+56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
        tAst=instance_create(asteroidX+256,asteroidY3-56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
        tAst=instance_create(asteroidX+256,asteroidY3,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
        tAst=instance_create(asteroidX+256,asteroidY3+56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
      }
      else if sceneDelay=410 {instance_create(spawnX,spawnY4,oC_SpikeRotater)}
      else if sceneDelay=460 {instance_create(spawnX,spawnY1,oC_SpikeRotater)}
      else if sceneDelay=550 {instance_create(spawnX,spawnY6,oC_RocketTurtle)}
      else if sceneDelay=620 {instance_create(spawnX,spawnY4,oC_RoboChicken)}
      else if sceneDelay=700 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=9 //37 seconds
    {
      if sceneDelay<670
      {
        otherTimeA+=1
        if otherTimeA=90
        {
          var tAst; tAst=instance_create(asteroidX,asteroidY1-56,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
          tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
          tAst=instance_create(asteroidX,asteroidY1+56,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
        }
        else if otherTimeA=180
        {
          var tAst; tAst=instance_create(asteroidX,asteroidY3-56,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
          tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
          tAst=instance_create(asteroidX,asteroidY3+56,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75
          otherTimeA=0
        }
      }

      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="2-4"}
      if sceneDelay=60 {instance_create(spawnX,spawnY2,oC_Bloominator)}
      else if sceneDelay=260
      {
        instance_create(spawnX,spawnY1,oC_RocketTurtle)
        instance_create(spawnX,spawnY7,oC_RocketTurtle)
      }
      else if sceneDelay=330 {instance_create(spawnX,spawnY2,oC_RoboChicken)}
      else if sceneDelay=410 {instance_create(spawnX,spawnY4,oC_DopeyBot)}
      else if sceneDelay=470
      {
        instance_create(spawnX,spawnY2,oC_DopeyBot)
        instance_create(spawnX,spawnY6,oC_DopeyBot)
      }
      else if sceneDelay=510 {instance_create(spawnX,spawnY5,oC_RoboChicken)}
      else if sceneDelay=630 {instance_create(spawnX,spawnY2,oC_Spinner)}
      else if sceneDelay=700 {instance_create(spawnX,spawnY3,oC_Butterdroid)}
      else if sceneDelay=790 {instance_create(spawnX,spawnY2,oC_SpikeRotater)}
      else if sceneDelay=840 {instance_create(spawnX,spawnY5,oC_RevenantDrone)}
      else if sceneDelay=860 {instance_create(spawnX,spawnY7,oC_RevenantDrone)}
      else if sceneDelay=1110
      {
        instance_create(0,0,oCheckpointNotice)
        if global.shooterProgress<3 {global.shooterProgress=3}
        global.newMapX=10
        sceneDelay=0; sceneProgress+=1
      }
    }
    else if sceneProgress=10 //MkII Ver 3.14 Boss
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="2-X"}
      if sceneDelay=50
      {
        instance_create(512,176,oC_Mark)
      }
      else if sceneDelay>=60
      {
        if !instance_exists(oC_Mark)
        {
          instance_create(0,0,oCheckpointNotice)
          if global.shooterProgress<4 {global.shooterProgress=4}
          global.newMapX=11
          global.shooterDifficulty=2
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=11 //29 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="3-1"}
      if sceneDelay=50 {instance_create(spawnX,spawnY4,oC_DopeyBot)}
      else if sceneDelay=100 {instance_create(spawnX,spawnY2,oC_Bloominator)}
      else if sceneDelay=190 {instance_create(spawnX,spawnY6,oC_RocketTurtle)}
      else if sceneDelay=300
      {
        instance_create(spawnX,spawnY3,oC_Butterdroid)
        instance_create(spawnX,spawnY4,oC_Butterdroid)
      }
      else if sceneDelay=390 {instance_create(spawnX,spawnY1,oC_Spinner)}
      else if sceneDelay=520 {instance_create(spawnX,spawnY3,oC_SpikeRotater)}
      else if sceneDelay=650 {instance_create(spawnX,spawnY4,oC_RevenantDrone)}
      else if sceneDelay=760 {instance_create(spawnX,spawnY1,oC_Sparker)}
      else if sceneDelay>=870
      {
        changeBackground+=1
        if changeBackground=1
        {
          backCloud=instance_create(0,0,oBackgroundFollow)
          backCloud.type=1
          backCloud.backSet=backShooterCloudMist; backCloud.xMoveScale=0.6; backCloud.yMoveScale=1
          backCloud.image_xscale=1.38; backCloud.image_yscale=1.38; backCloud.image_alpha=0
          backCloud.depth=1400000; backCloud.xScrollSpeed=-8
        }
        if changeBackground>=1 and changeBackground<=20 {backCloud.image_alpha+=0.05}
        else if changeBackground=21 {backFollow.backSet=backShooterD; backFollow.image_xscale=1; backFollow.image_yscale=1}
        else if changeBackground>=41 and changeBackground<=60 {backCloud.image_alpha-=0.05}
        else if changeBackground>=61
        {
          with backCloud {instance_destroy()}
          changeBackground=0; sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=12 //25 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="3-2"}
      if sceneDelay=30 {instance_create(spawnX,spawnY4,oC_RoboChicken)}
      else if sceneDelay=60 {instance_create(spawnX,spawnY4,oC_Butterdroid)}
      else if sceneDelay=130
      {
        instance_create(spawnX,spawnY2,oC_Spinner)
        instance_create(spawnX,spawnY6,oC_Sparker)
      }
      else if sceneDelay=210
      {
        instance_create(spawnX,spawnY1,oC_Sparker)
        instance_create(spawnX,spawnY7,oC_Spinner)
      }
      else if sceneDelay=270 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=200}
      else if sceneDelay=300 {instance_create(spawnX,spawnY4,oC_Bloominator)}
      else if sceneDelay=320 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=160}
      else if sceneDelay=390 {instance_create(spawnX,spawnY2,oC_RocketTurtle)}
      else if sceneDelay=530 {instance_create(spawnX,spawnY3,oC_RevenantDrone)}
      else if sceneDelay=580 {instance_create(spawnX,spawnY2,oC_Butterdroid)}
      else if sceneDelay=610 {instance_create(spawnX,spawnY4,oC_Bloominator)}
      else if sceneDelay=780 {sceneDelay=0; sceneProgress+=1}
    }
    else if sceneProgress=13 //28 seconds
    {
      sceneDelay+=1
      if sceneDelay=1 {oHUD.shooterLevel="3-3"}
      if sceneDelay=50 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180}
      else if sceneDelay=70 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=200; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=80 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=190; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=90 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=170; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=100 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=120 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180}
      else if sceneDelay=140 {var tAst; tAst=instance_create(asteroidX,asteroidY1+56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=200; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=160 {var tAst; tAst=instance_create(asteroidX,asteroidY2+56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=170; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=170 {var tAst; tAst=instance_create(asteroidX,asteroidY3-56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=160; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=190 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180}
      else if sceneDelay=210 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=200}
      else if sceneDelay=240
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=165
        tAst=instance_create(asteroidX,asteroidY3-48,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=165
        tAst=instance_create(asteroidX,asteroidY3-96,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=165
      }
      else if sceneDelay=280
      {
        var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=195
        tAst=instance_create(asteroidX,asteroidY1+48,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=195
        tAst=instance_create(asteroidX,asteroidY1+96,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=195
      }
      else if sceneDelay=300 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180}
      else if sceneDelay=320 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=200; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=330 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=190; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=340 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=170; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=500 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=180; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=520 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180}
      else if sceneDelay=540 {var tAst; tAst=instance_create(asteroidX,asteroidY1+56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=200; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=560 {var tAst; tAst=instance_create(asteroidX,asteroidY2+56,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=170; tAst.image_xscale=0.75; tAst.image_yscale=0.75}
      else if sceneDelay=590 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=2; tAst.direction=180}
      else if sceneDelay=610 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=200}
      else if sceneDelay=650 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=4; tAst.direction=195}
      else if sceneDelay=860
      {
        instance_create(0,0,oCheckpointNotice)
        if global.shooterProgress<5 {global.shooterProgress=5}
        global.newMapX=14
        sceneDelay=0; sceneProgress+=1
      }

      if sceneDelay>=390 and sceneDelay<=720
      {
        if sceneDelay mod 25=0
        {
          astProg+=1
          if astProg=1 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=point_direction(asteroidX,asteroidY1,oPlayer1.x,oPlayer1.y)}
          else if astProg=2 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=point_direction(asteroidX,asteroidY2,oPlayer1.x,oPlayer1.y)}
          else if astProg=3 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=6; tAst.direction=point_direction(asteroidX,asteroidY3,oPlayer1.x,oPlayer1.y); astProg=0}
        }
      }
    }
    else if sceneProgress=14 //Breakable asteroid sequence
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        backFollow.xScrollSpeed=0
        oHUD.shooterLevel="3-4"
      }
      else if sceneDelay=50 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oBreakableAsteroid); tAst.type=1 ;tAst.direction=150}
      else if sceneDelay=200 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oBreakableAsteroid); tAst.type=1; tAst.direction=175}
      else if sceneDelay=350 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oBreakableAsteroid); tAst.type=1; tAst.direction=200}
      else if sceneDelay>=360
      {
        if !instance_exists(oBreakableAsteroid)
        {
          instance_create(0,0,oCheckpointNotice)
          if global.shooterProgress<6 {global.shooterProgress=6}
          astProg=0
          global.newMapX=15
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=15 //40 seconds
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        backFollow.xScrollSpeed=-3
        oHUD.shooterLevel="3-5"
      }
      if sceneDelay=50
      {
        instance_create(spawnX,spawnY2,oC_RocketTurtle)
        instance_create(spawnX,spawnY4,oC_Bloominator)
        instance_create(spawnX,spawnY6,oC_Sparker)
      }
      else if sceneDelay=180 {instance_create(spawnX,spawnY1,oC_SpikeRotater)}
      else if sceneDelay=260 {instance_create(spawnX,spawnY1,oC_RevenantDrone)}
      else if sceneDelay=340 {instance_create(spawnX,spawnY2,oC_DopeyBot)}
      else if sceneDelay=420 {instance_create(spawnX,spawnY4,oC_Butterdroid)}
      else if sceneDelay=500 {instance_create(spawnX,spawnY6,oC_Spinner)}
      else if sceneDelay=580 {instance_create(spawnX,spawnY5,oC_Bloominator)}
      else if sceneDelay=690
      {
        instance_create(spawnX,spawnY2,oC_RocketTurtle)
        instance_create(spawnX,spawnY4,oC_RocketTurtle)
        instance_create(spawnX,spawnY6,oC_RocketTurtle)
      }
      else if sceneDelay=840
      {
        instance_create(spawnX,spawnY2,oC_Butterdroid)
        instance_create(spawnX,spawnY4,oC_Butterdroid)
        instance_create(spawnX,spawnY6,oC_Butterdroid)
      }
      else if sceneDelay=1020
      {
        instance_create(spawnX,spawnY2,oC_RoboChicken)
        instance_create(spawnX,spawnY4,oC_RoboChicken)
        instance_create(spawnX,spawnY6,oC_RoboChicken)
      }
      else if sceneDelay=1100
      {
        instance_create(spawnX,spawnY3,oC_RoboChicken)
        instance_create(spawnX,spawnY5,oC_RoboChicken)
      }
      else if sceneDelay=1180
      {
        instance_create(spawnX,spawnY2,oC_RoboChicken)
        instance_create(spawnX,spawnY4,oC_RoboChicken)
        instance_create(spawnX,spawnY6,oC_RoboChicken)
      }
      else if sceneDelay=1260
      {
        instance_create(spawnX,spawnY3,oC_RoboChicken)
        instance_create(spawnX,spawnY5,oC_RoboChicken)
      }
      else if sceneDelay>=1590
      {
        instance_create(0,0,oCheckpointNotice)
        if global.shooterProgress<7 {global.shooterProgress=7}
        astProg=0
        global.newMapX=16
        sceneDelay=0; sceneProgress+=1
      }

      if sceneDelay>=50 and sceneDelay<=660
      {
        if sceneDelay mod 70=0
        {
          astProg+=1
          if astProg=1 {var tAst; tAst=instance_create(asteroidX,asteroidY1,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5}
          else if astProg=2 {var tAst; tAst=instance_create(asteroidX,asteroidY2,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5}
          else if astProg=3 {var tAst; tAst=instance_create(asteroidX,asteroidY3,oDragAsteroid); tAst.bulletSpeed=5; tAst.direction=180; tAst.image_xscale=0.5; tAst.image_yscale=0.5}
        }
      }
    }
    else if sceneProgress=16 //Boss
    {
      sceneDelay+=1
      if sceneDelay=1
      {
        backFollow.xScrollSpeed=-1
        var tempMplay;
        tempMplay=findMusic(1010)
        playMusic(tempMplay,0,0)
        oHUD.shooterLevel="CHAOS"
      }
      if sceneDelay=30
      {
        instance_create(room_width+64,spawnY4,oFortressSkyguard)
      }
      else if sceneDelay>=60
      {
        if !instance_exists(oFortressSkyguard)
        {
          instance_create(0,0,oCheckpointNotice)
          global.newMapX=17
          sceneDelay=0; sceneProgress+=1
        }
      }
    }
    else if sceneProgress=17 //End
    {
      sceneDelay+=1
      if sceneDelay>=150 and sceneDelay<=800 //Lasers
      {
        if sceneDelay mod 13=0
        {
          var tEndLaser;
          tEndLaser=instance_create(room_width+32,48+random(room_height-48),oEndShooterLaser)
          tEndLaser.type=0
        }
      }
      if sceneDelay>=500 and sceneDelay<=820 //Ship smoke trail
      {
        if sceneDelay mod 8=0 {playSound(global.snd_EnemyDieMM,0,0.95,1)}
        if sceneDelay mod 6=0
        {
          var tEffect;
          tEffect=instance_create(oDragoonShip.x+random_range(-4,4),oDragoonShip.y+random_range(-4,4),oEffect)
          tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=-4-random(2); tEffect.ySpd=random_range(-0.5,0.5)
        }
      }

      if sceneDelay=30
      {
        msgCreate(0,0,"Jeremy","Time to speed up, the warship is just up ahead!",0,3,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if sceneDelay=60 {backFollow.xScrollSpeed=-12}
      else if sceneDelay=200
      {
        msgCreate(0,0,"Jeremy","Oh what, watch out!!",0,3,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=360
      {
        oDragoonShip.bCanUseWeapon=0
        oDragoonShip.bCanSuck=0
        var tEndLaser,tYY;
        tYY=-64
        for(i=0;i<17;i+=1)
        {
          tEndLaser=instance_create(room_width+32,oPlayer1.y+tYY,oEndShooterLaser)
          tEndLaser.type=1
          tYY+=8
        }
      }
      else if sceneDelay=540
      {
        msgCreate(0,0,"Jeremy","Jump out of that thing. It's going down!",0,3,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      else if sceneDelay=630
      {
        msgCreate(0,0,"Jerry","Jump out up here?! You crazy?!",0,3,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=700
      {
        msgCreate(0,0,"Jeremy","Trust me on this.",0,3,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if sceneDelay=760
      {
        msgCreate(0,0,"Jerry","Alright Claire, let's do this.",0,3,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if sceneDelay=820
      {
        oDragoonShip.visible=0
        for(i=0;i<6;i+=1)
        {
          var tEffect;
          tEffect=instance_create(oDragoonShip.x+random_range(-12,12),oDragoonShip.y+random_range(-12,12),oEffect)
          tEffect.sprite_index=sMMExplosion; tEffect.image_speed=0.5
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=-4-random(2); tEffect.ySpd=random_range(-0.5,0.5)
        }
        shipJerry=instance_create(oDragoonShip.x+4,oDragoonShip.y-12,oMisc)
        shipJerry.type=0; shipJerry.sprite_index=sJerryAirDash; shipJerry.image_speed=0.66
        shipClaire=instance_create(oDragoonShip.x-4,oDragoonShip.y+12,oMisc)
        shipClaire.type=0; shipClaire.sprite_index=sClaireAirDash; shipClaire.image_speed=0.66
      }
      else if sceneDelay>=850
      {
        shipJerry.x+=16; shipClaire.x+=16
        if shipJerry.x>=room_width+40
        {
          if global.shooterProgress<8 {global.shooterProgress=8}
          global.bShooter=0
          global.bossTrack=0
          global.newMapX=1072
          global.newMapY=416
          room_goto(rWarshipA)
        }
      }
    }
  }
}

keyWaitForInput()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeAlpha>0
{
  draw_set_alpha(fadeAlpha)
  draw_set_color(fadeColor)
  draw_rectangle(view_xview[0]-1,view_yview[0]-1,view_xview[0]+view_wview[0]+1,view_yview[0]+view_hview[0]+1,0)
}
