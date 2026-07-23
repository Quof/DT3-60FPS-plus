#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
baseY=y
standTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the switch
if global.gamePaused=false
{
  if isCollisionCharacterTop(1,0)
  {
    if y<baseY+16 {yVel=0.5}
    else {yVel=0}
    standTime=30
  }
  else
  {
    standTime-=1
    if standTime<=0
    {
      if y>baseY {yVel=-0.5}
      else {yVel=0}
    }
    else {yVel=0}
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite(sStepRopeA,0,x+8,baseY+16)
draw_sprite(sprite_index,0,x,y)
