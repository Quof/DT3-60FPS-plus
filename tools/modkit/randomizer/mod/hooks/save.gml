//Randomizer: its part of the save file (the save file is open)
var s;
s="Randomizer"
ini_write_real(s,"active",global.rndActive)
if global.rndActive=1
{
  ini_write_real(s,"version",global.rndVersion)
  ini_write_real(s,"seed",global.rndSeed)
  ini_write_string(s,"place",global.rndPlace)
  ini_write_string(s,"got",global.rndGot)
  ini_write_string(s,"boss",global.rndBossDone)
  ini_write_string(s,"bossseen",global.rndBossSeen) //(the places whose fight has been seen: their previews show it)
  ini_write_string(s,"gatereach",global.rndGateReach) //(the Nightmare Gates whose boss's room the player has been in)
  //(the boss list's types, in its order: a build with another boss list reads the beaten bosses by type)
  ini_write_string(s,"bosstypes",global.rndBossTypes)
  ini_write_string(s,"own",rndOwnString())
  ini_write_string(s,"keys",global.rndKeyOwn)
  ini_write_string(s,"eshop",global.rndEShopStr)
  ini_write_real(s,"won",global.rndWon)
  //the enemy traps beaten, by name (a build with other traps keeps the ones it has)
  var tTraps,k;
  tTraps=""
  for(k=0;k<global.rndTrapN;k+=1) {if string_char_at(global.rndTrapDone,k+1)="1" {tTraps+=global.rndTrapName[k]+","}}
  ini_write_string(s,"traps",tTraps)
  //Entrance Rando: the mode, the hash of the doors the shuffle was made with (a build with other doors can tell; an
  //earlier build's that this one still has: rndERLayout) and the shuffle (in pieces of 1000 characters)
  ini_write_real(s,"er",global.rndERMode)
  if global.rndERMode>0
  {
    var t,n,i;
    ini_write_string(s,"erhash",global.rndERGameHash)
    t=rndERString(global.rndERGameEnds)
    n=ceil(string_length(t)/1000)
    ini_write_real(s,"erparts",n)
    for(i=0;i<n;i+=1) {ini_write_string(s,"erpart"+string(i),string_copy(t,i*1000+1,1000))}
  }
  //Instrument Randomization: on or off (where the instruments are is in place, as for every item)
  ini_write_real(s,"ir",global.rndIRMode)
  //Chip Randomizer: on or off, and the Program Chips found (a character a gate)
  ini_write_real(s,"chips",global.rndChipMode)
  ini_write_string(s,"chipown",global.rndChipOwn)
  //Traps: on or off, each trap's time left, a Teleport Trap waiting, and the ways into rooms kept for one (in pieces
  //of 1000 characters)
  var tk,tH,tN;
  ini_write_real(s,"traps",global.rndSnareMode)
  for(tk=1;tk<=4;tk+=1) {ini_write_real(s,"trapt"+string(tk),global.rndSnareT[tk])}
  ini_write_real(s,"trappend",global.rndSnarePend)
  tH=rndSnareHistString()
  tN=ceil(string_length(tH)/1000)
  ini_write_real(s,"traphparts",tN)
  for(tk=0;tk<tN;tk+=1) {ini_write_string(s,"traph"+string(tk),string_copy(tH,tk*1000+1,1000))}
  //Boss Rando: on or off, the boss fought at each boss's place, and the bosses' types (a build with other bosses can
  //tell)
  ini_write_real(s,"br",global.rndBRMode)
  if global.rndBRMode=1
  {
    ini_write_string(s,"brfight",rndBRString(0))
    ini_write_string(s,"brtypes",rndBRString(1))
  }
  //Archipelago
  ini_write_real(s,"ap",global.rndAP)
  if global.rndAP=1
  {
    ini_write_string(s,"apseed",global.rndApSeedLine)
    ini_write_real(s,"aprecv",global.rndApRecv)
    ini_write_real(s,"apdeaths",global.rndApDeaths)
  }
}
