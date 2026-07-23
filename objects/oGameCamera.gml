#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
view_object[0]=oGameCamera

/*
view_xview[0]=global.newMapX-240
view_yview[0]=global.newMapY-176
if view_xview[0]<0
  view_xview[0]=0
else if view_xview[0]>room_width-480
  view_xview[0]=room_width-480

if view_yview[0]<0
  view_yview[0]=0
else if view_yview[0]>room_height-352
  view_yview[0]=room_height-352*/

shakeX=0
shakeAmp=0
shakeSrn=0
shakeTime=0 //Must be increments of 2
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Follow script
{
  x+=shakeX
}
else if type=1 //Follow player
{
  x=oPlayer1.x+shakeX
  y=oPlayer1.y
}
else if type=2 //Follow only player x
{
  x=oPlayer1.x+shakeX
  y=axisFollow
}
else if type=3 //Follow only player y
{
  x=axisFollow+shakeX
  y=oPlayer1.y
}

if shakeTime>0 //Screen shake
{
  shakeSrn+=1
  if shakeSrn mod 2=0 {shakeX=shakeAmp}
  else {shakeX=-shakeAmp}

  if global.gamePaused=false
  {
    shakeTime-=1
    if shakeTime=0 {shakeX=0}
  }
}
