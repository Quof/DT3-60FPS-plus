//Evil Boss Gallery: the orb: growing in his hand (prog 0), falling (1), rolling (2), fading (3)
if global.gamePaused=false
{
  t+=1*gDeltaTime
  var tR,tL,tRt,tFloor;
  tR=10*image_xscale
  tL=128
  tRt=416
  tFloor=288
  if instance_exists(owner) {tFloor=owner.yGround; tL=owner.xCenter-owner.roomSpan; tRt=owner.xCenter+owner.roomSpan}
  if prog=0
  {
    image_xscale=0.6+1.8*min(1,t/30)
    image_yscale=image_xscale
    image_angle+=8*gDeltaTime
    if instance_exists(owner) {x=owner.x+(12*owner.image_xscale); y=owner.y-34-(10*image_xscale)}
    if t>=30
    {
      prog=1
      bCanDealDamage=true
      yVel=0
      if x<oPlayer1.x {xVel=rollSpd}
      else {xVel=-rollSpd}
    }
  }
  else if prog=1
  {
    yVel=scrGravAcc(yVel,0.6,1)
    y+=yVel*gDeltaTime
    x+=xVel*0.5*gDeltaTime
    if y+tR>=tFloor
    {
      y=tFloor-tR
      playSound(global.snd_HardHit2,0,0.8,16000)
      prog=2
    }
  }
  else if prog=2
  {
    x+=xVel*gDeltaTime
    image_angle-=xVel*(180/(pi*tR))*gDeltaTime
    if (x-tR<=tL and xVel<0) or (x+tR>=tRt and xVel>0)
    {
      xVel=-xVel
      hits+=1
      playSound(global.snd_RupeeBounce,0,0.92,20000)
      if hits>=3 {prog=3; t=0; bCanDealDamage=false}
    }
  }
  else
  {
    image_alpha=max(0,1-(t/15))
    if t>=15 {instance_destroy()}
  }
}
