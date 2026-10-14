for(i=0;i<armNum;i+=1)
{
  myGrapplePoints[i]=instance_create(x,y,oDLatchCrystal)
}
armsCreated=1

if variable_local_exists("offset")
    armsRotation+=offset
