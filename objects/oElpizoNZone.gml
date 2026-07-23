#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bSeeking=0
moveSpd=1.25
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bSeeking=1
  {
    if instance_exists(oElpizo)
    {
      if oElpizo.specProg=0
      {
        if x+32<oPlayer1.x {x+=moveSpd}
        else if x+32>oPlayer1.x {x-=moveSpd}
        if y+32<returnPlayerYCenter() {y+=moveSpd}
        else if y+32>returnPlayerYCenter() {y-=moveSpd}
      }
    }
  }
}
