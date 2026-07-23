#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//global.recPeopleTalkedTo+=1
if global.optMessagePlink=1 {playSound(global.snd_MessagePlink,0,1,1)}
bFading=false
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bFading=false
{
  if instance_exists(idCheck)
  {
    x=idCheck.x-xOffset
    y=idCheck.y-yOffset
    if x<0 {x=0}
    else if x+xOffset*2>room_width {x=room_width-xOffset*2}

    findTargetX=point_distance(oPlayer1.x,0,idCheck.x,0)
    findTargetY=point_distance(0,oPlayer1.y,0,idCheck.y)
    if findTargetX>=64 or findTargetY>=64
      bFading=true
  }
  else
    bFading=true
}
else
{
  image_alpha-=0.05
  if image_alpha<=0
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
showMessage(x,y,message,talker,6,image_alpha,boxSize)
