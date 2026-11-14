//Logic Test: the player hit (takeDamage: argument0 the damage so far, argument1 what hit): noted in a run
var s;
if global.ltRun=1
{
  s="?"
  if instance_exists(argument1) {s=object_get_name(argument1.object_index)}
  ltOut("hit "+string(argument0)+" "+s+" f"+string(global.ltFrame)+" "+ltPos())
}
return 0
