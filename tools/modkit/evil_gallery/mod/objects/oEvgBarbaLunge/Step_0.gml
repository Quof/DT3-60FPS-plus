//Evil Boss Gallery: the lunge crosses the arena (see Create)
if global.gamePaused=false
{
  if started=0
  {
    started=1
    hx=x
    image_xscale=-64*dir
    image_yscale=20
    if low=1 {y=yTop-20}
    else {y=yTop-54}
  }
  t+=1*gDeltaTime
  hx+=spd*dir*gDeltaTime
  x=hx+dir*12
  if (dir=1 and hx>656) or (dir=-1 and hx<176) {instance_destroy()}
}
