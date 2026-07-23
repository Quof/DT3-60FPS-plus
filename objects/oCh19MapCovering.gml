#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//scaling must be divisible by 2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if collision_rectangle(x+3,y+3,x+(image_xscale*16)-6,y+(image_yscale*16)-6,oPlayer1,0,1)
  {
    if image_alpha>0 {image_alpha-=0.1}
  }
  else
  {
    if image_alpha<1 {image_alpha+=0.1}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=1
{
  for(i=0;i<image_xscale/2;i+=1)
  {
    for(ii=0;ii<image_yscale/2;ii+=1)
    {
      draw_background_part_ext(tileHighlands,0,32,32,32,x+(i*32),y+(ii*32),1,1,image_blend,image_alpha)
    }
  }
}
else if drawType=2
{
  for(i=0;i<image_xscale/2;i+=1)
  {
    for(ii=0;ii<image_yscale;ii+=1)
    {
      draw_background_part_ext(tileHighlands,0,80,32,16,x+(i*32),y+(ii*16),1,1,image_blend,image_alpha)
    }
  }
}
else if drawType=3
{
  for(i=0;i<image_xscale/2;i+=1)
  {
    for(ii=0;ii<image_yscale;ii+=1)
    {
      draw_background_part_ext(tileHighlands,0,16,32,16,x+(i*32),y+(ii*16),1,1,image_blend,image_alpha)
    }
  }
}
else if drawType=4
{
  for(i=0;i<image_xscale/3;i+=1)
  {
    for(ii=0;ii<image_yscale/2;ii+=1)
    {
      draw_background_part_ext(tileHighlands,112,80,48,32,x+(i*48),y+(ii*32),1,1,image_blend,image_alpha)
    }
  }
}
