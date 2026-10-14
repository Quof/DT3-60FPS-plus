if room=rCCity_NB_S1a or room=rWarshipB and image_index=0 //spsp ns
{
    if bColliding=1
    {
      for(i=0;i<maxDoor;i+=1)
      {
        /*targetDoor[i].mask_index=sBarrierCRev
        targetDoor[i].image_alpha=1*/
        targetDoor[i].mask_index=sNull
        targetDoor[i].image_alpha=0.25
      }
    }
}
