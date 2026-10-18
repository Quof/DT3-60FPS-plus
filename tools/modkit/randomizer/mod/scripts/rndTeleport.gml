//Randomizer: the pause menu's Teleport in a randomizer game (the mod's oPauseMenu: rndgen.py's GAME_PATCHES). In a gate
//(rndTeleportGate), out of it: where its way out leads, as walking out of it would (Entrance Rando's shuffle has it lead
//to its partner's way back in, rndERMapBuild's: with Gate Swap, by the portal the gate is come into by; else where the
//game has it). Outside the gates, where the game started (Central City - North, at the door from the Greatest Stretch)
var g,k;
g=rndTeleportGate()
if g>=0
{
  if global.rndERMode>0 and variable_global_exists("rndERMapR")
  {
    k=string(global.rndTpExRoom[g])+":"+string(global.rndTpExX[g])+","+string(global.rndTpExY[g])
    if ds_map_exists(global.rndERMapR,k)
    {
      global.newMapX=ds_map_find_value(global.rndERMapX,k)
      global.newMapY=ds_map_find_value(global.rndERMapY,k)
      room_goto(ds_map_find_value(global.rndERMapR,k))
      exit
    }
  }
  global.newMapX=global.rndTpX[g]
  global.newMapY=global.rndTpY[g]
  room_goto(global.rndTpRoom[g])
  exit
}
global.newMapX=608
global.newMapY=320
room_goto(rCCity_NorthA)
