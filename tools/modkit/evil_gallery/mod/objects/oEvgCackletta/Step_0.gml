//Evil Boss Gallery: Evil Cackletta (rMario1_CCBoss: the game's Cackletta made this by the fight's controller,
//oEvgFight). Her own fight (her Step), with 6 stomps to beat instead of 4, harder sooner (her phases at 4, 3 and 2
//left), and these besides:
//  before each of her phone calls (atkSequence 100), one of her evil moves (user event 3), in her phase's order
//  (evgPat, a digit a move):
//    1 thunder cage  rows of lightning across the arena, one after another, each with one gap to stand in (on solid
//                    ground: the left floor, the middle or the right island), the next row's warnings showing as the
//                    last one's bolts go out
//    2 bat barrage   bats flung at the player one after another (oEvgCackBat), each where the player was: keep moving,
//                    or stomp one
//  the floor gives way sooner (3 left), and from then on lava bubbles (oEvgPodoboo) leap from the pits in turn, the
//  lava bubbling first
if !variable_local_exists("evgOn")
{
  evgOn=1
  eName="Evil Cackletta"
  maxLife=6
  life=maxLife
  evgMove=0
  evgT=0
  evgStage=0
  evgDone=0
  evgPat[0]="12"
  evgPat[1]="21"
  evgPat[2]="121"
  evgPatPos=0
  evgRow=0
  evgRows=3
  evgCage=0
  evgNext=0
  evgWarn=40
  evgBats=0
  podT=0
  podDelay=75
  podSide=0
  jeremyText="Cackletta's back, and she's brought the whole storm. She'll fence the arena in with lightning, only ever leaving one gap: look for where the warnings aren't. When she flings her bats, keep moving. Her floor gives out sooner too, and the lava doesn't stay put."
}
if global.gamePaused=false and bActive=true and life>0
{
  //---------- her phases, sooner than the game's (its own checks then don't fire again) ----------
  if bossProgress=0 and life<=4
  {
    lightAmt+=1; lightWarn-=4; lightDecay+=4; fireAmt+=2
    bossProgress=1
  }
  if floorSeq=0 and life<=3
  {
    lightWarn-=1; lightDecay+=1; teleAmt+=2
    floorSeq=1
  }
  if life<=2 {podDelay=60}

  //---------- an evil move before each phone call ----------
  if evgMove=0 and evgDone=0 and atkSequence=100 and atkTime<1
  {
    var tPat;
    tPat=evgPat[min(bossProgress,2)]
    if evgPatPos>=string_length(tPat) {evgPatPos=0}
    evgMove=real(string_char_at(tPat,evgPatPos+1))
    evgPatPos+=1
    evgT=0
    evgStage=0
  }
  if atkSequence!=100 {evgDone=0}

  //---------- the lava bubbles, once the floor's gone ----------
  if floorSeq>=3
  {
    podT+=1*gDeltaTime
    if podT>=podDelay
    {
      podT=0
      var tPod;
      if podSide=0 {tPod=instance_create(384,304,oEvgPodoboo)}
      else {tPod=instance_create(544,304,oEvgPodoboo)}
      tPod.atkPower=atkPower
      podSide=1-podSide
    }
  }
}

if evgMove>0 and global.gamePaused=false and bActive=true and life>0
{
  event_user(3)
  enemyStepEvent()
}
else {event_inherited()}
