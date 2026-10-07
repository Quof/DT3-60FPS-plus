//This script allows the player to wall jump
//argument0: 0: left, 1: right

var tWallCheck;
tWallCheck=argument0

jumpTime=0
jumpButtonReleased=0
kRight=0
kRightReleased=1
kLeft=0
kLeftReleased=1

playSound(global.snd_PlayerJump[2],0,1,1)

xAcc=xVel/4
//if (gDeltaTime==1)
//{
//    yAcc+=initialJumpAcc
//    yVel=-0.05
//}
//else
//{
//    var bodged;
//    // fine tune this 1.00 as needed
//    bodged = (initialJumpAcc-0.05) * 1.00
//    yVel = bodged
//    // compensation for fixed gravity integration
//    yVel += gravityIntensity*0.5
//}
//60fps change: the 30fps kick at every frame rate, with yVelSetTick/xVelSetTick (below) so pMoveToWrapNew uses the 30fps
//formula (velocity + acceleration) * friction for this frame, like the wall dash. The tuned values made the jump 1-5px too
//high at 120fps (the half tick of gravity added here only gets a quarter tick there) and 3-5px too far when pushing into
//the wall. Now within ~1.3px of 30fps in height and ~2px sideways at 60 and 120fps
yAcc+=initialJumpAcc
yVel=-0.05
yVelSetTick=1

walljumpTime=3
scrSlowFall(5,0.5,1)
canAirDash=1
doubleJumpCheck=1
doubleJumpAnim=0

//var bodgedX;
//if gDeltaTime == 1 {bodgedX = 1}
//else {bodgedX = 0.88 } //tune as needed
xVelSetTick=1 //60fps change (added): see above

if tWallCheck=0
{
  //xVel = (-6) * bodgedX
  xVel=-6 //60fps change
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sAirDashWave; tEffect.image_xscale=-0.75; tEffect.image_yscale=0.75
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else
{
  //xVel = 6 * bodgedX
  xVel=6 //60fps change
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sAirDashWave; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
