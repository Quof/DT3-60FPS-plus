#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-6,-2,6,2)
image_speed=0.5

damageType="SPECIAL"
weaponTag=41
atkLv=global.stSamus_Missile[0]
atkPower=75+global.stSamus_Missile[0]+global.skillTree[13]
atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stSamus_Missile[2]+=1
stunTime=12
bulletSpeed=3
lifeTime=55
lingerFrame=0
alarm[0]=1
#define Destroy_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var tExpLight;
tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.75; tExpLight.image_yscale=0.75

if sprite_index=sSamusMissile
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sSamusMissileHit; tEffect.image_speed=0.5; tEffect.depth=6
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else if sprite_index=sSamusSuperMissile
{
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sSamusSMissileHit; tEffect.image_speed=0.5; tEffect.depth=6
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  instance_create(x,y,oDiffusionBlast)
}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
atkPower=round(atkPower*exPwr)
if image_angle=90 or image_angle=270 {setCollisionBounds(-2,-6,2,6)}
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
    if oGame.time mod 3=0
    {
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.5; tExpLight.image_yscale=0.5
    }

    image_angle=direction
    if sprite_index=sSamusMissile
    {
      if oGame.time mod 3=0
      {
        var tEffect,tXOffset;
        tXOffset=0
        if image_angle=90 or image_angle=270 {tXOffset=4}
        tEffect=instance_create(x+(4*image_xscale)-tXOffset,y,oEffect)
        tEffect.sprite_index=sSamusMissileEffect; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }
    else if sprite_index=sSamusSuperMissile
    {
      if oGame.time mod 3=0
      {
        var tEffect,tXOffset;
        tXOffset=0
        if image_angle=90 or image_angle=270 {tXOffset=4}
        tEffect=instance_create(x+(4*image_xscale)-tXOffset,y,oEffect)
        tEffect.sprite_index=sSamusSMissileEffect; tEffect.image_speed=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
    }

    if bulletSpeed<12 {bulletSpeed+=0.4}
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
