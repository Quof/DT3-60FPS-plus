#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
xSpd=2.5
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Advance death wall
if global.gamePaused=false
{
  //Variable speed depending on how far off screen the wall is
  if x>=view_xview[0]-32 {xSpd=2.5}
  else if x>=view_xview[0]-96 and x<=view_xview[0]-33 {xSpd=6}
  else if x>=view_xview[0]-240 and x<=view_xview[0]-97 {xSpd=8}
  else {xSpd=10}

  x+=xSpd
  if x+32>=oPlayer1.x
    oPlayer1.life-=oPlayer1.maxLife
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
draw_set_color(c_black)
draw_rectangle(0,y,x,room_height,0)
for(i=0;i<10;i+=1)
{
  draw_sprite(sSpikeWallA,0,x,y+(i*64))
}
