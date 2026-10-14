if global.gamePaused=false and bCanTakeDamage=0
{
  //activeTime-=1
  activeTime-=1*gDeltaTime //60fps change: per frame
  if activeTime<=0 {bCanTakeDamage=1}
}
