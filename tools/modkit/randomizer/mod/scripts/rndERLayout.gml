//Randomizer: the doors the game's shuffle is made with (argument0: -1 this build's, or an earlier build's, rndELeg*,
//for a save or an Archipelago world made with it: rndERAccept): their hash and how many ends they have (what the save
//keeps: the save hook), and what the world had then (rndERFeat, bits: 1 the exits that follow an end lead where it
//now does, 2 the Discombobulated's way in leads straight to its boss's room, 4 the Distortion is played as Jeremy's
//mech: the roomStart hook), so a shuffle made before one of them has the world it was made with. The exits that follow
//an end (rndEXFollow: a map's room's other ways back to the map that come out where the end's exit does, a town's far
//side or a palace's way out after its boss) are in rndEXEnd as their end's while rndERFollow is on
var k,i;
k=argument0
if k<0
{
  global.rndERGameHash=global.rndEHash
  global.rndERGameEnds=global.rndEDN
  global.rndERFeat=global.rndEFeat
}
else
{
  global.rndERGameHash=global.rndELegHash[k]
  global.rndERGameEnds=global.rndELegEnds[k]
  global.rndERFeat=global.rndELegFeat[k]
}
global.rndERFollow=(global.rndERFeat & 1)>0
for(i=0;i<global.rndEFoN;i+=1)
{
  if global.rndERFollow=1 {global.rndEXEnd[global.rndEFoX[i]]=global.rndEFoD[i]}
  else {global.rndEXEnd[global.rndEFoX[i]]=-1}
}
