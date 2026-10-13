//(Altered Beast: Mega Man's Gravity Field special bends enemy projectiles in it upward)
//    if direction>90 and direction < 270 {direction-=2}
//    else {direction+=2}
//60fps change: 2 degrees a 30fps tick, on DT3+'s own motion (_direction) for a projectile that moves by it (its
//direction can be outside 0-360, so it's compared as an angle)
var tTurn,tDir;
tTurn=2*gDeltaTime
if variable_local_exists("_speed") and _speed!=0
{
  tDir=_direction-floor(_direction/360)*360
  if tDir>90 and tDir<270 {_direction-=tTurn}
  else {_direction+=tTurn}
}
else
{
  if direction>90 and direction < 270 {direction-=tTurn}
  else {direction+=tTurn}
}
