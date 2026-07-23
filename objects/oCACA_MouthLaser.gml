#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: idleTime
event_inherited()
sprite_index=sNull
image_xscale=room_width
image_yscale=4

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
size=2
decayTime=0
warnTime=40
lineAlpha=0.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oCACA_Main.x+(13*oCACA_Main.image_xscale)
  y=oCACA_Main.y-58

  if bCanDealDamage=true
  {
    image_blend=make_color_rgb(150+random(50),150+random(50),150+random(50))
    decayTime+=1
    if decayTime>=idleTime {instance_destroy()}
  }
  else
  {
    warnTime-=1
    lineAlpha+=0.015
    if warnTime=0
    {
      playSound(global.snd_CShotA,0,1,13000)
      sprite_index=sShroudLLaser
      bCanDealDamage=true
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanDealDamage=true
{
  event_inherited()
}
else
{
  draw_set_alpha(lineAlpha)
  draw_set_color(c_red)
  draw_line_width(x,y,x+lengthdir_x(room_width,image_angle),y+lengthdir_y(room_width,image_angle),6)
}
