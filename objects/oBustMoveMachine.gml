#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_angle=90
rechargeTime=0
rechargeTotal=15/gDeltaTime
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if scrController(1)
  {
    if image_angle<145
    {
      image_angle+=3*gDeltaTime
    }
  }
  else if scrController(2)
  {
    if image_angle>33
    {
      image_angle-=3*gDeltaTime
    }
  }

  if rechargeTime=0
  {
    if scrController(6)
    {
      playSound(global.snd_MarioCannon,0,0.95,1)
      var tNewBubble;
      tNewBubble=instance_create(x,y-32,oBustMoveBubble)
      tNewBubble.type=0; tNewBubble.moveSpd=8
      tNewBubble.direction=image_angle
      rechargeTime=rechargeTotal
    }
    else if scrController(7)
    {
      playSound(global.snd_MarioCannon,0,0.95,1)
      var tNewBubble;
      tNewBubble=instance_create(x,y-32,oBustMoveBubble)
      tNewBubble.type=1; tNewBubble.moveSpd=8
      tNewBubble.direction=image_angle
      rechargeTime=rechargeTotal
    }
    else if scrController(8)
    {
      playSound(global.snd_MarioCannon,0,0.95,1)
      var tNewBubble;
      tNewBubble=instance_create(x,y-32,oBustMoveBubble)
      tNewBubble.type=2; tNewBubble.moveSpd=8
      tNewBubble.direction=image_angle
      rechargeTime=rechargeTotal
    }
  }
  else {rechargeTime-=1}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(0.4)
draw_set_color(c_red)
lineX=x+lengthdir_x(512,image_angle)
lineY=y-32+lengthdir_y(512,image_angle)
draw_line(x,y-32,lineX,lineY)

draw_sprite(sprite_index,image_index,x,y)
draw_sprite_ext(sBustMoveArrow,0,x,y-32,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if rechargeTime>0 //Recharge bar
{
  draw_set_alpha(1)
  draw_set_color(c_black)
  draw_rectangle(x-32,y+12,x-32+(rechargeTotal*2),y+17,0)
  draw_set_color(c_white)
  draw_rectangle(x-32,y+12,x-32+(rechargeTotal*2),y+17,1)
  draw_set_color(c_green)
  draw_rectangle(x-31,y+13,x-31+(rechargeTime*2),y+16,0)
}
