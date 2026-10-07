#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: locDisplay
image_alpha=0
lifeTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
lifeTime+=1*gDeltaTime
//if lifeTime>=1 and lifeTime<=100
if lifeTime>0 and lifeTime<=100 //60fps change: covers every frame of the first tick
{
  image_alpha+=0.05*gDeltaTime
  //if image_alpha=1
  if image_alpha>=1 //60fps change: smaller steps may not land exactly on 1 (it would keep brightening and stay up much longer)
    {image_alpha=1; lifeTime=200}
}
else if lifeTime>=290
{
  image_alpha-=0.05*gDeltaTime
  //if image_alpha=0
  if image_alpha<=0 //60fps change: smaller steps may not land exactly on 0 (the display would never be destroyed)
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(image_alpha)
draw_set_font(fnt_Location)
draw_set_halign(fa_left)
textDropShadow(locDisplay,view_xview[0]+4,view_yview[0]+330,c_black,c_white,4)
