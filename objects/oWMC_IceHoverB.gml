#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Ice Hover - Shot
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"

moveTime=0
moveSpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if gDeltaTime!=1 {moveSpd=scrTickAcc(moveSpd,0.2*(moveSpd<8),0)} //moves (copies the speed) first, then changes it: above 30fps the tick's change is spread before the move (scrTickAcc, scrTickAccBPre)
  _speed=moveSpd+scrTickAccBPre(0)
  if gDeltaTime==1 {if moveSpd<8 {moveSpd+=0.2}}
  moveTime+=1*gDeltaTime
  if moveTime>=210 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.15,image_yscale*1.15,image_angle,image_blend,0.4)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.3,image_yscale*1.3,image_angle,image_blend,0.2)
