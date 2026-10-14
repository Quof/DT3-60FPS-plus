if room=rExtGateA_5 and bWindWorks=1 and true //spsp
{
  if global.gamePaused=false
  {
    pushBlockX=0
    pushBlockY=0
    //if direction=0 {pushBlockX=2}
    //else if direction=90 {pushBlockY=-5}
    //else if direction=180 {pushBlockX=-2}
    //else if direction=270 {pushBlockY=1}
    if _direction=0 {pushBlockX=2} //60fps change: DT3+'s wind zones use _direction
    else if _direction=90 {pushBlockY=-5} //60fps change
    else if _direction=180 {pushBlockX=-2} //60fps change
    else if _direction=270 {pushBlockY=1} //60fps change

    with other
    {
      //if other.pushBlockY<1 {yVel=other.pushBlockY}
      //moveTo(other.pushBlockX,other.pushBlockY)
      yVel=-2
    }
  }
}
