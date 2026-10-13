//Randomizer: the spoiler log, in the Saves folder: the seed, where each ability and key is, every location's item, and the
//equipment shops' stock
var f,i,k,it,dir;
dir=working_directory+"\"
if variable_global_exists("saveDir") {dir=global.saveDir}
f=file_text_open_write(dir+"Randomizer spoiler log "+string(global.rndSeed)+".txt")
file_text_write_string(f,"DT3+ Randomizer, seed "+string(global.rndSeed)); file_text_writeln(f)
file_text_write_string(f,"(type seed"+string(global.rndSeed)+" on the title screen to play this seed again)"); file_text_writeln(f)
file_text_write_string(f,"Win: the 8 instruments (the Nightmare Gates' bosses, then the Sacred Temple), the Abomination, then the Warmaster (his door appears in the first room)."); file_text_writeln(f)
file_text_writeln(f)
file_text_write_string(f,"Abilities and keys"); file_text_writeln(f)
for(i=0;i<global.rndLocN;i+=1)
{
  it=rndPlaced(i)
  if global.rndItemProg[it]>=0 {file_text_write_string(f,"  "+rndItemName(it)+"  -  "+global.rndLocName[i]); file_text_writeln(f)}
}
file_text_writeln(f)
file_text_write_string(f,"Every location"); file_text_writeln(f)
for(i=0;i<global.rndLocN;i+=1)
{
  file_text_write_string(f,"  "+global.rndLocName[i]+"  -  "+rndItemName(rndPlaced(i))); file_text_writeln(f)
}
file_text_writeln(f)
file_text_write_string(f,"Equipment shops"); file_text_writeln(f)
for(k=0;k<global.rndEShopN;k+=1)
{
  equipmentInit(2,global.rndEShopNew[k])
  file_text_write_string(f,"  "+global.rndEShopRoom[k]+" slot "+string(global.rndEShopSlot[k]+1)+"  -  "+equipCheck[1]); file_text_writeln(f)
}
file_text_close(f)
