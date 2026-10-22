//Randomizer: the spoiler log, in the Saves folder's Seeds folder (made if it isn't there): the seed and options, where
//each ability and key is (by layer; the instruments too with Instrument Randomization), every location's item, the
//equipment shops' stock, with Boss Rando the boss fought at each boss's place, and with Entrance Rando where each
//shuffled door leads
var f,i,k,it,dir,tLay,tMax,tAny,tStr,d,p;
dir=working_directory+"\"
if variable_global_exists("saveDir") {dir=global.saveDir}
dir+="Seeds\"
if !directory_exists(dir) {directory_create(dir)}
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
else if global.rndERMode=2 {tStr+="Area"}
else if global.rndERMode=3 {tStr+="Chaos"}
else {tStr+="Off"}
tStr+=", Boss Rando "
if global.rndBRMode=1 {tStr+="On"} else {tStr+="Off"}
tStr+=", Instrument Randomization "
if global.rndIRMode=1 {tStr+="On"} else {tStr+="Off"}
tStr+=", Chip Randomizer "
if global.rndChipMode=1 {tStr+="On"} else {tStr+="Off"}
tStr+=", Traps "
if global.rndSnareMode=1 {tStr+=string(round(global.rndSnareTime/1800))+" Minutes"} else {tStr+="Off"}
tStr+=", Skip Tower Defense "
if global.rndSkipTD=1 {tStr+="On"} else {tStr+="Off"}
file_text_write_string(f,tStr); file_text_writeln(f)
file_text_write_string(f,"(this seed with these options places the items the same way again: type seed"+string(global.rndSeed)+" on the title screen, or choose it in the new game's options)"); file_text_writeln(f)
if global.rndIRMode=1 {file_text_write_string(f,"Win: the 8 instruments (anywhere: they're with the abilities below), the Abomination, then the CHAOS Warmaster at the end of the CHAOS Warship.")}
else {file_text_write_string(f,"Win: the 8 instruments (each Nightmare Gate's boss, beaten, leaves its instrument), the Abomination, then the CHAOS Warmaster at the end of the CHAOS Warship.")}
file_text_writeln(f)
if global.rndChipMode=1 {file_text_write_string(f,"Access Gates: each one's portal, and the Nightmare Gate portal beside it, opens with its Program Chip (anywhere: they're with the abilities below)"); file_text_writeln(f)}
file_text_writeln(f)
file_text_write_string(f,"Abilities, keys and Air Upgrades, by layer (layer 1: what jumping alone reaches from Central City; each layer after it: what the items in the layers before it open; the underwater rooms wait for 3 Air Upgrades at places in logic)"); file_text_writeln(f)
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
      //(an instrument is one of these only with Instrument Randomization: else it's at its gate's reward)
      if global.rndItemProg[it]>0 and !(global.rndItemKind[it]=26 and global.rndIRMode=0)
      {
        if tAny=0 {file_text_write_string(f,"  Layer "+string(tLay+1)); file_text_writeln(f); tAny=1}
        file_text_write_string(f,"    "+rndItemName(it)+"  -  "+global.rndLocName[i]); file_text_writeln(f)
      }
    }
  }
}
file_text_writeln(f)
file_text_write_string(f,"Every location, with its layer (as above; one that needs everything: the last)"); file_text_writeln(f)
for(i=0;i<global.rndLocN;i+=1)
{
  if global.rndGLayer[i]>=0 {tStr="layer "+string(global.rndGLayer[i]+1)} else {tStr="not in logic"}
  file_text_write_string(f,"  "+global.rndLocName[i]+"  -  "+rndItemName(rndPlaced(i))+"  ("+tStr+")"); file_text_writeln(f)
}
file_text_writeln(f)
file_text_write_string(f,"Equipment shops"); file_text_writeln(f)
for(k=0;k<global.rndEShopN;k+=1)
{
  equipmentInit(2,global.rndEShopNew[k])
  file_text_write_string(f,"  "+global.rndEShopRoom[k]+" slot "+string(global.rndEShopSlot[k]+1)+"  -  "+equipCheck[1]); file_text_writeln(f)
}
if global.rndBRMode=1
{
  //each boss's place (its room) and the boss fought there
  file_text_writeln(f)
  file_text_write_string(f,"Bosses (walking up to a boss in its room starts the fight of the boss listed for it, in that boss's own room)"); file_text_writeln(f)
  for(d=0;d<global.rndBossN;d+=1)
  {
    if d!=global.rndBossFinal
    {
      //(Ridley's and the Parasitic Seed's: the exit the story went into their fights by; a fight of several in a row,
      //rndBossChainN: Ridley's, says so)
      if global.rndBossViaFrom[d]>=0 {tStr="the way from "+room_get_name(global.rndBossViaFrom[d])+" to "+room_get_name(global.rndBossViaTo[d])}
      else {tStr=room_get_name(global.rndBossRoom[d])}
      p=global.rndBRFight[d]
      if global.rndBossChainN[p]>0 {file_text_write_string(f,"  "+global.rndBossName[d]+"'s place ("+tStr+")  -  "+global.rndBossName[p]+" ("+string(global.rndBossChainN[p]+1)+" fights in a row)")}
      else {file_text_write_string(f,"  "+global.rndBossName[d]+"'s place ("+tStr+")  -  "+global.rndBossName[p])}
      file_text_writeln(f)
    }
  }
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
  //the exits that follow a shuffled end: they lead where it now does (rndERLayout)
  tAny=0
  for(k=0;k<global.rndEFoN;k+=1)
  {
    d=global.rndEFoD[k]
    if global.rndERFollow=1 and global.rndERPart[d]>=0
    {
      if tAny=0
      {
        file_text_writeln(f)
        file_text_write_string(f,"Exits that lead where a door's exit above does (a room's other ways back to the map that come out at the same place: the far side of a town, a palace's way out after its boss)"); file_text_writeln(f)
        tAny=1
      }
      file_text_write_string(f,"  "+rndERExitNameX(global.rndEFoX[k])+"  ->  as "+rndERExitName(d)); file_text_writeln(f)
    }
  }
  //the one way exits (not shuffled, as the game has them: rndOneWayData): where each leads (one that goes by a state
  //the player carries, each place it can lead)
  if variable_global_exists("rndOneWayN")
  {
    file_text_writeln(f)
    file_text_write_string(f,"One-way exits (not shuffled, as the game has them: going through one, no exit where it comes out leads back to it; ONE WAY signs mark the ones with an arrow or a pipe)"); file_text_writeln(f)
    for(k=0;k<global.rndOneWayN;k+=1)
    {
      i=global.rndOneWayX[k]
      if global.rndERFollow=1 and global.rndEXFollow[i]>=0 {continue}
      tStr=""
      if global.rndEXSg[i]>=0
      {
        for(p=0;p<global.rndEXSdN[i];p+=1)
        {
          d=global.rndEXSd[i,p]
          if d>=0 {if tStr!="" {tStr+=" or "}; tStr+=rndEREntryName(d)}
        }
      }
      else if global.rndEXDest[i]>=0 {tStr=rndEREntryName(global.rndEXDest[i])}
      if tStr!="" {file_text_write_string(f,"  "+rndERExitNameX(i)+"  ->  "+tStr); file_text_writeln(f)}
    }
  }
}
file_text_close(f)
