#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
alarm[1]=3
#define Alarm_1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bCanTakeDamage=1
bCanDealDamage=1
#define Collision_oTDTShock
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bSlowed=1
slowTime=270+(other.myLevel*30)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.optEnemyHP=1
{
  draw_set_alpha(1)
  displayTDLifeX=x-13
  displayTDLifeY=bbox_bottom+4
  draw_set_color(make_color_rgb(164,164,164))
  draw_rectangle(displayTDLifeX,displayTDLifeY,displayTDLifeX+27,displayTDLifeY+5,0)
  draw_set_color(make_color_rgb(16,8,8))
  draw_rectangle(displayTDLifeX,displayTDLifeY,displayTDLifeX+27,displayTDLifeY+5,1)
  draw_set_color(make_color_rgb(228,30,30))
  TDlifeTrack=(life/maxLife)*25
  draw_rectangle(displayTDLifeX+1,displayTDLifeY+1,displayTDLifeX+1+TDlifeTrack,displayTDLifeY+4,0)
}
