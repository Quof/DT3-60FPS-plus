#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)
bCanDealDamage=false

damageType="SHOT"
weaponTag=40
atkLv=global.stSamus_Cannon[0]
atkPower=30+global.stSamus_Cannon[0]+global.skillTree[13]
atkPower=weaponDmgMod(1,atkPower)
basePower=atkPower
global.recAtkNum+=1
global.stSamus_Cannon[2]+=1
stunTime=3

bulletSpeed=11.5
lifeTime=50
lingerFrame=0
alarm[0]=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sSamusCannonHit; tEffect.depth=6
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
atkPower=round(atkPower*exPwr)
bCanDealDamage=true
if sprite_index=sSamusChargeCannon
{
  if image_angle=0 or image_angle=180 {setCollisionBounds(-8,-2,8,2)}
  else {setCollisionBounds(-2,-8,2,8)}
  weaponRehitTime=1
}
else if sprite_index=sSamusSpazer
{
  if image_angle=0 or image_angle=180 {setCollisionBounds(-8,-5,8,5)}
  else {setCollisionBounds(-5,-8,5,8)}
}
else if sprite_index=sSamusChargeSpazer
{
  if image_angle=0 or image_angle=180 {setCollisionBounds(-8,-5,8,5)}
  else {setCollisionBounds(-5,-8,5,8)}
  weaponRehitTime=1
}
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
    image_angle=direction
    if image_alpha=1 {image_alpha=0.5}
    else {image_alpha=1}
    if sprite_index=sMMXbuster3
    {
      if oGame.time mod 4=0
      {
        var tEffect;
        tEffect=instance_create(x-(sprite_width/2-3)+random(sprite_width-6),y-(sprite_height/2-3)+random(sprite_height-6),oEffect)
        tEffect.sprite_index=sMMchargeEffect1; tEffect.image_speed=0.25; tEffect.xSpd=random(0.3)*-image_xscale
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.ySpd=0
      }
    }

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
