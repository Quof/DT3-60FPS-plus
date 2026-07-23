#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: myText,mySpd,myFont,myAlign
if room=rTrueEnd_A {image_alpha=1}
else {image_alpha=0}
textProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if textProg=0
{
  image_alpha+=0.0075
  if image_alpha>=1 {textProg=1}
}
else if textProg=1
{
  if y<=64
  {
    image_alpha-=0.0075
  }
}

y-=mySpd
if y<-32 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_font(myFont)
draw_set_halign(myAlign)
draw_set_alpha(image_alpha)
textDropShadow(myText,view_xview[0]+floor(x),view_yview[0]+floor(y),c_white,c_black,4)
