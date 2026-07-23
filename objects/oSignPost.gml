#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
drawType=0
bChecked=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !variable_local_exists("signSize")
  signSize=0
if variable_local_exists("newDraw")
  drawType=newDraw
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Post message
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  bChecked=1
  global.recSignsRead+=1
  with oMessageSign {instance_destroy()}
  var tNewMessage,tXoffset,tYoffset;
  if signSize=0
  {
    tXoffset=70
    tYoffset=80
  }
  else if signSize=1
  {
    tXoffset=100
    tYoffset=93
  }
  else if signSize=2
  {
    tXoffset=130
    tYoffset=106
  }
  else if signSize=3
  {
    tXoffset=160
    tYoffset=119
  }
  tNewMessage=instance_create(x-tXoffset,y-tYoffset,oMessageSign)
  tNewMessage.message=stringToShow
  tNewMessage.fadingTime=65+(signSize*15)
  tNewMessage.signSize=signSize
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if drawType=0
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
else if drawType=1 //Sacred Temple slabs
{
  draw_background_part(tileSacredTemple,32,96,32,32,x-16,y-40)
}
