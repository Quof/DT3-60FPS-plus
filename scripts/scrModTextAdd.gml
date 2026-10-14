/*
mods change (added): keeps a piece of a mod's room, instance or patch code as text (it runs with scrModRunText) and
returns its number. That code runs once when a room starts, so it isn't compiled: gm82core's code_compile adds an
object event for every piece (object_event_add), which with the thousands of pieces a mod that changes many rooms has
would slow down loading or entering the rooms; execute_string compiles the text as it runs it.
argument0: the code
*/
global.modText[global.modTextCount]=argument0
global.modTextFixed[global.modTextCount]=0
global.modTextCount+=1
return global.modTextCount-1
