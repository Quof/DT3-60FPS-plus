//Advance death wall
if global.gamePaused=false
{
  x+=xSpd*gDeltaTime
  if x+xThres>=oPlayer1.x
    oPlayer1.life-=oPlayer1.maxLife
}
