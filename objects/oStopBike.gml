#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_alpha=0.33
bJumpedOut=0
veloAdd=0
animTop=16
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
animTop-=1*gDeltaTime
if animTop=0 {animTop=16}

if bJumpedOut=1
{
  x+=12*gDeltaTime
  veloAdd+=1*gDeltaTime
  if veloAdd<8 {oPlayer1.xVel=10}

  if x>=room_width+32
  {
    playSound(global.snd_BombExplode,0,0.95,1)
    tEffect=instance_create(x,y-8,oEffect)
    tEffect.sprite_index=sBombExplosion; tEffect.image_alpha=0.75
    tEffect.image_xscale=2; tEffect.image_yscale=2
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
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
      //yVel=-12/1.075; yAcc=0
      //bikeLaunchHold=1; bikeLaunchVel=-16
      if platformCharacterIs(ON_GROUND) //60fps change: the above only for a launch from the ground
      {
        yVel=-12/1.075; yAcc=0
        bikeLaunchHold=1; bikeLaunchVel=-16
      }
      //60fps change (added): in the air at the line (off a ramp) there's no walk-off to give the -16 back, so the launch
      //rose ~52px of 30fps's ~99. The 30fps launch as a one-off push instead (yVelSetExt: that move uses the 30fps
      //formula, as springs and fans do): 99.9px at 60fps, 98.9px at 120fps
      else {yVel=-8; yAcc=-8; yVelSetExt=1}
    }
    maxSlope=4; maxDownSlope=8
  }
  oBikeViewFollow.viewProg=1
  x=oPlayer1.x; y=oPlayer1.y
  image_yscale=1
  sprite_index=sJerryBike
  bJumpedOut=1
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bJumpedOut=0
{
  for(i=0;i<image_yscale*2;i+=1)
  {
    draw_sprite_part_ext(sprite_index,0,0,animTop,16,16,x,y+(i*16),1,1,image_blend,image_alpha)
  }
}
else if bJumpedOut=1
{
  draw_sprite(sJerryBike,0,x,y)
}
