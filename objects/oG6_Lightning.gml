#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Thunder,0,0.95,22100+random(22100))
image_xscale=0.2
image_yscale=0.2
lightningProg=0
lightningTime=0
backAlpha=0.2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if lightningProg=0
{
  image_xscale+=0.2
  image_yscale+=0.2
  if image_xscale>=1 {lightningProg+=1}
}
else if lightningProg=1
{
  lightningTime+=1
  if lightningTime>=30
  {
    lightningProg+=1
  }
}
else if lightningProg=2
{
  image_alpha-=0.2
  if image_alpha<=0 {instance_destroy()}
}

if backAlpha>0 {backAlpha-=0.02}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(backAlpha)
draw_set_color(c_white)
draw_rectangle(0,0,room_width,room_height,0)
draw_self()
