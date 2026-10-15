//Randomizer: the new game's option Chip Randomizer put in the items (argument0: 1 on, 0 off; a new game, or a save
//loaded): on, the items rndData lists as the Program Chips' (rndChipItem: six of the smallest Internetz chests) are the
//chips (kind 27, the gate's number), progression items; off, they're their Internetz, and the player has every chip
//(rndNewGame). global.rndChipMode keeps it
var g,i;
global.rndChipMode=argument0
for(g=1;g<=global.rndChipN;g+=1)
{
  i=global.rndChipItem[g]
  if argument0=1 {global.rndItemKind[i]=27; global.rndItemParam[i]=g}
  else {global.rndItemKind[i]=2; global.rndItemParam[i]=global.rndChipMoney[g]}
  global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])
}
