//
/*
Phase 1: bottom (y between 352 and 704)
Phase 2: mid (y at 352)
Phase 3: top (y between 0 and 352)
Phase 4: player camera, full room (n/a)
*/
var PhaseNumber;
PhaseNumber=argument0

if PhaseNumber=0
{
  // nothing really
}
else if PhaseNumber=1
{
  //go to mid and stay there
  //moveValue=1*(MyCamera.y>352)
  moveValue=1*(MyCamera.y>352)*(gDeltaDoTicks>0) //60fps change: a whole pixel once per 30fps tick
  MyCamera.y-=moveValue
  warpBorderY-=moveValue
  yTop-=moveValue
}
else if PhaseNumber=2
{
  //go to top and stay there
  //moveValue=1*(MyCamera.y>176)
  moveValue=1*(MyCamera.y>176)*(gDeltaDoTicks>0) //60fps change: a whole pixel once per 30fps tick
  MyCamera.y-=moveValue
  warpBorderY-=moveValue
  yTop-=moveValue
  defaultWarpY-=moveValue
}
else if PhaseNumber=3
{
  //destroy custom camera and follow player
  //done in oDAbomMain
  //phase switch while player is in a forced high to prevent discontinuity?
}



/*
//fixed camera code
viewFix=instance_create(480,176,oMisc)
viewFix.type=0
viewFix.sprite_index=sNull
view_object[0]=viewFix

view_object[0]=oPlayer1
*/
//normal fall death: room_height+64
