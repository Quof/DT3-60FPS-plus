#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)

eLineAlpha=0.05
minAlpha=0.05
maxAlpha=0.36
deathCheck=0

if room=rBT_ZeroD
{
  depth=25
  minAlpha=0.25
  maxAlpha=0.6
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
  if type=0
  {
    if isCollisionCharacterTop(1,0) or isCollisionCharacterTop(2,oPushRock) or isCollisionCharacterTop(2,oBreakRock)
    {
      if eLineAlpha<maxAlpha {eLineAlpha+=0.02}
      var tMove; tMove=0
      if fallSpeed>0
      {
        if y<ystart+distMax {tMove=1}
      }

      if tMove=1
      {
        yVel=fallSpeed
        myWeight.yVel=-fallSpeed
        if myWeight.eLineAlpha<myWeight.maxAlpha {myWeight.eLineAlpha+=0.02}
      }
      else
      {
        yVel=0
        myWeight.yVel=0
      }
    }
    else
    {
      if eLineAlpha>minAlpha {eLineAlpha-=0.02}
      if y>ystart
      {
        yVel=-riseSpeed
        myWeight.yVel=riseSpeed
        if myWeight.eLineAlpha>myWeight.minAlpha {myWeight.eLineAlpha-=0.02}
      }
      else
      {
        yVel=0
        myWeight.yVel=0
      }
    }
  }
  else if type=1
  {
    scrPlatformCrush()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(eLineAlpha)
draw_set_color(c_black)
if type=0
{
  draw_line_width(x,ystart,x,ystart+distMax+16,2)
  draw_line_width(x,y,myWeight.x,myWeight.y,2)
}
else if type=1
{
  draw_line_width(x,ystart+32,x,ystart-distMax,2)
}

draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
