#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
setCollisionBounds(2,0,sprite_width-2,sprite_height-1)
image_speed=0.15
bSubmerged=0
bubbleTime=0
bubbleDelay=irandom_range(4,20)
bubbleSeq=4
detectDist=112
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newDetect") {detectDist=newDetect}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if isCollisionWaterBottom(-16)
  {
    bSubmerged=1
    bubbleTime+=1
    if bubbleTime>=bubbleDelay
    {
      bubbleSeq+=1
      findDist=point_distance(oPlayer1.x,oPlayer1.y-26,x,y)
      if bubbleSeq>=6 and findDist<detectDist
      {
        newBubble=instance_create(x+2+random(12),y+4+random(6),oBigAbubble)
        bubbleSeq=0
      }
      else
      {
        var newBubble,bubbleCount;
        newBubble=instance_create(x+2+random(12),y+4+random(6),oPlayerAirBubble)
        bubbleTime=irandom_range(10,70)
        bubbleCount=instance_number(oPlayerAirBubble)
        if bubbleCount>global.recMaxBubbles {global.recMaxBubbles=bubbleCount}
      }
      bubbleTime=0
      bubbleDelay=irandom_range(10,40)
    }
  }
  else {bSubmerged=0}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bSubmerged=1
  draw_sprite(sprite_index,image_index,x,y)
