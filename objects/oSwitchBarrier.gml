#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: switchID
image_alpha=0.9
image_blend=c_orange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_alpha=0.9 {image_alpha=0.8}
else {image_alpha=0.9}

//set in the instance creation code
if switchID.activated=1 {instance_destroy()}
