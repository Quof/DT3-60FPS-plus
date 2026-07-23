#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
image_yscale=22
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<6;i+=1)
{
  draw_sprite_ext(sTS_Barrier,image_index,x+6,y+(64*i),1,1,image_angle,image_blend,image_alpha)
}
