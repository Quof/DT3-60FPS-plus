if global.gamePaused=false
{
  //decayTime-=1
  decayTime-=1*gDeltaTime //60fps change
  if decayTime<=0
  {
    instance_destroy()
  }
}
