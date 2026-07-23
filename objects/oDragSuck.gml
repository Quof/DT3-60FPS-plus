#define Collision_oCHAOS_DragSeg
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.suckReady=1 and oDragoonShip.bSucking=1
{
  other.bIsSucked=2
  other.x-=7
  if other.y<oDragoonShip.y-3 {other.y+=3}
  else if other.y>oDragoonShip.y+3 {other.y-=3}
}
