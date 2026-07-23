#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
warnTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false //Requires: warnTime
{
  warnTime+=1
  if warnTime>=warnMax
  {
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sWarningSymbol,-1,x,y,image_xscale,image_yscale,0,image_blend,image_alpha)
if warnTime mod 7=0
{
  if image_alpha=1 {image_alpha=0}
  else {image_alpha=1}
}
