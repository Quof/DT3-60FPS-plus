//Evil Boss Gallery: the lava bubble: bubbling (prog 0), then up and back down into the lava (1)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  if prog=0
  {
    if t>=warn
    {
      prog=1
      yVel=-11
      bCanDealDamage=true
      playSound(global.snd_Fireball,0,0.9,15000)
    }
  }
  else
  {
    yVel=scrGravAcc(yVel,0.4,1)
    y+=yVel*gDeltaTime
    image_angle=180*(yVel>0)
    if yVel>0 and y>=y0+8 {instance_destroy()}
  }
}
