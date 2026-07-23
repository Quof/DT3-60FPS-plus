#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Requires xOffset, yOffset, sensorTime, timeToON, timeToOFF
*/
bSensorActive=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  sensorTime+=1
  if bSensorActive=0
  {
    if sensorTime>=timeToON {sensorTime=0; bSensorActive=1}
  }
  else if bSensorActive=1
  {
    if sensorTime>=timeToOFF {sensorTime=0; bSensorActive=0}
  }

  if bSensorActive=1
  {
    if collision_line(x,y,x+xOffset,y+yOffset,oPlayer1,1,1) //----- Player touches laser -----
    {
      if room=rMega4_SigmaA4 //Achievement
      {
        oEvAchCheckG4_SA4.achProg=10
      }
      else if room=rBT_ZeroA or room=rBT_ZeroB or room=rBT_ZeroC or room=rBT_ZeroD //Zero's map
      {
        oPlayer1.dashEnergy=0
      }
      oRayTrap.checkArea=1
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bSensorActive=1
{
  if sensorTime mod 2=0 {draw_set_alpha(0.4)}
  else {draw_set_alpha(1)}
  draw_set_color(c_red)
  draw_line(x,y,x+xOffset,y+yOffset)
  //draw_line(x,y,x+lengthdir_x(sensorDist,image_angle),y+lengthdir_y(sensorDist,image_angle))
}
myDir=point_direction(x,y,x+xOffset,y+yOffset)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,myDir,image_blend,image_alpha)
draw_sprite_ext(sprite_index,image_index,x+xOffset,y+yOffset,image_xscale,image_yscale,myDir+180,image_blend,image_alpha)
