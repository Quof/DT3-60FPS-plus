//Randomizer: the new game's option Traps put in the items (argument0: 1 on, 0 off; a new game, or a save loaded): on,
//the items rndData lists as the trap items' (rndSnareItem: Internetz chests, not the six the Program Chips take) are
//traps (kind 29, the trap's number: rndSnareType), which look like Weapon Upgrades and spring a trap on the player
//(rndSnareSpring); off, they're their Internetz. global.rndSnareMode keeps it (not progression items either way)
var k,i;
global.rndSnareMode=argument0
for(k=0;k<global.rndSnareN;k+=1)
{
  i=global.rndSnareItem[k]
  if argument0=1 {global.rndItemKind[i]=29; global.rndItemParam[i]=global.rndSnareType[k]}
  else {global.rndItemKind[i]=2; global.rndItemParam[i]=global.rndSnareMoney[k]}
  global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])
}
