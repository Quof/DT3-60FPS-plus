#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
bCanControl=1
soundDelay=0
floorMove=0
moveSpd=8
deathCheck=0
solidIsNearPlayers=0

myCeiling=instance_create(x-32,y-80,oCEleTop)
with myCeiling
{
  sprite_index=sInvisibleSolidMask
  visible=0
  viscidTop=1
  makeActive()
  image_xscale=4
}

myLeft=instance_create(x-48,y-64,oCEleTop)
with myLeft
{
  sprite_index=sNull
  visible=0
  viscidTop=1
  makeActive()
  image_yscale=4
}

myRight=instance_create(x+32,y-64,oCEleTop)
with myRight
{
  sprite_index=sNull
  visible=0
  viscidTop=1
  makeActive()
  image_yscale=4
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bCanControl=1
  {
    myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y)
    if myDist<20
    {
      if oKeyCodes.kCodePressed[3]=1
      {
        if currFloor>1 //Go up one floor
        {
          playSound(global.snd_Elevator,0,1,1)
          yVel=-moveSpd; myCeiling.yVel=-moveSpd
          myLeft.yVel=-moveSpd; myRight.yVel=-moveSpd
          myLeft.sprite_index=sInvisibleSolidMask; myRight.sprite_index=sInvisibleSolidMask
          currFloor-=1
          bCanControl=0
        }
      }
      else if oKeyCodes.kCodePressed[4]=1
      {
        if currFloor<maxFloor //Go down one floor
        {
          playSound(global.snd_Elevator,0,1,1)
          yVel=moveSpd; myCeiling.yVel=moveSpd
          myLeft.yVel=moveSpd; myRight.yVel=moveSpd
          myLeft.sprite_index=sInvisibleSolidMask; myRight.sprite_index=sInvisibleSolidMask
          currFloor+=1
          bCanControl=0
        }
      }
    }
  }
  else
  {
    if soundDelay=0
    {
      //sound_play(snd_ElevatorUse)
      soundDelay=4
    }
    else {soundDelay-=1}

    floorMove+=abs(yVel)
    if floorMove>=floorSpc
    {
      yVel=0; myCeiling.yVel=0
      myLeft.yVel=-0; myRight.yVel=0
      myLeft.sprite_index=sNull; myRight.sprite_index=sNull
      floorMove=0
      bCanControl=1
    }
  }
  scrPlatformCrush()
}
