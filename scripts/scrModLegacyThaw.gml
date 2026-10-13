/*
mods change (added): puts back the built-in motion scrModLegacyFreeze held still this frame (oGame's end step).
*/
var i,tObj;
if global.modLegacyCount=0 or gDeltaDoTicks!=0 {exit}
for(i=0;i<global.modLegacyCount;i+=1)
{
  tObj=global.modLegacyObj[i]
  with (tObj)
  {
    if object_index=tObj
    {
      if variable_local_exists("__mlZ")
      {
        if __mlZ=1 {hspeed=__mlH; vspeed=__mlV; gravity=__mlG; path_speed=__mlP; __mlZ=0}
      }
    }
  }
}
