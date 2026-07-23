#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_xscale=oPlayer1.waveOfAwesomeScale
image_yscale=oPlayer1.waveOfAwesomeScale
image_alpha=0.6
myTime=3
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //x=oPlayer1.x
  //y=oPlayer1.y-26
  myTime-=1
  if myTime<=0 {instance_destroy()}
}
