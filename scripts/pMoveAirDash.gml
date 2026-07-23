//This script allows the player to air dash

canAirDash=0
global.recAirDash+=1
if facing=RIGHT
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sAirDashWave
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else
{
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sAirDashWave; tEffect.image_xscale=-1
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
with oSmallJumper {bouncePlayerTime=0}
with oLargeJumper {bouncePlayerTime=0}
//jumpSound=round(random(1)) //player jump sound
playSound(global.snd_PlayerJump[0],0,1,1)

var tDashAdj; tDashAdj=0
if global.activeCharacter=0
{
  dashMomentumTime=22
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=13 {tDashAdj=2; break;}
  }
}
else if global.activeCharacter=1
{
  var tEffect,tXspd,tFscale;
  for(i=0;i<6;i+=1)
  {
    tXspd=random_range(-2.5,2.5)
    tFscale=0.75+random(0.25)
    tEffect=instance_create(x-(image_xscale*9)+random_range(-8,8),y-37+random_range(-8,8),oEffectGrav)
    tEffect.type=2; tEffect.sprite_index=sDiveBirdFeather; tEffect.image_blend=image_blend
    tEffect.image_xscale=tFscale; tEffect.image_yscale=tFscale; tEffect.xSpd=tXspd; tEffect.ySpd=-1.5-random(2)
    tEffect.fadeSpd=0.03; tEffect.rotation=-tXspd*6; tEffect.grav=0.2
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
  }

  dashMomentumTime=15
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=13 {tDashAdj=2; break;}
  }
}
dashNumThisMap+=1
dashInvulnerabilityTime+=dashInvulnerability+tDashAdj
dashRecHalt+=9
dashEnergy-=2000
yAcc+=initialJumpAcc/2
//xAcc+=xVel
//xVel=dashVel
if airDashRecovery<7 {airDashRecovery=6}
