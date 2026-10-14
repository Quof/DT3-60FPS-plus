/*
mods change (added): runs a placed instance's creation code in its placeholder (scrModInstSetup), then makes it the
object with instance_change(object,true), which runs the object's create event in the instance it becomes. So the
creation code comes before the create event, as in a room made in the editor. instance_change gives the instance the
object's sprite, mask, depth, visible, solid and persistent, so the ones the creation code changed are made the object's
own for that moment (and put back after), so the instance keeps them and its create event sees them. If the creation
code destroys it, it stays destroyed (the placeholder's destroy event sets modGone): it never becomes the object.
argument0: the placeholder
argument1: object
argument2: creation code (compiled, or kept as text: argument4)
argument3: its scrModRun mode
argument4: 1 if the code is kept as text (scrModTextAdd, scrModRunText)
*/
//var tObj,tC,tM,s,ma,d,v,so,p,os,om,od,ov,oso,op;
var tObj,tC,tM,tTx,s,ma,d,v,so,p,os,om,od,ov,oso,op; //mods change: tTx (code kept as text)
//tObj=argument1; tC=argument2; tM=argument3
tObj=argument1; tC=argument2; tM=argument3; tTx=argument4 //mods change
if !instance_exists(argument0) {exit}
with (argument0)
{
  modGone=0
  //scrModRun(tC,tM,0,0)
  if tTx {scrModRunText(tC,tM)} //mods change: room and patch code is kept as text
  else {scrModRun(tC,tM,0,0)}
  if modGone=0 and instance_exists(id)
  {
    s=sprite_index; ma=mask_index; d=depth; v=visible; so=solid; p=persistent
    os=object_get_sprite(tObj); om=object_get_mask(tObj); od=object_get_depth(tObj)
    ov=object_get_visible(tObj); oso=object_get_solid(tObj); op=object_get_persistent(tObj)
    if s!=os {object_set_sprite(tObj,s)}
    if ma!=om {object_set_mask(tObj,ma)}
    if d!=od {object_set_depth(tObj,d)}
    if v!=ov {object_set_visible(tObj,v)}
    if so!=oso {object_set_solid(tObj,so)}
    if p!=op {object_set_persistent(tObj,p)}
    instance_change(tObj,true)
    if s!=os {object_set_sprite(tObj,os)}
    if ma!=om {object_set_mask(tObj,om)}
    if d!=od {object_set_depth(tObj,od)}
    if v!=ov {object_set_visible(tObj,ov)}
    if so!=oso {object_set_solid(tObj,oso)}
    if p!=op {object_set_persistent(tObj,op)}
  }
}
