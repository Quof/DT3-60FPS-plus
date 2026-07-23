#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
bAfterImage=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bAfterImage=1
{
  var tAfterI;
  tAfterI=instance_create(x,y,oEnemyAfterImage)
  tAfterI.sprite_index=sprite_index; tAfterI.image_index=image_index; tAfterI.depth=27
  tAfterI.image_xscale=image_xscale; tAfterI.xShift=0; tAfterI.yShift=0; tAfterI.image_angle=image_angle
  tAfterI.imageFade=0.15; ; tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.bFollow=0
}
