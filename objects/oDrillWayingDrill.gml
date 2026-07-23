#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  for(i=0;i<ceil(image_yscale);i+=1)
  {
    draw_sprite(sprite_index,image_index,x,y+(i*16))
  }
}
