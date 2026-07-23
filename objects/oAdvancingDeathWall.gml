#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: xSpd,xThres
if room=rMega4_ToxicJungleC or room=rExtGateF_3 or room=rExtGateF_4
{
  flameFrm=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Advance death wall
if global.gamePaused=false
{
  x+=xSpd
  if x+xThres>=oPlayer1.x
    oPlayer1.life-=oPlayer1.maxLife
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=0 //Castlevania - C - Spike Wall
{
  draw_set_alpha(1)
  draw_set_color(c_black)
  draw_rectangle(0,y,x,room_height,0)
  for(i=0;i<6;i+=1)
    draw_sprite(sSpikeWallA,0,x,y+(i*64))
}
else if type=1 //Mega Man - Toxic Jungle - Fire Wall
{
  flameFrm+=0.15
  for(i=0;i<7;i+=1)
  {
    for(ii=0;ii<8;ii+=1)
    {
      draw_sprite_part(sWallOfFire,flameFrm,0,0,32,63,x-88-(ii*32),y-15+(i*52))
    }
  }

  for(i=0;i<7;i+=1)
  {
    draw_sprite(sWallOfFire,flameFrm,x-56,y+16+(i*52))
  }
}
else if type=2 //Gate 6 - DT2 reference
{
  for(i=0;i<11;i+=1)
  {
    draw_sprite(sG6Spike,image_index,x,i*32)
  }
  draw_set_alpha(1)
  draw_set_color(make_color_rgb(255,108,0))
  draw_rectangle(0,0,x,room_height,0)
}
