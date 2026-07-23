#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
myIsle=choose(1,2,3)
if myIsle=1 {sprite_index=sGG_BackIsleA}
else if myIsle=2 {sprite_index=sGG_BackIsleB}
else if myIsle=3 {sprite_index=sGG_BackIsleC}

mySpd=1+random(0.5)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
y-=mySpd
if y<=-40
{
  instance_destroy()
}
