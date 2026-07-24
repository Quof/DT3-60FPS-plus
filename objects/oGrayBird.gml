#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2+random(0.2)
moveSpdX=3+random(5)
moveSpdY=random_range(-0.25,0.25)
bSpotted=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale=1 {x+=moveSpdX*gDeltaTime}
else {x-=moveSpdX*gDeltaTime}
y+=moveSpdY*gDeltaTime

if image_xscale=1
{
  if x>=room_width+24 {instance_destroy()}
}
else
{
  if x<=-24 {instance_destroy()}
}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
