/*
mods change (added): on frames between 30fps ticks, holds still what GameMaker itself would move every frame for a 30fps
mod's objects: their alarms (one more step each, so they count 30fps steps) and their built-in motion (speed, gravity,
path speed; not for the effect objects oGame scales itself: scrModLegacySetup). scrModLegacyThaw puts the motion back
in the end step. Their step events only run on ticks (scrModRun), so with this they move in 30fps steps at the speeds
their code gives. oGame's begin step, after the tick is worked out.
*/
var i,a,tObj,tMot;
if global.modLegacyCount=0 or gDeltaDoTicks!=0 {exit}
for(i=0;i<global.modLegacyCount;i+=1)
{
  tObj=global.modLegacyObj[i]
  tMot=global.modLegacyMotion[i]
  with (tObj)
  {
    if object_index=tObj
    {
      for(a=0;a<12;a+=1) {if alarm[a]>0 {alarm[a]+=1}}
      __mlZ=0
      if tMot=1 and (speed!=0 or gravity!=0 or path_speed!=0)
      {
        __mlZ=1; __mlH=hspeed; __mlV=vspeed; __mlG=gravity; __mlP=path_speed
        speed=0; gravity=0; path_speed=0
      }
    }
  }
}
