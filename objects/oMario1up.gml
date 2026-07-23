#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
moveProg=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  moveProg+=1*gDeltaTime
  if moveProg<=32
  {
    y-=0.5*gDeltaTime
    if moveProg=32
    {
      xVel=2.5*gDeltaTime
      if x>=oPlayer1.x
        xVel=2.5*gDeltaTime
      else
        xVel=-2.5*gDeltaTime
    }
  }
  else
  {
    yVel+=0.3
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    moveTo(xVel,yVel)

    if isCollisionSolid()
      y-=2*gDeltaTime
    if y>room_height+24
      instance_destroy()
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if moveProg>=20
{
  playSound(global.snd_1up,0,0.95,1)
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitions,18)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNotice)
    tAchievement.myAchievement="Infinity Plus One"; tAchievement.checkNum=18
  }
  awardAwesome(250)
  instance_destroy()
}
