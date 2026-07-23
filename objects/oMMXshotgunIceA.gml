#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-5,-5,5,5)

damageType="ELEMENTAL"
weaponTag=11
atkLv=global.stMega_ShotIce[0]
atkPower=50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10]
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_ShotIce[2]+=1
stunTime=3
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

bulletSpeed=11
lifeTime=35
lingerFrame=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if lingerFrame=0
  {
    if oGame.time mod 2=0
    {
      tEffect=instance_create(x+random_range(-2,2),y+random_range(-2,2),oEffect)
      tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.5; tEffect.image_angle=random(360)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=1.5
    }

    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=5.5}
    else {bulletSpeed=11}

    speed=bulletSpeed
    if direction=0 {image_angle-=10}
    else {image_angle+=10}

    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if isCollisionLeft(1)
    {
      var tFreezerCore;
      tFreezerCore=0
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=33 //Equipment: Freezer Core
        {
          tFreezerCore=1
          break;
        }
      }

      if tFreezerCore=0
      {
        var playerAttack,tIceDir;
        tIceDir=45
        for(i=0;i<3;i+=1)
        {
          playerAttack=instance_create(x+9+lengthdir_x(3,tIceDir),y+lengthdir_y(3,tIceDir),oMMXshotgunIceB)
          playerAttack.direction=tIceDir
          tIceDir-=45
        }
      }
      else
      {
        var playerAttack,tIceDir;
        tIceDir=45
        for(i=0;i<5;i+=1)
        {
          playerAttack=instance_create(x+9+lengthdir_x(3,tIceDir),y+lengthdir_y(3,tIceDir),oMMXshotgunIceB)
          playerAttack.direction=tIceDir
          tIceDir-=22.5
        }
      }
      playSound(global.snd_IceGunSplit,0,0.95,1)
      lingerFrame=1; speed=0; visible=0
    }
    if isCollisionRight(1)
    {
      var tFreezerCore;
      tFreezerCore=0
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=33 //Equipment: Freezer Core
        {
          tFreezerCore=1
          break;
        }
      }

      if tFreezerCore=0
      {
        var playerAttack,tIceDir;
        tIceDir=135
        for(i=0;i<3;i+=1)
        {
          playerAttack=instance_create(x-9+lengthdir_x(3,tIceDir),y+lengthdir_y(3,tIceDir),oMMXshotgunIceB)
          playerAttack.direction=tIceDir; playerAttack.image_xscale=-1
          tIceDir+=45
        }
      }
      else
      {
        var playerAttack,tIceDir;
        tIceDir=135
        for(i=0;i<5;i+=1)
        {
          playerAttack=instance_create(x-9+lengthdir_x(3,tIceDir),y+lengthdir_y(3,tIceDir),oMMXshotgunIceB)
          playerAttack.direction=tIceDir; playerAttack.image_xscale=-1
          tIceDir+=22.5
        }
      }
      playSound(global.snd_IceGunSplit,0,0.95,1)
      lingerFrame=1; speed=0; visible=0
    }
    lifeTime-=1
    if lifeTime=0 {instance_destroy()}
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}
