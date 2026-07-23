#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
atkPower=12

laserProg=0
laserTime=0
lifeTime=0

edgeFrame=0
image_yscale=235
sprite_index=sNull

fairyLightColor=make_color_rgb(226,226,0)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if laserProg=0
  {
    laserTime+=1
    if laserTime=1
    {
      var tFFScl,tEffect;
      for(i=0;i<64;i+=1)
      {
        tFFScl=random(0.1)
        tEffect=instance_create(x+random_range(-2,2),y+random(235),oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.5; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(1)+3; tEffect.friction=random(0.05)+0.1
        tEffect.fadeSpd=0.0075; tEffect.image_blend=fairyLightColor
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
    }
    else if laserTime>=60
    {
      playSound(global.snd_LaserB,0,0.9,12000)
      playSound(global.snd_SpearShot,0,1,14000)
      sprite_index=sPSF_LargeLaser_Main
      laserProg=1
    }
  }
  else if laserProg=1
  {
    edgeFrame+=0.33
    lifeTime+=1
    if lifeTime>=1 and lifeTime<=34
    {
      var tFFScl,tEffect;
      tFFScl=random(0.1)
      tEffect=instance_create(x+random_range(-64,64),304,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_alpha=0.85; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
      tEffect.direction=random(360); tEffect.speed=random(2)+4; tEffect.friction=random(0.1)+0.2
      tEffect.fadeSpd=0.04; tEffect.image_blend=fairyLightColor
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
    }
    if lifeTime>=35
    {
      var tFFScl,tEffect;
      for(i=0;i<24;i+=1)
      {
        tFFScl=random(0.1)
        tEffect=instance_create(x+random_range(-64,64),304,oEffectB)
        tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
        tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
        tEffect.direction=random(360); tEffect.speed=random(2)+5; tEffect.friction=random(0.1)+0.2
        tEffect.fadeSpd=0.01; tEffect.image_blend=fairyLightColor
        tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      }
      instance_destroy()
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if laserProg=1
{
  draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
  for(i=0;i<16;i+=1)
  {
    draw_sprite_ext(sPSF_LargeLaser_Edge,edgeFrame,x+34,round(y+(i*14.6)),1,1,0,image_blend,image_alpha)
    draw_sprite_ext(sPSF_LargeLaser_Edge,edgeFrame+0.5,x-34,round(y+(i*14.6)),-1,1,0,image_blend,image_alpha)
  }
}
