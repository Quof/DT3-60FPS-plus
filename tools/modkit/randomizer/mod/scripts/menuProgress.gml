//Randomizer: the mod's version of the game's menuProgress (the pause menu's Progress page), which runs in its place (one
//of the scripts a mod can replace: Mods\README.txt). The game draws its Program Chips as the first programChips of the
//six slots, so with Chip Randomizer, where they're found in any order, the wrong ones showed. In a Randomizer game each
//chip the player has (rndChipHas) is drawn in its own slot instead, and the slots' spinner turns as fast as the game's
//turns it for that many. The game's own script does the rest, with no chips for the call and their count put back
//after: this version stands aside for it (global.modOvr; "menuProgress (" with the space is the game's script,
//scrModFixCode)
var tOvr,tN,i,n;
tN=global.programChips
if global.rndActive=1 {global.programChips=0}
tOvr=global.modOvr[menuProgress]
global.modOvr[menuProgress]=-1
menuProgress ()
global.modOvr[menuProgress]=tOvr
global.programChips=tN
if global.rndActive=1 and mP_Page=1
{
  n=0
  for(i=0;i<6;i+=1)
  {
    if rndChipHas(i+1)
    {
      draw_sprite(sPauseM_Chips,i,contentMenuX+15,contentMenuY+77+16*i)
      n+=1
    }
  }
  mP_Spinner+=n*gDeltaTime
}
