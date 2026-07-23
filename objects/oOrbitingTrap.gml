#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Variables that need to be set on creation:
swingSpeed  : How fast the trap orbits
orbitDist   : How far the orbit is from the center
dir         : Starting direction from the center
drawLine    : Whether to draw a line from the center to the trap: 0-No, 1-Yes

swingSpeed,orbitDist,dir,drawLine
*/
event_inherited()
sX=x
sY=y

//Enemy base statistics
atkPower=12
bCanTakeDamage=false
bShowHealthBar=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sprite_index=sZapTrap or sprite_index=sZapTrapRed {image_angle=dir+95}

  dir+=swingSpeed
  x=sX+lengthdir_x(orbitDist,dir)
  y=sY+lengthdir_y(orbitDist,dir)
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawLine=1
{
  draw_set_color(c_black)
  draw_set_alpha(0.2)
  draw_line(sX,sY,x,y)
}
draw_sprite_ext(sTrap_RotoDisc,image_index,sX,sY,image_xscale,image_yscale,image_angle,image_blend,0.2)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
