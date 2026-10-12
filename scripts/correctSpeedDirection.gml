//60fps change (added): _speed/_direction/_hspeed/_vspeed stand in for GameMaker's built-in speed/direction/hspeed/
//vspeed, which every instance has from the start (0 until it's set). An instance that never sets one of them (e.g. a
//wind zone, which only ever used direction, or the skill-up notice, which only used vspeed) crashed with "Unknown
//variable"; they count as 0 here, as the built-ins did (oDamagableBase's Create does the same)
with argument0
{
  if !variable_local_exists("_speed") {_speed=0}
  if !variable_local_exists("_direction") {_direction=0}
}
argument0.x += cos(degtorad(argument0._direction)) * argument0._speed * gDeltaTime;
argument0.y -= sin(degtorad(argument0._direction)) * argument0._speed * gDeltaTime;
