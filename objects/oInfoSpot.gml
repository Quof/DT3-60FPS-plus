#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
depth=60
if variable_local_exists("binary")
{
  xx=9
  yy=26
  changeTime=0
  visible=true
}
#define Collision_oCharacter
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//post message
if (keyboard_check_pressed(ord(global.ctrlUp)) or keyboard_check_pressed(vk_up)) and global.gamePaused=false
{
  global.recBinariesRead+=1
  with oMessageSign
    instance_destroy()
  messageWidth=string_width(stringToShow)
  newMessage=instance_create(256-(messageWidth/2),48,oMessageInfoSpot)
  newMessage.message=stringToShow
  newMessage.talker=talker
  newMessage.window=window
  newMessage.fadingTime=(string_length(stringToShow)*1.5)+10
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("binary")
{
  draw_set_color(make_color_rgb(0,255,0))
  draw_set_alpha(1)
  draw_set_font(fnt_ScanData)
  draw_set_halign(fa_left)
  if changeTime=0
  {
    for(a=0;a<4;a+=1)
    {
      for(aa=0;aa<5;aa+=1)
      {
        bin[a,aa]=round(random(1))
      }
    }
    changeTime=4
  }
  else
    changeTime-=1
  for(i=0;i<4;i+=1)
  {
    for(ii=0;ii<5;ii+=1)
    {
      draw_text(x-xx+12,y-yy+51,bin[i,ii])
      xx+=4
    }
    xx-=20
    yy+=6
  }
  yy-=24
}
