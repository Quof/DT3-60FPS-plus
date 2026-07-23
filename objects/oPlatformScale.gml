#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: fallSpeed,riseSpeed,distMax
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)

newSprite=0
findTargetX=0
findTargetY=0
drawRangeX=512
drawRangeY=384
eLineAlpha=0
deathCheck=0

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("spriteChange")
{
  newSprite=spriteChange
  if newSprite=1
  {
    sprite_index=sInvisibleSolidMask
    image_xscale=4
    for(i=0;i<4;i+=1)
    {
      bColUp[i]=1
      lineColor[i]=i*63
    }
  }
  else if newSprite=2 or newSprite=3
  {
    sprite_index=sInvisibleSolidMask
    image_xscale=4
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//If the character is standing on the platform, move the platform
if global.gamePaused=false
{
  if isCollisionCharacterTop(1,0)
  {
    if eLineAlpha<1 {eLineAlpha+=0.05}
    //if isCollisionBottom(1)
    //  yVel=0
    //else
    //{
      var tMove; tMove=0
      if fallSpeed>0 {if y<ystart+distMax {tMove=1}}
      else if fallSpeed<0 {if y>ystart-distMax {tMove=1}}

      if tMove=1 {yVel=fallSpeed}
      else {yVel=0}
    //}
  }
  else
  {
    if eLineAlpha>0 {eLineAlpha-=0.05}
    if riseSpeed>0
    {
      if y>ystart
        yVel=-riseSpeed
      else
        yVel=0
    }
    else if riseSpeed<0
    {
      if y<ystart
        yVel=-riseSpeed
      else
        yVel=0
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
  {
    draw_set_alpha(eLineAlpha)
    draw_set_color(c_black)
    draw_line_width(x+(sprite_width/2),ystart-distMax+(sprite_height/2),x+(sprite_width/2),ystart+(sprite_height/2),2)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  else if newSprite=1 //Sacred Temple
  {
    draw_sprite_ext(sTrapDoor,image_index,x,y+16,1,1,90,image_blend,image_alpha)

    if eLineAlpha>0
    {
      for(i=0;i<4;i+=1)
      {
        if bColUp[i]=1
        {
          lineColor[i]+=3
          if lineColor[i]>=255 {bColUp[i]=0}
        }
        else
        {
          lineColor[i]-=3
          if lineColor[i]<=0 {bColUp[i]=1}
        }
      }
      colorA=make_color_rgb(lineColor[0],lineColor[1],lineColor[2])
      colorB=make_color_rgb(lineColor[1],lineColor[2],lineColor[3])
      colorC=make_color_rgb(lineColor[2],lineColor[3],lineColor[0])
      colorD=make_color_rgb(lineColor[3],lineColor[0],lineColor[1])

      draw_set_alpha(eLineAlpha/10)
      draw_rectangle_color(x,ystart-distMax,x+63,ystart+16,lineColor[0],lineColor[1],lineColor[2],lineColor[3],0)
      draw_set_alpha(eLineAlpha)
      draw_line_width_color(x,ystart-distMax,x,ystart+16,2,colorA,colorB)
      draw_line_width_color(x+63,ystart-distMax,x+63,ystart+16,2,colorC,colorD)
    }
  }
  else if newSprite=2 //Begonia Mountain Temple
  {
    draw_set_alpha(eLineAlpha)
    draw_set_color(c_black)
    draw_line_width(x+32,ystart-distMax+8,x+32,ystart+8,2)
    draw_background_part(tileBegoniaA,96,192,16,8,x,y)
    draw_background_part(tileBegoniaA,0,176,32,8,x+16,y)
    draw_background_part(tileBegoniaA,112,192,16,8,x+48,y)
    draw_background_part(tileBegoniaA,96,192,16,8,x,y+8)
    draw_background_part(tileBegoniaA,0,176,32,8,x+16,y+8)
    draw_background_part(tileBegoniaA,112,192,16,8,x+48,y+8)
  }
  else if newSprite=3 //Gate 6 - Castle of DOOM
  {
    draw_set_alpha(eLineAlpha)
    draw_set_color(c_black)
    draw_line_width(x+32,ystart-distMax+8,x+32,ystart+8,2)
    draw_background_part(tileCastleOfDoom,64,64,64,16,x,y)
  }
  else if newSprite=4 //Magical Castle
  {
    draw_sprite_ext(sCastleEleA,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
  else if newSprite=5 //Distortion
  {
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
  }
}
