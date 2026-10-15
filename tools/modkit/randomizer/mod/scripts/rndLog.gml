//Randomizer: the spoiler log, in the Saves folder: the seed and options, where each ability and key is (by layer), every
//location's item, the equipment shops' stock, and with Entrance Rando where each shuffled door leads
var f,i,k,it,dir,tLay,tMax,tAny,tStr,d,p;
dir=working_directory+"\"
if variable_global_exists("saveDir") {dir=global.saveDir}
f=file_text_open_write(dir+"Randomizer spoiler log "+string(global.rndSeed)+".txt")
file_text_write_string(f,"DT3+ Randomizer, seed "+string(global.rndSeed)); file_text_writeln(f)
tStr="Options: Guarantee Early Weapons "
if global.rndOptWeapons=1 {tStr+="On"} else {tStr+="Off"}
tStr+=", Ability Spread "
if global.rndOptSpread=0 {tStr+="Near"} else if global.rndOptSpread=2 {tStr+="Far"} else {tStr+="Normal"}
tStr+=", Shop Equipment "
if global.rndOptShops=1 {tStr+="Shuffled"} else {tStr+="As Normal"}
tStr+=", Entrance Rando "
if global.rndERMode=1 {tStr+="Gate Swap"}
else if global.rndERMode=2 {tStr+="Overworld"}
else if global.rndERMode=3 {tStr+="Chaos"}
else {tStr+="Off"}
file_text_write_string(f,tStr); file_text_writeln(f)
file_text_write_string(f,"(this seed with these options places the items the same way again: type seed"+string(global.rndSeed)+" on the title screen, or choose it in the new game's options)"); file_text_writeln(f)
file_text_write_string(f,"Win: the 8 instruments (the Nightmare Gates' bosses, then the Sacred Temple), the Abomination, then the Warmaster (his door appears in Grand Rising)."); file_text_writeln(f)
file_text_writeln(f)
file_text_write_string(f,"Abilities and keys, by layer (layer 1: what jumping alone reaches from Central City; each layer after it: what the items in the layers before it open)"); file_text_writeln(f)
tMax=0
for(i=0;i<global.rndLocN;i+=1) {tMax=max(tMax,global.rndGLayer[i])}
for(tLay=0;tLay<=tMax;tLay+=1)
{
  tAny=0
  for(i=0;i<global.rndLocN;i+=1)
  {
    if global.rndGLayer[i]=tLay
    {
      it=rndPlaced(i)
      if global.rndItemProg[it]>0
      {
        if tAny=0 {file_text_write_string(f,"  Layer "+string(tLay+1)); file_text_writeln(f); tAny=1}
        file_text_write_string(f,"    "+rndItemName(it)+"  -  "+global.rndLocName[i]); file_text_writeln(f)
      }
    }
  }
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
if global.rndERMode>0
{
  //each shuffled door once: the exit (its room, where it's placed) and the one it's joined to (going through one comes
  //out by the other)
  file_text_writeln(f)
  file_text_write_string(f,"Entrances (each pair of exits now leads to each other: going through one comes out next to the other)"); file_text_writeln(f)
  for(d=0;d<global.rndEDN;d+=1)
  {
    p=global.rndERPart[d]
    if p>d
    {
      file_text_write_string(f,"  "+rndERExitName(d)+"  <->  "+rndERExitName(p)); file_text_writeln(f)
    }
  }
}
file_text_close(f)
