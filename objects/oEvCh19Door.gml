#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
flashCol=255
fadeDown=1

if global.gameProgress!=4940 {instance_destroy()}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if fadeDown=1
{
  flashCol-=3
  if flashCol<=195 {fadeDown=0}
}
else
{
  flashCol+=3
  if flashCol>=255 {fadeDown=1}
}
image_blend=make_color_rgb(flashCol,flashCol,flashCol)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<image_xscale;i+=1)
{
  draw_sprite_ext(sprite_index,0,x+(i*16),y,1,1,0,image_blend,1)
}
for(i=0;i<image_yscale;i+=1)
{
  draw_sprite_ext(sprite_index,0,x,y+(i*16),1,1,0,image_blend,1)
}
