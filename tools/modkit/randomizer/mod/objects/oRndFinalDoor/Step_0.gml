if global.gamePaused=false
{
  yVel=scrGravAcc(yVel,0.3,1)
  moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  if isCollisionSolid() {y-=2}

  //Up at the door: the Warmaster's fight, the boss gallery's way (rndBossStart); back here if it's given up
  if place_meeting(x,y,oPlayer1) and oKeyCodes.kCodePressed[3]=1 and global.rndFight<0
  {
    resetKeyCodes()
    rndBossStart(global.rndBossFinal,room,oPlayer1.x,oPlayer1.y)
    global.newMapX=global.rndBossX[global.rndBossFinal]
    global.newMapY=global.rndBossY[global.rndBossFinal]
    writeToPlayerGlobals()
    global.gamePaused=false
    transition_steps=10
    transition_kind=21
    room_goto_fixed(global.rndBossRoom[global.rndBossFinal])
  }
}
