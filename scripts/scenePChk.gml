/*
Changes the player character animation and x/y position depending on active character
use: scenePChk(x,y,anim,speed,facing)

argument0: x position
argument1: y position
argument2: animation to use - check below for animation values
argument3: animation speed
argument4: facing direction

---- anim state [argument2] ----
-- 0: Idle
-- 1: Jump
-- 2: Duck
*/
var tSceneX,tSceneY,tSceneAnim,tSceneSpeed,tSceneFacing;
tSceneX=argument0
tSceneY=argument1
tSceneAnim=argument2
tSceneSpeed=argument3
tSceneFacing=argument4

oPlayer1.x=tSceneX
oPlayer1.y=tSceneY
oPlayer1.image_speed=tSceneSpeed
oPlayer1.image_xscale=tSceneFacing

if global.activeCharacter=0
{
  if tSceneAnim=0
    oPlayer1.sprite_index=sJerryIdle
  else if tSceneAnim=1
    oPlayer1.sprite_index=sJerryJump
  else if tSceneAnim=2
    oPlayer1.sprite_index=sJerryDuck
}
else if global.activeCharacter=1
{
  if tSceneAnim=0
    oPlayer1.sprite_index=sClaireIdle
  else if tSceneAnim=1
    oPlayer1.sprite_index=sClaireJump
  else if tSceneAnim=2
    oPlayer1.sprite_index=sClaireDuck
}
