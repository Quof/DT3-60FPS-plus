if collision_rectangle(x,y,x+16,y+16,oPlayer1,1,1)
  bColliding=1
else if collision_rectangle(x,y,x+16,y+16,oPlayerIdle,1,1)
  bColliding=1
else
  bColliding=0

if bColliding=1
{
  for(i=0;i<maxDoor;i+=1)
  {
    if(targetDoor[i] == noone)
    {
      targetDoor[i] = (GID(idsForTargetDoors[i]))
    }
  }
  for(i=0;i<maxDoor;i+=1)
  {
    if(targetDoor[i] != noone)
    {
      targetDoor[i].mask_index=sNull
      targetDoor[i].image_alpha=0.25
    }
  }
}
else
{
  for(i=0;i<maxDoor;i+=1)
  {
    if(targetDoor[i] != noone)
    {
      targetDoor[i].mask_index=sBarrierColor
      targetDoor[i].image_alpha=1
    }
  }
}
