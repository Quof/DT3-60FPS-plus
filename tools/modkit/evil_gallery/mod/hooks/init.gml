//Evil Boss Gallery: its variables (the init hook: the title screen, a new game, a loaded save, and once as the mods
//load). The evil fights' records, a place for each of the boss gallery's types (1-65, place type-1): the best time
//and the fewest hits taken in a win (99999: none yet) and how many wins (the load hook reads them back). global.evgFight:
//the gallery type of the evil fight going on (0: none), which takes the player back to the evil gallery when they give
//it up (the roomStart hook)
var i;
for(i=0;i<70;i+=1)
{
  global.evgTime[i]=99999
  global.evgHits[i]=99999
  global.evgWins[i]=0
}
global.evgFight=0
