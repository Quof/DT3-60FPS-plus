#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=103
{
  var myShadow;
  myShadow=instance_create(0,0,oObjectShadow)
  myShadow.ownerID=id; myShadow.type=1; myShadow.maxShadowDist=192
}
