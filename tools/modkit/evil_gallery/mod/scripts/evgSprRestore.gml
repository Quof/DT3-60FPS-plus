//Evil Boss Gallery: the game's sprites back as they were (evgSprOne kept them aside)
var i;
for(i=0;i<global.evgSprN;i+=1)
{
  sprite_assign(global.evgSprO[i],global.evgSprB[i])
  sprite_delete(global.evgSprB[i])
}
global.evgSprN=0
global.evgSprType=0
