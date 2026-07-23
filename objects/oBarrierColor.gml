#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale>image_yscale
{
  for(i=0;i<image_xscale;i+=1)
  {
    draw_sprite_ext(sBarrierColor,image_index,x+(i*16),y+16,1,1,90,image_blend,image_alpha)
  }
}
else
{
  for(i=0;i<image_yscale;i+=1)
  {
    draw_sprite_ext(sBarrierColor,image_index,x,y+(i*16),1,1,0,image_blend,image_alpha)
  }
}
