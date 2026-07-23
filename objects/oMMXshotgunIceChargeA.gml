#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-12,-12,12,12)

damageType="ELEMENTAL"
weaponTag=11
atkLv=global.stMega_ShotIce[0]
atkPower=round((50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10])*1.5)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_ShotIce[2]+=1
stunTime=3
bCanPierce=1

direction=90
bulletSpeed=3
lifeTime=40
bShatter=0
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
      tEffect=instance_create(x+random_range(-9,9),y+random_range(-9,9),oEffect)
      tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.25+random(0.25)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=random_range(-1,1); tEffect.ySpd=1.5
    }

    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=1.5}
    else {bulletSpeed=3}

    speed=bulletSpeed

    if isCollisionLeft(1) {bShatter=1}
    if isCollisionRight(1) {bShatter=1}
    if isCollisionBottom(1) {bShatter=1}
    if isCollisionTop(1) {bShatter=1}
    lifeTime-=1
    if lifeTime=0 {bShatter=1}

    if bShatter=1
    {
      var tFreezerCore;
      tFreezerCore=8
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=33 //Equipment: Freezer Core
        {
          tFreezerCore=12
          break;
        }
      }

      var playerAttack,tIceDir; tIceDir=0
      for(i=0;i<tFreezerCore;i+=1)
      {
        playerAttack=instance_create(x+lengthdir_x(6,tIceDir),y+lengthdir_y(6,tIceDir),oMMXshotgunIceChargeB)
        playerAttack.direction=tIceDir; playerAttack.image_angle=tIceDir
        tIceDir+=360/tFreezerCore
      }
      lingerFrame=1; speed=0; visible=0
    }
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}
