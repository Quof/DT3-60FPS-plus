#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(0,0,sprite_width,sprite_height)

//variables for the fall platform
grav=1               //how fast it falls
falling=0            //is the platform falling
timeUntilFall=20     //time till platform falls
newSprite=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character's falling
if global.gamePaused=false
{
  if falling
  {
    timeUntilFall-=1
    if timeUntilFall<=0
    {
      yAcc=grav
      if yVel>6 {yVel=6}
    }
  }
  else
  {
    if findTargetX<drawRangeX and findTargetY<drawRangeY
    {
      //if the character stands on the platform, start the timer
      if isCollisionCharacterTop(1,0)
        falling=1
    }
  }
}
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oCharacter.x,0,x,0)
findTargetY=point_distance(0,oCharacter.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if newSprite=0
    draw_background_part(tileIntermediaryWoods,32,256,16,16,x,y)
}
