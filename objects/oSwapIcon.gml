#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xPos=-440
waitTime=0
textColor=make_color_rgb(0,255,0)
shadowColor=make_color_rgb(5,135,5)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if waitTime=0
{
  xPos+=20
  if xPos=0
    waitTime+=1
}
else if waitTime>=1 and waitTime<=99
{
  waitTime+=1
  if waitTime=25
    waitTime=100
}
else if waitTime>=100
{
  xPos+=20
  if xPos>=440
    instance_destroy()
}

if xPos!=0
{
  afterImage=instance_create(view_xview[0]+256+xPos,view_yview[0]+192,oSceneAfterImage)
  afterImage.image_alpha=0.6
  afterImage.sprite_index=sprite_index
  afterImage.imageFade=0.05
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  draw_sprite(sprite_index,0,view_xview[0]+256+xPos,view_yview[0]+192)
  if xPos=0
  {
    draw_set_font(fnt_Swap)
    draw_set_halign(fa_middle)
    draw_set_alpha(1)
    textDropShadow(stringToShow,view_xview[0]+256+xPos,view_yview[0]+185,textColor,shadowColor,3)
  }
}
