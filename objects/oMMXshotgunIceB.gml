#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-3,-3,3,3)

damageType="ELEMENTAL"
weaponTag=11
atkLv=global.stMega_ShotIce[0]
atkPower=round((50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10])*0.5)
atkPower=weaponDmgMod(0,atkPower)
stunTime=3

bulletSpeed=11
lifeTime=35
bShatter=0
lingerFrame=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initFireDir=image_xscale
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
    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=5.5}
    else {bulletSpeed=11}

    speed=bulletSpeed

    if direction<90 {image_angle-=10}
    else {image_angle+=10}

    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if global.optWeaponTrail=1 {instance_create(x,y,oEfWeaponTrail)}

    if isCollisionLeft(1) {bShatter=1}
    if isCollisionRight(1) {bShatter=1}
    if isCollisionBottom(1) {bShatter=1}
    if isCollisionTop(1) {bShatter=1}
    lifeTime-=1
    if lifeTime=0 {bShatter=1}

    if bShatter=1
    {
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5; tEffect.image_xscale=0.25; tEffect.image_yscale=0.25
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      lingerFrame=1; speed=0; visible=0
    }
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}
