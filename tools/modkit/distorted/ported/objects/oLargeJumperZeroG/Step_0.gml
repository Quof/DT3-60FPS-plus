if global.gamePaused=false
{
  if bouncePlayerTime>0
  {
    //oPlayer1.yVel=-16
    oPlayer1.yVel=-16; oPlayer1.yVelSetExt=1 //60fps change: velocity set every frame, use the 30fps formula (pMoveToWrapNew), like oBegoniaFan
    bouncePlayerTime-=1*gDeltaTime
  }
  /*yVel=scrGravAcc(yVel,0.3,1)
  if isCollisionBottom(1)
    yVel=0
  //moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  //60fps change: between ticks, a jumper that reached the ground on the tick stays where the tick left it. Upside-down
  //ones sit a bit into the ground and every tick go down to it and get pushed back up 2px (below), as at 30fps; moving
  //back down on the frames in between, without the push, made them bounce 2px every frame.
  if !(restTick and gDeltaDoTicks=0) {moveTo(xVel*gDeltaTime,yVel*gDeltaTime)}
  if gDeltaDoTicks {restTick=isCollisionBottom(1)} //60fps change (added)
  //if isCollisionSolid()
  if isCollisionSolid() and gDeltaDoTicks //60fps change: the 2px push once per 30fps tick; every frame it beat the fall (moveTo is per frame) and the jumper hung in the air near the ground
    y-=2
  if y>room_height+24
    instance_destroy()*/
}
