//This script allows the player to dash forward

idleTime=0
if grappleState=0 {busterAnimStay=0}

global.recDashForward+=1
var tEffect;
tEffect=instance_create(x,y+2,oEffect)
tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

var tDashAdj; tDashAdj=0
if global.activeCharacter=0 or global.activeCharacter=4 //----- Jerry -----
{
  playSound(global.snd_MMSlide,0,1,1)
  if global.activeCharacter=0
  {
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=13 {tDashAdj=2; break;}
    }
  }
  dashMomentumTime=13
  groundDashRecovery=8
  backDashRecovery=0
}
else if global.activeCharacter=1 //----- Claire -----
{
  playSound(global.snd_PlayerJump[0],0,1,1)
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=13 {tDashAdj=2; break;}
  }
  dashMomentumTime=25
  if (gDeltaTime==1)
  {
    yAcc+=initialJumpAcc/2
  }
  else
  {
    //var bodged;
    //bodged = (initialJumpAcc/2) * 1.2 //fine tune this as needed
    //yVel = bodged
    //yVel += gravityIntensity*0.5
    //60fps change: gravity starts one frame after the hop here (1 tick at 30fps), which makes the hop higher the longer that
    //frame is. At 60fps that exactly makes up for pMoveToWrapNew's gravity (no correction needed); at 120fps it's 1/4 tick
    //short, so add back half of the missing gravity (all of it is right if the dash button is let go at once, none of it if
    //it's held, since gravity then ramps up from 0). With landTickHold (characterStepEvent) the hop distance averages within
    //~1px (60fps) / ~2px (120fps) of 30fps; with the 1.2 value it was 4-6px short at 120fps and the hop was higher at 60fps
    yVel = initialJumpAcc/2 - grav*(0.5-gDeltaTime)*0.5
  }
  //the "state" gets changed to JUMPING later on in the code
  state=FALLING
}
dashNumThisMap+=1
dashInvulnerabilityTime+=dashInvulnerability+tDashAdj
dashRecHalt+=9
dashEnergy-=2000

xAcc+=xVel

//no dash speed correction needed above 30fps: xVelSetTick makes pMoveToWrapNew use the original 30fps formula for this frame
var dashBodge;
dashBodge = 0
xVelSetTick=1

if facing=RIGHT
{
  xVel=dashVel+dashBodge
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sDashWave
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  if global.activeCharacter=4
  {
    tEffect=instance_create(x-(7*image_xscale),y-31,oEffect)
    tEffect.sprite_index=sJF_DashEf; tEffect.image_xscale=1.5; tEffect.image_yscale=1.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
}
else
{
  xVel=-dashVel-dashBodge
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sDashWave; tEffect.image_xscale=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  if global.activeCharacter=4
  {
    tEffect=instance_create(x-(7*image_xscale),y-31,oEffect)
    tEffect.sprite_index=sJF_DashEf; tEffect.image_xscale=-1.5; tEffect.image_yscale=1.5
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
  }
}

//"variable jumping" states
jumpButtonReleased=0
jumpTime=0

//60fps change (added): above 30fps the rest of this 30fps tick skips the run code and Jerry's dash keeps this acceleration
//(characterStepEvent), like the 30fps dash that set the whole tick
dashTickTime=1; dashTickXAcc=xAcc
