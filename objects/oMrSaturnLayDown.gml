#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
balloonX=0
balloonY=-64
balloonProg=0
jitterX=0
jitterY=0
moveWave=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  moveWave+=pi/60
  //balloonX+=cos(moveWave)/2

  oSaturnBalloon.x+=cos(moveWave)/2
  oSaturnBalloon.y=y+balloonY
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x+jitterX,y+jitterY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
