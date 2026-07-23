#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=0.5
image_yscale=0.5
decayTime=40
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oGame.time mod 5=0
  {
    if image_alpha=1 {image_alpha=0}
    else {image_alpha=1}
  }

  decayTime-=1
  if decayTime<=0 {instance_destroy()}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sWarningSymbol,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
