#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)
image_speed=0.5
bCanDealDamage=false

damageType="SHOT"
weaponTag=10
atkLv=global.stMega_Buster[0]
atkPower=30+global.stMega_Buster[0]+global.skillTree[10]
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stMega_Buster[2]+=1
stunTime=1
if oPlayer1.bWallGrab=1 {initFireDir*=-1}

bulletSpeed=12
lifeTime=50
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
atkPower=round(atkPower*exPwr)
bCanDealDamage=true
if sprite_index=sMMXbuster2 {setCollisionBounds(-3,-3,3,3)}
else if sprite_index=sMMXbuster3 {setCollisionBounds(-4,-4,4,4)}
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
    if sprite_index=sMMXbuster3 or sprite_index=sMMXbuster4
    {
      var tEffect;
      if oGame.time mod 3=0
      {
        tEffect=instance_create(x-(abs(sprite_width)/2-3)+random(abs(sprite_width)-6),y-(sprite_height/2-3)+random(sprite_height-6),oEffectB)
        tEffect.sprite_index=sMMchargeEffect1; tEffect.image_speed=0.25; tEffect.direction=direction
        tEffect.type=4; tEffect.speed=bulletSpeed-2; tEffect.AccelX=-0.65
        tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      }
    }

    if place_meeting(x,y,oNightmareEffect) {bulletSpeed=6}
    else {bulletSpeed=12}
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
