#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
image_index=1
image_xscale=0.8; image_yscale=0.8

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false

damageType="ELEMENTAL"
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()

image_angle-=15*gDeltaTime

//correctSpeedDirection(self)
//60fps change: removed the line above; event_inherited() already runs oExe_BulletBase's Step, which does the move, so this bullet moved twice per step (double speed)
