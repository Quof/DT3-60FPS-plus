#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: atkDelay
event_inherited()
image_speed=0.3
image_alpha=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2
atkPower=oHexor_Main.atkPower

atkProg=0
atkTime=0
circleWarnRad=24
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if atkProg=0 //Fade in
  {
    image_alpha+=0.05
    if image_alpha>=1
    {
      bCanDealDamage=true
      atkProg+=1
    }
  }
  else if atkProg=1 //Fire laser
  {
    if circleWarnRad>0 {circleWarnRad-=1}
    atkTime+=1
    if atkTime=30
    {
      playSound(global.snd_Dec_Fire,0,0.92,32000+random(3000))
      myLaser=instance_create(x+(4*image_xscale),y,oHexor_ShroudLaser)
      myLaser.myHead=id; myLaser.image_xscale=image_xscale*room_width
      atkTime=0; atkProg+=1
    }
  }
  else if atkProg=2 //Laser time
  {
    atkTime+=1
    if atkTime>=atkDelay
    {
      with myLaser {instance_destroy()}
      bCanDealDamage=false
      atkProg+=1
    }
  }
  else if atkProg=3 //Fade out
  {
    image_alpha-=0.05
    if image_alpha>=1
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
draw_self()
if atkProg=1
{
  if circleWarnRad>0
  {
    draw_set_alpha(0.2)
    draw_set_color(c_red)
    draw_line(x+(4*image_xscale),y,x+(room_width*image_xscale),y)
  }

  draw_set_alpha(1)
  draw_set_color(c_white)
  draw_circle(x+(4*image_xscale),y,circleWarnRad,1)
}
