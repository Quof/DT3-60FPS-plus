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
}
