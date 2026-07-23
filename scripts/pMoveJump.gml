//This script allows the player to jump

idleTime=0
if grappleState=0 {busterAnimStay=0}

if global.activeCharacter=0 or global.activeCharacter=1 or global.activeCharacter=4
{
  if room=rBT_BrianA or room=rBT_BrianB
  {
    playSound(global.snd_PlayerJump[1],0,0.95,1)
  }
  else
  {
    if global.location=7 or global.location=101 {playSound(global.snd_PlayerJump[1],0,0.95,1)}
    else if global.location=29 {playSound(global.snd_PlayerJump[2],0,1,1)}
    else {playSound(global.snd_PlayerJump[0],0,1,1)}
  }
}
else
{
  if global.location=110 {playSound(global.snd_MechJump,0,0.93,14000)}
  else {playSound(global.snd_MechJump,0,1,1)}
}

mechFuel=mechMaxFuel
global.recJumped+=1

if (gDeltaTime==1)
{
    if bombJump=0 {yAcc+=initialJumpAcc}
    else {yAcc+=initialJumpAcc*bombAcc}
}
else
{
    var ijabodge;
    // compensate for standard-height full jumps to have the same height despite different pixel rounding
    ijabodge = initialJumpAcc * 1.07
    if bombJump=0 {yVel+=ijabodge}
    else {yVel+=ijabodge*bombAcc}
    yVel += gravityIntensity*0.5
}
bombJump=0
ditherCounter=15 // make jumps deterministic

//xAcc+=xVel/2
var tEffect;
tEffect=instance_create(x,y+2,oEffect)
tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0

//the "state" gets changed to JUMPING later on in the code
state=FALLING
//"variable jumping" states
jumpButtonReleased=0
jumpTime=0
