if global.gamePaused=false
{
  if shakeTime mod 2=0 {shakeAmt=-turbulance}
  else {shakeAmt=turbulance}
  if oPlayer1.x<240 {x=240+shakeAmt}
  else if oPlayer1.x>room_width-240 {x=room_width-240+shakeAmt}
  else {x=oPlayer1.x+shakeAmt}
  y=oPlayer1.y
  shakeTime-=1*gDeltaTime
  if shakeTime=0
  {
    view_object[0]=oPlayer1
    instance_destroy()
  }
}
