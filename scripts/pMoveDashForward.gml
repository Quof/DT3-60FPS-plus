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
  yAcc+=initialJumpAcc/2
  //the "state" gets changed to JUMPING later on in the code
  state=FALLING
}
dashNumThisMap+=1
dashInvulnerabilityTime+=dashInvulnerability+tDashAdj
dashRecHalt+=9
dashEnergy-=2000

xAcc+=xVel
if facing=RIGHT
{
  xVel=dashVel
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
  xVel=-dashVel
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
