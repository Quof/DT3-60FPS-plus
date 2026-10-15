//Randomizer: the options window's controls (see Create)
var i,tDir,tStr;
if roGo>0
{
  //Start Game: the notice that the items are being placed is drawn first, then they are and the game starts. The options
  //are kept for the next new game (DT3Options.dts, section Randomizer: rndInit reads them)
  roGo+=1
  if roGo>=3
  {
    ini_open(global.saveDir+"DT3Options.dts")
    ini_write_real("Randomizer","weapons",global.rndOptWeapons)
    ini_write_real("Randomizer","spread",global.rndOptSpread)
    ini_write_real("Randomizer","shops",global.rndOptShops)
    ini_write_real("Randomizer","er",global.rndOptER)
    ini_write_real("Randomizer","br",global.rndOptBR)
    ini_write_real("Randomizer","log",global.rndOptLog)
    ini_close()
    rndNewGame()
    instance_destroy()
  }
  exit
}
if gDeltaDoTicks != 1 { exit; }
if oKeyCodes.kCodePressed[3]=1
{
  playSound(global.snd_MenuCursor,0,1,1)
  roCursor-=1
  if roCursor<0 {roCursor=roRows-1}
}
else if oKeyCodes.kCodePressed[4]=1
{
  playSound(global.snd_MenuCursor,0,1,1)
  roCursor+=1
  if roCursor>=roRows {roCursor=0}
}
//the option on the cursor: Left back, Right or Confirm on
tDir=0
if oKeyCodes.kCodePressed[1]=1 {tDir=-1}
else if oKeyCodes.kCodePressed[2]=1 or oKeyCodes.kCodePressed[15]=1 {tDir=1}
if tDir=0 {exit}
if roCursor=0
{
  //Seed: typed in (Confirm); empty for a random one
  if oKeyCodes.kCodePressed[15]=1
  {
    playSound(global.snd_MenuConfirm,0,0.95,1)
    tStr=""
    if global.rndNextSeed>=0 {tStr=string(global.rndNextSeed)}
    tStr=string_copy(string_digits(get_string("Seed: a number (leave it empty for a random one)",tStr)),1,9)
    if tStr="" {global.rndNextSeed=-1}
    else {global.rndNextSeed=real(tStr)}
    //the key that closed the window counts as already held
    io_clear()
    for(i=1;i<=18;i+=1)
    {
      oKeyCodes.kCode[i]=scrController(i)
      oKeyCodes.kCodePressed[i]=0
    }
  }
}
else if roCursor=1 {global.rndOptWeapons=1-global.rndOptWeapons; playSound(global.snd_MenuConfirm,0,0.95,1)}
else if roCursor=2 {global.rndOptSpread=(global.rndOptSpread+tDir+3) mod 3; playSound(global.snd_MenuConfirm,0,0.95,1)}
else if roCursor=3 {global.rndOptShops=1-global.rndOptShops; playSound(global.snd_MenuConfirm,0,0.95,1)}
else if roCursor=4 {global.rndOptER=(global.rndOptER+tDir+4) mod 4; playSound(global.snd_MenuConfirm,0,0.95,1)}
else if roCursor=5 {global.rndOptBR=1-global.rndOptBR; playSound(global.snd_MenuConfirm,0,0.95,1)}
else if roCursor=6 {global.rndOptLog=1-global.rndOptLog; playSound(global.snd_MenuConfirm,0,0.95,1)}
else if roCursor=7 and oKeyCodes.kCodePressed[15]=1 {roGo=1; playSound(global.snd_MenuConfirm,0,0.95,1)}
