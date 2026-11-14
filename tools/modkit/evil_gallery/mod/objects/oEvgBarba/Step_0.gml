//Evil Boss Gallery: Evil Barba (rLink2_DeathRoadA: the game's Barba made this by the fight's controller, oEvgFight).
//Its own fight (its Step), with 3900 life instead of 2800, and every other time it goes back under the lava (atkCycle
//5), one of these first (user event 3, in turn: evgPat):
//  1 serpent lunge  its eyes glow in the pit furthest from the player, low or high (the warning), then it shoots out
//                   sideways across the islands (oEvgBarbaLunge): low, jump it; high, duck it. Two in a row from its
//                   fourth phase, low then high
//  2 lava geysers   the pits erupt one after another (oEvgLavaGeyser: bubbling first, then a column of lava up to the
//                   ceiling, flinging two globs onto the islands): don't be jumping a pit as it goes up
//  3 cave-in        its roar shakes rocks loose from the ceiling (oEvgFallRock), onto the islands and at the player,
//                   each one's shadow and dust showing where first
if !variable_local_exists("evgOn")
{
  evgOn=1
  eName="Evil Barba"
  maxLife=3900
  life=maxLife
  evgMove=0
  evgT=0
  evgStage=0
  evgDives=0
  evgPat="123"
  evgPatPos=0
  evgPrev=atkCycle
  lungeLow=1
  lungeDir=1
  lungeX=0
  lungeNum=0
  lungeLeft=1
  gyRound=0
  gyNum=0
  gyNext=0
  rockNum=0
  rockNext=0
  jeremyText="Barba's angrier and so is the lava. Watch the pits: if its eyes glow low, jump the lunge; high, duck it. Bubbling lava means a geyser's coming, so don't jump that pit. And when it roars, look up and watch for the rocks' shadows."
}
if global.gamePaused=false and bActive=true and life>0
{
  if evgMove=0 and atkCycle=5 and evgPrev=4 //(just back under the lava)
  {
    evgDives+=1
    if (evgDives mod 2)=0
    {
      if evgPatPos>=string_length(evgPat) {evgPatPos=0}
      evgMove=real(string_char_at(evgPat,evgPatPos+1))
      evgPatPos+=1
      evgT=0
      evgStage=0
    }
  }
  evgPrev=atkCycle
}

if evgMove>0 and global.gamePaused=false and bActive=true and life>0
{
  event_user(3)
  enemyStepEvent()
}
else {event_inherited()}
