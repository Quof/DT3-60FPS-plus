#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.33
yVel=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  y+=yVel
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
for(i=0;i<12;i+=1)
{
  draw_sprite_part_ext(sprite_index,image_index,0,31,sprite_width,32,x-(sprite_width/2),y+(i*32),image_xscale,image_yscale,image_blend,image_alpha)
}
