#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  keyCheck[i]=0
}
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameProgress>=progCheck
{
  with oSwitchPanelColor
    instance_destroy()
  with oBarrierColor
    instance_destroy()
  with oKeyColor
    instance_destroy()
  with oLockPanelColor
    instance_destroy()
  with oEventBarrier
  {
    if spriteUse=1 {instance_destroy()}
  }
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<4;i+=1)
{
  if keyCheck[i]=1
    draw_sprite(sKeyColor,i,view_xview[0]+224+(i*16),view_yview[0]+332)
}
