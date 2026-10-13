/*
mods change (added): an event file's name (Create_0, Step_1, Alarm_3, Collision_oPlayer1, Other_10, Draw_0...) as
global.modEvType and global.modEvNum. Returns 1, or 0 if the name isn't an event (or names an object that doesn't exist).
argument0: event name
*/
var tP,tKind,tNum;
tP=string_pos("_",argument0)
if tP<2 {return 0}
tKind=string_copy(argument0,1,tP-1)
tNum=string_copy(argument0,tP+1,string_length(argument0)-tP)
if tKind="Create" {global.modEvType=ev_create}
else if tKind="Destroy" {global.modEvType=ev_destroy}
else if tKind="Alarm" {global.modEvType=ev_alarm}
else if tKind="Step" {global.modEvType=ev_step}
else if tKind="Collision" {global.modEvType=ev_collision}
else if tKind="Keyboard" {global.modEvType=ev_keyboard}
else if tKind="Mouse" {global.modEvType=ev_mouse}
else if tKind="Other" {global.modEvType=ev_other}
else if tKind="Draw" {global.modEvType=ev_draw}
else if tKind="KeyPress" {global.modEvType=ev_keypress}
else if tKind="KeyRelease" {global.modEvType=ev_keyrelease}
else if tKind="Trigger" {global.modEvType=ev_trigger}
else {return 0}
if global.modEvType=ev_collision
{
  global.modEvNum=scrModFind(tNum,"obj")
  if global.modEvNum<0 {return 0}
}
else {global.modEvNum=real(tNum)}
return 1
