#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_alpha=0.3
image_speed=0.25
image_xscale=0.25
image_yscale=0.25
maxLife=40
life=maxLife
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x=oIdentifier.x
  y=oIdentifier.y
  if life<maxLife and oGame.time mod 5=0
    life+=1
}
