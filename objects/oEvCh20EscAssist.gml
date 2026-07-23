#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
y+=48
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Magic,0,0.95,1)
oIdentifier.chaoEndAssisted=100; oIdentifier.chaoLightAssistAlpha=0.25

var i,xx,yy,distCheck,angCheck,tFFScl,tEffect,tDir;
tDir=0
for(i=0;i<16;i+=1)
{
  tEffect=instance_create(oIdentifier.x+lengthdir_x(16,tDir),oIdentifier.y+lengthdir_y(16,tDir),oEffect)
  tEffect.sprite_index=sMMshotgunIceEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_angle=random(360)
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.speed=2; tEffect.image_speed=0.33; tEffect.direction=tDir

  tEffect=instance_create(oIdentifier.x+lengthdir_x(8,tDir+11.25),oIdentifier.y+lengthdir_y(8,tDir+11.25),oEffect)
  tEffect.sprite_index=sMMshotgunIceEffect; tEffect.followID=-1; tEffect.xFollow=0; tEffect.yFollow=0; tEffect.image_angle=random(360)
  tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.speed=4; tEffect.image_speed=0.33; tEffect.direction=tDir
  tDir+=360/16
}

xx=oPlayer1.x; yy=oPlayer1.y-26

distCheck=point_distance(xx,yy,xSpot,ySpot-26)
distCheck=round(distCheck/16)
angCheck=point_direction(xx,yy,xSpot,ySpot-26)
for(i=0;i<distCheck;i+=1)
{
  tFFScl=random(0.1)
  tEffect=instance_create(xx+lengthdir_x(i*16,angCheck),yy+lengthdir_y(i*16,angCheck),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_alpha=0.7; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
  tEffect.direction=angCheck+90; tEffect.speed=1; tEffect.friction=0.01
  tEffect.fadeSpd=0.015; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0

  tEffect=instance_create(xx+lengthdir_x(i*16,angCheck),yy+lengthdir_y(i*16,angCheck),oEffectB)
  tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
  tEffect.image_alpha=0.7; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
  tEffect.direction=angCheck-90; tEffect.speed=1; tEffect.friction=0.01
  tEffect.fadeSpd=0.015; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
}

oPlayer1.x=xSpot; oPlayer1.y=ySpot
