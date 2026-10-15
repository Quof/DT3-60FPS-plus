//Randomizer: the entrance randomizer's reach grids freed (they're big: made again when a reach starts), once a new game's
//seed is made
if global.rndRGQ>=0
{
  ds_grid_destroy(global.rndRGSeen)
  ds_grid_destroy(global.rndRGQ)
  global.rndRGSeen=-1
  global.rndRGQ=-1
}
ds_map_clear(global.rndRSing)
