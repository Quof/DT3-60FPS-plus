#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: myDir,swingSpeed,chainLinks
event_inherited()
bActive=true

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false

initX=x
initY=y
chainColor=make_color_rgb(220,255,220)

alarm[0]=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  myDir+=swingSpeed
  x=initX+lengthdir_x(chainLinks*16,myDir)
  y=initY+lengthdir_y(chainLinks*16,myDir)
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<chainLinks;i+=1)
{
  draw_sprite_ext(sCh19SwingChain,0,initX+lengthdir_x(i*16,myDir),initY+lengthdir_y(i*16,myDir),image_xscale,image_yscale,image_angle+180,chainColor,image_alpha)
}
draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
