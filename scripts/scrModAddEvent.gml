/*
mods change (added): adds code to an object's event. A 30fps mod's code is compiled on its own and run through scrModRun
(see scrModEvMode); its event_inherited() becomes the event of the object it inherits from (code run that way would
otherwise look for the inherited event in the wrong place). Other mods' code goes in as it is, but for an object that
inherits from another object than its parent (object.ini inherit), event_inherited() becomes that object's event too.
argument0: object
argument1: event type
argument2: event number
argument3: code
argument4: 1 for a 30fps mod
argument5: the object event_inherited() runs the event of (-1: none)
argument6: where it's from, for the log
A 30fps mod's draw event whose code starts with a //tickvars: line (a,b,c: the variables it changes) runs through
scrModDrawRun, so those only change on 30fps ticks.
The time spent compiling and adding goes in global.modTimeCompile and modTimeAdd (for mod_log.txt: scrModLoadAll).
*/
var tObj,tType,tNum,tCode,tIdx,tInh,tErr,tMode,tKeep,tEnd,tT,tOk;
tObj=argument0; tType=argument1; tNum=argument2; tCode=scrModFixCode(argument3); tInh=argument5
if argument4=1
{
  if tInh>=0 {tCode=string_replace_all(tCode,"event_inherited()","event_perform_object("+string(tInh)+","+string(tType)+","+string(tNum)+")")}
  else {tCode=string_replace_all(tCode,"event_inherited()","")}
  tMode=scrModEvMode(tType,tNum)
  tKeep=""
  if string_copy(tCode,1,11)="//tickvars:"
  {
    tEnd=string_pos(chr(13),tCode)
    if tEnd=0 {tEnd=string_length(tCode)+1}
    tKeep=string_replace_all(string_replace_all(string_copy(tCode,12,tEnd-12)," ",""),chr(34),"")
  }
  tT=current_time
  tIdx=scrModCompile(tCode,argument6)
  global.modTimeCompile+=current_time-tT
  if tIdx<0 {exit}
  tT=current_time
  if tMode=3 and tKeep!="" {object_event_add(tObj,tType,tNum,"scrModDrawRun("+string(tIdx)+","+chr(34)+tKeep+chr(34)+")")}
  else {object_event_add(tObj,tType,tNum,"scrModRun("+string(tIdx)+","+string(tMode)+",0,0)")}
  global.modTimeAdd+=current_time-tT
}
else
{
  //an object whose event_inherited() runs another object's events than its parent's (object.ini inherit: a mod's copy
  //of one of the game's objects is that object's child, so the game's code finds it, but its event_inherited() is the
  //event of the parent the mod's version had)
  if tInh!=object_get_parent(tObj)
  {
    if tInh>=0 {tCode=string_replace_all(tCode,"event_inherited()","event_perform_object("+string(tInh)+","+string(tType)+","+string(tNum)+")")}
    else {tCode=string_replace_all(tCode,"event_inherited()","")}
  }
  //(code that doesn't compile would end the game in object_event_add: scrModCanCompile)
  tT=current_time
  tOk=scrModCanCompile(tCode)
  global.modTimeCompile+=current_time-tT
  if !tOk {scrModLog("  ERROR compiling "+argument6+": "+error_last); exit}
  tErr=error_is_enabled()
  if tErr {error_set_enabled(false)}
  error_occurred=false
  error_last=""
  tT=current_time
  object_event_add(tObj,tType,tNum,tCode)
  global.modTimeAdd+=current_time-tT
  if error_occurred {scrModLog("  ERROR compiling "+argument6+": "+error_last)}
  error_occurred=false
  if tErr {error_set_enabled(true)}
}
