//This script allows the player to double jump

idleTime=0
if grappleState=0 {busterAnimStay=0}

if global.location=7 or global.location=101 {playSound(global.snd_PlayerJump[1],0,0.95,1)}
else if global.location=29 {playSound(global.snd_PlayerJump[2],0,1,1)}
else {playSound(global.snd_PlayerJump[0],0,1,1)}
global.recJumped+=1
yVel=0

if (gDeltaTime==1)
{
    if bombJump=0 {yAcc+=doubleJumpAcc}
    else {yAcc+=doubleJumpAcc*bombAcc}
}
else
{
    var djabodge;
    // compensate for standard-height full jumps to have the same height despite different pixel rounding
    djabodge = doubleJumpAcc * doubleJumpBodge60 //0.98 by default (characterCreateEvent), overridden in Gate F
    if bombJump=0 {yVel+=djabodge}
    else {yVel+=djabodge*bombAcc}
    yVel += gravityIntensity*0.5
    //During an air dash, characterStepEvent sets yVel=-2.9 every frame afterwards, which erased this jump completely.
    //At 30fps the jump goes into yAcc and is added on top of the dash's -2.9 for that tick (and on the dash's last tick
    //nothing overwrites it afterwards, so the player shoots up). Keep it for the rest of this 30fps tick of the dash.
    if airDashRecovery>0
    {
      if bombJump=0 {airDashDJKick=doubleJumpAcc}
      else {airDashDJKick=doubleJumpAcc*bombAcc}
      airDashDJTick=ceil(airDashRecovery)
    }
}
ditherCounter=15 // make jumps deterministic
with oSmallJumper {bouncePlayerTime=0}
with oLargeJumper {bouncePlayerTime=0}
bombJump=0
jumpTime=3
jumpButtonReleased=0
var tEffect;
tEffect=instance_create(x,y+2,oEffect)
tEffect.sprite_index=sSpellCast; tEffect.image_xscale=0.6; tEffect.image_yscale=0.6
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
doubleJumpAnim=20
doubleJumpCheck=0
