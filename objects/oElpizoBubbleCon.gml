#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
bubbleDir=0
decayTime=oElpizo.bubbleDecay
atkPower=oElpizo.atkPower
bulletSpeed=2
direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)

for(i=0;i<3;i+=1)
{
  myBubble[i]=instance_create(x,y,oStaticBullet)
  myBubble[i].sprite_index=sE_Bubble
  myBubble[i].image_speed=0.5
  myBubble[i].atkPower=atkPower
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bulletSpeed<8 {bulletSpeed+=0.33}
  speed=bulletSpeed
  turn_toward_direction(point_direction(x,y,oPlayer1.x,oPlayer1.y-26),4.5)
  for(i=0;i<3;i+=1)
  {
    myBubble[i].x=x+lengthdir_x(12,(i*120)+bubbleDir)
    myBubble[i].y=y+lengthdir_y(12,(i*120)+bubbleDir)
  }
  bubbleDir+=15

  decayTime-=1
  if decayTime<=0
  {
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(myBubble[i].x,myBubble[i].y,oEffect)
      tEffect.sprite_index=sMMshotgunIceEffect; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      with myBubble[i] {instance_destroy()}
    }
    instance_destroy()
  }
}
else {speed=0}
