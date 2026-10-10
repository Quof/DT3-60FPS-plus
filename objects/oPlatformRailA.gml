#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
newSprite=0
myHP=2

findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=400
bCanMove=true
turnDelay=0
offscreenDestroy=300
deathCheck=0
solidIsNearPlayers=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xVel=xMove
yVel=yMove
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCanMove=true
  {
    offscreenDestroy-=1*gDeltaTime
    //60fps change (added): turns on 30fps ticks, checked at this tick's finished position (mstLX/mstLY, same as x/y at
    //30fps). Every frame it caught the turn mid-move and snapped the platform up to half a move in one go without the
    //player on it, so going up the player ended up inside it and wasn't carried sideways after the turn.
    if gDeltaDoTicks
    {
    if turnDelay=0
    {
      //nextTurn=instance_nearest(x,y,oPlatRail) //find closest rail turn
      //if point_distance(x,y,nextTurn.x+8,nextTurn.y+8)<moveSpd
      nextTurn=instance_nearest(mstLX,mstLY,oPlatRail) //find closest rail turn //60fps change: this tick's finished position
      if point_distance(mstLX,mstLY,nextTurn.x+8,nextTurn.y+8)<moveSpd //60fps change
      {
        //x=nextTurn.x+8; y=nextTurn.y+8
        //60fps change: above 30fps, while the tick's move is still being spread over the frames, the rest of it is made to
        //end on the turn instead (gameStepEvent moves it and carries/pushes the player)
        if gDeltaTime!=1 and mstFramesLeft>0 {mstXLeft=nextTurn.x+8-x; mstYLeft=nextTurn.y+8-y; mstLX=nextTurn.x+8; mstLY=nextTurn.y+8}
        else {x=nextTurn.x+8; y=nextTurn.y+8}
        var tXvel,tYvel;
        tXvel=xVel; tYvel=yVel
        xVel=0; yVel=0
        if nextTurn.turnType=0 //top-left corner
        {
          if tYvel<0 {xVel=moveSpd}
          else if tXvel<0 {yVel=moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=1 //top-right corner
        {
          if tXvel>0 {yVel=moveSpd}
          else if tYvel<0 {xVel=-moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=2 //bottom-right corner
        {
          if tYvel>0 {xVel=-moveSpd}
          else if tXvel>0 {yVel=-moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=3 //bottom-left corner
        {
          if tXvel<0 {yVel=-moveSpd}
          else if tYvel>0 {xVel=moveSpd}
          else {xVel=-tXvel; yVel=-tYvel}
          turnDelay=8
        }
        else if nextTurn.turnType=4 //turn around
        {
          xVel=-tXvel; yVel=-tYvel
          turnDelay=8
        }
      }
    }
    //else {turnDelay-=1}
    //else {turnDelay-=1*gDeltaTime} //60fps change: the delay after a turn was half/quarter as long at 60/120fps
    else {turnDelay-=1} //60fps change: once per 30fps tick (the turn logic is on ticks now)
    }
  }

  if myHP<=0
  {
    instance_destroy()
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if offscreenDestroy<=0 {instance_destroy()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if newSprite=0
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
}
