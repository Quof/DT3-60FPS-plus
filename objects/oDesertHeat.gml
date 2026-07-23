#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
innerColor=make_color_rgb(145,255,255)
outerColor=make_color_rgb(13,166,217)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  with oPlayer1
  {
    if isCollisionWaterBottom(-12)
    {
      if global.desertHeat<1500 {global.desertHeat+=60}
      else {global.desertHeat=1500}
    }
    else
    {
      global.desertHeat-=1
      if global.desertHeat<=0
      {
        oPlayer1.life-=oPlayer1.maxLife
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
myX=view_xview[0]+280
myY=view_yview[0]+24

draw_set_alpha(1)
draw_sprite(sDesertWaterMeter,0,myX,myY)
hydroTrack=(global.desertHeat/1500)*16
draw_circle_color(myX,myY,hydroTrack,innerColor,outerColor,0)

draw_set_color(c_black)
draw_circle(myX,myY,16,1)
