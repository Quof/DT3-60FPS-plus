#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

legA_Check=0
legB_Check=0
legC_Check=0
legD_Check=0

indexCheck=string_char_at(global.extraFlags,5)

if indexCheck="1"
{
  drone_Main=instance_create(1184,262,oLevelDecal); drone_Main.sprite_index=sC_SpiderDroneBody; drone_Main.image_angle=165
  drone_LegA=instance_create(1132,267,oLevelDecal); drone_LegA.sprite_index=sC_SpiderDroneLeg; drone_LegA.image_angle=52
  drone_LegB=instance_create(1168,265,oLevelDecal); drone_LegB.sprite_index=sC_SpiderDroneLeg; drone_LegB.image_angle=64
  drone_LegC=instance_create(1226,266,oLevelDecal); drone_LegC.sprite_index=sC_SpiderDroneLeg; drone_LegC.image_angle=-126
  drone_LegD=instance_create(1277,268,oLevelDecal); drone_LegD.sprite_index=sC_SpiderDroneLeg; drone_LegD.image_angle=-248
  sceneProgress=10
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProgress=0
{
  if oPlayer1.x>=1072 and oPlayer1.y<=288
  {
    sceneProgress+=1
  }
}
else if sceneProgress=1
{
  sceneDelay+=1
  if sceneDelay>=5
  {
    myDrone=instance_create(1184,-32,oLevelDecal)
    myDrone.sprite_index=sCHAOS_SpiderDrone; myDrone.image_index=3; myDrone.image_speed=0; myDrone.image_angle=180
    sceneDelay=0; sceneProgress+=1
  }
}
else if sceneProgress=2
{
  sceneDelay+=1
  if sceneDelay>=1
  {
    myDrone.y+=16
    if myDrone.y>=252
    {
      with myDrone {instance_destroy()}
      playSound(global.snd_BombExplode,0,1,14000)
      var tEffect;
      for(i=0;i<80;i+=1)
      {
        tEffect=instance_create(1184+random_range(-32,32),272+random_range(-32,8),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=1+random(2); tEffect.friction=0.01+random(0.01); tEffect.image_speed=0.1+random(0.1)
        tEffect.fadeSpd=0.02+random(0.02); tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.direction=random_range(30,150)
      }
      drone_Main=instance_create(1184,262,oLevelDecal); drone_Main.sprite_index=sC_SpiderDroneBody; drone_Main.image_angle=165
      drone_LegA=instance_create(1184,262,oLevelDecal); drone_LegA.sprite_index=sC_SpiderDroneLeg; drone_LegA.ySpd=-5
      drone_LegB=instance_create(1184,262,oLevelDecal); drone_LegB.sprite_index=sC_SpiderDroneLeg; drone_LegB.ySpd=-3
      drone_LegC=instance_create(1184,262,oLevelDecal); drone_LegC.sprite_index=sC_SpiderDroneLeg; drone_LegC.ySpd=-4
      drone_LegD=instance_create(1184,262,oLevelDecal); drone_LegD.sprite_index=sC_SpiderDroneLeg; drone_LegD.ySpd=-6
      sceneDelay=0; sceneProgress+=1
    }
  }
}
else if sceneProgress=3
{
  if legA_Check=0
  {
    if drone_LegA.y<=264
    {
      drone_LegA.x-=1; drone_LegA.image_angle+=1
      drone_LegA.y+=drone_LegA.ySpd
      if drone_LegA.ySpd<6 {drone_LegA.ySpd+=0.2}
    }
    else
    {
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(drone_LegA.x+random_range(-8,8),drone_LegA.y+random_range(-8,8),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=1+random(2); tEffect.friction=0.01+random(0.01); tEffect.image_speed=0.1+random(0.1)
        tEffect.fadeSpd=0.02+random(0.02); tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.direction=random_range(70,110)
      }
      legA_Check=1
    }
  }

  if legB_Check=0
  {
    if drone_LegB.y<=264
    {
      drone_LegB.x-=0.5; drone_LegB.image_angle+=2
      drone_LegB.y+=drone_LegB.ySpd
      if drone_LegB.ySpd<6 {drone_LegB.ySpd+=0.2}
    }
    else
    {
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(drone_LegB.x+random_range(-8,8),drone_LegB.y+random_range(-8,8),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=1+random(2); tEffect.friction=0.01+random(0.01); tEffect.image_speed=0.1+random(0.1)
        tEffect.fadeSpd=0.02+random(0.02); tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.direction=random_range(70,110)
      }
      legB_Check=1
    }
  }

  if legC_Check=0
  {
    if drone_LegC.y<=264
    {
      drone_LegC.x+=1; drone_LegC.image_angle-=3
      drone_LegC.y+=drone_LegC.ySpd
      if drone_LegC.ySpd<6 {drone_LegC.ySpd+=0.2}
    }
    else
    {
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(drone_LegC.x+random_range(-8,8),drone_LegC.y+random_range(-8,8),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=1+random(2); tEffect.friction=0.01+random(0.01); tEffect.image_speed=0.1+random(0.1)
        tEffect.fadeSpd=0.02+random(0.02); tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.direction=random_range(70,110)
      }
      legC_Check=1
    }
  }

  if legD_Check=0
  {
    if drone_LegD.y<=264
    {
      drone_LegD.x+=1.5; drone_LegD.image_angle-=4
      drone_LegD.y+=drone_LegD.ySpd
      if drone_LegD.ySpd<6 {drone_LegD.ySpd+=0.2}
    }
    else
    {
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(drone_LegD.x+random_range(-8,8),drone_LegD.y+random_range(-8,8),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sMMSmokeCloud; tEffect.newBlend=-1; tEffect.depth=26
        tEffect.speed=1+random(2); tEffect.friction=0.01+random(0.01); tEffect.image_speed=0.1+random(0.1)
        tEffect.fadeSpd=0.02+random(0.02); tEffect.image_blend=make_color_rgb(140+random(20),140+random(20),140+random(20))
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0; tEffect.direction=random_range(70,110)
      }
      legD_Check=1
    }
  }

  if legA_Check=1 and legB_Check=1 and legC_Check=1 and legD_Check=1
  {
    var tNewString;
    tNewString=string_delete(global.extraFlags,5,1)
    tNewString=string_insert("1",tNewString,5)
    global.extraFlags=tNewString
    sceneProgress+=1
  }
}
