#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
sizeMod=0
bSizeUp=false
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.25)
if bSizeUp=false
{
  sizeMod-=0.05
  if sizeMod<=-1 {bSizeUp=true}
}
else
{
  sizeMod+=0.05
  if sizeMod>=3 {bSizeUp=false}
}
draw_set_blend_mode(bm_add)
draw_circle_color(x+8,y+8,22+sizeMod,make_color_rgb(240,193,64),c_black,false)
draw_set_alpha(0.35)
draw_circle_color(x+8,y+8,(22+sizeMod)*2.75,make_color_rgb(240,193,64),c_black,false)
draw_set_blend_mode(bm_normal)
