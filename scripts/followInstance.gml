/*
Follow another moving instance
Requires idFollow,xFollow,yFollow,bFollow
*/
if global.gamePaused=false
{
  if bFollow=true
  {
    if instance_exists(idFollow)
    {
      x=idFollow.x+xFollow
      y=idFollow.y+yFollow
    }
    else
      instance_destroy()
  }
}
