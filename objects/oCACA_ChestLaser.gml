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
pixelOffset=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if pixelOffset=0 {pixelOffset=1}
else {pixelOffset=0}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
for(i=0;i<32;i+=1)
{
  draw_sprite_ext(sprite_index,image_index,x+(32*i)+pixelOffset,y,1,1,image_angle,image_blend,image_alpha)
}
