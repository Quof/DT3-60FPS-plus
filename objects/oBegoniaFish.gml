#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
_direction=random(360)
_speed=3+random(0.5)
dirChange=irandom(150)
escape=0
_speed=0
_direction=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if _direction>90 and _direction<270 {image_xscale=-1}
else {image_xscale=1}

if _speed>1 {_speed-=0.05*gDeltaTime}

dirChange+=1*gDeltaTime
if dirChange>=200
{
  _direction=random(360)
  _speed=2+random(0.25)
  dirChange=irandom(150)
}

if escape=0
{
  if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<80
  {
    _direction=(point_direction(x,y,oPlayer1.x,oPlayer1.y-26)-180)mod 360
    _speed=4+random(1)
    dirChange=irandom(150)
    escape=30
  }
}
else {escape-=1*gDeltaTime}

_speed=0
x += cos(degtorad(_direction)) * _speed * gDeltaTime
y -= sin(degtorad(_direction)) * _speed * gDeltaTime
correctSpeedDirection(self)
