#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: moveSpeedX,moveSpeedY,bMoving,drawType
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
solidIsNearPlayers=0

deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bMoving=1
{
  xVel=moveSpeedX
  yVel=moveSpeedY
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//If the character stands on the platform, the platform will continuously move indefinately
if global.gamePaused=false
{
  if isCollisionCharacterTop(1,0) and bMoving=0
  {
    xVel=moveSpeedX
    yVel=moveSpeedY
    bMoving=1
  }
  else
  {
    scrPlatformCrush()

    if x<-128
      instance_destroy()
    else if x>room_width+128
      instance_destroy()
    else if y<-128
      instance_destroy()
    else if y>room_height+128
      instance_destroy()
  }
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
  if drawType=0 //Normal
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else if drawType=1 //Vault
  {
    draw_set_color(platColor)
    draw_set_alpha(0.3)
    draw_roundrect(x,y,x+image_xscale-1,y+image_yscale-1,0)
    draw_set_alpha(1)
    draw_roundrect(x,y,x+image_xscale-1,y+image_yscale-1,1)
  }
  else if drawType=2 //Gate 6 - Castle of Doom
  {
    draw_background_part(tileCastleOfDoom,64,64,64,16,x,y)
  }
}
