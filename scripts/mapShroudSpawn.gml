/*
This script is called when a map starts.
It checks if a Shroud is detected in the map.
argument0: How much to increase shroud warn
---------------------------------------------
Threat Level Warning
0:    None
15:   Minimal
30:   Low
45:   Moderate
60:   High
75:   Critical
90:   Imminent
1000: Followed
---------------------------------------------
*/
if global.gameProgress>=183 and global.gameProgress<=323
{
  var shroudSpawn;
  shroudSpawn=irandom(100)
  if global.shroudThreat<115
    global.shroudThreat+=argument0
  if shroudSpawn+global.shroudThreat>115
    instance_create(0,0,oShroudCheck)
}
