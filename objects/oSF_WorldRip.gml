#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=0
image_alpha=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
atkPower=20
size=2
pullProg=0

circleRad=400
circleAlpha=0.2

playSound(global.snd_WindBlow,0,1,11050)
playSound(global.snd_Thunder,0,1,11050)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if pullProg=0 //Delay before pulling
  {
    circleRad-=10
    circleAlpha+=0.08
    if circleRad<=0
    {
      var tEffect;
      for(i=0;i<32;i+=1)
      {
        tEffect=instance_create(x,y,oEffectGrav)
        tEffect.sprite_index=sprite_index; tEffect.image_xscale=0.075; tEffect.image_yscale=0.075
        tEffect.xSpd=random_range(-5,5); tEffect.ySpd=-4-random(6); tEffect.grav=0.4
        tEffect.rotation=random_range(-15,15); tEffect.type=1; tEffect.decay=20+irandom(15)
        tEffect.newBlend=-1; tEffect.followID=-1
      }
      image_alpha=1
      bCanDealDamage=1
      pullProg+=1
    }
  }
  else if pullProg=1 //Pull in blocks
  {
    if checkScreenArea(x,y,208)
    {
      var tEffect,tDir;
      tDir=random(360)
      tEffect=instance_create(x+lengthdir_x(208,tDir),y+lengthdir_y(208,tDir),oEffect)
      tEffect.sprite_index=sprite_index; tEffect.image_xscale=0.025+random(0.025); tEffect.image_yscale=0.025+random(0.025)
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=24; tEffect.xSpd=0; tEffect.ySpd=0
      tEffect.speed=8; tEffect.direction=tDir-180
    }
  }
  else if pullProg=2 //Shrink to nothingness
  {
    image_xscale-=0.075
    image_yscale-=0.075
    if image_xscale<=0.075
    {
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
event_inherited()
if pullProg=0
{
  draw_set_alpha(circleAlpha)
  draw_set_color(c_black)
  draw_circle(x,y,circleRad,0)
}
