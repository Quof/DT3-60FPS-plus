/*
Warmaster II: shakes the screen (oBTB_Ev_Warmaster2 moves the view and lets it settle).
argument0: strength in pixels
*/
if instance_exists(oBTB_Ev_Warmaster2)
{
  oBTB_Ev_Warmaster2.shake=max(oBTB_Ev_Warmaster2.shake,argument0)
}
