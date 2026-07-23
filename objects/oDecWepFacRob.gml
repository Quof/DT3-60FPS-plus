#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_blend=c_gray
flashTime=0
alarm[0]=1

if global.gameProgress>=4500 and global.bBossGallery=0 {instance_destroy()}
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("jumpFlash")
{
  flashTime=100
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if flashTime>=100 and oPlayer1.x>=x-16
  {
    flashTime+=1
    if flashTime=101 {image_blend=c_maroon}
    else if flashTime=105 {image_blend=c_gray}
  }
}
