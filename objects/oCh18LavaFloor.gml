#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawAmt=round((room_width+128)/128)
lavaColor=make_color_rgb(208,0,0)
lavaFrm=0
glowY=0
moveWave=pi/2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lavaFrm+=0.3
moveWave+=pi/60
glowY+=sin(moveWave)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.8)
draw_set_blend_mode(bm_add)
draw_rectangle_color(0,y-64-glowY,room_width,y+8,c_black,c_black,c_red,c_red,0)
draw_set_blend_mode(bm_normal)
for(i=0;i<drawAmt;i+=1)
{
  draw_sprite_ext(sCh18Lava,lavaFrm,x+(128*i),y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
draw_set_alpha(1)
draw_set_color(lavaColor)
draw_rectangle(0,y+16,room_width,room_height,0)
