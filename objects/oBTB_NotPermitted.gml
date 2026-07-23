#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
touchTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  if touchTime>0 {touchTime-=1}
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if touchTime=0
{
  msgCreate(170,100,"","Your presence near the masters is not permitted.",6,1,oMessagePerson,0)
  newMessage.fadingTime=70
  touchTime=80
}
