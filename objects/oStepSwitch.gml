#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,16)
baseScale=8
stepScale=baseScale
standTimeMax=stepScale*5
standTime=standTimeMax
topY=y
baseY=y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the switch
if global.gamePaused=false
{
  y=topY-stepScale+6
  if isCollisionCharacterTop(2)
  {
    if standTime>0
      standTime-=1
  }
  else
  {
    if standTime<standTimeMax
      standTime+=returnTime
  }
  if isCollisionCharacterTop(1,oEarthShift)
  {

  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
stepScale=standTime/5
draw_sprite_ext(sprite_index,-1,x,topY-stepScale+baseScale-2,1,1,0,image_blend,1)
draw_sprite_ext(sStepSwitchBottom,-1,x,topY+baseScale,1,-stepScale,0,image_blend,1)
draw_sprite(sStepSwitchBase,-1,x,baseY)
