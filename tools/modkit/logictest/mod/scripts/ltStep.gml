//Logic Test: a frame of a run (oLTRunner's End Step). What happened this frame goes in the results (rooms and exits:
//the hooks; places taken; the game over screen; the player's place every global.ltTrace frames). Then the command
//going on counts down its frames or sees whether what it waits for has happened, and when it's done the next ones run
global.ltFrame+=1
if global.ltTrackLeft>0 {ltTrack()}
if global.ltGod=1 {with (oPlayer1) {if variable_local_exists("maxLife") {life=maxLife}}}
if global.ltNoHit=1 {with (oPlayer1) {bCanTakeDamage=false}}
if global.ltTrace>0 {if global.ltFrame mod global.ltTrace=0 {ltOut("t f"+string(global.ltFrame)+" "+ltPos())}}
if variable_global_exists("rndGot")
{
  if global.rndGot!=global.ltGotWas
  {
    ltGotDiff()
    global.ltGotWas=global.rndGot
  }
}
if instance_exists(oGameOver)
{
  if global.ltDeadWas=0 {ltOut("dead f"+string(global.ltFrame)+" "+ltPos())}
  global.ltDeadWas=1
}
else {global.ltDeadWas=0}

if global.ltWaitF>0
{
  if global.ltWaitKind=1 //goto: the room, with the player in it
  {
    if global.ltArrived=1 and instance_exists(oPlayer1) {global.ltWaitF=0}
    else
    {
      global.ltWaitF-=1
      if global.ltWaitF<=0 {ltErr("goto: the room didn't start"); exit}
    }
  }
  else if global.ltWaitKind=2 //newgame
  {
    if global.ltNGStage=0
    {
      //the title screen (oInitializeGame) for half a second, then its New Game, to a save file of its own
      //(Saves\LogicTest.dts, never one of the slots), as 'save NAME' on the title screen does
      if instance_exists(oInitializeGame) {global.ltNGT+=1}
      else {global.ltNGT=0}
      if global.ltNGT>=30
      {
        if global.ltNGSeed>=0 {global.rndNextSeed=global.ltNGSeed}
        global.ltNewGame=1
        global.ltNGStage=1
        with (oInitializeGame)
        {
          global.paraString[0]=global.saveDir+"LogicTest.dts"
          global.saveSlot=0
          global.saveSlotNewGame=0
          global.gamePaused=0
          event_user(2)
        }
      }
    }
    //the game started in the intro room (the roomStart hook): its first room, with the player in it
    else if global.ltNewGame=2 and room!=rBeginning and instance_exists(oPlayer1)
    {
      global.ltNewGame=0
      global.ltWaitF=0
      ltOut("newgame seed "+string(global.rndSeed)+" f"+string(global.ltFrame))
    }
    if global.ltWaitF>0
    {
      global.ltWaitF-=1
      if global.ltWaitF<=0 {ltErr("newgame: the game didn't start"); exit}
    }
  }
  else if global.ltWaitKind=3 //hold/wait ... room: the frames, or till a room starts
  {
    if global.ltArrived=1 and instance_exists(oPlayer1) {global.ltWaitF=0}
    else
    {
      global.ltWaitF-=1
      if global.ltWaitF<=0 {ltOut("noroom f"+string(global.ltFrame))}
    }
  }
  else {global.ltWaitF-=1}
}
if global.ltWaitF<=0
{
  global.ltWaitKind=0
  ltRunCmds()
}
