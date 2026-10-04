#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(-16,-51,16,0)
soundDelay=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if y!=global.newMapY
{
  y=global.newMapY
}

if variable_local_exists("forceNewY")
{
  if x!=global.newMapX
  {
    y=forceNewY
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//on 30fps ticks, with the collision checks done at this tick's finished position (mstLY),
//so the elevator stops exactly where it does at 30fps; gameStepEvent spreads the movement across frames
if global.gamePaused=false and gDeltaDoTicks != 0
{
  myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y) //real positions: the player is carried in step with the elevator
  var tRealY;
  tRealY=y; y=mstLY
  if myDist<10
  {
    if scrController(3)
    {
      if isCollisionTop(1)
        yVel=0
      else
        yVel=-4
    }
    else if scrController(4)
    {
      if isCollisionBottom(1)
        yVel=0
      else
        yVel=4
    }
    else {yVel=0}

    if yVel!=0
    {
      if soundDelay=0
      {
        //sound_play(snd_ElevatorUse)
        soundDelay=4
      }
      else {soundDelay-=1}
    }
  }
  else {yVel=0}
  y=tRealY
}
