if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false and trailStarted=0
{
  global.recPeopleTalkNum+=1
  if x<=oPlayer1.x {image_xscale=1}
  else {image_xscale=-1}
  
  var tCurseCheck;
  tCurseCheck=0
  for(i=0;i<3;i+=1)
  {
    if global.activeCharacter=0
    {
      if global.equipJerry[i]=10 {tCurseCheck+=1}
      else if global.equipJerry[i]=11 {tCurseCheck+=1}
      else if global.equipJerry[i]=12 {tCurseCheck+=1}
    }
    else
    {
      if global.equipClaire[i]=10 {tCurseCheck+=1}
      else if global.equipClaire[i]=11 {tCurseCheck+=1}
      else if global.equipClaire[i]=12 {tCurseCheck+=1}
    }
  }

  if tCurseCheck=3 //Have Gear Equip
  {
    if global.challengeRoom=1 
    {
    if global.modeSpeed=1
        msgCreate(80,120,"Challenge Master","You madman, I can't double the speed any further, guess this one's a freebie.",0,1,oMessagePerson,0)
    else
        msgCreate(80,120,"Challenge Master","The cousinoer5 Special: Kill all the enemies at DOUBLE SPEED!!",0,1,oMessagePerson,0)
    }
    if global.challengeRoom=2 {msgCreate(80,120,"Challenge Master","The Bird Trial: Kill all enemies without touching the ground!!",0,1,oMessagePerson,0)}
    if global.challengeRoom=3 {msgCreate(80,120,"Challenge Master","The Speed Trial: Kill all the enemies within 1800 frames!!",0,1,oMessagePerson,0)}
    if global.challengeRoom=4 {msgCreate(80,120,"Challenge Master","The Achilles Challenge: Kill all the enemies without taking a hit!!#DON'T SAVE DURING THIS ONE, YOU'LL REGRET IT!",0,3,oMessagePerson,0)}
    if global.challengeRoom=5 {msgCreate(80,120,"Challenge Master","The Stone Feet Challenge: Kill all the enemies without jumping!!",0,1,oMessagePerson,0)}
    if global.challengeRoom=6 {msgCreate(80,120,"Challenge Master","The AGI Debuff Challenge: Kill all the enemies wihout dashing!!",0,1,oMessagePerson,0)}
    if global.challengeRoom=7 {msgCreate(80,120,"Challenge Master","The Onslaught Challenge: ZERG RUSH KEKEKEKEKEKEKE",0,1,oMessagePerson,0)}
    if global.challengeRoom=8 {msgCreate(80,120,"Challenge Master","The Pacifist Challenge: No attacking, just survive!",0,1,oMessagePerson,0)}
    if global.challengeRoom=9 {msgCreate(80,120,"Challenge Master","The Clipped Wings Challenge: No dash, no touching the ground!",0,1,oMessagePerson,0)}
    if global.challengeRoom=10 {msgCreate(80,120,"Challenge Master","The BEST DAMN FRANCHISE Challenge: Kill everything EXCEPT the Mario enemies!",0,3,oMessagePerson,0)}
    if global.challengeRoom=11 {msgCreate(80,120,"Challenge Master","The Hydrophobia Challenge: Kill all enemies, and don't drown!",0,3,oMessagePerson,0)}
    if global.challengeRoom=12 {msgCreate(80,120,"Challenge Master","The ? Challenge: How will you be able to kill these enemies without your abilities!?",0,3,oMessagePerson,0)}
    if global.challengeRoom=13 {msgCreate(80,120,"Challenge Master","The Color Zone Challenge: Kill all enemies while dealing with everyone's favorite gimmick!",0,3,oMessagePerson,0)}
    if global.challengeRoom=14 {msgCreate(80,120,"Challenge Master","The Superman 64 Challenge: Solve my maze!",0,3,oMessagePerson,0)}
    if global.challengeRoom=15 {msgCreate(80,120,"Challenge Master","The Snake Challenge: Kill all targets while avoiding an ever growing tail!",0,3,oMessagePerson,0)}
    newMessage.fadingTime=60
    global.canCharSwap=1
    oExit.y+=room_height
    trailStarted=1
  }
  
  else //Need Cursed Gear
  {
    msgCreate(80,120,"Challenge Master","Only one who is cursed may attempt my trials.#RETURN WHEN YOU ARE TRULY READY!!",0,2,oMessagePerson,0)
    newMessage.fadingTime=80
  }
}
