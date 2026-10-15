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
  ini_write_string(s,"own",rndOwnString())
  ini_write_string(s,"keys",global.rndKeyOwn)
  ini_write_string(s,"eshop",global.rndEShopStr)
  ini_write_real(s,"won",global.rndWon)
  //Entrance Rando: the mode, the door data's hash (a build with other doors can tell) and the shuffle (in pieces of
  //1000 characters)
  ini_write_real(s,"er",global.rndERMode)
  if global.rndERMode>0
  {
    var t,n,i;
    ini_write_string(s,"erhash",global.rndEHash)
    t=rndERString()
    n=ceil(string_length(t)/1000)
    ini_write_real(s,"erparts",n)
    for(i=0;i<n;i+=1) {ini_write_string(s,"erpart"+string(i),string_copy(t,i*1000+1,1000))}
  }
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
