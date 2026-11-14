//Logic Test: the run is over (its commands done, an end command, or an error: ltErr). The end state goes in the
//results, they're written out, and done.txt says the run is over. The buttons, Gamepad Input and the game speed go back
//to what they were
var tF,i;
ltOut("end f"+string(global.ltFrame)+" "+ltPos())
ltFlush()
tF=file_text_open_write(global.ltDir+"done.txt")
file_text_write_string(tF,"done")
file_text_close(tF)
global.ltRun=0
global.ltWaitF=0
global.ltWaitKind=0
global.ltNewGame=0
global.ltGod=0
if global.ltNoHit=1 {with (oPlayer1) {bCanTakeDamage=true}}
global.ltNoHit=0
global.ltTrace=0
for(i=0;i<=16;i+=1) {global.ltHeld[i]=0}
global.optGamePad=global.ltPadWas
global.ltSpeed=1
global.modSpeedMul=1
