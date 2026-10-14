if global.gamePaused=false
{
  if isCollisionWaterBottom(-16)
  {
    bSubmerged=1
    bubbleTime+=1*gDeltaTime
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
  else if room=rMario1_12 //spsp ns
  {
    bSubmerged=1
    //bubbleTime+=1
    bubbleTime+=1*gDeltaTime //60fps change: per frame
    if bubbleTime>=bubbleDelay
    {
      bubbleSeq+=1
      findDist=point_distance(oPlayer1.x,oPlayer1.y-26,x,y)
      if bubbleSeq>=6 and findDist<detectDist
      {
        newBubble=instance_create(x,y,oBigAbubble)
        bubbleSeq=0
      }
      else
      {
        var newBubble,bubbleCount;
        newBubble=instance_create(x,y,oPlayerAirBubble)
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
