#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if image_angle=0
  {
    if scrController(3)
    {
      if controlID.x<controlID.rightEnd {controlID.x+=3}
    }
    else if scrController(4)
    {
      if controlID.x>controlID.leftEnd {controlID.x-=3}
    }
  }
  else
  {
    if scrController(3)
    {
      if controlID.y>controlID.leftEnd {controlID.y-=3}
    }
    else if scrController(4)
    {
      if controlID.y<controlID.rightEnd {controlID.y+=3}
    }
  }
}
