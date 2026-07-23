#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-2,-2,2,2)

damageType="PIERCE"
weaponTag=31
atkLv=global.stBelmont_Dagger[0]
atkPower=65+(global.stBelmont_Dagger[0]*2)+global.skillTree[12]
atkPower=weaponDmgMod(1,atkPower)
stunTime=7

bCollide=0
bCanHitSwitch=0
bulletSpeed=15
lifeTime=35
lingerFrame=0
noDestroyTime=1

if instance_exists(oEnemyBase)
{
  myTarget=instance_nearest(x,y,oEnemyBase)
  var tTargetCenterX,tTargetCenterY;
  tTargetCenterX=myTarget.bbox_left+(myTarget.sprite_width/2)
  tTargetCenterY=myTarget.bbox_top+(myTarget.sprite_height/2)
  direction=point_direction(x,y,tTargetCenterX,tTargetCenterY)
  image_angle=direction
}
else
{
  direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
  image_angle=direction
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
    speed=bulletSpeed
    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if noDestroyTime=0
    {
      if isCollisionLeft(1) {bCollide=1}
      if isCollisionRight(1) {bCollide=1}
      if isCollisionBottom(1) {bCollide=1}
      if isCollisionTop(1) {bCollide=1}
    }
    else {noDestroyTime-=1}

    if bCollide=1
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_DaggerHit,0,0.9,29000)}
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.5; tExpLight.image_yscale=0.5

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
    lifeTime-=1
    if lifeTime=0 {instance_destroy()}
  }
  else if lingerFrame=1 {instance_destroy()}
}
else {speed=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
