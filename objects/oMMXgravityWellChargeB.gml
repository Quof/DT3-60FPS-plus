#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

damageType="SPECIAL"
weaponTag=12
atkLv=global.stMega_Gravity[0]
atkPower=round((45+round(global.stMega_Gravity[0]*1.5)+global.skillTree[10])/2)
atkPower=weaponDmgMod(0,atkPower)
stunTime=4

bCanHitSwitch=0
bulletSpeed=14
lifeTime=40
lingerFrame=0
alarm[0]=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sprite_index=sMMXbuster1
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sMMbusterHitEffect
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_angle=direction
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
    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=7}
    else {bulletSpeed=14}
    speed=bulletSpeed

    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if isCollisionLeft(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionRight(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionBottom(1) {lingerFrame=1; speed=0; visible=0}
    if isCollisionTop(1) {lingerFrame=1; speed=0; visible=0}
    lifeTime-=1
    if lifeTime=0 {instance_destroy()}
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}
