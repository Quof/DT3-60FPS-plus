#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
windTime=0
windColor=make_color_rgb(0,85,85)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
windTime+=1
if windTime mod 5=0
{
  var tWindLine;
  tWindLine=instance_create(view_xview[0]+view_wport[0]+32+irandom(8),random(room_height),oWarshipWindEffect)
  tWindLine.image_alpha=0.4; tWindLine.image_blend=windColor; tWindLine.windLength=24+irandom(8)
}
