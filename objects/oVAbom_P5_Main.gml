#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bShowHealthBar=false
bCanTakeDamage=false
image_xscale=2; image_yscale=2
xVel=0; yVel=0
bActive=1

//Enemy base statistics
eName="Abomination"
eLevel=20
maxLife=100000
life=maxLife
atkPower=20
affiliation=9
bIsBoss=true

seqTime=0
if global.bossTrack=101 {sequence=10}
else {sequence=0}
bossProgress=0
moveSpd=1
dirArcMod=1
damageTakenSession=0
damageTakenTotal=0

shotTime=0
shotDelay=40

laserWarn=0
cirRad=32
circleAlpha=1

jeremyText="for(i=0;i<x;i++)
{
  //Incomplete sequence
}"
chaoText="I'm unable to get any new info on it, behaviors will just need to be observed. Jeremy is having an even harder time."
devText="No Dev Commentary at this time."

myHS=instance_create(x,y,oVAbomP5_Hitspot)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sequence=0 //----- Init -----
  {
    var tEffect;
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x+random_range(-168,168),280+random(64),oEffectB)
      tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
      tEffect.direction=random_range(1,179); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    seqTime+=1
    if seqTime=1
    {
      x=oPlayer1.x; y=room_height+352; visible=1
      playSound(global.snd_DemonVoice1,0,1,17000)
    }
    else if seqTime=60
    {
      if bossProgress=0
      {
        msgCreate(0,0,"Jeremy","Don't touch it, it has a damage box now. I'll try to remove that.",0,1,oMessagePerson,0)
        newMessage.fadingTime=100
      }
      seqTime=0; sequence+=1
    }
  }
  else if sequence=1 //----- Rise up -----
  {
    if bossProgress>0 //Find player location (Not on first pass)
    {
      if x<oPlayer1.x {dirArcMod=1}
      else {dirArcMod=-1}
    }
    yVel=-16
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x+random_range(-140,140),y,oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.4; tEffect.image_yscale=-1
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1+random(3); tEffect.image_xscale=choose(-1,1)
    }

    if y<=240 {sequence+=1}
  }
  else if sequence=2 //----- Rotate and fall to ground -----
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
        image_angle-=2.3*dirArcMod
        seqTime+=2.3
      }
      else
      {
        if dirArcMod=1 {image_angle=270}
        else {image_angle=90}
      }
    }
    if y>=152 and yVel>3
    {
      y=152
      yVel=0
    }

    if yVel=0 and (image_angle=270 or image_angle=90)
    {
      playSound(global.snd_BombExplode,0,0.98,13000)
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
  else if sequence=3 //----- Slight wait (Start move) -----
  {
    seqTime+=1
    if bossProgress=0 //First pass
    {
      if seqTime=20
      {
        msgCreate(0,0,"Jerry","Screw this, I'm not running this time! You with me on this, Claire?",0,1,oMessagePerson,0)
        newMessage.fadingTime=95
      }
      else if seqTime=120
      {
        msgCreate(0,0,"Claire","Of course! Let's take this thing on!",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if seqTime=180
      {
        xVel=1
        msgCreate(0,0,"Jeremy","I don't think you can beat this thing head on. Hold up, I'll try something. Just do what you can for the time being.",0,2,oMessagePerson,0)
        newMessage.fadingTime=170
      }
      else if seqTime>=230 {seqTime=0; sequence+=1}
    }
    else if bossProgress>=1 //Normal
    {
      if seqTime>=45
      {
        xVel=moveSpd*dirArcMod
        seqTime=0; sequence+=1
      }
    }
  }
  else if sequence=4 //----- Attack -----
  {
    seqTime+=1
    if bossProgress=0 //First pass
    {
      if seqTime=170
      {
        msgCreate(0,0,"Jeremy","I'm going to activate the split mode. Keep in mind where your partner is before switching.",0,2,oMessagePerson,0)
        newMessage.fadingTime=125
      }
      else if seqTime=300
      {
        global.partySplit=1
        var tPlayerIdle;
        tPlayerIdle=instance_create(176,272,oPlayerIdle)
        with tPlayerIdle {xThres=0; newX=176; newY=272}
        seqTime=0
        bossProgress=1
      }
    }
    else if bossProgress>=1 //-- Normal attack phase --
    {
      shotTime+=1
      if (image_angle=270 and oPlayer1.x<x) or (image_angle=90 and oPlayer1.x>x)
      {
        if shotTime>=shotDelay
        {
          var tNewAttack,tDir,tX,tY;
          tX=random_range(96,192); if image_angle=270 {tX*=-1}
          tY=random_range(-64,64)
          tDir=point_direction(x+tX,y+tY,oPlayer1.x,oPlayer1.y-26)

          tNewAtk=instance_create(x+tX,y+tY,oPassBullet)
          tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=9; tNewAtk.bulletSpeed=4; tNewAtk.image_speed=0.33
          tNewAtk.decayTime=-100; tNewAtk.image_xscale=1.5; tNewAtk.image_yscale=1.5; tNewAtk.direction=tDir
          shotTime=0
        }
      }

      //Check if close to edge of map
      if (xVel>0 and x>=1216) or (xVel<0 and x<=320) {yVel=2; seqTime=0; sequence+=1}
    }
  }
  else if sequence=5 //----- Dive down -----
  {
    var tEffect;
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x+random_range(-168,168),280+random(64),oEffectB)
      tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
      tEffect.direction=random_range(1,179); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }

    yVel+=0.2
    if xVel>0 {image_angle-=1.75}
    else {image_angle+=1.75}
    if y>=room_height+240
    {
      if damageTakenSession>=450
      {
        for(i=0;i<4;i+=1)
        {
          instance_create(x+random_range(-96,96),y+random_range(-96,96),oAbomSpawn)
        }
      }
      oVAbomP5_Hitspot.bCanTakeDamage=false
      visible=0; xVel=0; seqTime=0; sequence+=1
    }
  }
  else if sequence=6 //Slight wait
  {
    seqTime+=1
    if seqTime>=30
    {
      if damageTakenTotal>=900 and damageTakenTotal<=1799 {shotDelay=36}
      else if damageTakenTotal>=1800 and damageTakenTotal<=2699 {shotDelay=32}
      else if damageTakenTotal>=2700 and damageTakenTotal<=3399 {shotDelay=28}

      if damageTakenTotal>=3400 {damageTakenSession=0; image_angle=0; seqTime=0; sequence=9}
      else {damageTakenSession=0; image_angle=0; seqTime=0; sequence=0}
    }
  }
  else if sequence=9 //Initiate checkpoint
  {
    global.bossTrack=101
    xVel=0; yVel=0
    instance_create(0,0,oCheckpointNotice)
    sequence+=1
  }
  else if sequence=10 //----- Second phase start -----
  {
    var tempMplay;
    tempMplay=findMusic(823)
    playMusic(tempMplay,0,0)
    shotTime=0; shotDelay=0
    damageTakenTotal=0
    bCanDealDamage=false
    with oWeaponRecharger {instance_destroy()}
    x=768; y=room_height+160; image_angle=270; visible=1
    myCollision=instance_create(x,y,oMovingSolid)
    with myCollision
    {
      viscidTop=1
      makeActive()
      visible=0
      sprite_index=sAbom_Base
      image_xscale=2; image_yscale=2; image_angle=270
    }
    sequence+=1
  }
  else if sequence=11 //----- Rise up slowly -----
  {
    seqTime+=1
    if seqTime=10 {yVel=-1}
    if y<=room_height {yVel=0; seqTime=0; sequence+=1}
  }
  else if sequence=12 //----- Grow new head -----
  {
    seqTime+=1
    if seqTime=1
    {
      wallBehindHead=instance_create(880,0,oInvisibleSolid)
      wallBehindHead.image_xscale=4; wallBehindHead.image_yscale=22
    }
    if seqTime=11 {instance_create(x+152,y-140,oVAbomP5_Head)}
    else if seqTime>=11 and seqTime<=90
    {
      oVAbomP5_Head.image_xscale+=0.025
      oVAbomP5_Head.image_yscale+=0.025
    }
    else if seqTime>=101 and seqTime<=115 {oVAbomP5_Head.jawAngle+=1}
    else if seqTime=130
    {
      view_visible[1]=0
      global.partySplit=0
      with oPlayerIdle {instance_destroy()}
      with oPlayerShieldBubble {instance_destroy()}
      playSound(global.snd_DemonVoice2,0,0.98,8000)
      var tHexFlash;
      tHexFlash=instance_create(488,96,oVaultHexFlash); tHexFlash.image_xscale=-1
      oPlayer1.x=480; oPlayer1.y=249
    }
    else if seqTime>=161 and seqTime<=175 {oVAbomP5_Head.jawAngle-=1}

    if seqTime=150
    {
      msgCreate(0,0,"Hex","I don't know how you managed to get through the maze and the spike wall, but it doesn't matter. Your attempts to truly harm this are wasted.",0,2,oMessagePerson,0)
      newMessage.fadingTime=160
    }
    else if seqTime>=300 {seqTime=0; sequence+=1}
  }
  else if sequence=13 //----- Attack phase -----
  {
    seqTime+=1
    if oVAbomP5_Head.jawAngle>0 {oVAbomP5_Head.bCanTakeDamage=true}
    else {oVAbomP5_Head.bCanTakeDamage=false}

    if seqTime>=31 and seqTime<=45 {oVAbomP5_Head.jawAngle+=1}
    else if seqTime>=50 and seqTime<=125
    {
      if shotTime mod 4=0 and shotTime>=4 //Extra laser phase
      {
        if seqTime=51 {laserWarn=1}
        else if seqTime=80 {laserDir=point_direction(x-12,y-282,oPlayer1.x,oPlayer1.y-26)}
        else if seqTime>=81 and seqTime<=124
        {
          for(i=0;i<2;i+=1)
          {
            tNewAtk=instance_create(x-12,y-282,oPassBullet)
            tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=9; tNewAtk.bulletSpeed=6+random(2.5); tNewAtk.image_speed=0.33
            tNewAtk.decayTime=-100; tNewAtk.image_xscale=1.33; tNewAtk.image_yscale=1.33; tNewAtk.direction=laserDir+random_range(-8,8)
          }
        }
      }

      if shotTime mod 3=0 and seqTime mod 30=0 //Spawn spawns
      {
        instance_create(x-12,y-282,oAbomSpawn)
      }
      if seqTime mod 19=0 //Fire projectiles
      {
        var tNewAttack,tDir;
        tDir=point_direction(x-12,y-282,oPlayer1.x,oPlayer1.y-26)
        tDir-=30
        for(i=0;i<3;i+=1)
        {
          tNewAtk=instance_create(x-12,y-282,oPassBullet)
          tNewAtk.sprite_index=sBTFireball; tNewAtk.atkPower=9; tNewAtk.bulletSpeed=5; tNewAtk.image_speed=0.33
          tNewAtk.decayTime=-100; tNewAtk.image_xscale=1.25; tNewAtk.image_yscale=1.25; tNewAtk.direction=tDir
          tDir+=30
        }
      }
    }
    else if seqTime>=131 and seqTime<=145 {oVAbomP5_Head.jawAngle-=1}
    else if seqTime>=160 {shotTime+=1; seqTime=0}

    if damageTakenTotal>=700 and shotDelay=0
    {
      for(i=0;i<4;i+=1)
      {
        tEffect=instance_create(oPlayer1.x+lengthdir_x(216,i*90),oPlayer1.y+lengthdir_y(216,i*90),oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.followID=-1
        tEffect.image_xscale=0.33; tEffect.image_yscale=0.33; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_create(oPlayer1.x+lengthdir_x(216,i*90),oPlayer1.y+lengthdir_y(216,i*90),oAbomSpawn)
      }
      shotDelay+=1
    }
    else if damageTakenTotal>=1400 and shotDelay=1
    {
      for(i=0;i<6;i+=1)
      {
        tEffect=instance_create(oPlayer1.x+lengthdir_x(216,i*60),oPlayer1.y+lengthdir_y(216,i*60),oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.followID=-1
        tEffect.image_xscale=0.33; tEffect.image_yscale=0.33; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_create(oPlayer1.x+lengthdir_x(216,i*60),oPlayer1.y+lengthdir_y(216,i*60),oAbomSpawn)
      }
      shotDelay+=1
    }
    else if damageTakenTotal>=2100 and shotDelay=2
    {
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(oPlayer1.x+lengthdir_x(216,i*45),oPlayer1.y+lengthdir_y(216,i*45),oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.followID=-1
        tEffect.image_xscale=0.33; tEffect.image_yscale=0.33; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        instance_create(oPlayer1.x+lengthdir_x(216,i*45),oPlayer1.y+lengthdir_y(216,i*45),oAbomSpawn)
      }
      shotDelay+=1
    }
    else if damageTakenTotal>=2800
    {
      playSound(global.snd_DemonVoice2,0,0.98,8000)
      oVAbomP5_Head.jawAngle=0
      with wallBehindHead {instance_destroy()}
      seqTime=0; sequence+=1
    }
  }
  else if sequence=14 //----- Shrink back -----
  {
    oVAbomP5_Head.image_xscale-=0.025
    oVAbomP5_Head.image_yscale-=0.025
    oVAbomP5_Head.y+=1
    if oVAbomP5_Head.image_xscale<=0.3
    {
      with oVAbomP5_Head {instance_destroy()}
      sequence+=1
    }
  }
  else if sequence=15 //----- Hex talks -----
  {
    seqTime+=1
    if seqTime=10
    {
      msgCreate(0,0,"Hex","We've stalled enough, it's time for the Abomination to escape!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if seqTime=100
    {
      msgCreate(0,0,"Jeremy","I'm not letting that happen!",0,1,oMessagePerson,0)
      newMessage.fadingTime=60
    }
    else if seqTime=160
    {
      msgCreate(0,0,"Hex","As if you had any power to stop it. The gateway is opening now!",0,1,oMessagePerson,0)
      newMessage.fadingTime=90
    }
    else if seqTime=250
    {
      playSound(global.snd_DemonVoice1,0,1,17000)
      with myCollision {instance_destroy()}
      xVel=5
      seqTime=0; sequence+=1
    }
  }
  else if sequence=16 //----- Run away -----
  {
    var tEffect;
    for(i=0;i<5;i+=1)
    {
      tEffect=instance_create(x+random_range(-168,168),y+random_range(-96,96),oEffectB)
      tEffect.type=3; tEffect.image_speed=0; tEffect.image_index=choose(0,1); tEffect.sprite_index=sPauseM_SkillLv
      tEffect.direction=random_range(1,179); tEffect.speed=random(1)+1; tEffect.fadeSpd=0.03;
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    }
    if x>=room_width+240
    {
      global.bossTrack=0
      with oExit {y+=1000; visible=1}
      with oHealingPost {y+=1000}
      with oVAbomP5_Hitspot {instance_destroy()}
      msgCreate(0,0,"Jeremy","Chase it! I don't know how long it will take for another gateway to open like this!",0,2,oMessagePerson,0)
      newMessage.fadingTime=90
      global.gameProgress=2530
      var tempMplay;
      tempMplay=findMusic(11)
      playMusic(tempMplay,0,0)
      instance_destroy()
    }
  }

  //<<<<<<<<<< Continual effects >>>>>>>>>>
  if sequence>=11 //Move solid collision box
  {
    myCollision.xVel=xVel
    myCollision.yVel=yVel
  }
  x+=xVel; y+=yVel
  if xVel!=0 //Move effect
  {
    var tEffect;
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x+random_range(-192,192),274+random(6),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.followID=-1; tEffect.image_speed=0.3+random(0.1)
      tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=(1+random(2))*-dirArcMod; tEffect.ySpd=-0.75-random(0.75); tEffect.image_xscale=-dirArcMod
    }
  }

  //Laser warn delay
  if laserWarn>0
  {
    laserWarn+=1
    circleAlpha-=0.06
    cirRad-=1
    if laserWarn>=15
    {
      laserWarn=0
      cirRad=32
      circleAlpha=1
    }
  }

  //Check if player can hit based on which side player is on
  if sequence>=3 and sequence<=9
  {
    if (image_angle=270 and oPlayer1.x<x) or (image_angle=90 and oPlayer1.x>x) {oVAbomP5_Hitspot.bCanTakeDamage=true}
    else {oVAbomP5_Hitspot.bCanTakeDamage=false}
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,oVAbomP5_Hitspot.image_blend,image_alpha)

if laserWarn>0
{
  draw_set_alpha(circleAlpha)
  draw_set_color(c_red)
  for(i=0;i<12;i+=1)
  {
    draw_circle(x-12,y-282,cirRad*(i+1),1)
  }
}
