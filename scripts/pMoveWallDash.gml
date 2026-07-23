//This script allows the player to wall dash
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

xAcc=xVel/1.75
yAcc+=initialJumpAcc/1.33
dashMomentumTime=6

var tDashAdj; tDashAdj=0
if global.activeCharacter=0 //----- Jerry -----
{
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=13 {tDashAdj=2; break;}
  }
}
else if global.activeCharacter=1 //----- Claire -----
{
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=13 {tDashAdj=2; break;}
  }
}
dashInvulnerabilityTime+=dashInvulnerability
dashRecHalt+=9
dashEnergy-=1500

yVel=-0.05
walljumpTime=3
scrSlowFall(5,0.5,1)
canAirDash=1
doubleJumpCheck=1
doubleJumpAnim=0

if tWallCheck=0
{
  facing=LEFT
  xVel=-16
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sAirDashWave; tEffect.image_xscale=-0.75; tEffect.image_yscale=0.75
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
else
{
  facing=RIGHT
  xVel=16
  var tEffect;
  tEffect=instance_create(x,y,oEffect)
  tEffect.sprite_index=sAirDashWave; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
