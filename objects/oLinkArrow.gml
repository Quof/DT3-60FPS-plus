#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-6,-1,6,1)

damageType="PIERCE"
weaponTag=1
atkLv=global.stLink_Arrow[0]
var tCrossbow;
tCrossbow=1
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]=36 //Equipment: Crossbow
  {
    tCrossbow=1.5
    break;
  }
}
atkPower=round((50+(round(global.stLink_Arrow[0]*1.5)+global.skillTree[9]))*tCrossbow)
atkPower=weaponDmgMod(0,atkPower)
global.recAtkNum+=1
global.stLink_Arrow[2]+=1
stunTime=5

if oPlayer1.image_xscale=1
{
  bDir=0
  arrowProg=0
}
else
  bDir=1

bulletSpeed=0
bCollide=0
lingerFrame=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bulletSpeed=12+(attackCharge/5)
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
    speed=bulletSpeed
    image_angle=direction
    if bDir=0
    {
      if arrowProg=0
      {
        direction-=2
        if direction>180 {arrowProg=1}
      }
      else if arrowProg=1
      {
        if direction>300 {direction-=2}
      }
    }
    else
    {
      if direction<240 {direction+=2}
    }

    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if isCollisionLeft(1) {bCollide=1}
    if isCollisionRight(1) {bCollide=1}
    if isCollisionBottom(1) {bCollide=1}
    if isCollisionTop(1) {bCollide=1}
    if y>room_height+16 {instance_destroy()}

    if global.optWeaponTrail=1 {instance_create(x,y,oEfWeaponTrail)}

    if bCollide=1
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_ArrowHit,0,1,1)}
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.5; tExpLight.image_yscale=0.5
      arrEffect=instance_create(x,y,oWepEf_Arrow)
      arrEffect.image_xscale=image_xscale
      arrEffect.image_angle=image_angle
      for(i=0;i<6;i+=1)
      {
        var tFFScl,tEffect;
        tFFScl=random(0.15)
        tEffect=instance_create(x,y,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.5; tEffect.image_xscale=0.05+tFFScl; tEffect.image_yscale=0.05+tFFScl
        if image_xscale=1 {tEffect.direction=random_range(135,225)}
        else {tEffect.direction=random_range(-45,45)}
        tEffect.speed=random(1)+0.5; tEffect.friction=random(0.03)+0.02; tEffect.fadeSpd=0.03; tEffect.image_blend=c_silver
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
      lingerFrame=1; speed=0; visible=0
    }
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}
