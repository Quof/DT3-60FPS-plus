#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384

sizeMod=0
bSizeUp=false
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  draw_set_alpha(0.4)
  if bSizeUp=false
  {
    sizeMod-=sizeInc
    if sizeMod<=-modMax {bSizeUp=true}
  }
  else
  {
    sizeMod+=sizeInc
    if sizeMod>=modMax {bSizeUp=false}
  }
  draw_set_blend_mode(bm_add)
  draw_circle_color(x+8,y+8,baseSize+sizeMod,make_color_rgb(240,193,64),c_black,false)
  draw_set_blend_mode(bm_normal)
}
