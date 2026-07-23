//This script allows the player to dash back

idleTime=0
if grappleState=0 {busterAnimStay=0}

global.recDashBack+=1
var tEffect;
tEffect=instance_create(x,y+2,oEffect)
tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

var tDashAdj; tDashAdj=0
if global.activeCharacter=0 or global.activeCharacter=4 //----- Jerry -----
{
  playSound(global.snd_MMSlide,0,0.98,1)
  dashMomentumTime=20
  if global.activeCharacter=0
  {
    for(i=0;i<3;i+=1)
    {
      if global.equipJerry[i]=13 {tDashAdj=2; break;}
    }
  }
  groundDashRecovery=0
  xVel=0; xAcc=0
  backDashRecovery=8
}
else if global.activeCharacter=1 //----- Claire -----
{
  playSound(global.snd_PlayerJump[0],0,1,1)
  dashMomentumTime=25
  claireBackDashRec=8
  yAcc+=initialJumpAcc/2
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=13 {tDashAdj=2; break;}
  }
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
  xVel=-dashVel
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sDashWave; tEffect.image_xscale=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else
{
  xVel=dashVel
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sDashWave
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}

//"variable jumping" states
jumpButtonReleased=0
jumpTime=0
