//Evil Boss Gallery: Evil Thunderbird (rLink2_PalaceC_14: the game's Thunderbird made this by the fight's controller,
//oEvgFight). Its own fight (its Step: flying its box over the pyramid, spitting fire), with 3850 life instead of 2750,
//and every evgDelay ticks one of these (user event 3, in turn: evgPat), its own flying and spitting stopped meanwhile:
//  1 thunder     it screeches up high and calls lightning on three spots, the player's and 56 either side (the
//                warnings show first), twice from its third phase
//  2 wing gust   it hovers and beats its wings: a wind pushes the player away from it for 90 ticks (walk against it),
//                carrying fireballs low (jump) and high (duck) in turn
//  3 swoop       its eyes flash (20 ticks) and it dives through where the player was and back up the other side, low
//                enough there for the sword
if !variable_local_exists("evgOn")
{
  evgOn=1
  eName="Evil Thunderbird"
  maxLife=3850
  life=maxLife
  evgMove=0
  evgT=0
  evgStage=0
  evgClock=0
  evgDelay=230
  evgPat="123"
  evgPatPos=0
  boltRound=0
  gustDir=1
  gustNext=0
  gustNum=0
  swX0=0
  swY0=0
  swTX=0
  swTY=0
  swLen=40
  jeremyText="This thing's out for blood. When it screeches up high, lightning's coming: get off the marked spots. When it beats its wings, walk into the wind and watch the fireballs it carries, low ones you jump and high ones you duck. And when its eyes flash, it's diving at where you are: move, then hit it while it's low."
}
if global.gamePaused=false and bActive=true and life>0
{
  if bossProgress>=2 {evgDelay=200}
  if bossProgress>=4 {evgDelay=170}
  if evgMove=0
  {
    evgClock+=1*gDeltaTime
    if evgClock>=evgDelay
    {
      evgClock=0
      if evgPatPos>=string_length(evgPat) {evgPatPos=0}
      evgMove=real(string_char_at(evgPat,evgPatPos+1))
      evgPatPos+=1
      evgT=0
      evgStage=0
    }
  }
}

if evgMove>0 and global.gamePaused=false and bActive=true and life>0
{
  event_user(3)
  enemyStepEvent()
}
else {event_inherited()}
