#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sprite_index=sInvisibleSolidMask
virusFrm=0
moveWave=pi
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
virusFrm+=0.2
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
moveWave+=pi/20
if image_xscale>1
{
  for(i=0;i<image_xscale*2;i+=1)
  {
    draw_sprite_ext(sVirusGel,virusFrm+(i*0.33),x+4+(8*i),y+8+(sin(moveWave+i)*2),1,1,0,c_white,1)
  }
}
else if image_yscale>1
{
  for(i=0;i<image_yscale*2;i+=1)
  {
    draw_sprite_ext(sVirusGel,virusFrm+(i*0.33),x+8+(cos(moveWave+i)*2),y+4+(8*i),1,1,0,c_white,1)
  }
}
