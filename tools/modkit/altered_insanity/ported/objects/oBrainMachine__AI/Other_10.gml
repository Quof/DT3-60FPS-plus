//-------------------- ATTACK: Floor Trap --------------------
floorTrapTime+=1*gDeltaDoTicks
if floorTrapTime>=floorTrapDelay and floorTrapTime<=floorTrapDelay+100
{
  for(i=0;i<7;i+=1)
  {
    myTrap=instance_create(64+(i*64),room_height+8,oZapTrap)
    myTrap.image_xscale=2
    floorTrapTime=1000
  }
}
else if floorTrapTime>=1001 and floorTrapTime<=1999
{
  oZapTrap.y-=1*gDeltaDoTicks
  if oZapTrap.y<=yGround-6 {floorTrapTime=2000}
}
else if floorTrapTime>=2000+floorTrapDuration and bossPhase!=3
{
  oZapTrap.y+=4*gDeltaDoTicks
  if oZapTrap.y>=room_height+8
  {
    with oZapTrap {instance_destroy()}
    floorTrapTime=0
  }
}
