#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: spriteToDraw, timeUntilFall, grav
sprite_index=sInvisibleSolidMask
viscidTop=1
makeActive()
image_xscale=4
image_yscale=4

//variables for the fall platform
shaking=0            //is the platform shaking
//grav=0.3             //how fast it falls
//timeUntilFall=25     //time till platform falls

findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=400

shakeX=0
deathCheck=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if shaking
  {
    timeUntilFall-=1
    if timeUntilFall<=0
    {
      shakeX=0
      yAcc=grav
      if yVel>4
        yVel=4
    }
    else
    {
      if shakeX=1
        shakeX=-1
      else
        shakeX=1
    }
  }
  else
  {
    //if the character stands on the platform, start the timer
    if isCollisionCharacterTop(1,0)
      shaking=1
  }

  if y>=room_height+64
    instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
findTargetX=point_distance(oPlayer1.x,0,x,0)
findTargetY=point_distance(0,oPlayer1.y,0,y)
if findTargetX<drawRangeX and findTargetY<drawRangeY
{
  if spriteToDraw=0 {draw_background_part(tileBarrens,0,192,64,64,x+shakeX,y)}
  else if spriteToDraw=1 {draw_sprite(sWS_PlatB,0,x+shakeX,y)}
}
