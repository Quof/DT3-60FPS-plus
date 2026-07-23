#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
global.tempAction[0]=0

shotTime=0
shotDelay=15

eventProg=0
eventTime=0
setSpawnDir=180
setSpawnRate=65
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if eventProg=1 and global.gamePaused=false
{
  //---------- Defend self ----------
  shotTime+=1
  if shotTime=8 {sprite_index=sSeraIdle}
  if shotTime>=shotDelay
  {
    if instance_exists(oSeraInjector)
    {
      myTarget=instance_nearest(x,y-20,oSeraInjector)
      if point_distance(x,y-20,myTarget.x,myTarget.y)<=160
      {
        //Check facing
        if myTarget.x>x {image_xscale=1}
        else {image_xscale=-1}
        //Check height
        if myTarget.y<y-60
        {
          sprite_index=sSeraSpearStabB
          xx=21; yy=42
        }
        else if myTarget.y>y+24
        {
          sprite_index=sSeraSpearStabC
          xx=21; yy=6
        }
        else
        {
          sprite_index=sSeraSpearStabA
          xx=29; yy=23
        }
        //Fire spear projectile
        var mySpear;
        mySpear=instance_create(x+(xx*image_xscale),y-yy,oSeraSpearShot)
        mySpear.direction=point_direction(x+(xx*image_xscale),y-yy,myTarget.x,myTarget.y)
        if sprite_index=sSeraSpearStabA
        {
          var tEffect;
          tEffect=instance_create(x+(29*image_xscale),y-23,oEffect)
          tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.33; tEffect.xSpd=0; tEffect.ySpd=0
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
          if image_xscale=1 {tEffect.image_angle=0}
          else {tEffect.image_angle=180}
        }
        else if sprite_index=sSeraSpearStabB
        {
          var tEffect;
          tEffect=instance_create(x+(21*image_xscale),y-42,oEffect)
          tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.25; tEffect.xSpd=0; tEffect.ySpd=0
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
          if image_xscale=1 {tEffect.image_angle=45}
          else {tEffect.image_angle=135}
        }
        else if sprite_index=sSeraSpearStabC
        {
          var tEffect;
          tEffect=instance_create(x+(21*image_xscale),y-6,oEffect)
          tEffect.sprite_index=sSeraEfSpearWave; tEffect.image_speed=0.33; tEffect.xSpd=0; tEffect.ySpd=0
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100
          if image_xscale=1 {tEffect.image_angle=315}
          else {tEffect.image_angle=225}
        }
        shotTime=0
      }
    }
  }
  //---------- Virus Invasion Sequence ----------
  eventTime+=1
  if eventTime mod setSpawnRate=0 //Set spawn
  {
    newVirus=instance_create(x+lengthdir_x(208,setSpawnDir),y-20+lengthdir_y(208,setSpawnDir),oSeraInjector)
    with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
    setSpawnDir+=10
  }

  if eventTime=10
  {
    global.tempAction[0]=325
    for(i=0;i<3;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=35
    }
  }
  else if eventTime=70
  {
    global.tempAction[0]=145
    for(i=0;i<3;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=35
    }
  }
  else if eventTime=130
  {
    global.tempAction[0]=55
    for(i=0;i<3;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=35
    }
  }
  else if eventTime=190
  {
    global.tempAction[0]=235
    for(i=0;i<3;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=35
    }
  }
  else if eventTime=280
  {
    global.tempAction[0]=0
    for(i=0;i<4;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=90
    }
  }
  else if eventTime=360
  {
    global.tempAction[0]=45
    for(i=0;i<4;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=90
    }
  }
  else if eventTime=410
  {
    if setSpawnRate=65
    {
      setSpawnRate=55
      eventTime=0
    }
  }
  else if eventTime=440
  {
    global.tempAction[0]=0
    for(i=0;i<8;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=1; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=45
    }
  }
  else if eventTime=530
  {
    global.tempAction[0]=22.5
    for(i=0;i<8;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=1; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=45
    }
  }
  else if eventTime=700
  {
    global.tempAction[0]=0
    for(i=0;i<4;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=90
    }
  }
  else if eventTime=740
  {
    global.tempAction[0]=45
    for(i=0;i<4;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=90
    }
  }
  else if eventTime=780
  {
    if setSpawnRate=55
    {
      setSpawnRate=45
      eventTime=400
    }
  }
  else if eventTime=840
  {
    global.tempAction[0]=0
    for(i=0;i<8;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=1.5; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=45
    }
  }
  else if eventTime=930
  {
    global.tempAction[0]=55
    for(i=0;i<3;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=35
    }
  }
  else if eventTime=960
  {
    global.tempAction[0]=235
    for(i=0;i<3;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=35
    }
  }
  else if eventTime=990
  {
    global.tempAction[0]=0
    for(i=0;i<4;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=90
    }
  }
  else if eventTime=1020
  {
    global.tempAction[0]=45
    for(i=0;i<4;i+=1)
    {
      newVirus=instance_create(x+lengthdir_x(208,global.tempAction[0]),y-20+lengthdir_y(208,global.tempAction[0]),oSeraInjector)
      with newVirus {moveSpeed=2; direction=point_direction(x,y,oNPC_Sera.x,oNPC_Sera.y-26)}
      global.tempAction[0]+=90
    }
  }
  else if eventTime=1050
  {
    if setSpawnRate=45 {setSpawnRate=30}
    else if setSpawnRate=30 {setSpawnRate=10}
    else
    {
      if setSpawnRate>1 {setSpawnRate-=1}
    }
    eventTime=800
  }

  if instance_exists(oSeraInjector)
  {
    myTarget=instance_nearest(x,y-20,oSeraInjector)
    if point_distance(x,y-20,myTarget.x,myTarget.y)<=5 //Sera is infected
    {
      sprite_index=sSeraHit
      eventProg=2
      oEvCh17MainA.sceneProgress=2
      playSound(global.snd_Infect,0,1,22050+random(2205))
      playSound(global.snd_HardHit1,0,0.95,1)
      with oSeraInjector
      {
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
        tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_destroy()
      }
    }
  }
}
