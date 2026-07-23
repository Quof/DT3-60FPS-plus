#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(0,0,sprite_width,sprite_height)

//variables for the donut platform
grav=0.5                     //how fast it falls
returnAfterPeriodOfTime=180     //number of steps until it returns after it falls (set to 0 to make it never return)
timeUntilFall=20                //how long the character can stand on this until it falls
timeUntilFallMax=20             //the max value for timeUntilFall
falling=0                       //is the platform falling
solidIsNearPlayers=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if gDeltaDoTicks != 1 { exit; }
//if the character's falling
if global.gamePaused=false
{
  if falling
  {
    yAcc=grav
    if yVel>6 {yVel=6}
    returnAfterPeriodOfTime-=1
    if returnAfterPeriodOfTime=0
    {
      instance_create(xstart,ystart,oDonutPlatformStart)  
    }
  }
  else
  {
    //if the character is standing on the platform, subtract one from the timer
    if isCollisionCharacterTop(1,0)
    {
      timeUntilFall-=1
      //also, check to see if it is <= 0
      if timeUntilFall<=0
        falling=1
    }
    else
    {
      if timeUntilFall<timeUntilFallMax
        timeUntilFall+=1
    }
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if returnAfterPeriodOfTime<=0
  instance_destroy()
