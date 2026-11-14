//Logic Test: one line of a run (argument0). Commands that take time set global.ltWaitF (frames) and global.ltWaitKind
//(ltStep counts them down); a time in ticks is 30ths of a second, in frames the game's own (2 a tick at 60fps, 4 at
//120). An unknown command or a wrong argument ends the run (ltErr). tools\modkit\logictest\README.txt lists them
var s,tL,n,c,a1,a2,a3,i,r,f,k,tRest,tStop;
s=string_replace_all(argument0,chr(9)," ")
s=string_replace_all(s,chr(13),"")
tL=scrModSplit(s," ")
for(i=ds_list_size(tL)-1;i>=0;i-=1) {if ds_list_find_value(tL,i)="" {ds_list_delete(tL,i)}}
n=ds_list_size(tL)
if n=0 {ds_list_destroy(tL); exit}
c=string_lower(ds_list_find_value(tL,0))
a1=""; a2=""; a3=""
if n>1 {a1=ds_list_find_value(tL,1)}
if n>2 {a2=ds_list_find_value(tL,2)}
if n>3 {a3=ds_list_find_value(tL,3)}
ds_list_destroy(tL)
if string_char_at(c,1)="#" {exit}
//the line after the command (for log, items, exec)
tRest=string_delete(s,1,string_pos(c,string_lower(s))+string_length(c)-1)
while string_char_at(tRest,1)=" " {tRest=string_delete(tRest,1,1)}

switch (c)
{
  case "hold": case "holdf": case "wait": case "waitf":
    //hold KEYS TIME [room], wait TIME [room]: the buttons for that long (wait: none), or till a room starts
    if c="wait" or c="waitf" {k="none"; f=a1; tStop=a2}
    else {k=a1; f=a2; tStop=a3}
    if string_digits(f)="" {ltErr(c+": no time"); exit}
    if ltKeys(k)=0 {ltErr(c+": a button that isn't known: "+k); exit}
    if c="hold" or c="wait" {f=round(real(f)/gDeltaTime)}
    else {f=round(real(f))}
    global.ltWaitF=f
    global.ltWaitKind=0
    if string_lower(tStop)="room" {global.ltWaitKind=3; global.ltArrived=0}
    break
  case "goto":
    //goto ROOM X Y: the player comes into the room there, as an exit leading there puts them (global.newMapX/Y). From a
    //game over (the player died between runs, say drowning where the last run left them) too: its screen is gone and
    //the new room's player has full life
    r=scrModFind(a1,"room")
    if r<0 {ltErr("goto: no room "+a1); exit}
    if string_digits(a2)="" or string_digits(a3)="" {ltErr("goto: no x y"); exit}
    with (oPlayer1) {if variable_local_exists("maxLife") {writeToPlayerGlobals()}}
    with (oGameOver) {instance_destroy()}
    if global.pLife<=0 {global.pLife=global.pMaxLife}
    global.newMapX=real(a2)
    global.newMapY=real(a3)
    global.gamePaused=false
    transition_kind=0
    global.ltArrived=0
    global.ltWaitKind=1
    global.ltWaitF=900
    room_goto(r)
    break
  case "newgame":
    //newgame [SEED]: from the title screen (gone to first if the game's elsewhere), a Randomizer game with the options as
    //they are (set rndOpt... before it) and the seed (or a random one): the game's first room, Central City - North
    if scrModFind("oRndOptions","obj")<0 {ltErr("newgame: the Randomizer mod isn't on"); exit}
    global.ltNGSeed=-1
    if string_digits(a1)!="" {global.ltNGSeed=real(a1)}
    global.ltNGStage=0
    global.ltNGT=0
    global.ltWaitKind=2
    global.ltWaitF=36000
    if !instance_exists(oInitializeGame)
    {
      global.gamePaused=false
      transition_kind=0
      room_goto(rTitle)
    }
    break
  case "items":
    //items NAME...: what the player has, in place of what they had (ltItems)
    ltItems(tRest)
    break
  case "fps":
    //fps 30|60|120: the frame rate, from the next frame (best followed by a goto: the room's objects start afresh)
    f=real(string_digits(a1))
    if f!=30 and f!=60 and f!=120 {ltErr("fps: 30, 60 or 120"); exit}
    scrSetFrameRate(f)
    ltOut("fps "+string(f)+" f"+string(global.ltFrame))
    break
  case "speed":
    //speed N: the game runs N times as fast (global.modSpeedMul: the same frames, quicker)
    if string_digits(a1)="" {ltErr("speed: no number"); exit}
    global.ltSpeed=max(1,real(a1))
    break
  case "trace":
    //trace TICKS: the player's place in the results every so often (0: not)
    if string_digits(a1)="" {ltErr("trace: no number"); exit}
    global.ltTrace=max(0,round(real(a1)/gDeltaTime))
    break
  case "tracef":
    if string_digits(a1)="" {ltErr("tracef: no number"); exit}
    global.ltTrace=max(0,round(real(a1)))
    break
  case "pos":
    ltOut("pos f"+string(global.ltFrame)+" "+ltPos())
    break
  case "log":
    ltOut("log "+tRest)
    break
  case "shot":
    //shot NAME: the screen as it was last drawn, to Mods\LogicTest\shots\NAME.png
    if a1="" {ltErr("shot: no name"); exit}
    if !directory_exists(global.ltDir+"shots") {directory_create(global.ltDir+"shots")}
    screen_save(global.ltDir+"shots\"+a1+".png")
    ltOut("shot "+a1+" f"+string(global.ltFrame))
    break
  case "dump":
    //dump NAME: every instance in the room now, to Mods\LogicTest\dumps\NAME.txt (ltDump)
    if a1="" {ltErr("dump: no name"); exit}
    ltDump(a1)
    ltOut("dump "+a1+" f"+string(global.ltFrame))
    break
  case "snap":
    //snap: the globals Mods\LogicTest\snap.txt names, as they are now (ltSnap); restore puts them back
    ltSnap()
    ltOut("snap "+string(global.ltSnapN)+" f"+string(global.ltFrame))
    break
  case "restore":
    ltRestore()
    break
  case "track":
    //track NAME FRAMES: for that many frames, where each instance of the objects Mods\LogicTest\track.txt names is, to
    //Mods\LogicTest\tracks\NAME.txt (ltTrack, from the next frame on)
    if a1="" or string_digits(a2)="" {ltErr("track: a name and frames"); exit}
    if !file_exists(global.ltDir+"track.txt") {ltErr("track: no track.txt"); exit}
    global.ltTrackN=0
    f=file_text_open_read(global.ltDir+"track.txt")
    while !file_text_eof(f)
    {
      k=string_replace_all(file_text_read_string(f),chr(13),"")
      file_text_readln(f)
      if k="" {continue}
      r=scrModFind(k,"obj")
      if r>=0 {global.ltTrackObj[global.ltTrackN]=r; global.ltTrackN+=1}
    }
    file_text_close(f)
    if !directory_exists(global.ltDir+"tracks") {directory_create(global.ltDir+"tracks")}
    global.ltTrackF=file_text_open_write(global.ltDir+"tracks\"+a1+".txt")
    file_text_write_string(global.ltTrackF,"R"+chr(9)+room_get_name(room)+chr(9)+string(global.ltFrame))
    file_text_writeln(global.ltTrackF)
    global.ltTrackLeft=round(real(a2))
    global.ltWaitF=global.ltTrackLeft+1
    global.ltWaitKind=0
    break
  case "god":
    global.ltGod=(string_lower(a1)!="off" and a1!="0")
    break
  case "nohit":
    //nohit [off]: nothing hurts the player (what hits them doesn't push them either) till "nohit off"
    global.ltNoHit=(string_lower(a1)!="off" and a1!="0")
    with (oPlayer1) {bCanTakeDamage=(global.ltNoHit=0)}
    break
  case "life":
    if string_digits(a1)="" {ltErr("life: no number"); exit}
    global.pLife=real(a1)
    with (oPlayer1) {if variable_local_exists("maxLife") {life=real(a1)}}
    break
  case "char":
    //char jerry|claire: who the player is from the next room on (goto). The Randomizer's roomStart has the player go on
    //as who they were the frame before (rndCharSeen), so that's set too
    if string_lower(a1)="jerry" {global.activeCharacter=0}
    else if string_lower(a1)="claire" {global.activeCharacter=1}
    else {ltErr("char: jerry or claire"); exit}
    if variable_global_exists("rndCharSeen") {global.rndCharSeen=global.activeCharacter; global.rndCharLast=global.activeCharacter}
    break
  case "set":
    //set NAME VALUE: a global variable (a number, or text in quotes)
    if a1="" {ltErr("set: no name"); exit}
    k=string_delete(tRest,1,string_length(a1))
    while string_char_at(k,1)=" " {k=string_delete(k,1,1)}
    if string_char_at(k,1)='"' {variable_global_set(a1,string_replace_all(k,'"',""))}
    else {variable_global_set(a1,real(k))}
    break
  case "get":
    if !variable_global_exists(a1) {ltOut("get "+a1+" (none)")}
    else {ltOut("get "+a1+" "+string(variable_global_get(a1)))}
    break
  case "exec":
    //exec CODE: GameMaker code, run as it is (the game's scripts, not a mod's)
    execute_string(tRest)
    break
  case "end":
    ltEnd()
    break
  case "quit":
    //quit: the run ends (its results written) and the game closes (game_end ends it straight away)
    ltEnd()
    game_end()
    break
  default:
    ltErr("a command that isn't known: "+c)
    break
}
