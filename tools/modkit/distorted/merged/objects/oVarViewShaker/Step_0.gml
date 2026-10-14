if global.gamePaused=false and phasecheck=0
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
else if global.gamePaused=false and phasecheck=1 //spsp ns DAbom
{
  if shakeTime mod 2=0 {shakeAmt=-turbulance}
  else {shakeAmt=turbulance}

  x=oDAbomMain.MyCamera.x+shakeAmt
  y=oDAbomMain.MyCamera.y
  //shakeTime-=1
  shakeTime-=1*gDeltaTime //60fps change: per frame, as in the branch above
  if shakeTime=0
  {
    view_object[0]=oDAbomMain.MyCamera
    instance_destroy()
  }
}
