#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
delayTime=1000
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  delayTime-=1
  if delayTime=0
  {
    createEnemy(x,y,ceObject,ceQuest,ceEffect,ceActive)
    instance_destroy()
  }
}
#define Other_7
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if delayTime>100
{
  delayTime=10
  visible=0
}
