#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
setCollisionBounds(-4,-1,4,1)

damageType="PIERCE"
weaponTag=31
atkLv=global.stBelmont_Dagger[0]
atkPower=65+(global.stBelmont_Dagger[0]*2)+global.skillTree[12]
atkPower=weaponDmgMod(1,atkPower)
global.recAtkNum+=1
global.stBelmont_Dagger[2]+=1
stunTime=7

if oPlayer1.image_xscale=1
  x+=10
else
{
  image_xscale=-1
  x-=10
  direction=180
}

bCollide=0
//bulletSpeed=15
lifeTime=45
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
    speed=bulletSpeed
    if checkScreenArea(x,y,48)=0 {instance_destroy()}

    if isCollisionLeft(1) {bCollide=1}
    if isCollisionRight(1) {bCollide=1}
    if isCollisionBottom(1) {bCollide=1}
    if isCollisionTop(1) {bCollide=1}

    if bCollide=1
    {
      if checkScreenArea(x,y,48)=1 {playSound(global.snd_DaggerHit,0,0.92,1)}
      var tExpLight;
      tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=0.5; tExpLight.image_yscale=0.5

      if bBounce=0
      {
        dagEffect=instance_create(x,y,oWepEf_Dagger)
        dagEffect.image_xscale=image_xscale
      }
      else
      {
        instance_create(x-(6*image_xscale),y,oBounceDagger)
      }

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
if lifeTime<43 //trail
{
  draw_set_blend_mode(bm_add)
  draw_line_color(x,y,x-(68*image_xscale),y,c_red,c_black)
  draw_set_blend_mode(bm_normal)
}
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
