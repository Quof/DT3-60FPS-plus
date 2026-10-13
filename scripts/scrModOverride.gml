/*
mods change (added): runs a mod's own version of one of the game's scripts. The game's scripts a mod can replace start
with a line that, when a mod has its version of the script (scripts\<name>.gml in the mod: global.modOvr), copies its
arguments to global.modArg and returns what this returns, instead of running the rest of the game's script. The mod's
version runs as written, in the same instance (Mods\README.txt lists the scripts).
argument0: the game's script
argument1: how many arguments it was given
returns what the mod's version returns
*/
var tC,tN,k,a,i;
tC=global.modOvr[argument0]
tN=argument1
for(i=0;i<16;i+=1)
{
  if i<tN {a[i]=global.modArg[i]}
  else {a[i]=0}
}
k=global.modCodeArgc[tC]
if k<0 {k=tN} //takes any number (argument[n])
switch (k)
{
  case 0: return code_execute(tC)
  case 1: return code_execute(tC,a[0])
  case 2: return code_execute(tC,a[0],a[1])
  case 3: return code_execute(tC,a[0],a[1],a[2])
  case 4: return code_execute(tC,a[0],a[1],a[2],a[3])
  case 5: return code_execute(tC,a[0],a[1],a[2],a[3],a[4])
  case 6: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5])
  case 7: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6])
  case 8: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7])
  case 9: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8])
  case 10: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9])
  case 11: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10])
  case 12: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11])
  case 13: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12])
  case 14: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13])
  default: return code_execute(tC,a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14])
}
