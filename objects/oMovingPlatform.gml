#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: xDir,yDir,shiftChange,spriteChange
viscidTop=1
makeActive()
shiftTime=0
shiftTimeMax=96
newSprite=0
deathCheck=0
solidIsNearPlayers=0

prevX=0
prevY=0

findTargetX=0
findTargetY=0
drawRangeX=560
drawRangeY=400
bCanMove=true
bPauseOnEnd=true
shiftSeq=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xVel=xDir
yVel=yDir
x+=round(xDir)
y+=round(yDir)
shiftTimeMax=shiftChange-2
if variable_local_exists("spriteChange")
  newSprite=spriteChange
if variable_local_exists("newRangeX")
  drawRangeX=newRangeX
if variable_local_exists("newRangeY")
  drawRangeY=newRangeY
if variable_local_exists("doNotMove")
{
  bCanMove=false
  xVel=0
  yVel=0
}
if variable_local_exists("newStartTime")
  shiftTime=newStartTime
if variable_local_exists("doNotPause")
  bPauseOnEnd=doNotPause
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false && gDeltaDoTicks != 0
{
  if bCanMove=true
  {
    if shiftTime>=shiftTimeMax
    {
      if shiftSeq=0
      {
        if bPauseOnEnd=1
        {
          xVel=0
          yVel=0
          shiftSeq=1
        }
        else
          shiftSeq=1000
      }
      else if shiftSeq>=1 and shiftSeq<=20
        shiftSeq+=1
      else if shiftSeq>=21
      {
        shiftTime=0
        shiftSeq=0
        xVel=xDir
        yVel=yDir
        xVel*=-1
        yVel*=-1
        xDir=xVel
        yDir=yVel
      }
    }
    else
    {
      //if place_meeting(x,y,oNightmareEffect) {xVel=xDir/2; yVel=yDir/2}
      //else {xVel=xDir; yVel=yDir}
      if prevX!=x or prevY!=y
      {
        prevX=x
        prevY=y
        shiftTime+=1
      }
    }
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
  if newSprite=0
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  else if newSprite=1 //Stratum Steppe A
    draw_background_part(tileMeadelandA,96,64,64,16,x,y)
  else if newSprite=2 //Gate 1: Mario platforms
  {
    draw_sprite_part(sMovingPlatform1,0,0,0,32,16,x,y)
    draw_sprite_part(sMovingPlatform1,0,16,0,32,16,x+32,y)
  }
  else if newSprite=3 //Gate 2: Water Palace platforms
  {
    draw_background_part(tileZeldaWater,0,0,32,8,x,y)
    draw_background_part(tileZeldaWater,64,0,32,8,x+32,y)
    draw_background_part(tileZeldaWater,0,56,32,8,x,y+8)
    draw_background_part(tileZeldaWater,64,56,32,8,x+32,y+8)
  }
  else if newSprite=4 //Lost Vikings (Central City)
    draw_background_part(tileLostVikingsA,16,0,32,16,x,y)
  else if newSprite=5 //Magical Quest
    draw_background_part(tileMagicalQuestA,0,32,64,16,x,y)
  else if newSprite=6 //Castlevania A
  {
    for(i=0;i<image_xscale;i+=1)
      draw_background_part(tileCastlevaniaA,0,16,16,16,x+(i*16),y)
  }
  else if newSprite=7 //Castlevania B
  {
    for(i=0;i<image_xscale;i+=1)
      draw_background_part(tileCastlevaniaA,0,96,16,16,x+(i*16),y)
  }
  else if newSprite=8 //Castlevania C
  {
    draw_background_part(tileCastlevaniaB,48,32,48,16,x,y)
    draw_background_part(tileCastlevaniaB,112,32,16,16,x+48,y)
  }
  else if newSprite=9 //Castlevania D
  {
    draw_background_part(tileCastlevaniaB,48,32,16,16,x,y)
    draw_background_part(tileCastlevaniaB,112,32,16,16,x+16,y)
  }
  else if newSprite=10 //Gate B
  {
    draw_background_part(tileGateB1,32,48,32,16,x,y)
  }
  else if newSprite=11 //Begonia A
  {
    draw_background_part(tileBegoniaA,32,0,48,16,x,y)
  }
  else if newSprite=12 //Begonia B
  {
    draw_background_part(tileBegoniaA,64,192,32,16,x,y)
  }
  else if newSprite=13 //Bubble Tower A
  {
    draw_background_part(tileBubbleTower,16,towerColor,16,16,x,y) //Left
    if image_xscale>2
    {
      for(i=1;i<image_xscale-1;i+=1)
        draw_background_part(tileBubbleTower,32,towerColor,16,16,x+(i*16),y) //Mid
    }
    draw_background_part(tileBubbleTower,64,towerColor,16,16,x+(i*16),y) //Right

    //draw_background_part(tileBubbleTower,16,towerColor,32,16,x,y)
    //draw_background_part(tileBubbleTower,64,towerColor,16,16,x+32,y)
  }
  else if newSprite=14 //Barrens A
  {
    draw_background_part(tileBarrens,128,304,64,32,x,y)
  }
  else if newSprite=15 //Gate 6 - Paradise Island
  {
    draw_background_part(tileParadiseIsland,0,128,32,32,x,y)
  }
  else if newSprite=16 //Gate G - Forgotten Isles
  {
    draw_background_part(tileG6ForgottenIsles,0,128,112,80,x,y-16)
  }
  else if newSprite=17 //Highlands Tree Branch
  {
    draw_background_part(tileHighlands,64,64,64,16,x,y)
  }
  else if newSprite=18 //DCS
  {
    draw_background_part(tileDCS_B,80,128,64,16,x,y)
  }
  else if newSprite=19 //Gate 1: Mario platforms (extended)
  {
    draw_sprite_part(sMovingPlatform1,0,0,0,32,16,x,y)
    draw_sprite_part(sMovingPlatform1,0,16,0,16,16,x+32,y)
    draw_sprite_part(sMovingPlatform1,0,16,0,32,16,x+48,y)
  }
  else if newSprite=20 //Nightmare C
  {
    draw_background_part(tileCastlevaniaI,0,144,32,16,x,y)
    draw_background_part(tileCastlevaniaI,16,144,16,16,x+32,y)
    draw_background_part(tileCastlevaniaI,16,144,32,16,x+48,y)
  }
  else if newSprite=21
  {
    draw_sprite_ext(sMovingPlatform2,image_index,x+16,y,1,1,270,image_blend,image_alpha)
  }
}
