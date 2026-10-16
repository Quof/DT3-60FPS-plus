//Randomizer: the doors the game's shuffle is made with (argument0: -1 this build's, or an earlier build's, rndELeg*,
//for a save or an Archipelago world made with it: rndERAccept): their hash and how many ends they have (what the save
//keeps: the save hook), and whether the exits that follow an end (rndEXFollow: a map's room's other ways back to the
//map that come out where the end's exit does, a town's far side or a palace's way out after its boss) lead where the
//end now does. With this build's doors they do (rndEXEnd has them as their end's); with an earlier build's they lead
//where the game has them, as that shuffle was made
var k,i;
k=argument0
if k<0
{
  global.rndERGameHash=global.rndEHash
  global.rndERGameEnds=global.rndEDN
  global.rndERFollow=1
}
else
{
  global.rndERGameHash=global.rndELegHash[k]
  global.rndERGameEnds=global.rndELegEnds[k]
  global.rndERFollow=0
}
for(i=0;i<global.rndEFoN;i+=1)
{
  if global.rndERFollow=1 {global.rndEXEnd[global.rndEFoX[i]]=global.rndEFoD[i]}
  else {global.rndEXEnd[global.rndEFoX[i]]=-1}
}
