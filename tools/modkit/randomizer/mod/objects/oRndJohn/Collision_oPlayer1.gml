//Randomizer: talked to (Up, as the game's own NPCs, but pressed on this frame only: oKeyCodes' press lasts its whole
//30fps tick, so above 30fps it was taken 2 or 4 times). Debug mode off: he offers it, and the prompt opens (the game
//paused till it's answered: Step). On: off again without asking, with what it had turned on (mouse movement,
//invincibility, always max HP)
if oKeyCodesHighFPS.kCodePressed[3]=1 and global.gamePaused=false and rjOpen=0
{
  global.recPeopleTalkNum+=1
  if x<=oPlayer1.x {image_xscale=1} else {image_xscale=-1}
  if global.debugMenu=1
  {
    global.debugMenu=0
    global.debugMouseMove=0
    global.debugInvincible=false
    global.debugAlwaysMaxHP=false
    boxSize=0
    stringToShow="Off it goes."
    npcTextBox()
  }
  else
  {
    boxSize=2
    stringToShow="Stuck? Logic bugged out? I can turn debug mode on... Don't ask why I never did this to help before."
    npcTextBox()
    rjOpen=1
    rjCur=0
    depth=-101
    global.gamePaused=true
    resetKeyCodes()
  }
}
