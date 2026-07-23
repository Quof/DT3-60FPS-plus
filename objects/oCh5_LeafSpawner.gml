#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
initVars=0
initAmt=round((sqrt(sqr(room_width)+sqr(room_height)))/70)
leafSpawn=0
leafDelay=22-round(room_width/420)
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
var i;
for(i=0;i<initAmt;i+=1)
{
  instance_create(4+random(room_width-8),4+random(room_height-8),oDecFallingLeaf)
}
initVars=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if initVars=1
{
  leafSpawn+=1
  if leafSpawn>=leafDelay
  {
    instance_create(4+random(room_width-8),-4,oDecFallingLeaf)
    leafSpawn=0
  }
}
