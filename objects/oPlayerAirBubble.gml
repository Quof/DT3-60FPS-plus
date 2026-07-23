#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(1,0,sprite_width,sprite_height)
image_speed=0
ranSpeed=random_range(1,2.5)
image_index=choose(0,1)
breakThres=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  x+=sin(0.1)

  y-=ranSpeed

  breakThres+=1
  if isCollisionSolid() and breakThres>=30 {instance_destroy()}
  if y<-8 or y<view_yview[0]-96 or !isCollisionWaterTop(3) {instance_destroy()}
}
