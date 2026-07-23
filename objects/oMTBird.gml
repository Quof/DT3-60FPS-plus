#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=(0.15+random(0.1))
image_xscale=choose(-1,1)
moveSpd=(0.25+random(0.75))*gDeltaTime
dirChange=irandom(300)
type=0
bSpotted=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if image_xscale=1
  x+=moveSpd
else
  x-=moveSpd

if type=0
{
  dirChange+=1*gDeltaTime
  if dirChange>=480
  {
    if image_xscale=1
      image_xscale=-1
    else
      image_xscale=1
    dirChange=irandom(300)
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
