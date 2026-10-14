if oPlayer1.attackState=oPlayer1.ACT_IN_BIKE and bJumpedOut=0
{
  with oPlayer1
  {
    setCollisionBounds(-8,-40,8,-1)
    attackState=0
    if gDeltaTime == 1
    {
      yVel=-8; yAcc=-8
    }
    else
    {
      //var bodged;
      //bodged = (-16) * 1.00
      //yVel = bodged
      //yVel += gravityIntensity*0.5
      //60fps change: the launch as at 30fps. There the player is still on the ground for the launch's first tick (leaving
      //it is only noticed on the next tick), and the ground movement's whole-pixel slope handling only lifts them 12px of
      //the 16 that tick; then they carry on at -16 with gravity. Above 30fps leaving the ground was noticed a frame later,
      //so gravity started 3/4 tick early, and the jump out came 11px (60fps) / 16px (120fps) short of 30fps's 111px.
      //For one tick the walk-off is held and the speed gives the same 12px (the slope handling moves 1.075x per frame),
      //then -16 is put back as they leave the ground (characterStepEvent): within 1-2px of 30fps all the way up and down
      yVel=-12/1.075; yAcc=0
      bikeLaunchHold=1; bikeLaunchVel=-16
    }
    maxSlope=4; maxDownSlope=8
  }
  oBikeViewFollow.viewProg=1
  x=oPlayer1.x; y=oPlayer1.y
  image_yscale=1
  sprite_index=sJerryBike
  bJumpedOut=1
  
  if room=rSandCave {with oDSandCrawlerSpawner {instance_destroy()}} //spsp ns
}
