//Randomizer: the mod's version of the game's menuSpendAP (the pause menu's skill tree: its skills drawn, and the one
//the cursor's on, which oPauseMenu buys), which runs in its place (one of the scripts a mod can replace: Mods\README.txt).
//The tree's red nodes are gate locks: in the game, section N opens with Access Gate N's ability set (hasAbilToken: 1 the
//Mario Ability Set, 2 Link, 3 Belmont, 4 Mega Man, 5 Samus, 6 either Gate 6 set), and every section's first skills come
//after section 1's. A Randomizer game finds the sets in any order, the Mario Ability Set among the items, so the whole
//tree could stay locked till the end. In a Randomizer game section N opens with Program Chip N (rndChipHas): without
//Chip Randomizer the player has all six from the start, so the whole tree is open; with it, each section opens with its
//chip. A section's skills still come after the skills before them. The game's own script does the rest, with the sets
//counted that way for the call and put back after: this version stands aside for it (global.modOvr; "menuSpendAP ("
//with the space is the game's script, scrModFixCode)
var tOvr,i,tTok;
if global.rndActive=1
{
  for(i=0;i<7;i+=1) {tTok[i]=global.hasAbilToken[i]}
  for(i=0;i<5;i+=1) {global.hasAbilToken[i]=rndChipHas(i+1)}
  global.hasAbilToken[5]=rndChipHas(6)
  global.hasAbilToken[6]=rndChipHas(6)
}
tOvr=global.modOvr[menuSpendAP]
global.modOvr[menuSpendAP]=-1
menuSpendAP ()
global.modOvr[menuSpendAP]=tOvr
if global.rndActive=1
{
  for(i=0;i<7;i+=1) {global.hasAbilToken[i]=tTok[i]}
}
