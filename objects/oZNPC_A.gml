#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-6,-28,6,-1)
cycleTime=0
waitTime=0
storeSpd=0
storeImgSpd=0
image_yscale=1

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xVel=runAcc
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if AI_Action=0 //---------- AI ACTION: STAND AND LOOK AT PLAYER ----------
  {
    if x<oPlayer1.x
      image_xscale=1
    else
      image_xscale=-1
  }
  if AI_Action=2 //---------- AI ACTION: WALK BACK AND FORTH ----------
  {
    cycleTime+=1
    if cycleTime>=150
    {
      if storeSpd=0
      {
        storeSpd=xVel*-1
        storeImgSpd=image_speed
        image_speed=0
        xVel=0
      }
      waitTime+=1
      if waitTime>=40
      {
        xVel=storeSpd
        image_speed=storeImgSpd
        storeSpd=0
        waitTime=0
        cycleTime=0
      }
    }
  }

  if AI_Action>0
  {
    if xVel>0
      image_xscale=1
    else if xVel<0
      image_xscale=-1
  }

  if x<-16
    x=room_width+8
  else if x>room_width+16
    x=-8

  yVel+=0.2
  if isCollisionBottom(1)
    yVel=0
  if isCollisionLeft(1)
    xVel=runAcc
  if isCollisionRight(1)
    xVel=-runAcc
  moveTo(xVel,yVel)
  if isCollisionSolid()
    y-=2
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  global.recPeopleTalkNum+=1
  npcTextBox()
}
