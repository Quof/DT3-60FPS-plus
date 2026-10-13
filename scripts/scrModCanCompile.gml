/*
mods change (added): whether a piece of mod code compiles (if not, error_last says why). Code that doesn't compile is a
fatal error for object_event_add (and so for gm82core's code_compile, which uses it), which ends the game even with
error messages turned off. For execute_string it's an ordinary error, so the code is compiled there first, behind an
exit so that none of it runs.
argument0: code
*/
var tErr,tOk;
tErr=error_is_enabled()
if tErr {error_set_enabled(false)}
error_occurred=false
error_last=""
execute_string("exit;"+argument0)
tOk=!error_occurred
error_occurred=false
if tErr {error_set_enabled(true)}
return tOk
