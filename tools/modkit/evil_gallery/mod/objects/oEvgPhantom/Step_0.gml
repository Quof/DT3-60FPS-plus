//Evil Boss Gallery: the phantom's warning (prog 0), then its rush across the arena (1), gone past the far wall
if global.gamePaused=false
{
  t+=1*gDeltaTime
  spinA-=24*dir*gDeltaTime
  if prog=0
  {
    if t>=warnTime
    {
      prog=1; t=0
      bCanDealDamage=true
      playSound(global.snd_DeathSlash,0,0.95,22000)
    }
  }
  else
  {
    x+=spd*dir*gDeltaTime
    if (dir=1 and x>room_width+48) or (dir=-1 and x<-76) {instance_destroy()}
  }
}
