#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
alarm[0]=1
newSprite=0

findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
deathCheck=0
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
dir=dirStart
dirChangeRate=changeRate
mSpeed=pSpeed
if variable_local_exists("spriteChange")
  newSprite=spriteChange
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  dir+=dirChangeRate
  xVel=mSpeed*cos(degtorad(dir))
  yVel=mSpeed*sin(degtorad(dir))
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
  if newSprite=0
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else if newSprite=1 //Magical Quest
    draw_background_part(tileMagicalQuestA,0,32,64,16,x,y)
  else if newSprite=2 //Gate 4 Intro
  {
    draw_background_part(tileMM_A2,64,128,32,16,x,y)
    draw_background_part(tileMM_A2,128,128,32,16,x+32,y)
  }
  else if newSprite=3 //Farreaches
    draw_background_part(tileFarreachesA,0,176,32,16,x,y)
  else if newSprite=4 //Gate 6 - Castle of DOOM
    draw_background_part(tileCastleOfDoom,64,64,64,16,x,y)
}
