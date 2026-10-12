/*
This script is called to stop the player's momentum.
It is best used for cutscenes.
*/
with oPlayerAfterImage {instance_destroy()}
with oMMXstrikeChain {instance_destroy()}
if oPlayer1.grappleState>=2 and gDeltaTime<1 {oPlayer1.yVelSetExt=1} //60fps change (added): the gravity piled up while pulled to or hanging from a
//Strike Chain point is applied whole on the player's next move, as at 30fps (see pMoveToWrapNew and characterStepEvent)
oPlayer1.grappleState=0

oPlayer1.kLeft=0
oPlayer1.kRight=0
oPlayer1.kUp=0
oPlayer1.kDown=0
oPlayer1.kJump=0
oPlayer1.kJumpPressed=0
oPlayer1.kRun=0

if global.partySplit=0
{
  oPlayer1.kCharSwap=0
  oPlayer1.kCharSwapPressed=0
  oPlayer1.kAbilSwap=0
  oPlayer1.kAbilSwapPressed=0
}

oPlayer1.kActA=0
oPlayer1.kActAPressed=0
oPlayer1.kActB=0
oPlayer1.kActBPressed=0
oPlayer1.kActC=0
oPlayer1.kActCPressed=0

oPlayer1.xVel=0
oPlayer1.yVel=0

oPlayer1.image_index=0
oPlayer1.image_speed=0.1
