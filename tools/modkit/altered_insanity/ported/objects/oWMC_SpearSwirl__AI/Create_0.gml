if room=rWarshipZ_E3
{
  image_xscale=1.05; image_yscale=1.05
}
//Spear Swirl
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
atkProg=0
atkTime=0

var tEffect,tDir;
tDir=0
for(i=0;i<16;i+=1)
{
  tEffect=instance_create(x+lengthdir_x(32,tDir),y+lengthdir_y(32,tDir),oEffect)
  tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.25+random(0.25); tEffect.direction=tDir; tEffect.speed=3
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  tDir+=360/16
}
