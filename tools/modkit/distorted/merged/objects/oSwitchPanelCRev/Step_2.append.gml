if room=rGame6_WindG and image_index=0 //spsp ns
{
    if bColliding=1
    {
      for(i=0;i<maxDoor;i+=1)
      {
        targetDoor[i].mask_index=sBarrierCRev
        targetDoor[i].image_alpha=1
      }
    }
}
