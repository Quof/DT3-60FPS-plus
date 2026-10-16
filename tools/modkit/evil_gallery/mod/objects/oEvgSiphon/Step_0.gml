//Evil Boss Gallery: the vortex stays on Evil Death; gone with him
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if instance_exists(owner)
  {
    x=owner.x
    y=owner.y-40
  }
  else {instance_destroy()}
}
