#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
image_xscale=2; image_yscale=2

sequence=0
seqTime=0
damageTaken=0
bCameraMove=0
flashSprite=0
spawnTime=0
spawnDelay=1000000

myKillBox=instance_create(x,y,oStaticSpikeRed)
myKillBox.sprite_index=sprite_index; myKillBox.visible=0
myKillBox.image_xscale=2.05; myKillBox.image_yscale=2.05
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sequence=0
  {
    playSound(global.snd_DemonVoice1,0,1,17000)
    var tHexFlash,tCamera;
    tHexFlash=instance_create(1936,144,oVaultHexFlash); tHexFlash.image_xscale=-1
    tCamera=instance_create(1840,0,oGameCamera); tCamera.type=0
    view_object[0]=oGameCamera
    sequence+=1
  }
  else if sequence=1 //Rise up
  {
    yVel=-16
    var tEffect;
    tEffect=instance_create(x+random_range(-168,168),room_height-2,oEffectB)
    tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
    tEffect.direction=random_range(1,179); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0

    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x+random_range(-140,140),y,oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.4; tEffect.image_yscale=-1
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(3); tEffect.image_xscale=choose(-1,1)
    }

    if y<=176 {sequence+=1}
  }
  else if sequence=2 //Rotate and fall to ground
  {
    yVel+=0.6
    if yVel<0
    {
      var tEffect;
      for(i=0;i<3;i+=1)
      {
        tEffect=instance_create(x+random_range(-192,192),y,oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.3+random(0.1); tEffect.image_yscale=-1
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(3); tEffect.image_xscale=choose(-1,1)
      }
    }
    if yVel>-9
    {
      if seqTime<90
      {
        image_angle-=2.3
        seqTime+=2.3
      }
      else {image_angle=270}
    }
    if y>=144 and yVel>3
    {
      y=144
      yVel=0
    }

    if yVel=0 and image_angle=270
    {
      var tEffect;
      for(i=0;i<48;i+=1)
      {
        tEffect=instance_create(x+random_range(-10,320),288,oEffect)
        tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.3+random(0.1); tEffect.image_xscale=choose(-1,1)
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1-random(3)
      }
      seqTime=0; sequence+=1
    }
  }
  else if sequence=3 //Slight wait (Destroy the killbox)
  {
    seqTime+=1
    if seqTime=1 //Shake screen
    {
      playSound(global.snd_BombExplode,0,0.98,13000)
      oGameCamera.shakeAmp=6; oGameCamera.shakeTime=20
    }
    else if seqTime=10
    {
      with myKillBox {instance_destroy()}
    }
    else if seqTime=30
    {
      seqTime=0; sequence+=1
    }
  }
  else if sequence=4 //Spawn arm
  {
    seqTime+=1
    if seqTime=10
    {
      msgCreate(0,0,"Hex","Meet the greatest creation left behind.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if seqTime=20
    {
      for(i=0;i<4;i+=1)
      {
        bossArm[i]=instance_create(x+266+(i*16),y-114,oVAbom_P2_Arm)
        bossArm[i].waveOffset=i*0.41
      }
    }
    else if seqTime>=21 and seqTime<=110
    {
      for(i=0;i<4;i+=1)
      {
        bossArm[i].x+=0.25+(i*0.25)
        bossArm[i].x+=0.25+(i*0.25)
      }
    }
    else if seqTime=111
    {
      msgCreate(0,0,"Jerry","Would rather not.",0,1,oMessagePerson,0)
      newMessage.fadingTime=40
    }
    else if seqTime>=130
    {
      myClaw=instance_create(bossArm[3].x,bossArm[3].y,oVAbom_P2_Claw)
      seqTime=0; sequence+=1
    }
  }
  else if sequence=5 //Survive
  {
    seqTime+=1
    if seqTime=90
    {
      msgCreate(0,0,"Jeremy","What is that thing? All data is locked on it.",0,1,oMessagePerson,0)
      newMessage.fadingTime=95
    }
    else if seqTime=180
    {
      msgCreate(0,0,"Hex","A creature trapped forever in the Vault by the program. The immense output from this thing could easily level the mainland in no time at all.",0,3,oMessagePerson,0)
      newMessage.fadingTime=180
    }
    else if seqTime=360
    {
      msgCreate(0,0,"Jeremy","Why does it exist? Did the designers put this in?",0,1,oMessagePerson,0)
      newMessage.fadingTime=100
      spawnDelay=360
    }
    else if seqTime=460
    {
      msgCreate(0,0,"Hex","The program was designed to make content on the fly with small amounts of data. I found out during the early stages of the program becoming aware, it created this by accident from loose data strings.",0,3,oMessagePerson,0)
      newMessage.fadingTime=250
    }
    else if seqTime=710
    {
      msgCreate(0,0,"Jeremy","What does that even mean?",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if seqTime=770
    {
      msgCreate(0,0,"Hex","It didn't know what to do with much of the data it was fed. Instead of creating what it was supposed to, this amalgamation was made.",0,2,oMessagePerson,0)
      newMessage.fadingTime=190
    }
    else if seqTime=960
    {
      msgCreate(0,0,"Jeremy","There has to be a way to destroy it.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if seqTime=1030
    {
      msgCreate(0,0,"Jerry","Can you just figure out how to get us out of this position lock?",0,1,oMessagePerson,0)
      newMessage.fadingTime=110
    }
    else if seqTime=1140
    {
      msgCreate(0,0,"Hex","You can't destroy it. Nothing can.",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if seqTime=1210
    {
      msgCreate(0,0,"Jeremy","There we go, I think I figured out the position lock that Hex put up.",0,1,oMessagePerson,0)
      newMessage.fadingTime=110
    }
    else if seqTime=1320
    {
      msgCreate(0,0,"Hex","Oh that's right. You haven't seen the greatest thing it can do.",0,1,oMessagePerson,0)
      newMessage.fadingTime=110
    }
    else if seqTime>=1400
    {
      spawnDelay=420; seqTime=0; sequence+=1
    }
  }
  else if sequence=6 //Chase
  {
    seqTime+=1
    if seqTime=1
    {
      for(i=0;i<4;i+=1)
      {
        bossLeg[i]=instance_create(x+30+(i*48),y+136,oVAbom_P2_Legs)
        bossLeg[i].waveOffset=i*0.41; bossLeg[i].image_speed=0
      }
    }
    else if seqTime=70
    {
      msgCreate(0,0,"Jeremy","The hell?",0,0,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    else if seqTime=120
    {
      msgCreate(0,0,"Hex","I really like that feature of it. You just never know what this thing will do next.",0,2,oMessagePerson,0)
      newMessage.fadingTime=120
    }
    else if seqTime=140
    {
      var tempMplay;
      tempMplay=findMusic(822)
      playMusic(tempMplay,0,0)
      playSound(global.snd_DemonVoice1,0,1,17000)
      bCameraMove=1
      for(i=0;i<4;i+=1)
      {
        bossLeg[i].image_speed=0.1
        bossLeg[i].bMove=1
      }
      myCollision[0]=instance_create(x+222,0,oMovingSolid)
      with myCollision[0]
      {
        viscidTop=1; makeActive()
        sprite_index=sInvisibleSolidMask; visible=0; image_yscale=18; xVel=2
      }
      myCollision[1]=instance_create(x+177,0,oMovingSolid)
      with myCollision[1]
      {
        viscidTop=1; makeActive()
        sprite_index=sInvisibleSolidMask; visible=0; image_xscale=10; image_yscale=3; xVel=2
      }
      myCollision[2]=instance_create(x+177,y+99,oMovingSolid)
      with myCollision[2]
      {
        viscidTop=1; makeActive()
        sprite_index=sInvisibleSolidMask; visible=0; image_xscale=8; image_yscale=3; xVel=2
      }
      myCollision[3]=instance_create(x+273,y+115,oMovingSolid)
      with myCollision[3]
      {
        viscidTop=1; makeActive()
        sprite_index=sInvisibleSolidMask; visible=0; image_xscale=4; image_yscale=2; xVel=2
      }
      if oPlayer1.x<=1794 {oPlayer1.x=1800}
      if oPlayer1.x<=1894 and oPlayer1.y>=243 {oPlayer1.y-=32}
      flashSprite=1
    }
    else if seqTime=240
    {
      msgCreate(0,0,"Jeremy","You can stop that.",0,0,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if seqTime=310
    {
      msgCreate(0,0,"Hex","I don't control it, at least not yet.",0,1,oMessagePerson,0)
      newMessage.fadingTime=80
    }
    else if seqTime=390
    {
      msgCreate(0,0,"Jerry","Jeremy, this thing doesn't seem to be affected by what we do.",0,2,oMessagePerson,0)
      newMessage.fadingTime=120
    }
    else if seqTime=510
    {
      msgCreate(0,0,"Hex","I told you, this creature is unstoppable!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if seqTime=600
    {
      msgCreate(0,0,"Jeremy","Damn it, sorry you guys. I'm trying to get you out of this.",0,2,oMessagePerson,0)
      newMessage.fadingTime=120
    }
    else if seqTime=720
    {
      msgCreate(0,0,"Hex","Does it bother you that somewhere in this place, your sister is suffering?",0,2,oMessagePerson,0)
      newMessage.fadingTime=120
      playSound(global.snd_DemonVoice1,0,1,42000)
      spawnDelay=150
    }
    else if seqTime=840
    {
      msgCreate(0,0,"Jeremy","Shut up!",0,0,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    else if seqTime=890
    {
      msgCreate(0,0,"Hex","Let's play a little game. If you can manage to get away from this thing, I'll tell you where she is... if it isn't too late already.",0,3,oMessagePerson,0)
      newMessage.fadingTime=200
    }
    else if seqTime=1400
    {
      msgCreate(0,0,"Jeremy","I can see something up ahead. When the time is right, I'm going to change this.",0,2,oMessagePerson,0)
      newMessage.fadingTime=130
    }
    else if seqTime=1530
    {
      msgCreate(0,0,"Hex","What are you plotting now?",0,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
    else if seqTime=1600
    {
      msgCreate(0,0,"Jeremy","Piss off!",0,0,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    else if seqTime=1650
    {
      msgCreate(0,0,"Jerry","How long? These things are annoying.",0,1,oMessagePerson,0)
      newMessage.fadingTime=80
    }
    else if seqTime=1710 {playSound(global.snd_DemonVoice1,0,1,40000); oVAbom_P2_Claw.fireDelay=100}
    else if seqTime=1730
    {
      msgCreate(0,0,"Jeremy","Just hold out a little bit longer.",0,1,oMessagePerson,0)
      newMessage.fadingTime=80
      seqTime=0; sequence+=1
    }
  }
  else if sequence=7 //End chase
  {
    if x>=5128
    {
      bCameraMove=0
      oVAbom_P2_Claw.fireDelay=1000000
      spawnDelay=1000000
      for(i=0;i<4;i+=1)
      {
        with myCollision[i] {instance_destroy()}
      }
      with oGameCamera {instance_destroy()}
      view_object[0]=oPlayer1
      xVel=0
      seqTime=0; sequence+=1
    }
  }

  //-- Continual effects --
  if sequence<=3 {myKillBox.x=x; myKillBox.y=y; myKillBox.image_angle=image_angle} //Kill box
  if instance_exists(oVAbom_P2_Claw) //Claw follow arm
  {
    myClaw.x=bossArm[3].x; myClaw.y=bossArm[3].y
  }
  if bCameraMove=1 //Objects follow camera
  {
    var tEffect;
    tEffect=instance_create(x+random_range(-10,320),304+random(32),oEffect)
    tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.3+random(0.1)
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=-0.5-random(1); tEffect.ySpd=-1-random(1)
    oGameCamera.x+=2
    xVel=2
    myClaw.x+=2
    for(i=0;i<4;i+=1)
    {
      bossLeg[i].x+=2
      bossArm[i].x+=2
    }
  }
  if flashSprite>0 //Flash sprite
  {
    flashSprite+=1
    if flashSprite>=2 and flashSprite<=11 {image_blend=make_color_rgb(255-(flashSprite*10),255-(flashSprite*10),255-(flashSprite*10))}
    else if flashSprite>=12 and flashSprite<=21 {image_blend=make_color_rgb(205+(flashSprite*5),205+(flashSprite*5),205+(flashSprite*5))}
    else if flashSprite=22 {image_blend=c_white; flashSprite=0}
  }

  spawnTime+=1
  if spawnTime>=spawnDelay and instance_number(oAbomSpawn)<2
  {
    instance_create(x+96,y,oAbomSpawn)
    spawnTime=0
  }
}
