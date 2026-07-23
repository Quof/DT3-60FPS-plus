#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
direction=random(360)
speed=3+random(0.5)
dirChange=irandom(150)
escape=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if direction>90 and direction<270 {image_xscale=-1}
else {image_xscale=1}

if speed>1 {speed-=0.05}

dirChange+=1
if dirChange>=200
{
  direction=random(360)
  speed=2+random(0.25)
  dirChange=irandom(150)
}

if escape=0
{
  if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<80
  {
    direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)-180
    speed=4+random(1)
    dirChange=irandom(150)
    escape=30
  }
}
else {escape-=1}
