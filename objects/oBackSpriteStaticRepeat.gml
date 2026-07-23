#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<xRepeat;i+=1)
{
  for(ii=0;ii<yRepeat;ii+=1)
  {
    draw_sprite_ext(sprite_index,image_index,x+(i*128),y+(ii*128),image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
}
