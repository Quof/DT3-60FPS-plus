#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
size=2
damageType="ELEMENTAL"
animSeq=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animSeq+=1
if animSeq>=1 and animSeq<=5 {image_index=0; image_xscale=1}
else if animSeq>=6 and animSeq<=10 {image_index=1; image_xscale=1}
else if animSeq>=11 and animSeq<=15 {image_index=0; image_xscale=-1}
else if animSeq>=16 and animSeq<=20
{
  image_index=1; image_xscale=-1
  if animSeq=20 {animSeq=0}
}
