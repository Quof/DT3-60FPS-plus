/*
mods change (added): calls a mod's script (a mod's code calls them by name; scrModFixCode turns those calls into this).
Missing arguments are 0; extra ones are dropped.
argument0: the script's slot
argument1...: its arguments
returns what the script returns
*/
var tC,tN,tA,i,tArg;
tC=global.modScrCode[argument0]
if tC<0 {return 0}
tN=global.modCodeArgc[tC]
tA=argument_count-1
if tN<0 {tN=tA} //takes any number (argument[n])
for(i=0;i<16;i+=1)
{
  if i<tA {tArg[i]=argument[i+1]}
  else {tArg[i]=0}
}
switch (tN)
{
  case 0: return code_execute(tC)
  case 1: return code_execute(tC,tArg[0])
  case 2: return code_execute(tC,tArg[0],tArg[1])
  case 3: return code_execute(tC,tArg[0],tArg[1],tArg[2])
  case 4: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3])
  case 5: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4])
  case 6: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5])
  case 7: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6])
  case 8: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7])
  case 9: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7],tArg[8])
  case 10: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7],tArg[8],tArg[9])
  case 11: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7],tArg[8],tArg[9],tArg[10])
  case 12: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7],tArg[8],tArg[9],tArg[10],tArg[11])
  case 13: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7],tArg[8],tArg[9],tArg[10],tArg[11],tArg[12])
  case 14: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7],tArg[8],tArg[9],tArg[10],tArg[11],tArg[12],tArg[13])
  default: return code_execute(tC,tArg[0],tArg[1],tArg[2],tArg[3],tArg[4],tArg[5],tArg[6],tArg[7],tArg[8],tArg[9],tArg[10],tArg[11],tArg[12],tArg[13],tArg[14])
}
