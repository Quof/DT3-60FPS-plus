//If type=2 - requires: turMax

screenFrm=0
bActivate=0
turretProg=0

myInfectSpot=instance_create(x,y-16,oHPF_ConInfect)
myInfectSpot.myOwner=id
alarm[0]=1 //gid order change (added): see Alarm 0
