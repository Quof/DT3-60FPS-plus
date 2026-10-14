bubbleDir=0
decayTime=oElpizo.bubbleDecay
atkPower=oElpizo.atkPower
bulletSpeed=2
bubbleRadius=56 //spsp ns
bubbleAmount=5
_direction=point_direction(x,y,oPlayer1.x,oPlayer1.y-26)

for(i=0;i<bubbleAmount;i+=1)
{
  myBubble[i]=instance_create(x,y,oStaticBullet)
  myBubble[i].sprite_index=sE_Bubble
  myBubble[i].image_speed=0.5
  myBubble[i].atkPower=atkPower
}
