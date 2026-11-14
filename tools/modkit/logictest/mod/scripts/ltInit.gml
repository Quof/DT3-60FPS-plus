//Logic Test: its variables, set once (the init hook). A run's commands come from Mods\LogicTest\cmd.txt, its results go
//to out.txt beside it, and done.txt is made when it's over (tools\modkit\logictest\lt.py writes the commands and waits
//for done.txt; its README lists the commands)
var i;
if variable_global_exists("ltRun") {exit}
global.ltDir=global.modDir+"LogicTest\"
global.ltRun=0 //1 while a run goes on
global.ltPollT=0 //frames till the runner looks for cmd.txt again
global.ltCmd=-1 //the run's command lines (a ds_list); global.ltPC: the next one
global.ltPC=0
global.ltOutBuf="" //results not written out yet (ltOut, ltFlush)
global.ltFrame=0 //frames since the run started
global.ltWaitF=0 //frames the command going on still has (0: the next command runs)
global.ltWaitKind=0 //what it waits for: 0 the frames, 1 the room it goes to (goto), 2 the new game (newgame), 3 the
                    //frames or a room change, whichever is first (hold ... room)
global.ltArrived=0 //a room has started since the command began (the roomStart hook)
global.ltNewGame=0 //1 the run's new game is on its way to the intro room, 2 the Randomizer's game has been started there
global.ltNGStage=0
global.ltNGT=0
global.ltNGSeed=-1
global.ltTrace=0 //the player's place goes in the results every this many frames (0: not)
global.ltSpeed=1 //the game speed (global.modSpeedMul) during the run
global.ltGod=0 //1: the player's life kept full
global.ltNoHit=0 //1: nothing hurts the player (bCanTakeDamage kept off), so a hit's push doesn't move them
global.ltTrackLeft=0 //frames a track (track NAME FRAMES) still writes: ltTrack
global.ltPadWas=0 //Gamepad Input before the run (the run turns it on: ltInput)
global.ltGotWas="" //the Randomizer's places taken, the last frame (ltGotDiff)
global.ltDeadWas=0
for(i=0;i<=16;i+=1) {global.ltHeld[i]=0} //the buttons held (scrController's 1-16: ltKeys)
