/*
mods change (added): runs a piece of compiled mod code in the current instance, the way its mod needs it:
  mode 0: as is (code written for DT3+, which scales by gDeltaTime itself)
  mode 1: 30fps code ("legacy" mods): gDeltaTime is 1 while it runs, so it and the game's scripts it calls work in
          30fps steps the way they did at 30fps
  mode 2: as 1, but only on 30fps ticks (gDeltaDoTicks); used for step, collision and other every-frame events, so the
          code runs 30 times a second whatever the frame rate
  mode 3: 30fps code that runs every frame at the real gDeltaTime (draw events)
code_execute needs exactly as many arguments as the code uses (it counts argument0, argument1... in order), so the two
given are passed as needed and any more it uses get 0.
argument0: code index (scrModCompile), -1 does nothing
argument1: mode
argument2, argument3: arguments for the code, if it takes them
returns what the code returns
*/
var tC,tM,tR,tDt,a,b;
tC=argument0
tM=argument1
if tC<0 {return 0}
if tM=2 and gDeltaDoTicks=0 {return 0}
a=argument2; b=argument3
tDt=gDeltaTime
if tM=1 or tM=2 {gDeltaTime=1}
switch (global.modCodeArgc[tC])
{
  case 0: tR=code_execute(tC); break
  case 1: tR=code_execute(tC,a); break
  case 3: tR=code_execute(tC,a,b,0); break
  case 4: tR=code_execute(tC,a,b,0,0); break
  case 5: tR=code_execute(tC,a,b,0,0,0); break
  case 6: tR=code_execute(tC,a,b,0,0,0,0); break
  case 7: tR=code_execute(tC,a,b,0,0,0,0,0); break
  case 8: tR=code_execute(tC,a,b,0,0,0,0,0,0); break
  case 9: tR=code_execute(tC,a,b,0,0,0,0,0,0,0); break
  case 10: tR=code_execute(tC,a,b,0,0,0,0,0,0,0,0); break
  case 11: tR=code_execute(tC,a,b,0,0,0,0,0,0,0,0,0); break
  case 12: tR=code_execute(tC,a,b,0,0,0,0,0,0,0,0,0,0); break
  case 13: tR=code_execute(tC,a,b,0,0,0,0,0,0,0,0,0,0,0); break
  case 14: tR=code_execute(tC,a,b,0,0,0,0,0,0,0,0,0,0,0,0); break
  case 15: tR=code_execute(tC,a,b,0,0,0,0,0,0,0,0,0,0,0,0,0); break
  default: tR=code_execute(tC,a,b); break //2, or any number (argument[n])
}
gDeltaTime=tDt
return tR
