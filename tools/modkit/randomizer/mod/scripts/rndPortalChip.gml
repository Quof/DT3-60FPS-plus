//Randomizer (Chip Randomizer): the Program Chip the Access Gate portal running this (an oAccessGate) takes, 0 none. A
//game whose portals take the chips (global.rndChipPortals 1): the portal's own, wherever Entrance Rando has it lead (each
//Access Gate's portal its gate's chip, the Nightmare Gate portal beside it the same: rndPortal*, the room logic's need
//lines for the portals, by the portal's room and where it's placed). A game made before that (0): as it was made, the
//chip of the Access Gate whose rooms the portal leads into (toRoom) from outside that gate
var i,g;
if global.rndChipPortals=1
{
  for(i=0;i<global.rndPortalN;i+=1)
  {
    if global.rndPortalRoom[i]=room and global.rndPortalX[i]=xstart and global.rndPortalY[i]=ystart {return global.rndPortalChip[i]}
  }
  return 0
}
g=rndGateOf(toRoom)
if g>0 and g!=rndGateOf(room) {return g}
return 0
