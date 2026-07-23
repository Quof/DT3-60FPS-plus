#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
tailState=0
tailwag=15+irandom(180)

bSpotted=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tailwag-=1
if tailState=0
{
  if tailwag<=0
  {
    image_speed=0.33
    tailState=1
    tailwag=10+irandom(40)
  }
}
else if tailState=1
{
  if tailwag<=0
  {
    image_speed=0
    tailState=0
    tailwag=15+irandom(180)
  }
}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}
