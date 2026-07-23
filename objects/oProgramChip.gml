#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
effectSize[0]=1
effectSize[1]=1.25
effectSize[2]=1.5
effectAlpha[0]=0.75
effectAlpha[1]=0.5
effectAlpha[2]=0.25
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for (i=0;i<3;i+=1)
{
  if effectSize[i]<1.75
  {
    effectSize[i]+=0.01*gDeltaTime
    effectAlpha[i]-=0.01*gDeltaTime
  }
  else
  {
    effectSize[i]=1
    effectAlpha[i]=0.75
  }
}
draw_set_blend_mode(bm_add)
draw_set_alpha(0.75)
draw_circle_color(x,y,24,make_color_rgb(240,160,70),c_black,false)
for(i=0;i<3;i+=1) {draw_sprite_ext(sprite_index,chipType,x,y,effectSize[i],effectSize[i],0,c_white,effectAlpha[i])}
draw_set_blend_mode(bm_normal)
draw_sprite_ext(sprite_index,chipType,x,y,1,1,0,c_white,1)
