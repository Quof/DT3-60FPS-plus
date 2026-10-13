/*
mods change (added): while the mods load (scrModLoadAll), shows how far along it is on the loading screen (oInitializeGame's
Draw: its bar, and the "Loading: ..." line under it), at most ten times a second, and keeps the game's window answering
meanwhile.
argument0: what's loading ("": the same as before)
argument1: how far along that is (0 to 1), in the part of the bar scrModLoadAll gives it (global.modProgFrom to modProgTo)
*/
if argument0!="" {global.modProgText=argument0}
if current_time-global.modProgTime<100 {exit}
global.modProgTime=current_time
if variable_local_exists("loadingBar")
{
  loadingType=global.modProgText
  loadingBar=round(201*(global.modProgFrom+(global.modProgTo-global.modProgFrom)*min(1,max(0,argument1))))
}
io_handle()
screen_redraw()
