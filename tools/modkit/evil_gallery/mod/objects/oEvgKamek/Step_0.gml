//Evil Boss Gallery: Evil Kamek (rExtGateA_6: the game's Kamek made this by the fight's controller, oEvgFight). His
//own fight (his Step), with 7 stomps to beat instead of 5, his wand (and its barrier) up from the start, and these
//besides, at every other end of his walk and after each meteor shower (user event 3, in turn: evgPat):
//  1 decoys      two fake Kameks fade in elsewhere (oEvgKamDecoy: see-through, stompable) and shoot his shapes at the
//                player, twice, then fade out
//  2 mega orb    a magic shape grows in his hand, drops and rolls the arena's floor, big (oEvgKamMegaOrb): jump it
//                (a full jump) or wait on a side platform
//  3 swoop       he flies up to the far side, shows the line he'll take (a dotted line at the player) and swoops
//                down it fast, landing where it ends
if !variable_local_exists("evgOn")
{
  evgOn=1
  eName="Evil Kamek"
  maxLife=7
  life=maxLife
  evgMove=0
  evgT=0
  evgStage=0
  evgEnds=0
  evgArmed=0
  evgPat="123"
  evgPatPos=0
  evgWand=0
  swDir=0
  swSpd=9
  swX=0
  swY=0
  jeremyText="Kamek's wand guards him from the start this time, so take it down first: stomp it when it swoops low. He's learned some new tricks too: fake copies of himself, giant magic that rolls along the floor, and a dive straight at you. The dive always shows you its line first."
}
if global.gamePaused=false and bActive=true and life>0 and hitStateTime=0
{
  //his wand and its barrier up from the start (the game's Kamek gets them after the first stomp)
  if evgWand=0 and wandState=0
  {
    instance_create(x,yGround-158,oKamWand)
    wandState=2
  }
  evgWand=1
  //an evil move at every other end of his walk (atkTime back to 0, standing), and after each meteor shower
  if atkTime>=1 {evgArmed=1}
  if evgMove=0 and evgArmed=1 and atkTime<1
  {
    evgArmed=0
    var tGo;
    tGo=0
    if moveType=3 {tGo=1}
    else if moveType=0 and sprite_index=sKamekIdle
    {
      evgEnds+=1
      if (evgEnds mod 2)=0 {tGo=1}
    }
    if tGo=1
    {
      if evgPatPos>=string_length(evgPat) {evgPatPos=0}
      evgMove=real(string_char_at(evgPat,evgPatPos+1))
      evgPatPos+=1
      evgT=0
      evgStage=0
    }
  }
}

if evgMove>0 and global.gamePaused=false and bActive=true and life>0 and hitStateTime=0
{
  event_user(3)
  enemyStepEvent()
}
else {event_inherited()}
