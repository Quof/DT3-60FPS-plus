//Randomizer: the new game's option Traps put in the items (argument0: 1 on, 0 off; argument1: which trap items, 2 this
//build's, 1 a save's from before the Wind Orb; a new game, or a save loaded): on, the items rndData lists as the trap
//items' (rndSnareItem, or rndSnareOldItem: Internetz chests, not the six the Program Chips take) are traps (kind 29, the
//trap's number: rndSnareType), which look like Weapon Upgrades and spring a trap on the player (rndSnareSpring); off,
//they're their Internetz. global.rndSnareMode and rndSnareSet keep them (not progression items either way)
var k,i;
global.rndSnareMode=argument0
global.rndSnareSet=argument1
//(both lists' items their Internetz first: the old list's are among this build's)
for(k=0;k<global.rndSnareN;k+=1)
{
  i=global.rndSnareItem[k]
  global.rndItemKind[i]=2; global.rndItemParam[i]=global.rndSnareMoney[k]
}
for(k=0;k<global.rndSnareOldN;k+=1)
{
  i=global.rndSnareOldItem[k]
  global.rndItemKind[i]=2; global.rndItemParam[i]=global.rndSnareOldMoney[k]
}
if argument0=1
{
  if argument1=1
  {
    for(k=0;k<global.rndSnareOldN;k+=1) {i=global.rndSnareOldItem[k]; global.rndItemKind[i]=29; global.rndItemParam[i]=global.rndSnareOldType[k]}
  }
  else
  {
    for(k=0;k<global.rndSnareN;k+=1) {i=global.rndSnareItem[k]; global.rndItemKind[i]=29; global.rndItemParam[i]=global.rndSnareType[k]}
  }
}
for(k=0;k<global.rndSnareN;k+=1) {i=global.rndSnareItem[k]; global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])}
for(k=0;k<global.rndSnareOldN;k+=1) {i=global.rndSnareOldItem[k]; global.rndItemProg[i]=rndProgOf(global.rndItemKind[i],global.rndItemParam[i])}
