/*
mods change (added): for one of the game's events in global.modEvList (scrModEvInit), makes a mod's version the one that
runs, without clearing the game's event (scrModLoadObjects): the game's event starts with a line that performs the same
event of global.modEvOvr[its place in the list] and ends, when that's an object. That object is made here for it, with
the mod's code as its event: it has no other events, no instances and no children, so adding to it (and clearing it, for
a later mod's version) is quick. The code goes in as scrModAddEvent adds code to the game's object (30fps code for a
30fps mod), and its event_inherited() runs the event of the object the game's object inherits from.
argument0: the game's object's name
argument1: the event (Create_0, Collision_oAttackBase...; scrModEvent has read it into global.modEvType and modEvNum)
argument2: the mod's code
argument3: 1 for a 30fps mod
argument4: the object event_inherited() runs the event of (-1: none)
returns 1 if the event is one of those (the mod's version is set up), 0 if not (clear the game's event and add it)
*/
var tL,tP,k,tC;
if !variable_global_exists("modEvList") {return 0}
tL=","+global.modEvList+","
tP=string_pos(","+argument0+" "+argument1+",",tL)
if tP=0 {return 0}
k=string_count(",",string_copy(tL,1,tP))-1
//(a mod's version made from the game's event with its first line in it would perform itself again and again: that one
//goes in the old way, replacing the game's event, where the line does nothing)
if string_pos("global.modEvOvr[",argument2)>0
{
  scrModLog("  WARNING: "+argument0+" "+argument1+": the mod's version has the game's line that runs a mod's version in it; it replaces the game's event instead")
  return 0
}
tC=global.modEvOvr[k]
//a later mod's version replaces an earlier one's
if tC>=0 {object_event_clear(tC,global.modEvType,global.modEvNum)}
else {tC=object_add()}
scrModAddEvent(tC,global.modEvType,global.modEvNum,argument2,argument3,argument4,argument0+" "+argument1)
global.modEvOvr[k]=tC
scrModLog("  "+argument0+" "+argument1+": the mod's version runs in place of the game's (scrModEvRegister, not cleared)")
return 1
