#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
flowerFrm=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
flowerFrm+=1
if flowerFrm=10 {image_index=1}
else if flowerFrm=20 {image_index=0}
else if flowerFrm=30 {image_index=2}
else if flowerFrm=40 {image_index=0; flowerFrm=0}
