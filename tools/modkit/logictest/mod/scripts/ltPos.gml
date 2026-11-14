//Logic Test: where the player is and how they're doing, for the results: the room, x,y (their feet), the speed (xVel,
//yVel, in 30fps ticks), their life and who they are (global.activeCharacter: 0 Jerry, 1 Claire)
var s;
s=room_get_name(room)
if instance_exists(oPlayer1)
{
  with (oPlayer1)
  {
    s+=" "+string(x)+","+string(y)
    if variable_local_exists("xVel") {s+=" v "+string_format(xVel,0,3)+","+string_format(yVel,0,3)}
    if variable_local_exists("maxLife") {s+=" life "+string(life)}
  }
}
else {s+=" noplayer"}
s+=" char "+string(global.activeCharacter)
return s
