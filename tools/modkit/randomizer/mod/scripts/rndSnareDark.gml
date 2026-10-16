//Randomizer: a Darkness Trap's darkness in the room (argument0: 1 on, 0 off): Dark Mode's (oSurfLightAll, which the
//game's oPlayer1 makes in every room in Dark Mode: the room black but for the light round the player, Chao, the enemies
//and the room's own lights). Off: taken away, its surface freed first (its room end would free it), but not in Dark
//Mode itself
if argument0=1
{
  if instance_exists(oPlayer1) and instance_exists(oIdentifier) and !instance_exists(oSurfLightAll) {instance_create(0,0,oSurfLightAll)}
  exit
}
if global.modeDark=1 {exit}
with (oSurfLightAll)
{
  if surface_exists(surf) {surface_free(surf)}
  instance_destroy()
}
