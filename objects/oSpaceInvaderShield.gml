#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
life=6
#define Collision_oPassBulletRed
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
with other
{
  var tEfCir;
  tEfCir=instance_create(x,y,oEfCircleBlast)
  tEfCir.myRad=2; tEfCir.radScl=1; tEfCir.fadeSpeed=0.1
  instance_destroy()
}
life-=1
if life<=0 {instance_destroy()}
